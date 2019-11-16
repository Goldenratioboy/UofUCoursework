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
        #print(result) # need to figure out how to print U/D
        updownresult = list()
        updownresult.append('D')
        index = None
        for key, val in spidermanDict.items():
            if val == result:
                if index == None: # dont do anything first pass
                    index = key[1]
                else:
                    if index > key[1]:
                        updownresult.append('U')
                    else:
                        updownresult.append('D') 

                    index = key[1]
        result = ""
        for i in updownresult:
            result = i + result

        print(result, sep='')

        bestMaxHeight = math.inf # reset global var
        spidermanDict.clear() # reset dictionary



