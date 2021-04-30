---
author: PCC102 - Teoria da Computação - Prof. Rodrigo Ribeiro
title: Expressões livres de contexto e gramáticas
---

Objetivos
=========

- Apresentar a equivalência entre gramáticas livres de 
contexto e $\mu$-regular expressions.

Anteriormente
=============

- Foi apresentada a sintaxe e semântica de 
$\mu$-regular expressions.

Anteriormente
=============

- Equivalência com autômatos de pilha não 
determinísticos


Anteriormente
=============

- É fato conhecido que autômatos de pilha não
determinísticos são equivalentes a gramáticas
livres de contexto.


Nessa aula
===========

- Apresentaremos a equivalência entre $\mu$-regular
expressions e gramáticas livres de contexto.

Parte 1
=======

- Como obter uma $\mu$-regular expression a partir 
de uma gramática livre de contexto?

Parte 1
=======

- Seja $G = (V,\Sigma,R,P)$ uma gramática livre de contexto.

1. Inicie com uma expressão formada pelas regras para $P$, 
substituindo $|$ por $+$.

Parte 1
=======

2. Substitua cada variável livre por sua expressão correspondente 
até que não existam variáveis livres.

Parte 1
=======

- Considere a seguinte gramática

$$
\begin{array}{lcl}
S & \to & a ST\,|\,U\\
T & \to & TU\,|\,S\\
U & \to & \lambda
\end{array}
$$


Parte 1
=======

- Convertendo para uma $\mu$-regular expression.
   - Convertendo $S \to a ST\,|\,U$
   
$$
\mu S. a ST + U
$$

Parte 1
=======

- Próxima variável livre: $T$
   - Expressão para $T$: $\mu T. TU + S$
- Obtemos a expressão:

$$
\mu S. a S(\mu T. TU + S) + U
$$

Parte 1
=======

- Próxima variável livre: $U$
   - Expressão para $U$: $\mu U. 1$.
   
- Obtemos a expressão:

$$
\mu S. a S(\mu T. T(\mu U. 1) + S) + (\mu U. 1)
$$

Parte 2
=======

- A segunda parte da equivalência envolve obter uma 
gramática a partir de uma expressão $\mu$-regular.


Parte 2
=======

- Para isso, vamos definir uma função que a partir de
uma expressão $\mu$-regular constrói uma gramática 
equivalente.

Parte 2
=======

- Definição da função $\varphi$:

$$
\begin{array}{lcl}
   \varphi(0) & = & (\{P\},\Sigma,\emptyset,P)\\
   \varphi(1) & = & (\{P\},\Sigma,\{P\to \lambda\},P)\\
   \varphi(a) & = & (\{P\},\Sigma,\{P\to a\},P)\\
   \varphi(v) & = & (\{P,v\},\Sigma,\{P\to v\},P)\\
\end{array}
$$

Parte 2
=======

- Definição da função $\varphi$:

$$
\begin{array}{lcl}
   \varphi(e_1 + e_2) & = & (\{P\} \cup V_1 \cup V_2,\Sigma,R,P)\\
   \text{em que:}     &   &\\
   \:\:\:\:R                  & = & \{P \to P_1\,|\,P_2\}\cup R_1 \cup R_2\\
   \:\:\:\:\varphi(e_1)       & = & (V_1,\Sigma,R_1,P_1)\\
   \:\:\:\:\varphi(e_2)       & = & (V_2,\Sigma,R_2,P_2)\\
\end{array}
$$

Parte 2
=======

- Definição da função $\varphi$:

$$
\begin{array}{lcl}
   \varphi(e_1\,e_2) & = & (\{P\} \cup V_1 \cup V_2,\Sigma,R,P)\\
   \text{em que:}     &   &\\
   \:\:\:\:R                  & = & \{P \to P_1\,P_2\}\cup R_1 \cup R_2\\
   \:\:\:\:\varphi(e_1)       & = & (V_1,\Sigma,R_1,P_1)\\
   \:\:\:\:\varphi(e_2)       & = & (V_2,\Sigma,R_2,P_2)\\
\end{array}
$$

Parte 2
=======

- Definição da função $\varphi$:

$$
\begin{array}{lcl}
   \varphi(e_1^*) & = & (\{P\} \cup V_1,\Sigma,R,P)\\
   \text{em que:}     &   &\\
   \:\:\:\:R                  & = & \{P \to P_1\,P\,|\,\lambda\} \cup R_1\\
   \:\:\:\:\varphi(e_1)       & = & (V_1,\Sigma,R_1,P_1)\\
\end{array}
$$

Parte 2
=======

- Definição da função $\varphi$:

$$
\begin{array}{lcl}
   \varphi(\mu v. e_1) & = & (\{v\} \cup V_1,\Sigma,R,v)\\
   \text{em que:}      &   &\\
   \:\:\:\:R                   & = & \{v \to P_1\} \cup R_1\\
   \:\:\:\:\varphi(e_1)        & = & (V_1,\Sigma,R_1,P_1)\\
\end{array}
$$

Exercício
=========

- Implemente, em sua linguagem de programação favorita, 
a transformação entre expressões $\mu$-regulares e 
gramáticas livres de contexto.

Referências
===========

- Leiß, Hans. Towards Kleene algebra with recursion.
