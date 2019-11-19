import sys
import math

n = int(sys.stdin.readline()) # number of test scenarios

bestMaxHeight = math.inf # make a global max best height
spidermanDict = dict()

def climb(dist, i, currPos, maxHeight):

    global bestMaxHeight

    # alternate base case, end recursion early if we exceed our bestMaxHeight
    if currPos > bestMaxHeight:
        return math.inf, maxHeight

    # check if we're at new max height
    if currPos > maxHeight:
        maxHeight = currPos

    # base case
    if i == len(dist) - 1:
        if currPos - dist[i] == 0:

            # add this index to dict for up/down printing
            spidermanDict[i, currPos, bestMaxHeight] = 0, maxHeight
            bestMaxHeight = maxHeight

            return 0, maxHeight # we are at ground level
        else:
            return math.inf, maxHeight

    if currPos - dist[i] < 0: # cannot climb below ground level

        if (i, currPos) in spidermanDict.keys():
            return spidermanDict[i, currPos, bestMaxHeight]
        else:
            spidermanDict[i, currPos, bestMaxHeight] = climb(dist, i+1, currPos+dist[i], maxHeight)
        
        return spidermanDict[i, currPos, bestMaxHeight]

    else:
        if (i, currPos) in spidermanDict.keys():
            return spidermanDict[i, currPos, bestMaxHeight]
        else:
            spidermanDict[i, currPos, bestMaxHeight] = min(climb(dist, i+1, currPos - dist[i], maxHeight), climb(dist, i+1, currPos + dist[i], maxHeight)) # climb up or down
        
        return spidermanDict[i, currPos, bestMaxHeight]

for i in range(n):

    m = int(sys.stdin.readline())
    array = [0]*m # temp list of distances
    params = sys.stdin.readline().split()

    for j in range(m):
        array[j] = int(params[j])

    # call recursive function here
    result = climb(array, 0, 0, 0)

    if result[0] == math.inf:
        print("IMPOSSIBLE")

    else:
        resultArray = [None]*m

        for key, val in spidermanDict.items():
            print(key, val)
            if val == result:
                resultArray[key[0]] = key[1]

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
 
    bestMaxHeight = math.inf # reset global var
    spidermanDict.clear() # reset dictionary