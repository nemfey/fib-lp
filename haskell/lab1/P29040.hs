insert :: [Int] -> Int -> [Int]
insert [] n = [n]
insert (x:xs) n
 | x > n = n:(x:xs)
 | otherwise = (x:(insert xs n))

isort :: [Int] -> [Int]
isort [] = []
isort (x:xs) = insert (isort xs) x

remove :: [Int] -> Int -> [Int]
remove [] _ = []
remove (x:xs) n
 | x == n = xs
 | otherwise = x:(remove xs n)
 

ssort :: [Int] -> [Int]
ssort [] = []
ssort list = min:ssort(remove list min)
 where min = minimum list

merge :: [Int] -> [Int] -> [Int]
merge [] [] = []
merge [] list = list
merge list [] = list
merge (x:xs) (y:ys)
 | x < y = x:(merge xs (y:ys))
 | otherwise = y:(merge (x:xs) ys) 

splitHalf :: [Int] -> ([Int],[Int])
splitHalf [] = ([],[])
splitHalf list = splitAt (((length list) + 1) `div` 2) list

msort :: [Int] -> [Int]
msort [] = []
msort [x] = [x]
msort list = merge (msort (fst split)) (msort(snd split))
 where split = splitHalf list

smaller :: Ord a => [a] -> a -> [a]
smaller [] _ = []
smaller list x = [n | n <- list, n <= x]

greater :: Ord a => [a] -> a -> [a]
greater [] _ = []
greater list x = [n | n <- list, n > x]

qsort :: [Int] -> [Int]
qsort [] = []
qsort (x:xs) = (qsort (smaller xs x)) ++ (x:(qsort (greater xs x)))

genQsort :: Ord a => [a] -> [a]
genQsort [] = []
genQsort (x:xs) = (genQsort (smaller xs x)) ++ (x:(genQsort (greater xs x)))













