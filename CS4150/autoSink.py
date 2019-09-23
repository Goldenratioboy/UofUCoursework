import sys

from collections import defaultdict

clock = 1

tList = list()

#graph class to represent DAG
class graph:

    def __init__(self, vertices):
        self.V = vertices
        self.graph = defaultdict(list)

    def addEdge(self, u, v):
        self.graph[u].append(v)


def explore(g, v, visited):
            visited[v] = True
            for key in g.graph:
                for val in g.graph[key]:
                    if visited[val] is False:
                        explore(g, val, visited)
            postvisit(v)

def dfs(g, cityIds):
    visited = [False] * len(cityIds)
    for v in cityIds:
        if visited[cityIds[v]] is False:
            explore(g, cityIds[v], visited)

def postvisit(v):
    global clock
    print(v, clock)
    ccnum[v] = clock
    clock+=1
    return clock


#create graph
nCities = int(sys.stdin.readline())
ccnum = [0]*nCities
dag = graph(nCities)

cityList = dict()
cityIds = dict()
idCount = 0

# build vertex dictionary with costs set to value, set vertex to correspond to number value to
for i in range(nCities):
    params = sys.stdin.readline().split()
    cityList[params[0]] = int(params[1])
    cityIds[params[0]] = idCount
    idCount+=1

nHighways = int(sys.stdin.readline())

#get edges for DAG
for i in range(nHighways):
    params = sys.stdin.readline().split()
    dag.addEdge(cityIds.get(params[0]),cityIds.get(params[1]))

dfs(dag, cityIds) #This will give us ccnum values for topological sort

# get vertices in topological order
tOrder = list()
tOrderDict = dict()
for i in range(0,len(ccnum)):
    tOrderDict[i] = ccnum[i]



nTrips = int(sys.stdin.readline())

for i in range(nTrips):
    # This will be the bulk of our program
    pass
