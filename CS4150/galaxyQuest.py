import sys

def distance(p1, p2, d):
    if (p1[0] - p2[0])**2 + (p1[1] - p2[1])**2 <= d:
        return True
    else:
        return False


starList = set()

#Read first line to get params
params = sys.stdin.readline().split()
d = int(params[0]) #Size of PU
k = int(params[1]) #Number of stars to read

#Create our list of stars
for i in sys.stdin:
    params = i.split()
    starList.add((int(params[0]), int(params[1])))

d2 = d**2

highestStarCount = 0

for star in starList:
    count = 1 # Must count this first star if we find other stars
    for star2 in starList:
        if star is star2:
            break
        if distance(star, star2, d2) is True:
            count += 1

    if count > highestStarCount:
        highestStarCount = count


if highestStarCount > k/2:
    print(highestStarCount)
else:
    print('NO')    
