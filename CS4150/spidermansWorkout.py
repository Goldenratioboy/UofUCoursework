import sys
import math

n = int(sys.stdin.readline()) # number of test scenarios

spidermanDict = dict()
resultDict = dict()
bestHeight = math.inf

def climb(dist, i, currPos, maxHeight):

    global bestHeight

    # alternate base case
    if currPos > bestHeight: # if we've already climbed higher than an already found optimal solution, return
        return math.inf

    if currPos > maxHeight: # update current maximum building required
        maxHeight = currPos

    # base case
    if i == len(dist) - 1:

        if currPos - dist[i] == 0:
            if bestHeight > maxHeight:
                bestHeight = maxHeight
                # add this index to dict for up/down printing
                spidermanDict[i, currPos] = bestHeight
                resultDict[i, bestHeight] = currPos
                return bestHeight # we are at ground level
            else:
                return math.inf # we've found a more optimal solution, do not return 0

        else:
            return math.inf

    # reorganized dynamic programming
    if (i, currPos) in spidermanDict.keys() and maxHeight > bestHeight: # don't use a cached value if we might find a better solution
        return spidermanDict[i, currPos]

    else:
        if currPos - dist[i] < 0:
            spidermanDict[i, currPos] = climb(dist, i+1, currPos+dist[i], maxHeight)
            resultDict[i, bestHeight] = currPos
            return spidermanDict[i, currPos]
        else:
            spidermanDict[i, currPos] = min(climb(dist, i+1, currPos - dist[i], maxHeight), climb(dist, i+1, currPos + dist[i], maxHeight)) # climb up or down
            resultDict[i, bestHeight] = currPos
            return spidermanDict[i, currPos]


for i in range(n):

    m = int(sys.stdin.readline())
    array = [0]*m # temp list of distances
    params = sys.stdin.readline().split()

    for j in range(m):
        array[j] = int(params[j])

    # call recursive function here
    result = climb(array, 0, 0, 0)

    if result == math.inf:
        print("IMPOSSIBLE")

    else:
        resultArray = [0]*m

        for j in range(m):
            resultArray[j] = resultDict[j, result]

        letterArray = [0]*m  
        for i in range(m):
            if i == 0:
                pass
            else:
                if resultArray[i] > resultArray[i-1]:
                    letterArray[i-1] = 'U'
                else:
                    letterArray[i-1] = 'D'

        letterArray[-1] = 'D' # always end with Down

        print(''.join(letterArray))
 
    bestHeight = math.inf # reset global var
    spidermanDict.clear() # reset dictionary
    resultDict.clear()