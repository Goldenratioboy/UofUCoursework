import sys
import math

n = int(sys.stdin.readline())
visited = set()
matrix = [[0]*n for i in range(n)]
bestSoFar = math.inf
minEdgeWeight = math.inf


def travel(currVertex, currTotal, currLen):
    global matrix
    global bestSoFar

    if currTotal + (n - currLen) * minEdgeWeight >= bestSoFar:
        return

    if currLen == n - 1:
        bestSoFar = min(bestSoFar, currTotal + matrix[currVertex][0])

    else:
        for vertex in range(n):
            if vertex not in visited:
                visited.add(vertex)
                travel(vertex, currTotal+matrix[currVertex][vertex], currLen+1)
                visited.remove(vertex)
                

for i in range(n):
    params = sys.stdin.readline().split()

    for j in range(n):
        potentialMin = int(params[j])
        if potentialMin < minEdgeWeight:
            minEdgeWeight = potentialMin

        matrix[i][j] = potentialMin

visited.add(0)
travel(0, 0, 0)
print(matrix)
print(bestSoFar)
