absValue :: Integer -> Integer
absValue x = if x < 0 then -x else x

power :: Integer -> Integer -> Integer
power x p = if p == 0 then 1 else x * power x (p - 1)

hasDivisors :: Integer -> Integer -> Bool
hasDivisors n divisor
 | divisor * divisor > n = False
 | mod n divisor == 0 = True
 | otherwise = hasDivisors n (divisor+1)

isPrime :: Integer -> Bool
isPrime 0 = False
isPrime 1 = False
isPrime n = not (hasDivisors n 2)

slowFib :: Integer -> Integer
slowFib n = if n == 0 then 0 else if n == 1 then 1 else slowFib (n-1) + slowFib (n-2)

quickFibonacci :: Integer -> Integer -> Integer -> Integer
quickFibonacci x y 0 = x
quickFibonacci x y iteration = quickFibonacci y (x + y) (iteration - 1)

quickFib :: Integer -> Integer
quickFib x = quickFibonacci 0 1 x
