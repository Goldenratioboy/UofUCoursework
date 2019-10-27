import sys

import heapq as q  

from collections import defaultdict

#graph class to represent graph
class graph:

    def __init__(self, vertices):
        self.V = vertices
        self.graph = dict()

    def addEdge(self, u, v, w):
        self.graph[u,v] = w

    def Dijkstras(self, sVertex, numVertexes, E, AdjacencyList):

        dist = [-1] * numVertexes

        dist[sVertex] = 1

        pq = []
        q.heappush(pq, (-1, sVertex))
        
        trackPop = dict() #First item that pops will be the one

        while len(pq) > 0:

            u = q.heappop(pq) 

            if trackPop.get(u[1]*-1) is True:
                continue

            trackPop[u[1]*-1] = True

            for v in AdjacencyList[u[1]]:

                weight = E.graph[u[1],v]

                if dist[v] < dist[u[1]] * weight:
                    dist[v] = dist[u[1]] * weight
                    q.heappush(pq, (-1 * dist[v], v))

        return dist
        
inDungeon = True

while(inDungeon):

    AdjacencyList = defaultdict(list)

    params = sys.stdin.readline().split()

    n, m = int(params[0]), int(params[1])

    if m is 0 and n is 0: # break out if we reach EOF
        inDungeon = False
        break
  
    G = graph(n)

    for i in range(0, m):
        params = sys.stdin.readline().split()
        # Add vertices with weight of dmg
        G.addEdge(int(params[0]), int(params[1]), float(params[2]))
        G.addEdge(int(params[1]), int(params[0]), float(params[2]))

        AdjacencyList[int(params[0])].append(int(params[1])) # Add vertices to AdjacencyList
        AdjacencyList[int(params[1])].append(int(params[0]))

    dist = G.Dijkstras(0, n, G, AdjacencyList)

    if dist[n-1] is -1:
        print( "{:.{}f}".format( 1 , 4 ) )
    else:
        print( "{:.{}f}".format( dist[n-1], 4 ) )

    