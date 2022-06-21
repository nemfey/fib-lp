result :: Double -> String
result value
    | value < 18 = "magror"
    | value < 25 = "corpulencia normal"
    | value < 30 = "sobrepes"
    | value < 40 = "obesitat"
    | otherwise = "obesitat morbida"

imc :: String -> String -> String
imc weight height = result (w / (h*h))
    where w = read(weight) :: Double
          h = read(height) :: Double

calculate :: String -> String
calculate line = name ++ ": " ++ imc weight height
    where
        [name,weight,height] = words line

main = do
    line <- getLine
    
    if(line/="*") then do
        putStrLn $ calculate line
        main
    else
        return()
