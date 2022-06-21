eql :: [Int] -> [Int] -> Bool
eql x y
    | not (length(x) == length(y)) = False
    | otherwise = all (==True) (zipWith (==) x y)
--  | otherwise = all (==0) (zipWith (-) x y)

prod :: [Int] -> Int
prod x = foldl (*) 1 x

prodOfEvens :: [Int] -> Int
prodOfEvens x = prod (filter even x)

powersOf2 :: [Int]
powersOf2 = iterate (*2) 1

scalarProduct :: [Float] -> [Float] -> Float
scalarProduct x y = sum (zipWith (*) x y)
