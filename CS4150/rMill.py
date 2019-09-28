import sys

from collections import defaultdict, deque

#graph class to represent graph
class graph:

    def __init__(self, vertices):
        self.V = vertices
        self.graph = defaultdict(list)

    def addEdge(self, u, v):
        self.graph[u].append(v)  

    def BFS(self, sVertex, vList, E):
        dist = list()
        prev = list()
        for u in vList.keys():
            dist.append(-1) # We'll use -1 as a default value for dist
            prev.append(None)

        dist[sVertex] = 0
        q = deque()

        q.append(sVertex)

        while len(q) is not 0:
            u = q.pop()
            for v in E.graph[u]:
                if dist[v] is -1:
                    q.append(v)
                    dist[v] = dist[u] + 1
                    prev[v] = u

        return dist, prev

def generateReport(rumorReport): # void method to print out valid rumor report given a dictionary
    # Need to find max distance/key in dictionary
    maxDistance = 0
    for k in rumorReport.keys():
        if k > maxDistance:
            maxDistance = k

    for i in range(0, maxDistance+1):
        print(' '.join(rumorReport[i]), end=" ")

    if -1 in rumorReport.keys():
        print(' '.join(rumorReport[-1]))

    # else our whole graph is connected


nStudents = int(sys.stdin.readline())

G = graph(nStudents)

studentID = dict()
studentNameDict = dict()

for i in range(0,nStudents):
    studentName = sys.stdin.readline().rstrip('\n')
    studentID[studentName] = i # Adding a friend with ID
    studentNameDict[i] = studentName

nFriendPairs = int(sys.stdin.readline())

for i in range(0,nFriendPairs):
    params = sys.stdin.readline().split()
    G.addEdge(studentID[params[0]], studentID[params[1]])
    G.addEdge(studentID[params[1]], studentID[params[0]])

nRumorReports = int(sys.stdin.readline())

for i in range(0,nRumorReports):
    rumorReport = defaultdict(list)
    rumorBoy = sys.stdin.readline().rstrip('\n')
    dist, prev = G.BFS(studentID.get(rumorBoy), studentID, G) # call bfs on the name of the student starting a rumor
    
    print(dist)
    
    # build the rumorReport
    for d in dist:
        rumorReport[d].append(studentNameDict[dist.index(d)])

    for key, val in rumorReport.items():
        print(key,val)

    generateReport(rumorReport)


