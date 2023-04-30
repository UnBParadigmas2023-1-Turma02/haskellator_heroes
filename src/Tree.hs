-- Módulo Tree
module Tree where

import Hero

data Tree a = Leaf a | Node String (Tree a) (Tree a)
  deriving (Show)

-- | Constrói a árvore com as perguntas e heróis
tree :: Tree (Either String Hero)
tree =
  Node "O herói que você está pensando é da DC?"
  (Node "O herói é do gênero feminino?"
    (Node "O herói é da raça humana?"
      (Node "O herói é filha do comissário de Gotham?"
        (Leaf (Right Batgirl))
        (Leaf (Right CanarioNegro))
      )
      (Node "O herói é um Deus ou semi-Deus?"
        (Leaf (Right MulherMaravilha))
        (Leaf (Right Zattana))
      )
    )
    (Node "O herói é um Deus, semi-Deus ou extraterrestre?"
      (Node "O herói é de Krypton?"
        (Leaf (Right Superman))
        (Leaf (Right CacadorDeMarte))
      )
      (Node "O herói é uma IA?"
        (Leaf (Right Ciborgue))
        (Node "O herói é um mutante?"
          (Node "O herói usa um anel de poder?"
            (Leaf (Right LanternaVerde))
            -- continuar a árvore aqui
            (Leaf (Left "Não sei"))
          )
          -- continuar a arvore aqui
          (Leaf (Left "Não sei"))
        )
      )
    )
  )
  (Leaf (Left "Desculpe, não consegui identificar o herói que você está pensando"))


    -- Exemplo de código
   {--(Node "O herói que você está pensando é humano?" 
      (Node  "O herói que você está pensando usa armas?" 
        (Leaf (Right Batman))
        (Node "O herói que você está pensando é ciborgue?" 
          (Leaf (Right Cyborg))
          (Leaf (Right CanarioNegro))))
      (Node "O herói que você está pensando tem habilidades sobre-humanas?" 
        (Node "O herói que você está pensando é extremamente rápido?" 
          (Leaf (Right Flash))
          (Node "O herói que você está pensando é um marciano?" 
            (Leaf (Right CacadorDeMarte))
            (Leaf (Right LanternaVerde))))
        (Node "O herói que você está pensando é um atlante?" 
          (Leaf (Right Aquaman))
          (Leaf (Left "Desculpe, não consegui identificar o herói que você está pensando.")))))   -}

-- | Executa o jogo e retorna o herói escolhido pelo usuário
runGame :: Tree (Either String Hero) -> IO Hero
runGame (Leaf (Left message)) = do
  putStrLn message
  runGame tree
runGame (Leaf (Right hero)) = do
  putStrLn ("O herói em que você está pensando é " ++ show hero ++ ".")
  return hero
runGame (Node question left right) = do
  putStrLn question
  answer <- getLine
  if answer == "sim"
    then runGame left
    else runGame right
