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
q2 = q.copy() # make a copy of q

total = 0

# This is where we'll iterate through the list
for i in range(0, T):

    # if anybody is about to leave this min, help them! *Note that if there are multiple ppl leaving at this time, help the one with most cash
    if [item for item in q if item[1] == i]:
        total += max([item for item in q if item[1]==i])[0]        

    # else help the person with the most money
    else:
        flag = True
        while(flag):
            if not q: # if we've popped all of q, exit
                break

            temp = q.pop(-1) # pop greatest element from q, if that customer is already gone move on
            if temp[1] >= i:
                flag = False
                total += temp[0]

total2 = 0

# greedy algo where we take max value every time
for i in range(0, T):
    if not q2:
        break
    temp = q2.pop(-1)
    if temp[1] >= i:
        total2 += temp[0]

if total > total2:
    print(total)
else:
    print(total2)

    