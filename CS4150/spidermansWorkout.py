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
            spidermanDict[i, currPos, maxHeight] = (0, maxHeight)
            bestMaxHeight = maxHeight
            return 0, maxHeight # we are at ground level
        else:
            return math.inf, maxHeight

    if currPos - dist[i] < 0: # cannot climb below ground level

        if (i, currPos, maxHeight) in spidermanDict.keys():
            return spidermanDict[i, currPos, maxHeight]
        else:
            spidermanDict[i, currPos, maxHeight] = climb(dist, i+1, currPos+dist[i], maxHeight)
        
        return spidermanDict[i, currPos, maxHeight]

    else:
        if (i, currPos, maxHeight) in spidermanDict.keys():
            return spidermanDict[i, currPos, maxHeight]
        else:
            spidermanDict[i, currPos, maxHeight] = min(climb(dist, i+1, currPos - dist[i], maxHeight), climb(dist, i+1, currPos + dist[i], maxHeight)) # climb up or down
        
        return spidermanDict[i, currPos, maxHeight]

for i in range(n):
    array = list() # temp list of distances

    m = int(sys.stdin.readline())
    params = sys.stdin.readline().split()

    for j in range(m):
        array.append(int(params[j]))

    # call recursive function here
    maxHeight = 0
    result = climb(array, 0, 0, maxHeight)
    if result[0] == math.inf:
        print("IMPOSSIBLE")

    else:
        updownresult = [0]*m

        for key, val in spidermanDict.items():
            if val == result:
                if updownresult[key[0]] == 0:
                    updownresult[key[0]] = key[1]
                else:
                    pass # do not overwrite the value if we've seen this before

        for i in range(0, len(updownresult)):
            if i == 0:
                pass
            else:
                if updownresult[i] > updownresult[i-1]:
                    print('U', end='')
                else:
                    print('D', end='')

        print('D') # sequence always ends with down to the ground

        bestMaxHeight = math.inf # reset global var
        spidermanDict.clear() # reset dictionary



