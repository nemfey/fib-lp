def myLength(L):
    length = 0
    for i in L:
        length = length + 1
    return length

def myMaximum(L):
    max = L[0]
    for x in L:
        if(x > max): max = x
    return max

def average(L):
    sum = 0
    for x in L:
        sum = sum + x
    return sum / len(L)

def buildPalindrome(L):
    p = []
    for x in L:
        p.insert(0,x)
    for x in L:
        p.append(x)
    return p

def remove(L1,L2):
    removed = []
    for x in L1:
        if x not in L2:
            removed.append(x)
    return removed

def flatten(L):
    flat = []
    for x in L:
        if (isinstance(x, list)):
            flat += flatten(x)
        else:
            flat.append(x)
    return flat


def oddsNevens(L):
    odds = []
    evens = []
    for x in L:
        if(x%2 == 0): evens.append(x)
        else: odds.append(x)
    return (odds, evens)

def hasDivisors(n,divisor):
    if(divisor*divisor > n): return False
    elif(n % divisor == 0): return True
    else: return hasDivisors(n, divisor+1)

def isPrime(x):
    if(x == 0 or x == 1): return False
    return not(hasDivisors(x,2))

def primeDivisors(n):
    primes = []
    for i in range(1, n+1):
        if(n % i == 0 and isPrime(i)):
            primes.append(i)
    return primes