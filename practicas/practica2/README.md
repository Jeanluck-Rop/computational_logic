# Lógica Computacional
=======================

# Práctica 2. Laboratorio

## Ramírez Juárez María Fernanda

## Rojo Peña Manuel Ianluck
----------------------------------------------------

### Fecha de entrega: martes 04 de marzo, 2025


Ingresar al entorno del intérprete de Haskell

```
$ ghci
```

Para compilar el archivo 'practica2.hs'

```
ghci> :load practica2.hs
[1 of 2] Compiling Main             ( practica2.hs, interpreted )
Ok, one module loaded.
```

## Ejemplos de ejecución con sus entradas y salidas:

Ejercicio 1. Primero creamos las variables binaryTree para poder usarlas com entrada de nuestras funciones.
```
ghci> let arbolito = Node 4 (Node 2 (Node 1 (Node 0 Empty Empty) Empty) (Node 3 Empty Empty)) (Node 7 (Node 6 (Node 5 Empty Empty) Empty) (Node 8 Empty Empty))
```

```
ghci> let arbolote = Node 20 (Node 10 (Node 5 (Node 2 (Node 1 (Node 0 Empty Empty) Empty) (Node 4 (Node 3 Empty Empty) Empty)) (Node 8 (Node 7 (Node 6 Empty Empty) Empty) (Node 9 Empty Empty))) (Node 15 (Node 13 (Node 12 (Node 11 Empty Empty) Empty) (Node 14 Empty Empty)) (Node 18 (Node 17 (Node 16 Empty Empty) Empty) (Node 19 Empty Empty)))) (Node 31 (Node 26 (Node 23 (Node 22 (Node 21 Empty Empty) Empty) (Node 25 (Node 24 Empty Empty) Empty)) (Node 29 (Node 28 (Node 27 Empty Empty) Empty) (Node 30 Empty Empty))) (Node 36 (Node 34 (Node 33 (Node 32 Empty Empty) Empty) (Node 35 Empty Empty)) (Node 39 (Node 38 (Node 37 Empty Empty) Empty) (Node 40 Empty Empty))))
```

1. a) :
```
ghci> count arbolito
9
```

```
ghci> count arbolote
41
```

1. b) :
```
ghci> height arbolito
3
```

```
ghci> height arbolote
5
```

1. c) :
```
ghci> balancedTree 8
Node 4 (Node 2 (Node 1 (Node 0 Empty Empty) Empty) (Node 3 Empty Empty)) (Node 7 (Node 6 (Node 5 Empty Empty) Empty) (Node 8 Empty Empty))
```

Ejercicio 2:
Estos métodos son usados en el ejercicio 3 y 4, se verifica su funcionamiento cuando se ejecutan las funciones de dichos ejercicios.
```
ghci> vars (Var "x")
["x"]
```

```
ghci> vars ((Var "x" :& Var "y") :| No (Var "z"))
["x","y","z"]
```

```
ghci> vars (Var "x" :& (Var "x" :| Var "y"))
["x","x","y"]
```

Ejercicio 3 : 
Formula simple:
```
ghci> let p1 = Var "A"
ghci> let interp1 = [("A", True)]
ghci> interpretation p1 interp1
True
```

Conjunción:
```
ghci> let p2 = Var "A" :& Var "B"
ghci> let interp2 = [("A", True), ("B", False)]
ghci> interpretation p2 interp2
False
```

Disyunción:
```
ghci> let p3 = Var "A" :| Var "B"
ghci> let interp3 = [("A", False), ("B", False)]
ghci> interpretation p3 interp3
False
```

Implicación:
```
ghci> let p4 = Var "A" :/ Var "B"
ghci> let interp5 = [("A", True), ("B", False)]
ghci> interpretation p4 interp5
True
```

Negación:
```
ghci> let p5 = No (Var "A")
ghci> let interp6 = [("A", True)]
ghci> interpretation p5 interp6
False
```

```
ghci> let interp7 = [("A", False)]
ghci> interpretation p5 interp7
True
```

Ejercicio 4: Con ejemplos que sabemos el resultado

Contradicción:
```
ghci> let contra = Var "A" :& No (Var "A")
ghci> tautology contra
False
```

Tercero excluido:
```
ghci> let taut1 = Var "A" :| No (Var "A")
ghci> tautology taut1
True
```

Implicación (A ∧ B) -> A:
```
ghci>  let taut2 = (Var "A" :& Var "B") :/ Var "A"
ghci> tautology taut2
True
```

A -> B:
```
ghci> let notTaut = Var "A" :/ Var "B"
ghci> tautology notTaut
False
```