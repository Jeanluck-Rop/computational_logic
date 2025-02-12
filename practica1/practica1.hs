
--  Las 7 maneras de definir recursivamente una función factorial en haskell en base a la presentacion
 -- 'HASKELL: PROGRAMACION FUNCIONAL' impartida por el ayudante Ricardo.

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
  | n >= 1   = n * fact4 (n-1)


-- Quinta definición, restricción del dominio mediante patrones.
{-
   NOTA: Junto con mi compañero Salgado González Edgar, notamos que la quinta forma del factorial ya no es
   soportada por versiones recientes de Haskell, por lo que sera comentada para el compilador la ignore.

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

-- Ejercicio 3. Definir la función comb tal que comb n k devuelve las combinaciones de n en k.
comb :: Integer -> Integer -> Integer
comb n k = fact1 (n) `div` (fact1 (k) * fact1 (n - k))
  

 --Ejercicio 4. Definir una función que compruebe que las diferentes versiones de la función factorial vistas
--en la sesión del laboratorio son equivalentes, es decir, producen el mismo resultado con los mismos argumentos de entrada.

factEquivalence :: Integer -> Bool
factEquivalence e = (fact1 e == fact2 e) && (fact2 e == fact3 e) && (fact3 e == fact4 e) &&
                    (fact1 e == fact2 e) && (fact6 e == fact7 e)

--Ejercicio 5. Definir una función anterior de modo que anterior n es el anterior del número natural n.

-- Definida por patrones 
anteriorP :: Integer -> Integer
anteriorP 0 = error "El 0 no tiene anterior"
anteriorP n = n-1

--Definida por guardas
anteriorG :: Integer -> Integer
anteriorG n
  | n > 0 = n-1
  |otherwise = error "El 0 no tiene anterior"

equivalentes :: Integer -> Bool
equivalentes n = anteriorP n == anteriorG n

--Ejercicio 6. Definir una función primi tal que la evaluación de primo n dé como resuktado TRUE únicamnete cuando n es un número primo.

divisor :: Integer -> Integer -> Bool
divisor n x
  | x*x > n = False
  | n `mod` x == 0 = True
  | otherwise = divisor n(x+1)

primoP :: Integer -> Bool
primoP 0 = False
primoP 1 = False
primoP 2 = True 
primoP n = not (divisor n 2)

primoG :: Integer -> Bool
primoG n
  | n < 2 = False
  | otherwise = not(divisor n 2)


--revisar equivalencia


--Ejercicio 7. Considere la gramaticá que define las expresiones de paréntesis balanceados : E ::= () , E ::=(E), E ::= EE
--Definir una función esFormula e dé como resultado True si e es una cadena correspondiente a una expresión que pertenece a la gramática de los parentesisi balanceados.
esFormula :: String -> Bool
esFormula "" = False  -- La cadena vacía no es válida
esFormula "()" = True -- Caso base
esFormula s
  | head s == '(' && last s == ')' && esFormula (init (tail s)) = True  -- Caso (E)
  | otherwise = algunaParticionValida s  -- Caso EE

-- Función auxiliar para verificar si alguna partición de la cadena en dos partes da dos expresiones válidas
algunaParticionValida :: String -> Bool
algunaParticionValida s = any (\(a, b) -> esFormula a && esFormula b) (particiones s)

-- Función que genera todas las formas de partir la cadena en dos partes no vacías
particiones :: String -> [(String, String)]
particiones s = [(take i s, drop i s) | i <- [1..length s - 1]]
