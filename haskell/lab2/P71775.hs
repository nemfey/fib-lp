countIf :: (Int -> Bool) -> [Int] -> Int
countIf op list = length (filter op list)
--countIf op list = foldl (+) 0 (map (const 1) (filter op list))

pam :: [Int] -> [Int -> Int] -> [[Int]]
pam _ [] = []
--pam list (op:ops) = (map op list):(pam list ops)
pam list ops = map (\f -> map(\elem -> f elem) list) ops

pam2 :: [Int] -> [Int -> Int] -> [[Int]]
pam2 list ops = map (\elem -> map(\f -> f elem) ops) list 

filterFoldl :: (Int -> Bool) -> (Int -> Int -> Int) -> Int -> [Int] -> Int
filterFoldl f op ini list = foldl op ini (filter f list)

insert :: (Int -> Int -> Bool) -> [Int] -> Int -> [Int]
insert _ [] n = [n]
insert op (x:xs) n
 | (op x n) = x:(insert op xs n)
 | otherwise = n:(x:xs)

insertionSort :: (Int -> Int -> Bool) -> [Int] -> [Int]
insertionSort op list = foldl (insert op) [] list
