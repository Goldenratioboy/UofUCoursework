import sys


clock = 0

nCities = int(sys.stdin.readline())
postVisit = list()
visited = list()
cityList = dict()
adjacencyList = dict(list())

def postvisit(v):
    postVisit[v] = clock
    clock += 1

def explore(v):
    visited[v] = True
    for u, v in adjacencyList.items():
        if visited[u] is False:
            explore(u)
    postvisit(v)

# build vertex dictionary with costs set to value
for i in range(nCities):
    params = sys.stdin.readline().split()
    cityList[params[0]] = int(params[1])

nHighways = int(sys.stdin.readline())

#get edges for DAG
for i in range(nHighways):
    params = sys.stdin.readline().split()

    # builds dictionary, for every city we append a list of cities it points to
    if params[0] in adjacencyList:
        adjacencyList[params[0]].append(params[1])
    else :
        adjacencyList[params[0]] = list()
        adjacencyList[params[0]].append(params[1])

#DFS
for v in cityList:
    visited[v] = False
for v in cityList:
    if visited[v] is False:
        explore(v)

nTrips = int(sys.stdin.readline())

for i in range(nTrips):
    # This will be the bulk of our program
    pass
