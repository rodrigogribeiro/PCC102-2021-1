---
author: PCC102 - Teoria da Computação - Prof. Rodrigo Ribeiro
title: Indução
---

Objetivos
=========

- Revisar os conceitos de indução fraca e 
forte sobre números naturais.

- Discutir sobre como realizar provas por indução
sobre a sintaxe de objetos e sobre derivações de provas.

Objetivos
=========

- Apresentar o conceito de indução sobre uma relação 
bem formada.


Indução
=======

- Indução é, provavelmente, a técnica de demonstração
mais utilizada em ciência da computação.

- Vamos revisar rapidamente alguns conceitos de indução
pois usaremos muitas provas por indução no curso.

Indução
=======

- A forma mais conhecida de indução matemática é a chamada
indução _fraca_. 

$$
\forall n \in \mathbb{N}. P(n) \equiv P(0) \land (\forall n. P(n) \to P(n + 1)).
$$

Indução
=======

- Provar que $\sum_{k=0}^n k = \frac{n(n+1)}{2}$.

Indução
=======

- Caso base $(n = 0)$. Temos que:

$$
\begin{array}{lc}
\sum_{k=0}^0 k & = \\ 
\end{array}
$$

Indução
=======

- Caso base $(n = 0)$. Temos que:

$$
\begin{array}{lc}
\sum_{k=0}^0 k & = \\ 
0              & = \\
\end{array}
$$

Indução
=======

- Caso base $(n = 0)$. Temos que:

$$
\begin{array}{lc}
\sum_{k=0}^0 k & = \\ 
0              & = \\
\frac{0(0 + 1)}{2} & \\
\end{array}
$$

Indução
=======

- Passo indutivo. Suponha $n$ arbitrário e que $\sum_{k=0}^n k = \frac{n(n+1)}{2}$.
Temos:

$$
\begin{array}{lc}
\sum_{k = 0}^{n + 1}k         & = \\
\end{array}
$$

Indução
=======

- Passo indutivo. Suponha $n$ arbitrário e que $\sum_{k=0}^n k = \frac{n(n+1)}{2}$.
Temos:

$$
\begin{array}{lc}
\sum_{k = 0}^{n + 1}k         & = \\
\sum_{k = 0}^n k + (n + 1)    & = \\
\end{array}
$$

Indução
=======

- Passo indutivo. Suponha $n$ arbitrário e que $\sum_{k=0}^n k = \frac{n(n+1)}{2}$.
Temos:

$$
\begin{array}{lc}
\sum_{k = 0}^{n + 1}k         & = \\
\sum_{k = 0}^n k + (n + 1)    & = \\
\frac{n(n+1)}{2} + (n + 1)    & = \\
\end{array}
$$

Indução
=======

- Passo indutivo. Suponha $n$ arbitrário e que $\sum_{k=0}^n k = \frac{n(n+1)}{2}$.
Temos:

$$
\begin{array}{lc}
\sum_{k = 0}^{n + 1}k         & = \\
\sum_{k = 0}^n k + (n + 1)    & = \\
\frac{n(n+1)}{2} + (n + 1)    & = \\
\frac{n(n + 1) + 2(n + 1)}{2} & = \\
\end{array}
$$


Indução
=======

- Passo indutivo. Suponha $n$ arbitrário e que $\sum_{k=0}^n k = \frac{n(n+1)}{2}$.
Temos:

$$
\begin{array}{lc}
\sum_{k = 0}^{n + 1}k         & = \\
\sum_{k = 0}^n k + (n + 1)    & = \\
\frac{n(n+1)}{2} + (n + 1)    & = \\
\frac{n(n + 1) + 2(n + 1)}{2} & = \\
\frac{(n + 1)(n + 2)}{2}      & \\
\end{array}
$$

Indução
=======

- Indução fraca nem sempre é o método mais conveniente para uma prova.
- A hipótese de indução é restrita apenas a $n$ e não pode ser usada
para valores menores que $n$.

Indução
=======

- A Indução _forte_ assume uma hipótese de indução válida para quaisquer 
valores menores que $n$.
- É possível mostrar que ambos os princípios são equivalentes.

$$
\forall n \in \mathbb{N}. P(n) \equiv \forall n. (\forall k. k < n \to P(k)) \to P(n)
$$

Indução
=======


- Exemplo: Prove que para todo $n > 1$, $n$ é primo ou um produto de primos.


Indução
=======

- Suponha $n > 1$ arbitrário. Se $n$ é primo, a conclusão é imediata. Logo, 
suponha que $n$ não é primo.

- Como $n$ não é primo, existem $a, b$ tais que  $1< a < n$,  $1< b < n$ e 
$n = ab$.

Indução
=======

- Como $a < n$, pela H.I., $a$ é primo ou produto de primos.

- Como $b < n$, pela H.I., $b$ é primo ou produto de primos.

Indução
=======

- Logo, $n = ab$ é um produto de primos em todos os casos.

Indução
=======

- Podemos usar a indução sobre números naturais em elementos 
de um conjunto $A$ qualquer se existir uma função
- $f : A \to \mathbb{N}$

Indução
=======

- Usando a função $f$, podemos definir:

$$
Q(n) = \forall a \in A. f(a) = n \to P(a)
$$

- E então provamos $\forall n. Q(n)$ usando indução fraca ou forte.

Indução
=======

- Prove que o número de folhas em uma árvore binária é, no máximo, um
a mais que o número de nós internos.

Indução
=======

- Para esse exemplo, temos que $P(t)$ é "a árvore $t$ tem, no máximo, 
uma folha a mais que seu número de nós internos".

- Defina $H(t)$ como a altura de uma árvore $t$. Temos

$$
Q(n) = \forall t. H(t) = n \to P(t)
$$

Indução
=======

- Provaremos esse resultado usando indução forte.

- Suponha $n \in \mathbb{N}$ arbitrário. Suponha que para todo 
$k < n$ e árvore $t$, se $H(t) = k$ então $P(t)$.

Indução
=======

- Caso $n = 0$: 
  - Note que não existe $k < 0$.
  - Logo, devemos mostrar que $H(t) = 0 \to P(t)$.
  - Somente uma folha é uma árvore com $H(t) = 0$.
  - Logo, o número de folhas $L(t)$ é um a mais que o número de nós 
  internos, $N(t)$.

Indução
=======

- Caso $n > 0$: 
- Nesse caso, $t$ é formada for duas subárvores: $l$ e $r$.
- Pela HI, temos que $P(l)$ e $P(r)$. Logo, temos:

$$
\begin{array}{lc}
L(t)        & = \\
L(l) + L(r) & \leq \\
N(l) + 1 + N(r) + 1 & = \\
N(t) + 1
\end{array}
$$


Indução
=======

- Outra aplicação de indução é demonstrar propriedades de 
um sistema de provas.

- Similar ao apresentado para árvores, porém consideramos 
como "árvores" sub-derivações de uma prova.

Indução
=======

- Um sistema de prova simples.

$$
\begin{array}{cc}
\dfrac{}{even\:0} &
\dfrac{even\:n}{even (n + 2)}
\end{array}
$$

Indução
=======

- Uma prova de que $even\:6$.

$$
\dfrac{
\dfrac{
\dfrac{\dfrac{}{even\:0}}{even\:2}
}{even\:4}
}{even\:6}
$$

Indução
=======

- Provar que se $even\:n$ e $even\:m$ então $even (n + m)$.

- Para provar esse fato, provamos que é válido para cada uma 
das regras do sistema de provas.

Indução
=======

- Suponha que $even\:n$ e $even\:m$. Seguiremos por indução sobre a 
derivação de $even\:n$.
- Caso $even\:0$: Nesse caso, temos que $n = 0$ e portanto  + m = m$.
- Como temos que $even\:m$, a conclusão segue.

Indução
=======

- Caso $even\:(n' + 2)$: Nesse caso, temos que $n = n' + 2$ e seja $D$ a subderivação
de $even\:n'$.

- Pela H.I. sobre as derivações de $even\:n'$ e $even\:m$ temos que $even(n' + m)$.

Indução
=======

- Seja $E$ a derivação de $even(n' + m)$.

- Ao usarmos a regra 

$$
\dfrac{even\:n}{even (n + 2)}
$$

- sobre a derivação $E$, obtemos $even (n' + 2 + m)$.

Indução
=======

- Porém, como $n = n' + 2$, temos que $even (n + m)$, conforme requerido.


Indução
=======

- Todos os princípios de indução apresentados podem ser generalizados em 
um único: indução sobre relações bem formadas.

- Relações bem formadas: Dizemos que uma relação $\prec \subseteq A \times A$ 
é bem formada se ela não possui uma cadeia decrescente infinita.
- Cadeia decrescente infinita: $a_1 \prec a_2 \prec ...$.

Indução
=======

- Indução sobre relações bem formadas: Seja $\prec$ uma relação bem formada
sobre um conjunto $A$. Temos que:

$$
\forall a \in A. P(a) \equiv \forall a. (\forall b. b \prec a \to P(b)) \to P(a)
$$

Indução
=======

- Exemplo de relação bem formada: $<$ sobre $\mathbb{N}$.

- Outro exemplo: $i \prec j$, quando $i = j + 1$. 
- Essa relação é a que especializa a indução sobre relações bem formadas
para indução fraca.

Indução
=======

- Ordem lexicográfica: Sejam $\prec_A$ e $\prec_B$ duas relações bem formadas sobre
conjuntos $A$ e $B$, respectivamente. Definimos que a ordem lexicográfica de relações
sobre $A$ e $B$ como:

$$
(a,b) \prec (a',b') \equiv a \prec_A a' \lor (a = a' \land b \prec_B b')
$$


Exercícios
==========

- Prove a equivalência entre os princípios de indução fraca 
e forte para números naturais.


Exercícios
==========

- Considere a seguinte definição de um predicado que indica que
um valor pertence a uma lista.

$$
\begin{array}{cc}
\dfrac{}{x \in x:xs} & \dfrac{x \in ys}{x \in y:ys}
\end{array}
$$

Exercícios
==========

- A regra a seguir diz que um elemento pertence a uma lista se 
ele é a cabeça da lista.

$$
\dfrac{}{x \in x:xs}
$$

Exercícios
==========

- A segunda regra diz que um elemento pertence a uma lista se 
ele pertence à cauda da lista.

$$
\dfrac{x \in ys}{x \in y:ys}
$$

Exercícios
==========

- Exemplo:  \in [1,2,3]$.

$$
\dfrac{
\dfrac{}{2 \in [2,3]}
}{2\in [1,2,3]}
$$

Exercícios
==========

- Prove que se $x \in xs$ então $x \in ys ++ xs$, em que 
$++$ é a função de concatenação de listas.

Symbol’s function definition is void: end-of-fileSymbol’s value as variable is void: haskellSymbol’s function definition is void: end-of-file

Referências
===========

- Mitchel, John. Foundations for programming Languages, MIT Press, 1996.
