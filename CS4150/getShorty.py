import sys

import heapq as q  

from collections import defaultdict

inDungeon = True

#graph class to represent graph
class graph:

    def __init__(self, vertices):
        self.V = vertices
        self.graph = defaultdict(list)

    def addEdge(self, u, v, w):
        self.graph[u,v] = w

    def Dijkstras(self, sVertex, vList, E):
        dist = list()
        prev = list()

        for idx in vList:
            dist.append(-1)
            prev.append(None)

        dist[sVertex] = 0

        pq = []
        q.heappush(pq, (sVertex, 0))

        while len(pq) > 0:
            u = q.heappop(pq)
            for u,v,w in G.graph:
                if dist[v] < dist[u] * w:
                    dist[v] = dist[u] * w
                    prev[v] = u
                    q.heappush(pq, (v, dist[v]))

        return dist, prev
        

while(inDungeon):
    params = sys.stdin.readline().split()

    n, m = params[0], params[1]

    vList = [None] * n # list of vertices

    G = Graph(n)

    if m is 0 and n is 0: # break out if we reach EOF
        inDungeon = False

    for i in range(0, m):
        params = sys.stdin.readline().split()

        # Add vertices with weight of dmg
        G.addEdge(params[0], params[1], params[2])

    dist, prev = G.Dijkstras(0, vList, G)
    print(dist[n])



    