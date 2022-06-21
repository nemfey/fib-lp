myMap :: (a -> b) -> [a] -> [b]
myMap f xs = [f x | x <- xs]
--myMap _ [] = []
--myMap f (x:xs) = (f x):(myMap f xs)

myFilter :: (a -> Bool) -> [a] -> [a]
myFilter f xs = [x | x <- xs, f x]
--myFilter _ [] = []
--myFilter f (x:xs)
--    | (f x) = x:(myFilter f xs)
--    | otherwise = myFilter f xs

myZipWith :: (a -> b -> c) -> [a] -> [b] -> [c]
myZipWith f xs ys = [f x y | (x,y) <- zip xs ys]
--myZipwith _ [] _ = []
--myZipWith _ _ [] = []
--myZipWith f (x:xs) (y:ys) = (f x y):myZipWith f xs ys

thingify :: [Int] -> [Int] -> [(Int,Int)]
thingify xs ys = [(x,y) | x <- xs, y <- ys, x `mod` y == 0]
--thingify (x:xs) (y:ys) = 

factors :: Int -> [Int]
factors n = [x | x <- [1..n], n `mod`x == 0]
