import sys
from operator import itemgetter

params = sys.stdin.readline().split()

N = int(params[0]) # number of people in the bank
T = int(params[1]) # time in min before bank closes

q = []
for i in range(0,N): 
    params = sys.stdin.readline().split()
    q.append((int(params[0]), int(params[1]))) # tuple contains (cash in hand, time until person leaves)

q = sorted(q, key=itemgetter(0))

total = 0

masterQ = list(bytearray(T))

# greedy algo where we take max value every time
for i in range(0, N):

    temp = q.pop(-1)
    for j in reversed(range(temp[1]+1)):
        if masterQ[j] == 0:
            masterQ[j] = temp[0]
            break

for val in masterQ:
    total += val

print(total)

    