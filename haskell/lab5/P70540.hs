data Expr = Val Int | Add Expr Expr | Sub Expr Expr | Mul Expr Expr | Div Expr Expr

eval1 :: Expr -> Int
eval1 (Val x) = x
eval1 (Add x y) = (eval1 x) + (eval1 y)
eval1 (Sub x y) = (eval1 x) - (eval1 y)
eval1 (Mul x y) = (eval1 x) * (eval1 y)
eval1 (Div x y) = div (eval1 x) (eval1 y)

{-
eval2 :: Expr -> Maybe Int
eval2 (Val x) = Just x
eval2 (Add x y) = computeMaybe (+) (eval2 x) (eval2 y)
eval2 (Sub x y) = computeMaybe (-) (eval2 x) (eval2 y)
eval2 (Mul x y) = computeMaybe (*) (eval2 x) (eval2 y)
eval2 (Div x y) = computeMaybe (div) (eval2 x) (eval2 y)

eval3 :: Expr -> Either String Int
eval3 (Val x) = Right x
eval3 (Add x y) = computeEither (+) (eval3 x) (eval3 y)
eval3 (Sub x y) = computeEither (-) (eval3 x) (eval3 y)
eval3 (Mul x y) = computeEither (*) (eval3 x) (eval3 y)
eval3 (Div x y) = computeEither (div) (eval3 x) (eval3 y)

--------------------

computeMaybe :: (Int -> Int -> Int) -> Maybe Int -> Maybe Int -> Maybe Int
computeMaybe div _ (Just 0) = Nothing
computeMaybe f maybeX maybeY =
 do
  x <- maybeX
  y <- maybeY
  Just (f x y)
  
computeEither :: (Int -> Int -> Int) -> Either String Int -> Either String Int -> Either String Int
computeEither div _ (Right 0) = Left "div0"
computeEither f eitherX eitherY =
 do
  x <- eitherX
  y <- eitherY
  Right(f x y)
-}
  
eval2 :: Expr -> Maybe Int
eval2 (Val x)       = Just x
eval2 (Add x y)     = do
    ex <- eval2 x
    ey <- eval2 y
    Just(ex + ey)
eval2 (Sub x y)     = do
    ex <- eval2 x
    ey <- eval2 y
    Just(ex-ey)
eval2 (Mul x y)     = do
    ex <- eval2 x
    ey <- eval2 y
    Just(ex*ey)
eval2 (Div x y)     = do
    ex <- eval2 x
    ey <- eval2 y
    if ey == 0 then Nothing else return (div ex ey)

eval3 :: Expr -> Either String Int
eval3 (Val x)       = Right x
eval3 (Add x y)     = do
    ex <- eval3 x
    ey <- eval3 y
    return (ex + ey)
eval3 (Sub x y)     = do
    ex <- eval3 x
    ey <- eval3 y
    return(ex-ey)
eval3 (Mul x y)     = do
    ex <- eval3 x
    ey <- eval3 y
    return(ex*ey)
eval3 (Div x y)     = do
    ex <- eval3 x
    ey <- eval3 y
    if ey == 0 then Left "div0" else return (div ex ey)
  
  
