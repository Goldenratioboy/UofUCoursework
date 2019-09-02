#! /usr/bin/python3

import sys
count = 0
myList = set()
badList = set()

params = sys.stdin.readline()
nk = params.split()
n = int(nk[0]) # n = number of words
k = int(nk[1]) # k = number of letters per word

for line in sys.stdin:
    item = ''.join(sorted(line))
    if item in myList:
        myList.remove(item) # remove it!
        badList.add(item)
    elif item not in badList:
        myList.add(item)
print(len(myList))      