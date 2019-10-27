import sys.stdin

def gcd(a, b):
    if b == 0:
        return a
    else:
        return gcd(b, a % b)

def modexp(x, y, N):
    if y == 0:
        return 1
    else:
        z = modexp(x, y/2, N)
        if y % 2 == 0:
            return z**2 % N # even
        else:
            return x*z**2 % N

def isPrime(N):
    if (modexp(2, N-1, N) & modexp(3, N-1, N) & modexp(5, N-1, N)) == 1:
        return "yes"
    else:
        return "no"

def ee(a, b): # extended Euclid's
    if b == 0:
        return [1, 0, a]
    else:
        [x, y, d] = ee(b, a % b)
        return [y, x - (a/b)*y, d]

def inverse(a, N):
    [x, y, d] = ee(a, N)
    if d == 1:
        return x % N
    else
        return "None"




# main loop
while(sys.stdin):
    params = sys.stdin.readline.split()

    if params[0] is 'gcd': # Perform gcd computation
        print(gcd(params[1], params[2]))

    elif params[0] is 'exp': # Perform exp computation
        print(modexp(params[1], params[2], params[3]))

    elif params[0] is 'inverse': # Perform inverse computation
        print(inverse(params[1], params[2]))

    elif params[0] is 'isprime': # Perform isPrime Computation
        print(isPrime(params[1]))

    else: # should be key computation

