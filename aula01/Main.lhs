---
author: PCC102 - Teoria da Computação - Prof. Rodrigo Ribeiro
title: Noções de semântica formal
---

Setup
====

> main :: IO ()
> main = return ()

Objetivo
========

- Apresentar conceitos de semântica formal: semântica denotacional,
operacional big-step e operacional small-step.

Semântica formal
================

- O foco da disciplina de teoria da computação versa sobre a *sintaxe*.

- Porém, para a definição de alguns formalismos, faz-se necessário o
uso de semântica formal.

Semântica formal
================

- Objetivo: definir o significado preciso de linguagens formais.

- Como? Veremos três diferentes técnicas usando uma linguagem
simples de expressões e sua implementação em Haskell.

Sintaxe
=======

- Vamos considerar uma linguagem simples formada apenas por
constantes númericas e adição.

$$
\begin{array}{lcl}
   e & \to & n\:\mid\:e\,+\,e
\end{array}
$$

Sintaxe
=======

- Sintaxe como um tipo de dados Haskell

> data Exp
>   = Const Int | Exp :+: Exp
>     deriving (Eq, Ord, Show)

Denotacional
============

- Semântica denotacional consiste em definir uma função
para associar termos de uma linguagem a valores de um
domínio semântico apropriado.

Denotacional
============

- Seja $\mathcal{T}$ o domínio de termos da linguagem
para a qual desejamos definir a semântica e $V$ o universo
de valores semânticos.

Denotacional
============

- A semântica denotacional de $\mathcal{T}$ consiste em definir
uma função $[\![\_]\!] : \mathcal{T}\to V$.

- É importante que a semântica seja _composicional_, isto é,
o significado de um termo composto deve ser definido em termos
de seus subtermos.

Denotacional
============

- A semântica de expressões é definida por uma função
$[\![\_]\!] : e\to \mathbb{Z}$.
    - $\mid n \mid$ valor inteiro correspondente a $n$.
    - $\oplus : \mathbb{Z} \times \mathbb{Z} \to \mathbb{Z}$

Denotacional
============

- Semântica de expressões.

$$
\begin{array}{lcl}
[\![ n ]\!]         & = & \mid n \mid\\
[\![ e_1 + e_2 ]\!] & = & [\![ e_1 ]\!] \oplus [\![ e_2 ]\!]
\end{array}
$$

Denotacional
============

- Implementação em Haskell.

> eval :: Exp -> Int
> eval (Const n) = n
> eval (e1 :+: e2) = eval e1 + eval e2


Operacional
===========

- Semântica operacional consiste em atribuir significado a
termos utilizando uma relação de execução.

- Dois tipos principais: _small-step_ e _big-step_.

Operacional
===========

- Semântica small-step define o significado de termos
usando uma relação que descreve cada um dos passos necessários
para sua execução.

Operacional
===========

- Semântica big-step define o significado de termos usando
uma relação que descreve o resultado final de sua execução.

Operacional
===========

- Semântica small-step para expressões.

$$
\begin{array}{cc}
   \dfrac{x \to x'}{x + y \to x' + y} &
   \dfrac{y \to y'}{n + y \to n + y'} & \\ \\
   \dfrac{}{n + n' \to \mid n \mid \oplus \mid n' \mid}
\end{array}
$$

Operacional
===========

- Exemplo.

$$
\begin{array}{c}
\dfrac{1 + 2 \to 3}{(1 + 2) + (3 + 4) \to 3 + (3 + 4)}
\end{array}
$$

Operacional
===========

- Para obtenção do resultado final da execução de um termo,
devemos aplicar regras da semântica small-step enquanto possível.
    - Devemos usar o conceito de fecho reflexivo e transitivo
      da semântica.

Operacional
===========

- Fecho reflexivo e transitivo: Seja $R$ uma relação binária sobre
um conjunto $A$. Dizemos que $S$ é o fecho reflexivo e transitivo de $R$ se:
   - $S$ é reflexiva e transitiva.
   - $R \subseteq S$.
   - Para toda $T$ reflexiva e transitiva tal que $R \subseteq T$ temos que
     $S\subseteq T$.

Operacional
===========

- A implementação da semântica small-step em Haskell pode ser feita usando
list comprehensions.

- Para isso, vamos definir uma função de tipo


> trans :: Exp -> [Exp]

Operacional
===========

- Cada equação da função irá representar uma regra da semântica.

- O resultado será a uma lista contendo o resultado de
aplicar uma regra.

Operacional
===========

- A primeira equação denota o fato de que constantes não podem
ser mais reduzidas pela semântica.


> trans (Const _) = []

Operacional
===========

- Representando a regra:

$$
\dfrac{}{n + n' \to \mid n \mid \oplus \mid n' \mid}
$$

> trans ((Const n) :+: (Const n'))
>   = [Const (n + n')]

Operacional
===========

- Representando a regra

$$
\dfrac{e' \to e1}{n + e' \to n + e1}
$$

> trans ((Const n) :+: e')
>   = [(Const n) :+: e1 | e1 <- trans e']

Operacional
===========

- Representando a regra

$$
\dfrac{e \to e1}{e + e' \to e1 + e'}
$$

> trans (e :+: e')
>   = [e1 :+: e' | e1 <- trans e]

Operacional
===========

- Obtemos o fecho transitivo da semântica
aplicado transições de forma a construir uma árvore.

> data Tree a = Node a [Tree a]
>    deriving (Eq, Ord, Show)

Operacional
===========

- Aplicando repetidamente transições sobre a árvore
de execução.

> exec :: Exp -> Tree Exp
> exec e = Node e [exec e' | e' <- trans e]

Operacional
===========

- Outra forma popular de representar a semântica small-step
é usando contextos, que separam a execução propriamente dita
de regras estruturais (i.e. para recursão sobre termos).

Operacional
===========

- A ordem de execução da semântica é definida usando
o conceito de _contextos_.

- Contextos são exatamente a sintaxe de expressões
marcados por "holes", representados por $[\_]$.

Operacional
===========

- A sintaxe de contexto deve refletir a estrutura
de avaliação da semântica.


Operacional
===========

- Sintaxe de contextos.

$$
C\:\to\:[\_]\:\mid\:C + e\:\mid\:n + C
$$

Operacional
===========

- O contexto $C + e$ indica que a avaliação deve
proceder recursivamente sobre o termo da esquerda.

- O contexto $n + C$ indica que avaliamos o termo
da direita somente quando o da esquerda for reduzido
a um valor.

Operacional
===========

- A execução da semântica dá-se por re-escrever termos
em contextos.

- Pontos de re-escrita são marcados na sintaxe por holes.

Operacional
===========

- Denotamos por $C[e]$ o resultado de substituir um hole no
contexto $C$ pelo termo $e$.

Operacional
===========

- Exemplo:
    - Contexto $C = [\_] + (3 + 4)$.
    - Temos que $C[3] = 3 + (3 + 4)$.

Operacional
===========

- Semântica de expressões

$$
\begin{array}{cc}
  \dfrac{e \to e'}{C[e] \to C[e']} & \dfrac{}{n + n' \to \mid n \mid \oplus \mid n' \mid}
\end{array}
$$

Operacional
===========

- O uso de contextos permitiu que duas regras
fossem condensadas em uma, usando contextos.

Operacional
===========

- Representando contextos em Haskell

> data Con = Hole | AddL Con Exp | AddR Exp Con
>   deriving (Eq, Ord, Show)

Operacional
===========

- Substituição em um contexto.

> subst :: Con -> Exp -> Exp
> subst Hole e = e
> subst (AddL c e') e = (subst c e) :+: e'
> subst (AddR e c) e' = e :+: (subst c e')

Operacional
===========

- A operação dual da substituição $C[e]$ envolve
dividir uma expressão nos contextos possíveis.

Operacional
===========

- Decompondo uma expressão em contextos.

> decompose :: Exp -> [(Con,Exp)]
> decompose e = (Hole, e) : case e of
>   Const n   -> []
>   e1 :+: e2 -> [(AddL c e2, e1') | (c,e1') <- decompose e1] ++
>                [(AddR e1 c, e2') | (c,e2') <- decompose e2]

Operacional
===========

- Usando as definições anteriores, podemos definir a semântica
small-step usando contextos usando a função:

> transCon :: Exp -> [Exp]

Operacional
===========

- Representando a regra

$$\dfrac{}{n + n' \to \mid n \mid \oplus \mid n' \mid}$$

> transCon ((Const n) :+: (Const n'))
>       = [Const (n + n')]


Operacional
===========

- Representando a regra

$$
\dfrac{e \to e'}{C[e] \to C[e']}
$$

> transCon e
>       = [subst c e1 | (c,e') <- tail (decompose e)
>                     , e1 <- trans e']


Operacional
===========

- Semântica big-step para expressões.

$$
\begin{array}{cc}
  \dfrac{}{n \Downarrow \mid n \mid} &
  \dfrac{e \Downarrow n \,\,\,\,\, e' \Downarrow n'}{e + e' \Downarrow \mid n \mid \oplus \mid n' \mid} \\
\end{array}
$$

Operacional
===========

- Implementação em Haskell da semântica big-step

> interp :: Exp -> [Int]
> interp (Const n) = [n]
> interp (e :+: e') = [n + m | n <- interp e
>                            , m <- interp e']


Exercícios
==========

- Considere a seguinte linguagem sobre constantes booleanas
em conjunto com o operador de disjunção (ou lógico).

$b \to true\,\mid\,false\,\mid\,b \lor b$

Exercícios
==========

- Apresente definições da semânticas small-step, small-step
com contextos e big-step e suas respectivas implementações
em Haskell.

- Para apresentação das regras formais das semânticas, utilize
o template laTeX disponível no Moodle.

Referências
===========

- Hutton, Graham. It's easy as 1,2,3. Under consideration for
publication on Journal of Functional Programming, 2021.
