# Lógica Computacional
=======================

# Práctica 3. Laboratorio

## Ramírez Juárez María Fernanda

## Rojo Peña Manuel Ianluck
----------------------------------------------------

### Fecha de entrega: martes 18 de marzo, 2025


Ingresar al entorno del intérprete de Haskell

```
$ ghci
```

Para compilar el archivo 'practica3.hs'

```
ghci> :load practica3.hs
[1 of 2] Compiling Main             ( practica3.hs, interpreted )
Ok, one module loaded.
```

## Ejemplos de ejecución con sus entradas y salidas:

### Ejercicio 1.
```
ghci> primeFactors 60
[2,2,3,5]

ghci> primeFactors 441
[3,3,7,7]

ghci> primeFactors 73
[73]

ghci> primeFactors 1024
[2,2,2,2,2,2,2,2,2,2]

ghci> primeFactors 11
[11]
ghci> 
```



### Ejercicio 2.
Para ejecutar el ejercicio dos basta con hacer lo siguiente:
```
ghci> let formula1 = ((Var "p" :/ Var "q") :/ (Var "q" :/ Var "p"))
ghci> propToNum formula
866299611024933211458382050

ghci> let formula2 = (Var "p" :/ (Var "q"))
ghci> propToNum formula2
984150
```

Sin embargo si se quiere comprobar cada paso realizado por el algoritmo solo hacemos:
```
ghci> let formula1 = ((Var "p" :/ Var "q") :/ (Var "q" :/ Var "p"))
ghci> propToNumData formula1
Árbol binario generado:
Node 9 (Node 9 (Node 1 Empty Empty) (Node 2 Empty Empty)) (Node 9 (Node 2 Empty Empty) (Node 1 Empty Empty))

Lista inorden de valores de la Prop:
[1,9,2,9,2,9,1]

Lista de números primos generados:
[2,3,5,7,11,13,17]

Lista de primos elevados a las potencias:
[2,19683,25,40353607,121,10604499373,17]

Resultado final (multiplicación de todos los elementos):
866299611024933211458382050
```

```
ghci> let formula2 = (Var "p" :/ Var "q")
ghci> propToNumData formula2
Árbol binario generado:
Node 9 (Node 1 Empty Empty) (Node 2 Empty Empty)

Lista inorden de valores de la Prop:
[1,9,2]

Lista de números primos generados:
[2,3,5]

Lista de primos elevados a las potencias:
[2,19683,25]

Resultado final (multiplicación de todos los elementos):
984150
```


### Ejercicio 3.
<!-- Para este ejericio, a los números a los que sí se halla encontrado una posible fórmula Prop, será necesario, en algunos casos, agregar paréntesis según lo necesiten las fórmulas -->
```
ghci> numToProp 984150
(Var "p" :/ Var "q")
True

ghci> numToProp 54675000
(Var "r" :& Var "t")
True

ghci> numToProp 12
False
```

<!-- Como este caso, para que la Prop sea completamente valida falta agregar los parentesis: (Var "s" :| No (Var"r"))-->
```
ghci> numToProp 1543790178000
(Var "s" :| No Var "r") 
True

ghci> numToProp 1024
False 
```