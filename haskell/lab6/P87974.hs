main = do
    name <- getLine
    let first = take 1 name
    if first == "A" || first == "a" then do
        putStrLn $ "Hello!"
    else
        putStrLn $ "Bye!"
