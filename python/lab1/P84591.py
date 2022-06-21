def absValue(x):
    if(x < 0): x = -x
    return x

def power(x,p):
    if(p == 0): return 1
    return x * power(x,p-1)

def hasDivisors(n,divisor):
    if(divisor*divisor > n): return False
    elif(n % divisor == 0): return True
    else: return hasDivisors(n, divisor+1)

def isPrime(x):
    if(x == 0 or x == 1): return False
    return not(hasDivisors(x,2))


def slowFib(x):
    if(x==0): return 0
    elif(x==1): return 1
    return slowFib(x-1) + slowFib(x-2)

def quickFibonnacci(a,b,x):
    if(x == 0): return a
    return quickFibonnacci(b, a+b, x-1)

def quickFib(x):
    return quickFibonnacci(0,1,x)
