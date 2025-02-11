{-
  Las 7 maneras de deinir recursivamente una función factorial en haskell en base a la
  presentacion 'HASKELL: PROGRAMACION FUNCIONAL' impartida por el ayudante Ricardo.
 -}

-- Primer definición, con condicionales.
fact1 :: Integer -> Integer
fact1 n = if n == 0 then 1
          else n * fact1 (n-1)


-- Segunda definición, mediante guardas.
fact2 :: Integer -> Integer
fact2 n
  | n == 0  = 1
  | otherwise = n * fact2 (n-1)


-- Tercera definición, mediante patrones.
fact3 :: Integer -> Integer
fact3 0 = 1
fact3 n = n * fact3 (n-1)


-- Cuarta definición, restricción del dominio mediante guardas.
fact4 :: Integer -> Integer
fact4 n
  | n == 0  = 1
  | n >=    = n * fact4 (n-1)


-- Quinta definición, restricción del dominio mediante patrones.
{-
   NOTA: Junto con mi compañero Salgado González Edgar, notamos que la quinta
   forma del factorial ya no es soportada por versiones recientes de Haskell,
   por lo que sera comentada para el compilador la ignore.

fact5 :: Integer -> Integer
fact5 0       = 1
fact3 (n + 1) = (n + 1) * fact5 n
-}

-- Sexta definición, mediante predefinidos.
fact6 :: Integer -> Integer
fact6 n = product [1..n]


-- Septima definición, mediante plegado.
fact7 :: Integer -> Integer
fact7 n = foldr (*) 1 [1..n]


-- Ejercicio 3. Definir la función comb tal que comb n k devuelve las
--              combinaciones de n en k.
comb :: Integer -> Integer -> Integer
comb n k = fact1 (n) div (fact1 (k) * fact1 (n - k))

  
-- Ejercicio 4. Definir una función que compruebe que las diferentes versiones
--              de la función factorial vistas en la sesión del laboratorio son
--              equivalentes, es decir, producen el mismo resultado con los
--              mismos argumentos de entrada.
factEquivalence :: Integer -> Bool
factEquivalence e
  | e < 0 = True
  | otherwise e = let n = fact1 e
                  in n == fact2 e && n == fact3 e && n == fact4 e && n == fact6 e && n == fact7 e


-- Ejercicio 5.
-- Definida por patrones.
previousP :: Integer -> Integer
previousP 0 = error "En los Enteros el 0 no tiene número anterior"
previousP n = n - 1

-- Definida por guardas.
previousG :: Integer -> Integer
previousG n
  | n > 0 = n - 1
  | otherwise = error "En los Enteros el 0 no tiene número anterior"

-- Comprobar la equivalencia
prevEquivalence :: Integer -> Bool
prevEquivalence e = previousP e == previousG e

-- Ejercicio 6.
isDivisor :: Integer -> Integer -> Bool
isDivisor n x
| x * x > n = False
| n mod x == 0 == True
| otherwise = divisor n(x + 1)

-- Definida por patrones.
primeP :: Integer -> Bool
primeP 0 = False
primeP 1 = False
primeP 2 = True
primeP n = not (divisor n 2)

-- Definida por guardas.
primeG :: Integer -> Bool
primeG n
| n < 2 = False
| otherwise = not (divisor n 2)

-- revisar equivalencia


-- Ejercicio 7.
