import sys
import math

def gcd(a, b):
    if b == 0:
        return a
    else:
        return gcd(b, a % b)

def modexp(x, y, N):
    z = 1
    y = bin(y)
    #for each bit b in y
    for i in range(2, len(y)):
        if y[i] == "1":
            z = x * pow(z,2) % N
        else:
            z = pow(z,2) % N
    
    return z

def isPrime(N):
    if modexp(2, N-1, N) == 1 and modexp(3, N-1, N) == 1 and modexp(5, N-1, N) == 1:
        return "yes"
    else:
        return "no"

def ee(a, b): # extended Euclid's
    if b == 0:
        return 1, 0, a
    else:
        x, y, d = ee(b, a % b)
        return y, x - math.floor(a/b)*y, d

def inverse(a, N):
    x, y, d = ee(a, N)
    if d == 1:
        return x % N
    else:
        return "none"

def key(p, q): #prints modolus, public exponent, private exponent
    N = p*q
    phi = (p-1) * (q-1)
    #public exponent e, where gcd(phi, e) = 1
    for i in range(2, phi):
        if gcd(i, phi) == 1:
            e = i
            break
    
    #private exponent d, so that ed = 1 (mod phi)
    d = inverse(e, phi)

    return N, e, d

# main loop
for line in sys.stdin:
    params = line.split()

    if params[0] == "gcd": # Perform gcd computation
        print(gcd(int(params[1]), int(params[2])))

    elif params[0] == 'exp': # Perform exp computation
        print(modexp(int(params[1]), int(params[2]), int(params[3])))

    elif params[0] == 'inverse': # Perform inverse computation
        print(inverse(int(params[1]), int(params[2])))

    elif params[0] == 'isprime': # Perform isPrime Computation
        print(isPrime(int(params[1])))

    elif params[0] == 'key': # should be key computation
        mod, public, private = key(int(params[1]), int(params[2]))
        print(mod, public, private)
