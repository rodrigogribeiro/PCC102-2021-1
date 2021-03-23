---
author: PCC102 - Teoria da Computação - Prof. Rodrigo Ribeiro
title: Derivadas de Expressões Regulares
header-includes: \usepackage{multicolumn}
---

Setup
====

> main :: IO ()
> main = return ()

Objetivo
========

- Apresentar o conceito de derivadas de expressões regulares.

- Apresentar como derivadas podem ser usadas para matching e
obtenção de AFDs a partir de uma expressão regular.

Derivadas
=========

- Definição: Seja $L \subseteq \Sigma^*$ e $a \in \Sigma$.
A derivada de $L$ com respeito a $a$, $\delta(L,a)$, é definida
como:

$$
 \delta(L,a) =\{w \in \Sigma^*\,|\,aw \in L\}
$$

Derivadas
=========

- Brzozowski mostrou que a classe das linguagens regulares é
fechada sobre a operação de derivadas.
    - Para isso, mostrou um algoritmo para calcular a derivada
      de uma expressão regular.

Derivadas
=========

- O algoritmo depende de uma função que testa
se uma expressão regular aceita a string vazia.

$$
\begin{array}{lcl}
   \nu(\emptyset) & = & \bot \\
   \nu(\lambda)   & = & \top \\
   \nu(a)         & = & \bot \\
   \nu(e_1 + e_2) & = & \nu(e_1) \lor \nu(e_2) \\
   \nu(e_1\:e_2)  & = & \nu(e_1) \land \nu(e_2) \\
   \nu(e_1^*)     & = & \top \\
\end{array}
$$

Derivadas
=========

- Algoritmo de cálculo de derivada.

$$
\begin{array}{lcl}
\partial(\emptyset, a) & = & \emptyset \\
\partial(\lambda, a)   & = & \emptyset \\
\partial(a,a)          & = & \lambda \\
\partial(b,a)          & = & \emptyset,\:\:\textrm{se }a \neq b\\
\partial(e_1 + e_2, a) & = & \partial(e_1,a) + \partial(e_2,a)\\
\end{array}
$$

Derivadas
=========

- Algoritmo de cálculo de derivada.

$$
\begin{array}{lcl}
\partial(e_1\:e_2,a) & = & \left\{
                           \begin{array}{ll}
                             \partial(e_1,a)e_2 + \partial(e_2,a) & \textrm{se }\nu(e_1) = \top \\
                             \partial(e_1,a)e_2  & \textrm{se }\nu(e_1) = \bot \\
                           \end{array}
                         \right. \\
\partial(e_1^*,a)    & = & \partial(e_1,a)e_1^*
\end{array}
$$

Exemplo
=======

$$
\begin{array}{lc}
\partial((ab + a)^*, a) & = \\
\end{array}
$$

Exemplo
=======

$$
\begin{array}{lc}
\partial((ab + a)^*, a) & = \\
\partial(ab + a,a)(ab + a)^* & =\\
\end{array}
$$

Exemplo
=======

$$
\begin{array}{lc}
\partial((ab + a)^*, a) & =\\
\partial(ab + a,a)(ab + a)^* & =\\
(\partial(ab, a) + \partial(a,a))(ab + a)^* & = \\
\end{array}
$$

Exemplo
=======

$$
\begin{array}{lc}
\partial((ab + a)^*, a) & = \\
\partial(ab + a,a)(ab + a)^* & =\\
(\partial(ab, a) + \partial(a,a))(ab + a)^* & = \\
(b + \lambda)(ab + a)^* & = \\
\end{array}
$$

Exemplo
=======

$$
\begin{array}{lc}
\partial((ab + a)^*, a) & = \\
\partial(ab + a,a)(ab + a)^* & =\\
(\partial(ab, a) + \partial(a,a))(ab + a)^* & = \\
(b + \lambda)(ab + a)^* & = \\
b(ab + a)^* + (ab + a)^*\\
\end{array}
$$

Derivadas
=========

- Teorema 1: Se $aw \in [\![e]\!]$ então $w \in [\![\partial(e,a)]\!]$

- Teorema 2: Se $w \in [\![\partial(e,a)]\!]$ então $aw \in [\![e]\!]$.

Matching
========

- Derivadas podem ser utilizadas para construir um algoritmo de
matching.

- A ideia consiste em aplicar a operação de derivada em cada caractere
de uma string.
    - Se a expressão regular resultante for tal que $\nu(e) = \top$, então
      a string pertence a linguagem da RE original.

Matching
========

- Algoritmo de matching

$$
\begin{array}{lcl}
\partial^*(e,\lambda) & = & \nu(e)\\
\partial^*(e,ay)      & = & \partial^*(\partial(e,a),y)\\
\end{array}
$$

Exemplo
=======

$$
\begin{array}{lc}
  \partial^*((ab + a)^*, ab) & = \\
\end{array}
$$

Exemplo
=======

$$
\begin{array}{lc}
  \partial^*((ab + a)^*, ab) & = \\
  \partial^*(\partial((ab + a)^*, a), b) & = \\
\end{array}
$$

Exemplo
=======

$$
\begin{array}{lc}
  \partial^*((ab + a)^*, ab) & = \\
  \partial^*(\partial((ab + a)^*, a), b) & = \\
  \partial^*(b(ab + a)^* + (ab + a)^*,b) & = \\
\end{array}
$$

Exemplo
=======

$$
\begin{array}{lc}
  \partial^*((ab + a)^*, ab) & = \\
  \partial^*(\partial((ab + a)^*, a), b) & = \\
  \partial^*(b(ab + a)^* + (ab + a)^*,b) & = \\
  \partial^*(\partial(b(ab + a)^* + (ab + a)^*,b),\lambda) & = \\
\end{array}
$$

Exemplo
=======

$$
\begin{array}{lc}
  \partial^*((ab + a)^*, ab) & = \\
  \partial^*(\delta((ab + a)^*, a), b) & = \\
  \partial^*(b(ab + a)^* + (ab + a)^*,b) & = \\
  \partial^*(\partial(b(ab + a)^* + (ab + a)^*,b),\lambda) & = \\
  \partial^*((ab + a)^* + b(ab + a)^* + (ab + a)^*, \lambda) & = \\
  \top
\end{array}
$$

Autômatos
=========

- Outra aplicação de derivadas é a obtenção de um autômato
determinístico equivalente à expressão regular.

Autômatos
=========

- Recordando: um autômato finito determinístico (AFD)
$M = (E,\Sigma,\delta,i,F)$ é tal que:
    - $E$: conjunto finito de estados.
    - $\Sigma$: alfabeto
    - $\delta : E \times \Sigma \to E$, função total de transição.
    - $i \in E$: estado inicial.
    - $F \subseteq E$: conjunto de estados finais.


Autômatos
=========

- Ideia: gerar todas as derivadas para cada $a\in\Sigma$:
    - Número de derivadas possíveis é finito, se
       levarmos em conta equivalência de expressões.
    - Consequência do teorema de Myhill-Nerode.

Autômatos
=========

- Definição: Sejam $e_1$ e $e_2$ duas REs sobre $\Sigma$.
Dizemos que $e_1$ e $e_2$ são equivalentes, $e_1 \equiv e_2$, se

$$
\forall w \in \Sigma^*. w \in [\![e_1]\!] \leftrightarrow w \in [\![e_2]\!]
$$

Autômatos
=========

- Algoritmo para conversão em um AFD

```haskell
mkDFA e
  = let
     q0 = e
     (states, delta) = explore [e] [] e
     finals = filter acceptNull states
    in DFA states delta q0 finals
```

Autômatos
=========

- Função auxiliar: `explore`.
   - Constrói novos estados para cada símbolo $a \in \Sigma$.

```haskell
explore states delta e
  = fold (goto e) (states, delta) alphabet
```

Autômatos
=========

- Função auxiliar: `goto`
   - Identifica se um novo estado necessita ser gerado.

```haskell
goto e (c, (states, delta))
  = let
      e' = deriv e c
      es = filter (isEquiv e') states
    in if not $ null es
       then (states, ((e,c), head es))
       else
         explore (e' : states)
                 (((e,c), head es) : delta)
                 (head es)
```

Autômatos
=========

- Problema central: testar equivalência entre duas REs.
   - No código, representado pela função `isEquiv`
   - Como testar a equivalência de REs?


Autômatos
=========

- Idealmente, devemos ser capazes de testar a equivalência
considerando apenas a sintaxe das REs.

- Para isso, consideraremos algumas equações.
   - A função `isEquiv` implementa as equações.

Autômatos
=========

- Equivalência de REs.

$$
\begin{array}{ccc}
(e_1e_2)e_3 \approx e_1(e_2 e_3) & \emptyset e_1 \approx \emptyset & e_1 \emptyset \approx \emptyset \\
e_1 \lambda \approx e_1          & \lambda e_1 \approx e_1         & e_1 + e_2 \approx e_2 + e_1 \\
\lambda^* \approx \lambda & \emptyset + e_1 \approx e_1 &  (e_1^*)^* \approx e_1^*\\
\end{array}
$$

Autômatos
=========

- Equivalência de REs

$$
\begin{array}{cc}
\emptyset^* \approx \lambda & (e_1 + e_2) + e_3 \approx e_1 + (e_2 + e_3) \\
\end{array}
$$

Exemplo
=======

- Construir um AFD para $e_1 = b(a + b)^*$.

\begin{tikzpicture}[auto, node distance=5cm, very thick, initial text=, >=latex,
                    state/.style={circle, draw, minimum size=2cm,
                    every edge quotes/.append style={font=\Large, align=center, auto}}]
  \node[state, initial]  (e_1) []  {\mbox{\huge $e_1$}};
\end{tikzpicture}

Exemplo
=======

- Construir um AFD para $e_1 = b(a + b)^*$.
    - $\partial(e_1,a) = \emptyset$

\begin{tikzpicture}[auto, node distance=5cm, very thick, initial text=, >=latex,
                    state/.style={circle, draw, minimum size=2cm,
                    every edge quotes/.append style={font=\Large, align=center, auto}}]
  \node[state, initial]  (e1) []  {\mbox{\huge $e_1$}};
  \node[state](err) [below of=e1] {\mbox{\huge $\emptyset$}};
  \path[->] (e1) edge [] node {\mbox{\huge a}} (err) ;
\end{tikzpicture}


Exemplo
=======

- Construir um AFD para $e_1 = b(a + b)^*$.
    - $\partial(\emptyset,a) = \partial(\emptyset,b) = \emptyset$

\begin{tikzpicture}[auto, node distance=5cm, very thick, initial text=, >=latex,
                    state/.style={circle, draw, minimum size=2cm,
                    every edge quotes/.append style={font=\Large, align=center, auto}}]
  \node[state, initial]  (e1) []  {\mbox{\huge $e_1$}};
  \node[state](err) [below of=e1] {\mbox{\huge $\emptyset$}};
  \path[->] (e1)  edge [] node {\mbox{\huge a}} (err)
            (err) edge [loop below] node {\mbox{\huge a,b}} (err);
\end{tikzpicture}

Exemplo
=======

- Construir um AFD para $e_1 = b(a + b)^*$.
    - $e_2 = \partial(b(a + b)^*,b) = (a + b)^*$

\begin{tikzpicture}[auto, node distance=5cm, very thick, initial text=, >=latex,
                    state/.style={circle, draw, minimum size=2cm,
                    every edge quotes/.append style={font=\Large, align=center, auto}}]
  \node[state, initial]  (e1) []             {\mbox{\huge $e_1$}};
  \node[state, accepting]  (e2) [right of=e1]  {\mbox{\huge $e_2$}};
  \node[state](err) [below of=e1] {\mbox{\huge $\emptyset$}};
  \path[->] (e1)  edge [] node {\mbox{\huge a}} (err)
                  edge [] node {\mbox{\huge b}} (e2)
            (err) edge [loop below] node {\mbox{\huge a,b}} (err);
\end{tikzpicture}

Exemplo
=======

- Construir um AFD para $e_1 = b(a + b)^*$.
    - $\partial((a + b)^*,a) = \partial((a + b)^*,b) = (a + b)^*$

\begin{tikzpicture}[auto, node distance=5cm, very thick, initial text=, >=latex,
                    state/.style={circle, draw, minimum size=2cm,
                    every edge quotes/.append style={font=\Large, align=center, auto}}]
  \node[state, initial]  (e1) []             {\mbox{\huge $e_1$}};
  \node[state, accepting]  (e2) [right of=e1]  {\mbox{\huge $e_2$}};
  \node[state](err) [below of=e1] {\mbox{\huge $\emptyset$}};
  \path[->] (e1)  edge [] node {\mbox{\huge a}} (err)
                  edge [] node {\mbox{\huge b}} (e2)
            (e2)  edge [loop right] node {\mbox{\huge a,b}} (e2)
            (err) edge [loop below] node {\mbox{\huge a,b}} (err);
\end{tikzpicture}


Exercícios
==========

- Apresente provas dos teoremas 1 e 2.

Referências
===========

- Owens, et. al. Regular-expression derivatives reexamined.
Journal of Functional Programming, 2009.
