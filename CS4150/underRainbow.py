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

penaltyArray = [0] * n # this array will contain min penalties for each hotel

for i in range(0, n):
    currPenalty = (400 - dist[i])**2 # this is current penalty if we drove straight to hotel from munchkinland
    for j in range(i):
        if (400 - (dist[i] - dist[j]))**2 + penaltyArray[j] < currPenalty:
            currPenalty = (400 - (dist[i] - dist[j]))**2 + penaltyArray[j]

    penaltyArray[i] = currPenalty


print(penaltyArray[-1])