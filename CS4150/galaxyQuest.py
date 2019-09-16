import sys

def distance(p1, p2, d):
    if (p1[0] - p2[0])**2 + (p1[1] - p2[1])**2 <= d:
        return True
    else:
        return False

def distanceTest(x, y, d):
    if x + y <= d:
        return True
    else:
        return False

# A is an array of stars, (x,y) coordinates
def StarCounter(A, d):
    if len(A) is 0:
        return None
    elif len(A) is 1:
        return A[0]
    else:
        APrime = list()

        for p1, p2 in zip(*[iter(A)]*2):
            if distance(p1, p2, d) is True:
                APrime.append(p1)
        if len(A) % 2 != 0:
            #list is uneven
            y = A[-1]
        else:
            y = None

        x = StarCounter(APrime, d)

        if x is None:
            if len(A) % 2 != 0:
                yCount = 0
                for star in A:
                    if distance(star, y, d) is True:
                        yCount += 1
                if yCount > len(A)/2:
                    return y
                else:
                    return None
            else:
                return None
        else:
            xCount = 0
            for star in A:
                if distance(star, x, d) is True:
                    xCount += 1
            if xCount > len(A)/2:
                return x
            else:
                return None




starList = list()

#Read first line to get params
params = sys.stdin.readline().split()
d = int(params[0]) #Size of PU
k = int(params[1]) #Number of stars to read

#Create our list of stars
for i in sys.stdin:
    params = i.split()
    starList.append((int(params[0]), int(params[1])))

d2 = d**2

finalStar = StarCounter(starList, d2)

if finalStar is None:
    print('NO')
else:
    count = 0

    for star in starList:
        if distance(finalStar, star, d2) is True:
            count += 1
    if count > k/2:
        print(count)
    else:
        print('NO')
