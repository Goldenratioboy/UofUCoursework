import sys
import math

myList = dict()

params = sys.stdin.readline().split()

n = int(params[0])
k = int(params[1])

values = [[0]*2 for i in range(n+1)]

for i in range(n+1):
    params = sys.stdin.readline().split()
    values[i][0] = int(params[0])
    values[i][1] = int(params[1])

def maxValue(r, unclosableRoom, k):
    # base case
    if k == 0: # if we've run out of rooms to close, add up the remaining values in the narrow art gallery
        lastRooms = 0
        for i in range(r,n):
            lastRooms += values[i][0]
            lastRooms += values[i][1]

        return lastRooms

    # if k = n - r && unclosable room = 0
    elif k == n-r and unclosableRoom == 0:
        if (r,0,k) in myList.keys():
            return myList[r,0,k]
        else:
            myList[r,0,k] = values[r][0]+maxValue(r+1,0,k-1)
        
        return myList[r,0,k] 

    # if k = n - r && unclosable room = 1
    elif k == n-r and unclosableRoom == 1:
        if (r,1,k) in myList.keys():
            return myList[r,1,k]
        else:
            myList[r,1,k] = values[r][1]+maxValue(r+1,1,k-1)

        return myList[r,1,k] 

    # if k = n - r && unclosable room = -1 -> should be larger of two options
    elif k == n-r and unclosableRoom == -1:
        if (r,-1,k) in myList.keys():
            return myList[r,-1,k]
        else:
            myList[r,-1,k] = max(values[r][0]+maxValue(r+1,0,k-1), values[r][1]+maxValue(r+1,1,k-1))
        
        return myList[r,-1,k]

    # if unclosable room = 0 -> should be larger of two options
    elif unclosableRoom == 0:
        if (r,0,k) in myList.keys():
            return myList[r,0,k]
        else:
            myList[r,0,k] = max(values[r][0]+maxValue(r+1,0,k-1), values[r][0]+values[r][1]+maxValue(r+1,-1,k))

        return myList[r,0,k] 

    # if unclosable room = 1 -> should be larger of two options
    elif unclosableRoom == 1:
        if (r,1,k) in myList.keys():
            return myList[r,1,k]
        else:
            myList[r,1,k] = max(values[r][1]+maxValue(r+1,1,k-1), values[r][0]+values[r][1]+maxValue(r+1,-1,k))

        return myList[r,1,k] 

    # if unclosable room = -1 -> should be larger of three options  
    else:
        if (r,-1,k) in myList.keys():
            return myList[r,-1,k]
        else:
            myList[r,-1,k] = max(values[r][0]+maxValue(r+1,0,k-1), values[r][1]+maxValue(r+1,1,k-1), values[r][0]+values[r][1]+maxValue(r+1,-1,k))

        return myList[r,-1,k] 

print(maxValue(0, -1, k))