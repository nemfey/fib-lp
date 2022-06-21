Main |:
    <!> "Introduce un numero"
    <?> x
    list <- {1 2 3 4 5}
    i <- 1
    while i <= #list |:
        if list[i] <= x |:
            ~~~ der Scherenoperator elimina el element i-ésimo de una lista ~~~
            8< list[i] 
        :|
        else |:
            i <- i+1
        :|
    :|
    <!> "Lista resultante:" list
:|
