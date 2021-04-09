---
author: PCC102 - Teoria da Computação - Prof. Rodrigo Ribeiro
title: Teorema de Myhill-Nerode
---

Objetivos
=========

- Apresentar o conceito de relações de Myhill-Nerode e 
sua relação com AFs.

Isomorfismo
===========

- Considere dois AFs. 
    - $M_1 = (E_1,\Sigma,\delta_1,i_1,F_1)$ 
    - $M_2 = (E_2,\Sigma,\delta_2,i_2,F_2)$

Isomorfismo
===========

- Dizemos que $M_1 \approx M_2$ se existe
$f : E_1 \to E_2$:
    - $f(i_1) = i_2$
    - $f(\delta_1(e_1,a)) = \delta_2(f(e_1),a)$
    - Se $e_1 \in F_1$ então $f(e_1) \in F_2$.

Resumindo
=========

- Dois AFs são isomórficos se são exatamente o 
mesmo AF, a menos de renomear estados.

Isomorfismo
===========

- Nessa aula, mostraremos que certas relações sobre linguagens
possuem um isomorfismo com os AFs que as aceitam.

Recordando
==========

- Relação de equivalência.
   - reflexiva: $\forall x \in A. x R x$.
   - simétrica: $\forall x,y \in A. xRy \to y R x$.
   - Transitiva: $\forall x,y,z \in A. xRy \land yRz \to x R z$.

Recordando
==========

- Classe de equivalência.

$$
[x]_{R} = \{y\,|\,xRy\}
$$

Recordando
==========

- Partição é uma família $\mathcal{F} \subseteq \mathcal{P}(A)$:
    - $\bigcup \mathcal{F} = A$.
    - $\forall X,Y \in \mathcal{F}. X \neq Y \to X \cap Y = \emptyset$.
    - $\forall X \in \mathcal{F}. X \neq \emptyset$.
    
Recordando
==========

- O conjunto de classes de equivalência sobre um conjunto $A$ é uma partição.

Definições
==========

- Seja $A\subseteq \Sigma^*$ e $M = (E,\Sigma,\delta,i,F)$ um 
AF tal que $L(M) = A$.

- O AF $M$ induz a seguinte relação de equivalência:

$$
w \equiv_M w' = \{(w,w')\,|\,\widehat{\delta}(i,w) = \widehat{\delta}(i,w')\}
$$


Definições
==========

- Adicionalmente, $\equiv_M$, satisfaz:
    1. Congruência à direita:
    
$$
\forall w,w'\in\Sigma^*.\forall a \in \Sigma. w \equiv_M w' \to wa \equiv_M w'a
$$

Definições
==========

- Para mostrar esse fato, suponha $w \equiv_M w'$ e $a \in \Sigma$. Temos:

$$
\begin{array}{lc}
\widehat{\delta}(i,wa) & = \\
\end{array}
$$

Definições
==========

- Para mostrar esse fato, suponha $w \equiv_M w'$ e $a \in \Sigma$. Temos:

$$
\begin{array}{lc}
\widehat{\delta}(i,wa)          & = \\
\delta(\widehat{\delta}(i,w),a) & = \\
\end{array}
$$

Definições
==========

- Para mostrar esse fato, suponha $w \equiv_M w'$ e $a \in \Sigma$. Temos:

$$
\begin{array}{lcc}
\widehat{\delta}(i,wa)            & = \\
\delta(\widehat{\delta}(i,w),a)   & = & \textrm{usando }w \equiv_M w'\\
\delta(\widehat{\delta}(i,w'),a)) & = \\
\end{array}
$$

Definições
==========

- Para mostrar esse fato, suponha $w \equiv_M w'$ e $a \in \Sigma$. Temos:

$$
\begin{array}{lc}
\widehat{\delta}(i,aw)            & = \\
\delta(\widehat{\delta}(i,w),a)   & = \\
\delta(\widehat{\delta}(i,w'),a)) & = \\
\widehat{\delta}(i,w'a)           & \\
\end{array}
$$


Definições
==========

2. $\equiv_M$ é um refinamento de $A$:

$$
w \equiv_M w' \to (w \in A \leftrightarrow w' \in A)
$$

Definições
==========

3. O número de classes de equivalência de $\equiv_M$ é finito.
    - Cada classe de equivalência corresponde a um estado de $M$.
    
Definições
==========

- Uma relação de equivalência sobre $\Sigma^*$ que atende as condições 1-3
é chamada de relação Myhill-Nerode.

Isomorfismo
===========

- Existe um isomorfismo entre um AF $M$ e uma relação Myhill-Nerode $\equiv_M$ para uma 
linguagem $A$.
   - Não é necessário supor que $A$ é regular.

Isomorfismo
===========

- Já vimos a primeira parte da construção: obter uma relação a partir de um AF.

- Segunda parte: Suponha $\equiv$ uma relação Myhill-Nerode para $A \subseteq\Sigma^*$.


Isomorfismo
===========

- Construa o AF $M=(E,\Sigma,\delta,i,F)$, em que:
    - $E = \{[w]_{\equiv}\,|\,w \in \Sigma^*\}$.
    - $\delta([w]_{\equiv},a)=[aw]_\equiv$.
    - $i = [\lambda]_\equiv$
    - $F =\{[x]_\equiv \,|\, x\in A\}$.
    
Isomorfismo
===========

- Prop. 1: $w \in A$ se e somente se $[w]_\equiv \in F$.
    - Imediato a partir da def. de $F =\{[x]_\equiv \,|\, x\in A\}$


Isomorfismo
===========

- Para mostrar que $L(M) = A$, vamos provar um resultado auxiliar:

$$
\widehat{\delta}([w]_\equiv,w') = [ww']
$$


Isomorfismo
===========

- Caso base ($w'= \lambda$):

$$
\begin{array}{lc}
  \widehat{\delta}([w]_\equiv,\lambda) & = \\
\end{array}
$$

Isomorfismo
===========

- Caso base ($w'= \lambda$):

$$
\begin{array}{lc}
  \widehat{\delta}([w]_\equiv,\lambda) & = \\
  [w]_\equiv                           & = \\
\end{array}
$$

Isomorfismo
===========

- Caso base ($w'= \lambda$):

$$
\begin{array}{lc}
  \widehat{\delta}([w]_\equiv,\lambda) & = \\
  [w]_\equiv                           & = \\
  [w\lambda]_\equiv                    & \\
\end{array}
$$

Isomorfismo
===========

- Passo indutivo:

$$
\begin{array}{lc}
   \widehat{\delta}([w]_\equiv,w'a)          & = \\
\end{array}
$$

Isomorfismo
===========

- Passo indutivo:

$$
\begin{array}{lc}
   \widehat{\delta}([w]_\equiv,w'a)          & = \\
   \delta(\widehat{\delta}([w]_\equiv,w'),a) & = \\
\end{array}
$$

Isomorfismo
===========

- Passo indutivo:

$$
\begin{array}{lc}
   \widehat{\delta}([w]_\equiv,w'a)          & = \\
   \delta(\widehat{\delta}([w]_\equiv,w'),a) & = \\
   \delta([ww']_\equiv,a)                    & = \\
\end{array}
$$

Isomorfismo
===========

- Passo indutivo:

$$
\begin{array}{lc}
   \widehat{\delta}([w]_\equiv,w'a)          & = \\
   \delta(\widehat{\delta}([w]_\equiv,w'),a) & = \\
   \delta([ww']_\equiv,a)                    & = \\
   [ww'a]_\equiv
\end{array}
$$

Isomorfismo
===========

- Teorema: $L(M) = A$.

- Suponha $w \in L(M)$ arbitrário.

$$
\begin{array}{lc}
   w \in L(M) & \leftrightarrow \\
\end{array}
$$

Isomorfismo
===========

- Teorema: $L(M) = A$.

- Suponha $w \in L(M)$ arbitrário.

$$
\begin{array}{lc}
   w \in L(M) & \leftrightarrow \\
   \widehat{\delta}([\lambda]_\equiv,w) & \leftrightarrow \\
\end{array}
$$


Isomorfismo
===========

- Teorema: $L(M) = A$.

- Suponha $w \in L(M)$ arbitrário.

$$
\begin{array}{lcl}
   w \in L(M) & \leftrightarrow \\
   \widehat{\delta}([\lambda]_\equiv,w) \in F & \leftrightarrow \\
   [w]_\equiv \in F & \leftrightarrow & \{\textrm{por }\widehat{\delta}([w]_\equiv,w')=[ww']_\equiv\}\\
\end{array}
$$

Isomorfismo
===========

- Teorema: $L(M) = A$.

- Suponha $w \in L(M)$ arbitrário.

$$
\begin{array}{lcl}
   w \in L(M) & \leftrightarrow \\
   \widehat{\delta}([\lambda]_\equiv,w) \in F & \leftrightarrow \\
   [w]_\equiv \in F & \leftrightarrow & \{\textrm{por }\widehat{\delta}([w]_\equiv,w')=[ww']_\equiv\}\\
   w \in A &  & \{\textrm{por Prop. 1}\}\\ 
\end{array}
$$

Refinamento
===========

- Dizemos que uma relação $\equiv_1$ _refina_ uma relação $\equiv_2$ se 
$\equiv_1 \subseteq \equiv_2$.

Refinamento
===========

- Exemplo: $R_1$ refina $R_2$.

$$
\begin{array}{l}
R_1 = \{(x,y)\in\mathbb{N}\times\mathbb{N}\,|\, y = 4 * x\}\\
R_2 = \{(x,y)\in\mathbb{N}\times\mathbb{N}\,|\, y = 2 * x\}\\
\end{array}
$$

Refinamento
===========

- A relação de refinamento entre relações é uma ordem parcial:
   - reflexiva: $\forall x. x R x$
   - transitiva: $\forall x,y,z. xRy \land yRz \to xRz$
   - anti-simétrica: $\forall x,y. xRy \land yRx \to x = y$

Refinamento
===========

- Seja $A \subseteq \Sigma^*$. Defina a relação de equivalência:

$$
w \equiv_A w' = \forall z \in \Sigma^*. (wz \in A \Leftrightarrow w'z \in A) 
$$


Refinamento
===========

1. $\forall w,w'\in\Sigma^*.\forall a \in \Sigma. w \equiv_A w' \to wa \equiv_A w'a$

2. $\equiv_A$ é um refinamento de $A$.


Refinamento
===========

- A relação anterior atende as propriedades 1 e 2 apresentadas.

- Se $A$ é uma linguagem regular, então a relação atende a propriedade 3.

Teorema
=======

- As seguintes afirmativas são equivalentes:

1. $A$ é uma linguagem regular;

2. Existe uma relação Myhill-Nerode para $A$;

3. A relação $\equiv_R$ possui um número finito de classes de equivalência.

Aplicação
=========

- Além de relacionar os estados de AFs com classes de equivalências de 
linguagens, o teorema de Myhill-Nerode pode ser usado para provar que 
linguagens não são regulares.

Aplicação
=========

- Provar que $A = \{0^n1^n\,|\,n\geq 0\}$ não é regular.

- Se $k \neq m$ então $0^k1^k \not\equiv_A 0^m1^m$. 
   - Como existem infinitos valores para $k$ e $m$, temos que o 
     número de classes de equivalência para 
     $\equiv_A$ é infinito e, portanto, pelo teorema de Myhill-Nerode, $A$ não 
     pode ser uma linguagem regular.


Exercício
=========

- Prove que a relação $\equiv A$ atende as propriedades 1 e 2.

Referência
==========

- Kozen, Dexter. Automata and Computability.
