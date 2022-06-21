Proyecto de Python y Compiladores
===
Autor: [Victor Teixidó Lopez](https://github.com/nemfey)

## Contenido repositorio
- **TreeVisitor.py**: Contiene el visitador que define la ejecución de toda la gramática
- **jsbach.g4**: Contiene la gramática del lenguaje JSBach
- **jsbach.py**: Contiene el programa principal del intérprete. Desde aqui se llama al visitador y se generan los distintos ficheros de salida.
- **Makefile**: Instala las dependencias requeridas y genera los ficheros necesarios para la grámatica
- El resto de programas son ejemplos de códigos escritos en **JSBach** y salidas de programas

# JSBach
Este proyecto corresponde a la práctica de GEI-LP (2021-22 Q2). Se ha implementado un doble intérprete para un lenguaje de programación musical conocido como JSBach. Este doble intérprete tiene como salida una partitura y ficheros de audio que reproducirán las melodias descritas por el compositor (o programador).

## Instalación
Antes de poder trabajar con el harmonioso lenguaje de JSBach será necesario instalar las librerias necesarias a través del ```Makefile```.
```
make
make dependencies
```

## Ejecución
El siguiente comando ejecuta el fichero desde la función **Main**.
```
python3 jsbach.py <nombre_fichero>
```

Para que la ejecución del programa empiece desde una **función** arbitraria, se puede hacer de la siguiente manera.
```
python3 jsbach.py <nombre_fichero> <nombre_funcion>
```

Si además dicha función tiene **parámetros**, se deberá utilizar el siguiente comando.
```
python3 jsbach.py <nombre_fichero> <nombre_funcion> <param1> <param2> ...
```

Es muy importante que el fichero a ejecutar tenga la extensión ```.jsb```

## Intérprete
**JSBach** es muy similar en cuanto a grámatica a lenguajes de programación como **Python** o **Java** pero con sus propias normas y patrones. El programa ```test-Euclides.jsb``` muestra como calcular el máximo común divisor entre dos números utilizando Euclides y permite entrever las distintas pautas a seguir:
```
Main |:
    <!> "Introduce dos numeros"
    <?> a
    <?> b
    Euclides a b
:|

Euclides a b |:
    while a /= b |:
        if a > b |:
            a <- a - b
        :| else |:
            b <- b - a
        :|
    :|
    <!> "El MCD es" a
:|
```

**JSBach** también cuenta con listas y sus respectivas operaciones y funcionalidades. El siguiente ejemplo del programa ```test-Remove.jsb``` hace lo siguiente, dado un número dado por el usuario, se eliminan de una lista arbitraria todos los elementos menores o igual a dicho número.

```
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
```

Como no podía ser de otra manera, el lenguaje de programación **JSBach** cuenta con recursividad. El programa ```test-Hanoi.jsb``` muestra como solucionar el problema de las Torres de Hanoi.

```
Main |:
    <?> n
    Hanoi n 1 2 3
:|

Hanoi n ori dst aux |:
    if n > 0 |:
        Hanoi (n - 1) ori aux dst
        <!> ori "->" dst
        Hanoi (n - 1) aux dst ori
    :|
:|
```

Este doble intérprete va más allá de únicamente interpretar código estándard como cualquier otro lenguaje, **JSBach** es capaz de generar una partitura y reproducir música a través de notas dadas por el usuario durante la ejecución del programa. En el programa ```test-Birthday.jsb``` podemos ver como dadas un conjunto de notas en forma de lista podemos reproducir la famosa canción de **Cumpleaños feliz** (o en alemán **Zum Geburtstag viel Glück**).

```
Main |:
    song <- {C C D C F E C C D C G F C C A F F E D B B A F G F}
    <:> song
:|
```
Además se nos generán los siguientes ficheros:
- [test-Birthday.midi](https://github.com/nemfey/jsbach/blob/main/test-Birthday.midi)
- [test-Birthday.mp3](https://github.com/nemfey/jsbach/blob/main/test-Birthday.mp3)
- [test-Birthday.pdf](https://github.com/nemfey/jsbach/blob/main/test-Birthday.pdf)
- [test-Birthday.wav](https://github.com/nemfey/jsbach/blob/main/test-Birthday.wav)

Como último ejemplo, con el código ```test-HanoiMusic``` podemos escuchar el agradable sonido que producen los discos de las torres de Hanoi al ser ordenados y colocados por el programa. Destacar que en este caso habría que indicar que la función *Hanoi* hace de Main del programa.

```
~~~ Hanoi Music ~~~

Hanoi |:
    src <- {C D E F G}
    dst <- {}
    aux <- {}
    HanoiRec #src src dst aux
:|

HanoiRec n src dst aux |:
    if n > 0 |:
        HanoiRec (n - 1) src aux dst
        note <- src[#src]
        8< src[#src]
        dst << note
        <:> note
        HanoiRec (n - 1) aux dst src
    :|
:|
```

## Reproducción musical
El intérprete de **JSBach**, además de generar los archivos relacionados con la escritura musical, reproducirá automáticamente la melodia generada al acabar la ejecucción del programa cuando se detecte que el compositor (o programador) ha ideado una composición musical.

## Tratamiento de errores
Para  el interpréte de **JSBach** se ha implementado el tratamiento de errores tal y como ocurriria en cualquier otro intérprete. Los errores que se tratan y de los cuales se avisa al usuario cuando ocurren son los siguientes:
- Division entre 0
- Nota musical no existente
- Acceso a posición de lista fuera de los límites
- Sobrescritura de función
- Acceso a función no existente
- Número de parámetros de una función incorrectos
