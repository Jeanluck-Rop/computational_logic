import Data.List (nub)
import Data.Maybe (fromJust)

-- % Ejercicio 1 % --
data BinaryTree = Empty
              | Node Int BinaryTree BinaryTree
              deriving (Show, Eq)

-- a) Dunción count que cuente la cantidad de nodos de un árbol binario.
count :: BinaryTree -> Int
count Empty = 0
count (Node _ left right) = 1 + count left + count right


-- b) Función que cuenta la cantidad de niveles de profundidad del árbol
height :: BinaryTree -> Int
height Empty = 0
height (Node _ left right) = 1 + (max (height right) (height right))


-- c) Función que dado un entero no negativo z, devuelve un árbol binario balanceado que contiene
--    en sus nodos a todos los enteros no negativos k ≤ z.
balancedTree :: Int -> BinaryTree
balancedTree z
  | z < 0     = Empty
  | otherwise = buildTree [0..z]

  -- Función auxiliar para construir el árbol binario balanceado.
buildTree :: [Int] -> BinaryTree
buildTree [] = Empty
buildTree xs =
  let mid = length xs `div` 2
      (left, root:right) = splitAt mid xs
  in Node root (buildTree left) (buildTree right)


-- % Ejercicio 2 % --
data Prop = Var String
  | Prop :& Prop
  | Prop :| Prop
  | Prop :/ Prop
  | No Prop
  deriving( Eq, Show)

vars :: Prop -> [String]
vars (Var p)  = [p]
vars (p :& q) = vars p ++ vars q
vars (p :| q) = vars p ++ vars q
vars (p :/ q) = vars p ++ vars q
vars (No p)   = vars p

-- % Ejercicio 3 % --
-- Función que calcula la interpretación de una fórmula proposicional, dados los estados
-- de las variables proposicionales.
type Interpretation = [(String, Bool)]
interpretation :: Prop -> Interpretation -> Bool
interpretation (Var p) i = maybe(error $ "Variable no definida: " ++ p ) id (lookup p i)
interpretation (p :& q) i = interpretation p i && interpretation q i
interpretation (p :| q) i = interpretation p i || interpretation q i 
interpretation (p :/ q) i = not (interpretation p i) || interpretation q i
interpretation (No p) i = not (interpretation p i)

-- % Ejercicio 4 % --
-- función que determine si una fórmula es una tautología
generateInterpretations :: [String] -> [Interpretation]
generateInterpretations vars = sequence [ [(v, True), (v, False)] | v <- vars ]


tautology :: Prop -> Bool
tautology p = all (interpretation p) (generateInterpretations (nub(vars p)))
