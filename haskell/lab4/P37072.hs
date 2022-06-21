data Tree a = Node a (Tree a) (Tree a) | Empty
    deriving (Show)

t7 = Node 7 Empty Empty
t6 = Node 6 Empty Empty
t5 = Node 5 Empty Empty
t4 = Node 4 Empty Empty
t3 = Node 3 t6 t7
t2 = Node 2 t4 t5
t1 = Node 1 t2 t3
t1' = Node 1 t3 t2

size :: Tree a -> Int
size Empty = 0
size (Node _ tl tr) = 1 + (size tl) + (size tr)

height :: Tree a -> Int
height Empty = 0
height (Node _ tl tr) = 1 + max (height tl) (height tr)

equal :: Eq a => Tree a -> Tree a -> Bool
equal Empty Empty = True
equal _ Empty = False
equal Empty _ = False
equal (Node x xl xr) (Node y yl yr)
    | x == y = equal xl yl && equal xr yr
    | otherwise = False;

isomorphic :: Eq a => Tree a -> Tree a -> Bool
isomorphic Empty Empty = True
isomorphic _ Empty = False
isomorphic Empty _ = False
isomorphic (Node x xl xr) (Node y yl yr)
    | x == y = isomorphic xl yl || isomorphic xl yr || isomorphic xr yl || isomorphic xr yr
    | otherwise = False

preOrder :: Tree a -> [a]
preOrder Empty = []
preOrder (Node x tl tr) = [x] ++ preOrder tl ++ preOrder tr

postOrder :: Tree a -> [a]
postOrder Empty = []
postOrder (Node x tl tr) = postOrder tl ++ postOrder tr ++ [x]

inOrder :: Tree a -> [a]
inOrder Empty = []
inOrder (Node x tl tr) = inOrder tl ++ [x] ++ inOrder tr

breadthFirst :: Tree a -> [a]
breadthFirst t = bf [t]
 where
  bf [] = []
  bf (Empty : ts) = bf ts
  bf ((Node x tl tr) : ts) = (x : bf (ts ++ [tl,tr]))

build :: Eq a => [a] -> [a] -> Tree a
build [] [] = Empty
build [x] [y] = Node x Empty Empty
build (h:pre) ind = Node h (build lpre lin) (build rpre rin)
 where
  lin = takeWhile (/= h) ind
  lastl = last lin
  rin = tail $ dropWhile (/= h) ind
  lpre = takeWhile (/= lastl) pre ++ [lastl]
  rpre = tail $ dropWhile (/= lastl) pre

overlap :: (a -> a -> a) -> Tree a -> Tree a -> Tree a
overlap _ Empty Empty = Empty
overlap _ t1 Empty = t1
overlap _ Empty t2 = t2
overlap f (Node t1 lt1 rt1) (Node t2 lt2 rt2) = Node (f t1 t2) (overlap f lt1 lt2) (overlap f rt1 rt2)




