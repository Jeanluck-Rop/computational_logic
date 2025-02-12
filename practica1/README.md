Lógica Computacional
=======================

Práctica 1. Laboratorio

Ramírez Juárez María Fernanda

Rojo Peña Manuel Ianluck
----------------------------------------------------

### Fecha de entrega: martes 11 de febrero, 2025


Ingresar al entorno del intérprete de Haskell

```
$ ghci
```

Para compilar el archivo 'practica1.hs'

```
Prelude> :load practica1.hs
```

## Nota: Para resolver esta práctica tomamos en cuenta lo visto en las clases de laboratorio, la presentación, y las dudas que se resolvieron. 

### Ejercicios:

3. Se define la función comb, la cual regresa las combinaciones de n en k, para probar esta función escribimos debemos escribir (siendo n y k numeros y v su resultado) :

```
ghci> comb n k
v
ghci> comb 6 3
20
ghci> comb 10
```

4. Definir una función que compruebe que las diferentes versiones de la función factorial vistas en la sesión son equivalentes

```
ghci> fact1 5
120
ghci> fact2 5
120
ghci> fact3 5
120
ghci> fact4 5
120
ghci> fact6 5
120
ghci> fact7 5
120
```

```
ghci> factEquivalence 5
True
```

5. Definir una función anterior de modo que anterior n es el anterior del número natural n. Definirla usando patrones y con guardas.

```
ghci> previousP 5
4
ghci> previousG 5
4
ghci> previousP 1
0
ghci> previousG 1
0
ghci> previousP 0
*** Exception: El 0 no tiene anterior
```

Además se creo una función para verificar la equivalencia de  previousP con  previousG.

```
ghci> prevEquivalence 100
True
ghci> prevEquivalence 0
*** Exception: El 0 no tiene anterior
```

6. Definir una función primo tal que la evaluación de primo n dé como resultado True únicamente cuando n es un número primo. Definirla usando restricción de dominio con patrones y con guardas.

```
ghci> primeP 1
False
ghci> primeG 1
False
ghci> primeP 7
True
ghci> primeG 7
True
```

Igual que el ejercicio anterior se hizo una función para verificar la equivalencia entre primeP  y primeG

```
ghci> prevEquivalence6 7
True
```

7. Definir una función esFormula tal que la evaluación esFormula e dé
como resultado True si e es una cadena correspondiente a una expresión
que pertenece a la gramática de los paréntesis balanceados.

```
ghci> isFormula "()"
True
ghci> isFormula "()()"
True
ghci> isFormula "(()())"
True
ghci> isFormula "("
False
ghci> isFormula "())("
False
```
