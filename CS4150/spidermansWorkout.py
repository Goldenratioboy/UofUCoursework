import sys
import math

n = int(sys.stdin.readline()) # number of test scenarios

def climb(dist, i, currPos, maxHeight, spidermanDict):

    # check if we're at new max height
    if currPos > maxHeight:
        maxHeight = currPos

    # base case
    if i == len(dist) - 1:
        if currPos - dist[i] == 0:
            return 0, maxHeight # we are at ground level
        else:
            return math.inf, maxHeight

    if currPos - dist[i] < 0: # cannot climb below ground level

        if (i, currPos, maxHeight) in spidermanDict.keys():
            return spidermanDict[i, currPos, maxHeight]
        else:
            spidermanDict[i, currPos, maxHeight] = climb(dist, i+1, currPos+dist[i], maxHeight, spidermanDict)
        
        return spidermanDict[i, currPos, maxHeight]

    else:
        if (i, currPos, maxHeight) in spidermanDict.keys():
            return spidermanDict[i, currPos, maxHeight]
        else:
            spidermanDict[i, currPos, maxHeight] = min(climb(dist, i+1, currPos - dist[i], maxHeight, spidermanDict), climb(dist, i+1, currPos + dist[i], maxHeight, spidermanDict)) # climb up or down
        
        return spidermanDict[i, currPos, maxHeight]

for i in range(n):
    array = list() # temp list of distances
    spidermanDict = dict()

    m = int(sys.stdin.readline())
    params = sys.stdin.readline().split()

    for j in range(m):
        array.append(int(params[j]))

    # call recursive function here
    maxHeight = 0
    result = climb(array, 0, 0, maxHeight, spidermanDict)
    if result[0] == math.inf:
        print("IMPOSSIBLE")

    else:
        print(result) # need to figure out how to print U/D
        
        for key, val in spidermanDict.items():
            if val == result:
                print(key, val)



