---
author: PCC102 - Teoria da Computação - Prof. Rodrigo Ribeiro
title: Derivadas parciais
---

Objetivos
=========

- Apresentar o conceito de derivada parcial para expressões regulares.

- Mostrar como obter um AFN para uma expressão regular usando 
derivadas parciais

Objetivos
=========

- Apresentar um algoritmo de casamento usando derivadas parciais.


Derivadas
=========

- Anteriormente vimos como derivadas de Brzozowski podem ser 
usadas para criar um AFD a partir de uma RE.

Derivadas
=========

- As derivadas parciais foram criadas por Antimirov para criar
AFNs sem transições $\lambda$ a partir de uma RE.

Derivadas
=========

- Intuitivamente, $\nabla_a(e)$ denota o conjunto de expressões
regulares obtidas ao processar o símbolo $a$.

Derivadas
=========

- Assim como as derivadas de Brzozowski, as derivadas parciais 
também utilizam a função $\nu(e)$ que retorna $\lambda$ se 
$\lambda \in[\![e]\!]$ e $\emptyset$, caso contrário.

Derivadas
=========

- A definição de derivada parcial usa a seguinte operação.

$$
S \odot e' = \{e ∙ e'\,\mid\, e \in S\}
$$

Derivadas
=========

- Definição de derivada parcial. 

$$
\begin{array}{lclr}
  \nabla_a(\emptyset) & = & \emptyset\\
  \nabla_a(\lambda) & = & \emptyset \\
  \nabla_a(b) & = & \left\{
                      \begin{array}{lr}
                        \{\lambda\} & \text{se } b = a\\
                        \emptyset & \text{caso contrário}
                      \end{array}
                                \right.\\
\end{array}
$$

Derivadas
=========

- Definição de derivada parcial. 

$$
  \begin{array}{lclr}
    \nabla_a(e\:e') & = & \left \{
                           \begin{array}{lr}
                              \nabla_a(e) \odot e' \cup \nabla_a(e') & \text{se }\nu(e) = \lambda \\
                              \nabla_a(e) \odot e' & \text{caso contrário} \\
                           \end{array} \right . \\
  \end{array}
$$


Derivadas
=========

- Definição de derivada parcial. 

$$
  \begin{array}{lclr}
    \nabla_a(e + e') & = & \nabla_a(e) \cup \nabla_a(e') \\
    \nabla_a(e^\star) & = & \nabla_a(e) \odot e^\star\\
  \end{array}
$$

Derivadas
=========

- Correção: $w \in[\![\nabla_a(e)]\!]$ se e somente se $aw\in[\![e]\!]$.
- Demonstração: Indução sobre a estrutura de $e$.

Matching
========

- O algoritmo de matching pode ser adaptado de maneira imediata.

$$
\begin{array}{lcl}
   \nabla^*(S,\lambda) & = & \exists e \in S. \nu(e) = \lambda \\
   \nabla^*(S,aw)      & = & \nabla^*(\bigcup_{e \in S}\nabla(e,a),w) \\
\end{array}
$$

Conversão em NFA
================

- Seja $\mathcal{D}(e)$ o conjunto de derivadas parciais para uma RE. 
   - Esse conjunto é finito.

Conversão em NFA
================

- $M=(\mathcal{D}(e),\Sigma,\delta,I,F)$
   - $\delta(e',a)=\nabla_a(e')$.
   - $I = \{e\}$
   - $F=\{e'\,|\, \nu(e') = \lambda\}$

Conversão em NFA
================

- O AFNs produzido usando derivadas parciais possui no máximo $\varphi(e) + 1$ estamos.
   - $\varphi(e)$ é o número de símbolos do alfabeto em $e$.

Exemplo
=======

- Construir um AFN para $e = aa^* +ab^*$.
  
\begin{tikzpicture}[auto, node distance=5cm, very thick, initial text=, >=latex,
                    state/.style={circle, draw, minimum size=2cm}]
    \node[state, initial] (A) {\mbox{\huge $e$}};
\end{tikzpicture}


Exemplo
=======

- Construir um AFN para $e = aa^* +ab^*$.

$$
\begin{array}{lc}
\nabla_a(aa^* + ab^*) & = \\
\nabla_a(aa^*) \cup \nabla_a(ab^*) & = \\
\nabla_a(a)\odot a^* \cup \nabla_a(a) \odot b^* & =\\ 
\{\lambda\} \odot a^* \cup \{\lambda\}\odot b^* & = \\
\{a^*, b^*\}
\end{array}
$$
  
Exemplo
=======

- $e_1 = \{a^*, b^*\}$.

\begin{tikzpicture}[auto, node distance=5cm, very thick, initial text=, >=latex,
                    state/.style={circle, draw, minimum size=2cm}]
    \node[state, initial]   (A) {\mbox{\huge $e$}};
    \node[state, accepting, right of=A] (B) {\mbox{\huge $a^*$}};
    \node[state, accepting, below right of=A] (C) {\mbox{\huge $b^*$}};
    \path[->] (A) edge[above] node{\mbox{\huge a}} (B) 
              (A) edge[above] node{\mbox{\huge a}} (C) ;
\end{tikzpicture}

Exemplo
=======

- Construir um AFN para $e = aa^* +ab^*$.

$$
\begin{array}{lc}
\nabla_b(aa^* + ab^*) & = \\
\nabla_b(aa^*) \cup \nabla_a(ab^*) & = \\
\nabla_b(a)\odot a^* \cup \nabla_b(a) \odot b^* & =\\ 
\emptyset \odot a^* \cup \emptyset\odot b^* & = \\
\emptyset
\end{array}
$$

Exemplo
=======

- Adicionando estados para $\{a^*,b^*\}$.

\begin{tikzpicture}[auto, node distance=5cm, very thick, initial text=, >=latex,
                    state/.style={circle, draw, minimum size=2cm}]
    \node[state, initial]   (A) {\mbox{\huge $e$}};
    \node[state, accepting, right of=A] (B) {\mbox{\huge $a^*$}};
    \node[state, accepting, below right of=A] (C) {\mbox{\huge $b^*$}};
    \node[state,below of= A](E){\mbox{\huge $\emptyset$}};
    \path[->] (A) edge[above] node{\mbox{\huge a}} (B) 
              (A) edge[left] node{\mbox{\huge b}} (E) 
              (A) edge[above] node{\mbox{\huge a}} (C)
              (E) edge[loop left] node{\mbox{\huge a,b}} (E);
\end{tikzpicture}



Exemplo
=======

$$
\begin{array}{lcl}
\nabla_a(a^*) & = & \{a^*\} \\
\nabla_a(b^*) & = & \emptyset \\
\nabla_b(a^*) & = & \emptyset\\
\nabla_b(b^*) & = & \{b^*\} \\
\end{array}
$$

Exemplo
=======

- Adicionando transições.

\begin{tikzpicture}[auto, node distance=5cm, very thick, initial text=, >=latex,
                    state/.style={circle, draw, minimum size=2cm}]
    \node[state, initial above]   (A) {\mbox{\huge $e$}};
    \node[state, accepting, right of=A] (B) {\mbox{\huge $a^*$}};
    \node[state, accepting, below of=A] (C) {\mbox{\huge $b^*$}};
    \node[state,left of= A](E){\mbox{\huge $\emptyset$}};
    \path[->] (A) edge[above] node{\mbox{\huge a}} (B) 
              (A) edge[above] node{\mbox{\huge b}} (E) 
              (A) edge[right] node{\mbox{\huge a}} (C)
              (C) edge[above] node{\mbox{\huge a}} (E)
              (C) edge[loop below] node{\mbox{\huge b}} (C)
              (B) edge[loop above] node{\mbox{\huge a}} (B)
              (B) edge[bend right, above] node{\mbox{\huge b}} (E)
              (E) edge[loop left] node{\mbox{\huge a,b}} (E);
\end{tikzpicture}


Exercício
=========

- Implemente o algoritmo de matching baseado em derivadas parciais
em sua linguagem de programação favorita.


Referências 
===========

- Antimirov, Valentin. Partial derivatives of regular expressions 
and finite automaton constructions. Theoretical Computer Science.
