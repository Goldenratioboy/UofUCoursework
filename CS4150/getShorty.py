import sys

import heapq as q  

from collections import defaultdict

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

        dist[sVertex] = 1

        pq = []
        q.heappush(pq, (sVertex, 0))

        while len(pq) > 0:
            u = q.heappop(pq)
            for u,v in E.graph.keys():
                if dist[v] < dist[u] * E.graph[u,v]:
                    dist[v] = dist[u] * E.graph[u,v]
                    prev[v] = u
                    q.heappush(pq, (v, dist[u]))

        return dist, prev
        
inDungeon = True

while(inDungeon):
    params = sys.stdin.readline().split()

    n, m = int(params[0]), int(params[1])

    if m is 0 and n is 0: # break out if we reach EOF
        inDungeon = False
        break

    vList = [None] * n # list of vertices

    G = graph(n)

    for i in range(0, m):
        params = sys.stdin.readline().split()
        # Add vertices with weight of dmg
        G.addEdge(int(params[0]), int(params[1]), float(params[2]))

    dist, prev = G.Dijkstras(0, vList, G)
    if dist[n-1] is -1:
        print( "{:.{}f}".format( 1 , 4 ) )
    else:
        print( "{:.{}f}".format( dist[n-1], 4 ) )

    