import Data.List (group) 
import Data.List (isInfixOf)
import Data.Char (isSpace)

{-     Funciones auxiliares para la funcionalidad del Ejercicio 1.     -}
-- Función para obtener los factores del número dado
factors :: Integer ->[Integer]
factors n = [x | x <- [1..n], (mod n x) == 0]

-- Función auxiliar para revisar si el número es primo
isPrime :: Integer -> Bool
isPrime n = (factors n) == [1, n]

-- Fución para obtener una lista con los números primos de 2 hasta n
generatePrimes :: Integer -> [Integer]
generatePrimes n = [x | x <- [1..n], isPrime x]

--     %    Ejercicio 1.   %     --
-- Función principal que recibe un número natural y devuelve la lista de sus factores primos
primeFactors :: Integer -> [Integer]
primeFactors n 
  | n < 2 = error "El número ingresado debe ser mayor o igual a 2"
  | otherwise = factorize n (generatePrimes n)                 -- Creamos una lista de primos 
  where
    factorize 1 _ = []                                         -- Caso base, cuando n es 1 terminamos
    factorize m (p:ps)
      | m `mod` p == 0 = p : factorize (m `div` p) (p:ps)      -- Si p divide a m dividimos m/p
      | otherwise      = factorize m ps                        -- De lo contrario movemos a p al siguiente primo





{-     Funciones auxiliares para la funcionalidad del Ejercicio 2.     -}
-- Usamos el tipo Integer ya que manejamos potencias y sobrepasamos el límite de Int muy facilmente 
data Prop = Var String
  | Prop :& Prop
  | Prop :| Prop
  | Prop :/ Prop
  | No Prop
  deriving(Eq, Show)

data BinaryTree = Empty
              | Node Integer BinaryTree BinaryTree
              deriving (Show, Eq)

-- Función auxiliar para asignar valores a los operadores y variables
getVarNum :: Prop -> Integer
getVarNum (Var "p") = 1
getVarNum (Var "q") = 2
getVarNum (Var "r") = 3
getVarNum (Var "s") = 4
getVarNum (Var "t") = 5
getVarNum (No _)    = 6
getVarNum (_ :& _)  = 7
getVarNum (_ :| _)  = 8
getVarNum (_ :/ _)  = 9

-- Función auxiliar que crea un árbol binario de una Prop, en el fondo es un árbol de análisis sintáctico
toBinaryTree :: Prop -> BinaryTree
toBinaryTree (Var x)   = Node (getVarNum (Var x)) Empty Empty
toBinaryTree (No p)    = Node (getVarNum (No p)) (toBinaryTree p) Empty
toBinaryTree (p :& q)  = Node (getVarNum (p :& q)) (toBinaryTree p) (toBinaryTree q)
toBinaryTree (p :| q)  = Node (getVarNum (p :| q)) (toBinaryTree p) (toBinaryTree q)
toBinaryTree (p :/ q)  = Node (getVarNum (p :/ q)) (toBinaryTree p) (toBinaryTree q)

-- Función para recorrer el árbol en orden (izquierda, raíz, derecha), es decir usamos el algorimo 'Inorden'
inorderProp :: BinaryTree -> [Integer]
inorderProp Empty = []
inorderProp (Node val left right) =
    inorderProp left ++ [val] ++ inorderProp right
    
-- Función auxiliar para generar los primeros n números primos
generateNPrimes :: Integer -> [Integer]
generateNPrimes n = take (fromIntegral n) (filter isPrime [2..])
  where
    isPrime x = all (\y -> x `mod` y /= 0) [2 .. floor (sqrt (fromIntegral x))]

-- Función auxiliar para elevar cada número primo a la potencia correspondiente
assignPowers :: [Integer] -> [Integer] -> [Integer]
assignPowers primes powers = zipWith (^) primes powers

-- Función auxiliar para multiplicar los elementos de la lista
multiplyList :: [Integer] -> Integer
multiplyList = product

--     %   Ejercicio 2.   %     --
{- Función principal que recibe un objeto de tipo Prop y devuelva un número natural
 - La asignación es tal que a cada fórmula distinta le corresponda un número unico y diferente a las demás
 - Incluso las fórmulas equivalentes tienen un número diferente
 -}
propToNum :: Prop -> Integer
propToNum prop =
    let tree = toBinaryTree prop                                     -- Convertimos la fórmula a un árbol
        orderedNums = inorderProp tree                               -- Obtenemos la lista inorden de valores
        primes = generateNPrimes (fromIntegral (length orderedNums)) -- Generamos n números primos
        poweredPrimes = assignPowers primes orderedNums              -- Elevamos los primos a las potencias
    in multiplyList poweredPrimes                                    -- Multiplicamos los valores obtenidos

-- Función alterna que imprime cada procedimiento hecho y corroborar que todo salga bien
propToNumData :: Prop -> IO ()
propToNumData prop = do
    let tree = toBinaryTree prop
        orderedNums = inorderProp tree
        primes = generateNPrimes (fromIntegral (length orderedNums))
        poweredPrimes = assignPowers primes orderedNums
        result = multiplyList poweredPrimes
    
    putStrLn "Árbol binario generado:"
    print tree
    
    putStrLn "\nLista inorden de valores de la Prop:"
    print orderedNums
    
    putStrLn "\nLista de números primos generados:"
    print primes
    
    putStrLn "\nLista de primos elevados a las potencias:"
    print poweredPrimes
    
    putStrLn "\nResultado final (multiplicación de todos los elementos):"
    print result





{-     Funciones auxiliares para la funcionalidad del Ejercicio 3.     -}
-- Función que asigna las cadenas correspondientes a números entre 1 y 9
getVars :: Integer -> String
getVars 1 = "Var \"p\""
getVars 2 = "Var \"q\""
getVars 3 = "Var \"r\""
getVars 4 = "Var \"s\""
getVars 5 = "Var \"t\""
getVars 6 = "No"
getVars 7 = ":&"
getVars 8 = ":|"
getVars 9 = ":/"

-- Verificamos si la cadena es válida de acuerdo a Prop
validString :: String -> Bool
validString str =
    let cleanStr = filter (not . isSpace) str  -- Eliminamos los espacios
    in not ("\"Var" `isInfixOf` cleanStr ||    -- Verificamos si una lista es una sublista de otra
            "&:" `isInfixOf` cleanStr || 
            "|:" `isInfixOf` cleanStr || 
            "/:" `isInfixOf` cleanStr)

-- Función auxiliar para construir la cadena en orden
buildProp :: [Integer] -> String
buildProp list =
  let propStr = "(" ++ unwords (map getVars list) ++ ")"  -- Construimos la cadena
  in if validString propStr then propStr else ""          -- Validamos antes de devolver

-- Función auxiliar para contar las ocurrencias de cada factor primo y convertirlas en una lista de números
countFactors :: [Integer] -> [Integer]
countFactors = map (fromIntegral . length) . group -- Tomamos la lista y agrupamos los elementos consecutivos iguales en sublistas

-- Verificamos si la lista es válida, es decir que no haya números mayores a 9 o números iguales consecutivos
isValidList :: [Integer] -> Bool
isValidList xs = all (<=9) xs && not (hasConsecutives xs)

-- Verificamos si hay números repetidos consecutivos
hasConsecutives :: [Integer] -> Bool
hasConsecutives (a:b:rest) = (a == b) || hasConsecutives (b:rest)
hasConsecutives _ = False

-- Función para intercambiar los operandos 'No' a la posicion correcta
swapList :: [Integer] -> [Integer]
swapList (x:y:xs)
    | y == 6    = y : x : swapList xs  -- Intercambiamos si el segundo elemento es 6
    | otherwise = x : swapList (y:xs)  -- Continuamos recorriendo la lista
swapList xs = xs                       -- Caso base, listas de 0 o 1 elementos no cambian

--     %   Ejercicio 3.   %     --
{- Función principal que, dado un número entero de manera arbitraria, devuelve un objeto de tipo Bool,
 - De modo que se devuelva True solamente para aquellos casos que el número ingresado es el asociado
 - con la fórmula proposicional
 -}
numToProp :: Integer -> IO Bool
numToProp n = do
    let factors = primeFactors (fromIntegral n)
    let listaProp = countFactors factors
    
    if not (isValidList listaProp)
        then return False
        else do
            let checkedList = swapList listaProp
            let propStr = buildProp checkedList
            if propStr == ""
                then return False
                else do
                    putStrLn propStr
                    return True
