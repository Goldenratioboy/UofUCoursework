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
    if len(A) is None:
        return None
    elif len(A) is 1:
        return A[0]
    else:
        half = round(len(A)/2)
        A1 = A[:half]
        A2 = A[half:]

        x = StarCounter(A1, d)
        y = StarCounter(A2, d)

        if x is None and y is None:
            return None
        elif x is None:
            yCount = 0
            for star in A:
                if distance(y, star, d):
                    yCount += 1
            if yCount > len(A)/2:
                return y
        elif y is None:
            xCount = 0
            for star in A:
                if distance(x, star, d):
                    xCount += 1
            if xCount > len(A)/2:
                return x
        else:
            xCount = 0
            yCount = 0
            for star in A:
                if distance(x, star, d):
                    xCount += 1
                if distance(y, star, d):
                    yCount += 1
            if xCount > len(A)/2:
                return x
            elif yCount > len(A)/2:
                return y
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
