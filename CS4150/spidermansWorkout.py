import sys
import math

from collections import OrderedDict

n = int(sys.stdin.readline()) # number of test scenarios

bestMaxHeight = math.inf # make a global max best height
spidermanDict = OrderedDict()

def climb(dist, i, currPos, maxHeight):

    global bestMaxHeight

    # alternate base case, end recursion early if we exceed our bestMaxHeight
    if currPos > bestMaxHeight:
        return math.inf

    # check if we're at new max height
    if currPos > maxHeight:
        maxHeight = currPos

    # base case
    if i == len(dist) - 1:
        if currPos - dist[i] == 0:

            # add this index to dict for up/down printing
            spidermanDict[i, currPos] = 0
            bestMaxHeight = maxHeight
            return 0 # we are at ground level
        else:
            return math.inf

    if currPos - dist[i] < 0: # cannot climb below ground level

        if (i, currPos) in spidermanDict.keys():
            return spidermanDict[i, currPos]
        else:
            spidermanDict[i, currPos] = climb(dist, i+1, currPos+dist[i], maxHeight)
        
        return spidermanDict[i, currPos]

    else:
        if (i, currPos) in spidermanDict.keys():
            return spidermanDict[i, currPos]
        else:
            spidermanDict[i, currPos] = min(climb(dist, i+1, currPos - dist[i], maxHeight), climb(dist, i+1, currPos + dist[i], maxHeight)) # climb up or down
        
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
        k = 0
        resultArray = [None]*m

        while k < m:
            key, val = spidermanDict.popitem()
            if val == result:
                if resultArray[key[0]] == None:
                    resultArray[key[0]] = key[1]
                    k+=1
                else:
                    pass # don't overwrite values
        
        for i in range(m):
            if i == 0:
                pass
            else:
                if resultArray[i] > resultArray[i-1]:
                    print('U', end='')
                else:
                    print('D', end='')

        print('D') # sequence always ends with down to the ground
 
    bestMaxHeight = math.inf # reset global var
    spidermanDict.clear() # reset dictionary