ones :: [Integer]
ones = repeat 1

nats :: [Integer]
nats = iterate (+1) 0

ints :: [Integer]
ints = tail $ foldr (++) [] $ map f nats
 where f x = [x, -x]

triangulars :: [Integer]
triangulars = triangulars' 0 0
 where triangulars' x y = (x+y) : triangulars' (x+y) (y+1)

factorials :: [Integer]
factorials = 1 : factorials' 1 1
 where factorials' x y = (x*y) : factorials' (x*y) (y+1)

fibs :: [Integer]
fibs = fibs' 0 1
 where fibs' x y = x : fibs' y (x+y)
--fibs = 0 : 1 : zipWith (+) fibs (tail fibs)

hasDivisors :: Integer -> Integer -> Bool
hasDivisors n divisor
 | divisor * divisor > n = False
 | mod n divisor == 0 = True
 | otherwise = hasDivisors n (divisor+1)

isPrime :: Integer -> Bool
isPrime 0 = False
isPrime 1 = False
isPrime n = not (hasDivisors n 2)

primes :: [Integer]
primes = primes' 2
 where primes' x = if (isPrime x) then x : primes' (x+1) else primes' (x+1)
  
merge2 :: [Integer] -> [Integer] -> [Integer]
merge2 a [] = a
merge2 [] b = b
merge2 (a:as) (b:bs)
 | a < b = a : (merge2 as (b:bs))
 | b < a = b : (merge2 (a:as) bs)
 | otherwise = merge2 (a:as) bs

merge3 :: [Integer] -> [Integer] -> [Integer] -> [Integer]
merge3 xs ys zs = merge2 (merge2 xs ys) zs

hammings :: [Integer]
hammings = 1 : merge3 (map (*2) hammings) (map (*3) hammings) (map (*5) hammings)

next :: [Char] -> [Char]
next [] = []
next cs = (show n) ++ [pr] ++ next list
 where
  pr = head cs
  n = length $ takeWhile ( == pr) cs
  list = dropWhile ( == pr) cs

count :: Integer -> Integer
count n = read $ next $ show n

lookNsay :: [Integer]
lookNsay = iterate count 1

pascal :: [Integer] -> [Integer]
pascal xs = zipWith (+) (xs ++ [0]) ([0] ++ xs)

tartaglia :: [[Integer]]
tartaglia = (iterate (pascal) [1])
