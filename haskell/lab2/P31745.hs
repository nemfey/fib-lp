flatten :: [[Int]] -> [Int]
flatten x = foldl (++) [] x

myLength :: String -> Int
myLength s = foldl (+) 0 (map (const 1) s)
--myLength s = length s

myReverse :: [Int] -> [Int]
myReverse = foldl (flip(:)) []
--myReverse x = reverse x

countIn :: [[Int]] -> Int -> [Int]
countIn list n = map (\sublist -> length (filter (==n) sublist)) list

firstWord :: String -> String
firstWord s = takeWhile (/=' ') (dropWhile (==' ') s)
