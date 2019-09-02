#! /usr/bin/python3
import sys
import time
import random
import string

#Creating the set of og list values
ogList = set()

for i in range(2000):
    randomString = ''.join(random.choice(string.ascii_lowercase) for x in range(512))
    ogList.add(randomString)

start = time.time()
#Start Timing here, here is our algorithm
count = 0
myList = set()
badList = set()

for line in ogList:
    item = ''.join(sorted(line))
    if item in myList:
        myList.remove(item) # remove it!
        badList.add(item)
    elif item not in badList:
        myList.add(item)

end = time.time()

print((end - start) * 1000)