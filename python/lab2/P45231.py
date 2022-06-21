def fibs():
    a = 0
    yield a
    b = 1
    while True:
        yield b
        a, b = b, a +  b

def roots(x):
    yield x
    n = x
    while True:
        n = 0.5 * (n + (x / n))
        yield n

def hasDivisors(n,divisor):
    if(divisor*divisor > n): return False
    elif(n % divisor == 0): return True
    else: return hasDivisors(n, divisor+1)

def isPrime(x):
    if(x == 0 or x == 1): return False
    return not(hasDivisors(x,2))

def primes():
    x = 2
    yield x
    while True:
        x = x +1
        if isPrime(x): 
            yield x

def isHamming(x):
    if x == 1: return True
    elif x % 2 == 0: return isHamming(x/2)
    elif x % 3 == 0: return isHamming(x/3)
    elif x % 5 == 0: return isHamming(x/5)
    return False


def hammings():
    x = 1
    yield x
    while True:
        x = x+1
        if isHamming(x):
            yield x