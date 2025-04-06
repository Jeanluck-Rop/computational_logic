--     %    Ejercicio 1.   %     --
--  Definimos un tipo de dato para las fórmulas de la lógica de primer orden.
data Prop = Var String
  | Pred String [Prop]
  | Prop :& Prop
  | Prop :| Prop
  | Prop :/ Prop
  | No Prop
  | V String Prop
  | E String Prop
  deriving(Eq, Show)



--     %    Ejercicio 2.   %     --
-- Implementamos una función para verificar si una interpretación satisface una fórmula.




--     %    Ejercicio 3.   %     --
-- Implementamos una función para verificar si una fórmula es consecuencia lógica de un conjunto de premisas.




--     %    Ejercicio 4.   %     --
-- Definimos un conjunto de reglas para un sistema donde los usuarios tienen permisos según sus credenciales.

-- Representamos el predicado "isUsuario"
isUser :: Prop -> Prop
isUser x = Pred "isUser" [x]

-- Representamos el predicado "tieneLlave"
hasKey :: Prop -> Prop
hasKey x = Pred "hasKey" [x]

-- Representamos el predicado "esAdministrador"
isAdmin :: Prop -> Prop
isAdmin x = Pred "isAdmin" [x]

-- Representamos el predicado "accesoPermitido"
allowedAccess :: Prop -> Prop
allowedAccess x = Pred "allowedAccess" [x]

-- Regla 1: Si es usuario y tiene llave, entonces tiene acceso permitido.
rule1 :: Prop -> Prop
rule1 x = (isUser x :& hasKey x) :/ allowedAccess x

-- Regla 2: Si es admin, entonces tiene llave.
rule2 :: Prop -> Prop
rule2 x = isAdmin x :/ hasKey x

-- Regla 3: Si es admin, entonces tiene acceso permitido.
rule3 :: Prop -> Prop
rule3 x = isAdmin x :/ allowedAccess x

-- Regla 4: Es usuario o admin.
rule4 :: Prop -> Prop
rule4 x = isUser x :| isAdmin x

-- Regla 5: Si es usuario y tiene acceso, entonces tiene llave.
rule5 :: Prop -> Prop
rule5 x = (isUser x :& allowedAccess x) :/ hasKey x

-- Regla 6: Si tiene acceso, entonces tiene llave.
rule6 :: Prop -> Prop
rule6 x = allowedAccess x :/ hasKey x

-- Regla 7: Si no tiene llave, entonces no tiene acceso.
rule7 :: Prop -> Prop
rule7 x = No (hasKey x) :/ No (allowedAccess x)

-- Regla 8: Si es admin, entonces tiene acceso.
rule8 :: Prop -> Prop
rule8 x = isAdmin x :/ allowedAccess x

-- Regla 9: Si no es usuario ni admin, entonces no tiene acceso.
rule9 :: Prop -> Prop
rule9 x = No (isUser x :| isAdmin x) :/ No (allowedAccess x)

-- Regla 10: Si tiene acceso, entonces debe ser usuario o admin.
rule10 :: Prop -> Prop
rule10 x = allowedAccess x :/ (isUser x :| isAdmin x)




{-     Funciones auxiliares para la funcionalidad del Ejercicio 5.     -}

-- Tipo para representar los datos a interpretar como pares (nombre de persona, propiedad).
type Facts = [(String, String)]

--     %    Ejercicio 5.   %     --
--  Definimos una función de interpretación para los predicados del ejercicio anterior.

-- Función principal de interpretación de proposiciones lógicas.
-- Toma una lista de hechos y una fórmula, y evalúa si esta es verdadera bajo dichos hechos.
interpret :: Facts -> Prop -> Bool
interpret facts (Var x) = False     -- No evaluamos a una sola variable
interpret facts (Pred p [Var x]) = 
  case lookup x facts of
    Just v  -> v == p                -- Verificamos si el valor de x coincide con el predicado
    Nothing -> False
interpret facts (p1 :& p2) = interpret facts p1 && interpret facts p2
interpret facts (p1 :| p2) = interpret facts p1 || interpret facts p2
interpret facts (p1 :/ p2) = not (interpret facts p1) || interpret facts p2
interpret facts (No p) = not (interpret facts p)
interpret facts (V _ _) = False
interpret facts (E _ _) = False
