convertion :: Int -> Either Int String
convertion x
    | mod x 3 == 0 && mod x 5 == 0 = Right "FizzBuzz"
    | mod x 3 == 0 = Right "Fizz"
    | mod x 5 == 0 = Right "Buzz"
    | otherwise = Left x

fizzBuzz :: [Either Int String]
fizzBuzz = map (convertion) [0..]
