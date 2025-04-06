# Lógica Computacional
=======================

# Práctica 4. Laboratorio

## Ramírez Juárez María Fernanda

## Rojo Peña Manuel Ianluck
----------------------------------------------------

### Fecha de entrega: 10 de abril, 2025


Ingresar al entorno del intérprete de Haskell

```
$ ghci
```

Para compilar el archivo 'practica4.hs'

```
ghci practica4.hs 
GHCi, version 9.4.5: https://www.haskell.org/ghc/  :? for help
[1 of 2] Compiling Main             ( practica4.hs, interpreted )
Ok, one module loaded.
ghci>
```

## Ejemplos de ejecución con sus entradas y salidas:

### Ejercicio 1.

```
ghci> Var "x"
Var "x"
```

```
ghci> Pred "esCacahuate" [Var "x"]
Pred "esCacahuate" [Var "x"]
```

```
ghci> V "x" (Pred "esChayote" [Var "x"])
V "x" (Pred "esChayote" [Var "x"])
```

```
ghci> No (Pred "comestible" [Var "x"])
No (Pred "comestible" [Var "x"])
```

```
ghci> Pred "comida" [Var "x"] :/ Pred "comestible" [Var "x"]
Pred "comida" [Var "x"] :/ Pred "comestible" [Var "x"]
```

```
ghci> let p = Pred "cacahuate" [Var "x"]
ghci> let q = Pred "salado" [Var "x"]
ghci> let formula = p :/ q
ghci> formula
Pred "cacahuate" [Var "x"] :/ Pred "salado" [Var "x"]
```

### Ejercicio 2.

```
```

### Ejercicio 3.

```
```

### Ejercicio 4.
```
ghci> let hechos = [("Alice", "isUser"), ("Bob", "isAdmin"), ("Carol", "hasKey")]
```

```
ghci> interpret hechos (rule1 (Var "Alice"))
False
```

```
ghci> interpret hechos (rule2 (Var "Bob"))
False
```

```
ghci> interpret hechos (rule4 (Var "Carol"))
False
```

```
ghci> interpret hechos (rule4 (Var "Alice"))
True
```

```
ghci> interpret hechos (rule8 (Var "Bob"))
False
```

### Ejercicio 5.
Podemos probar el ejercicio de manera manual:

```
ghci> interpret [("Alicia", "isAdmin")] (Pred "isAdmin" [Var "Alicia"])
True
```

```
ghci> interpret [("Bob", "hasKey")] (Pred "hasKey" [Var "Bob"])
True
```

```
ghci> interpret [] (Pred "isUser" [Var "Charlie"])
False
```

```
ghci> interpret [("Bob", "isUser")]((Pred "isAdmin" [Var "Bob"]) :| (Pred "isUser" [Var "Bob"]))
True
```

```
ghci> interpret [("Bob", "isUser")] (No (Pred "hasKey" [Var "Bob"]))
True
```

O podemos hacerlo de la forma en que definimos la variable antes de llamara a la funcion:

```
ghci> let hechos = [("Alice", "isUser"), ("Bob", "isAdmin"), ("Carol", "hasKey"), ("Dana", "allowedAccess")]
```

```
ghci> interpret hechos (Pred "isAdmin" [Var "Bob"])
True
```

```
ghci> interpret hechos (Pred "hasKey" [Var "Carol"])
True
```

```
ghci> interpret hechos (Pred "allowedAccess" [Var "Alice"])
False
```

```
ghci> interpret hechos ((Pred "isUser" [Var "Alice"]) :& (Pred "hasKey" [Var "Alice"]))
False
```

```
ghci> interpret hechos (No (Pred "hasKey" [Var "Dana"]))
True
```

```
ghci> interpret hechos (rule10 (Var "Alice"))
True
```
