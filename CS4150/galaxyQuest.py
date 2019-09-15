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
    print(A)
    print(d)
    if len(A) is 0:
        return None    
    elif len(A) is 1:
        return A
    else:
        aPrime = []
        y = []

        #Finding A' array of stars and y value?
        for p1, p2, p3 in zip(*[iter(A)]*3):
            if distance(p1, p2, d) is True and distance(p1, p3, d) is True:
                aPrime.append(p1)
        if len(A) % 3 == 1 or len(A) % 3 == 2:
            y.append(A[-1])

        x = StarCounter(aPrime, d) # call again with smaller list
        
        if x is None:
            yCount = 0
            if len(A) % 3 != 0:
                for star in A:
                    if distance(star, y, d) is True:
                        yCount += 1              
                if yCount >= 2:
                    return y                
                else:
                    return None

            else:
                return None

                
        else:
            xCount = 0
            for i in A:
                if distance(i, x, d) is True:
                    xCount += 1
            if xCount >= 2:
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

finalList = StarCounter(starList, d2)

print('Final List:' + finalList)

if finalList is None:
    print('NO')
else:
    count = 0

    for star in starList:
        if distance(finalList[0], star, d) is True:
            count += 1
    if count > k/2:
        print(count)
    else:
        print('NO')
