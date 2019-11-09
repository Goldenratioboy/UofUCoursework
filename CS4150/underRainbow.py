import sys
import math

penaltyDict = dict()

def penaltyCalculation(x):
    return (400 - x)**2

n = sys.stdin.readline()
n = int(n)
n += 1
dist = [None] * n
for i in range(0,n):
    dist[i] = int(sys.stdin.readline())

kValues = []
kVal = 0
for i in range(0,len(dist)):
    if i == 0:
        pass
    else:
        minimumK = math.inf
        for k in range(i-1, -1, -1):           
            testVal = penaltyCalculation(dist[i]-dist[k])
            if minimumK > testVal:
                minimumK = testVal
                kVal = k
        kValues.append(kVal)
        
#append value of emerald city
kValues.append(n-1)       
finalPenalty = 0
for i in range(0,len(kValues)):
    if i == 0:
        pass
    else:
        if kValues[i] - kValues[i-1] == 0: # if k value hasn't changed yet, don't add to final penalty
            pass
        else:
            finalPenalty += penaltyCalculation(dist[kValues[i]]-dist[kValues[i-1]])

print(kValues)
print(finalPenalty)