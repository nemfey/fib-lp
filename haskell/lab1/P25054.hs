myLength :: [Integer] -> Integer
myLength [] = 0
myLength (x:xs) = 1 + myLength(xs)


myMaximum :: [Integer] -> Integer
myMaximum [x] = x
myMaximum (x:xs)
 | x > max = x
 | otherwise = max
 where max = myMaximum xs
 

average :: [Integer] -> Float
average list = fromIntegral (sum list) / fromIntegral (length list)


buildPalindrome :: [Integer] -> [Integer]
buildPalindrome [] = []
buildPalindrome list = reverse list ++ list


hasNumber :: [Int] -> Int -> Bool
hasNumber [] y = False;
hasNumber (x:xs) y
 | x == y = True
 | otherwise = hasNumber xs y

remove :: [Int] -> [Int] -> [Int]
remove [] [] = []
remove [] listToRemove = []
remove list [] = list
remove (x:xs) listToRemove
 | hasNumber listToRemove x = remove xs listToRemove
 | otherwise = (x:(remove xs listToRemove))


flatten :: [[Int]] -> [Int]
flatten [] = []
flatten (x:xs) = x ++ flatten xs

oddList :: [Integer] -> [Integer]
oddList [] = []
oddList (x:xs)
 | not (even x) = (x:(oddList xs))
 | otherwise = oddList xs

evenList :: [Integer] -> [Integer]
evenList [] = []
evenList (x:xs)
 | even x = (x:(evenList xs))
 | otherwise = evenList xs

oddsNevens :: [Integer] -> ([Integer],[Integer])
oddsNevens [] = ([],[])
oddsNevens list = ((oddList list),(evenList list))


hasDivisors :: Integer -> Integer -> Bool
hasDivisors n divisor
 | divisor * divisor > n = False
 | mod n divisor == 0 = True
 | otherwise = hasDivisors n (divisor+1)

isPrime :: Integer -> Bool
isPrime 0 = False
isPrime 1 = False
isPrime n = not (hasDivisors n 2)

primeDivisors :: Integer -> [Integer]
primeDivisors n = [divisor | divisor <- [1..n], mod n divisor == 0, isPrime divisor]






