myFoldl :: (a -> b -> a) -> a -> [b] -> a
myFoldl op ini [] = ini
myFoldl op ini (x:xs) = myFoldl op (op ini x) xs

myFoldr :: (a -> b -> b) -> b -> [a] -> b
myFoldr op ini [] = ini
myFoldr op ini (x:xs) = op x (myFoldr op ini xs)

myIterate :: (a -> a) -> a -> [a]
myIterate op x = x:(myIterate op (op x))

myUntil :: (a -> Bool) -> (a -> a) -> a -> a
myUntil stop op x
 | stop x = x
 | otherwise = myUntil stop op (op x)

myMap :: (a -> b) -> [a] -> [b]
myMap op list = myFoldr (\x i -> (op x):i) [] list

myFilter :: (a -> Bool) -> [a] -> [a]
myFilter op list = myFoldr (\x i -> if op x then x:i else i) [] list

myAll :: (a -> Bool) -> [a] -> Bool
myAll op list = myFoldr (\x y -> (op x) && y ) True list

myAny :: (a -> Bool) -> [a] -> Bool
myAny op list = myFoldr (\x y -> (op x) || y) False list

myZip :: [a] -> [b] -> [(a,b)]
myZip [] [] = []
myZip _ [] = []
myZip [] _ = []
myZip (x:xs) (y:ys) = (x,y):myZip xs ys

myZipWith :: (a -> b -> c) -> [a] -> [b] -> [c]
myZipWith op xs ys = myFoldr (\(x,y) a -> (op x y):a) [] (myZip xs ys)
