import sys
import math

n = int(sys.stdin.readline()) # number of test scenarios

spidermanDict = dict()
solutionDict = dict()

def climb(dist, i, currPos, maxHeight):

    if currPos > maxHeight: # update current maximum building required
        maxHeight = currPos

    # base case
    if i == len(dist) - 1:

        if currPos - dist[i] == 0:
            return maxHeight # returns max building height
        else:
            return math.inf

    # reorganized dynamic programming
    if (i, currPos) in spidermanDict.keys():
        return spidermanDict[i, currPos]

    else:
        if currPos - dist[i] < 0: # we can only go up
            spidermanDict[i, currPos] = climb(dist, i+1, currPos+dist[i], maxHeight)
            return spidermanDict[i, currPos]
        else:
            up = climb(dist, i+1, currPos + dist[i], maxHeight)
            down = climb(dist, i+1, currPos - dist[i], maxHeight)

            if up < down:
                solutionDict[i, currPos] = 'U'
                spidermanDict[i, currPos] = up
            else:
                solutionDict[i, currPos] = 'D'
                spidermanDict[i, currPos] = down
            
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

        for k, v in solutionDict.items():
            print(k, v)

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
 
    spidermanDict.clear() # reset dictionaries
    solutionDict.clear()
