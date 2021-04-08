---
author: PCC102 - Teoria da Computação - Prof. Rodrigo Ribeiro
title: Minimização
---

Objetivos
=========

- Apresentar o algoritmo de Brzozowski de minimização de AFDs
e sua correção.

- Apresentar um algoritmo de minimização para AFNs.


Revisão
=======

- Antes de apresentar o algoritmo de Brzozowski, devemos 
revisar algumas construções sobre AFs.

- Seja $M=(E,\Sigma,\delta,i,F)$ um AFD que aceita $L(M)$

Revisão
=======

- O AFN $M' = (E,\Sigma,\delta',F,\{i\})$ aceita $L(M)^{R}$.
    - $\delta'(e',a) = \{e \in E\,|\,\delta(e,a) = e'\}$.

Revisão
=======

- Seja $M = (E,\Sigma,\delta,I,F)$ um $AFN$ que aceita $L(M)$.

Revisão
=======

- O AFD $M' = (\mathcal{P}(E),\Sigma,\delta',i,F')$ aceita $L(M)$:
    - $\delta'(X,a) = \bigcup_{e\in X}\delta(e,a)$
    - $i = I$
    - $F' = \{X \in\mathcal{P}(E)\,|,X \cap F \neq \emptyset\}$.

Brzozowski
==========

- O algoritmo de Brzozowski 
    - `rev`: Construção de reverso.
    - `determ`: Construção de um AFD a partir de um AFN.

```haskell
minimize = determ . rev . determ . rev
```

Brzozowski
==========

- Exemplo

\begin{tikzpicture}[auto, node distance=5cm, very thick, initial text=, >=latex,
                    state/.style={circle, draw, minimum size=2cm,
                    every edge quotes/.append style={font=\Large, align=center, auto}}]
    \node[state, initial] (q1) {\mbox{\huge $q_1$}};
    \node[state, accepting, right of=q1] (q2) {\mbox{\huge $q_2$}};
    \node[state, accepting, right of=q2] (q3) {\mbox{\huge $q_3$}};
    \path[->]   (q1) edge[loop above] node{\mbox{\huge 1}} (q1)
                (q1) edge[above] node{\mbox{\huge 0}} (q2)
                (q2) edge[loop above] node{\mbox{\huge 0}} (q2)
                (q2) edge[bend left, above] node{\mbox{\huge 1}} (q3)
                (q3) edge[bend left, below] node{\mbox{\huge 1}} (q2)
                (q3) edge[loop above]node{\mbox{\huge 0}}(q3);
\end{tikzpicture}


Brzozowski
==========

- Aplicando a construção de reverso.

\begin{tikzpicture}[auto, node distance=5cm, very thick, initial text=, >=latex,
                    state/.style={circle, draw, minimum size=2cm}]
    \node[state, accepting] (q1) {\mbox{\huge $q_1$}};
    \node[state, initial below, right of=q1] (q2) {\mbox{\huge $q_2$}};
    \node[state, initial below, right of=q2] (q3) {\mbox{\huge $q_3$}};
    \path[->]   (q1) edge[loop above] node{\mbox{\huge 1}} (q1)
                (q2) edge[above] node{\mbox{\huge 0}} (q1)
                (q2) edge[loop above] node{\mbox{\huge 0}} (q2)
                (q3) edge[bend left, below] node{\mbox{\huge 1}} (q2)
                (q2) edge[bend left, above] node{\mbox{\huge 1}} (q3)
                (q3) edge[loop above]node{\mbox{\huge 0}}(q3);
\end{tikzpicture}

Brzozowski
==========

- Convertendo para um AFD.
   - $A = \{q_2,q_3\}$.
   - $B = \{q_1,q_2,q_3\}$.

\begin{tikzpicture}[auto, node distance=5cm, very thick, initial text=, >=latex,
                    state/.style={circle, draw, minimum size=2cm}]
    \node[state, initial] (A) {\mbox{\huge $A$}};
    \node[state, accepting, right of=A] (B) {\mbox{\huge $B$}};
    \path[->] (A) edge[loop above] node{\mbox{\huge 1}} (A)
              (A) edge[above] node{\mbox{\huge 0}} (B)
              (B) edge[loop above] node{\mbox{\huge $0,1$}} (B) ;
\end{tikzpicture}

Brzozowski
==========

- Construção de reverso.
   - $A = \{q_2,q_3\}$.
   - $B = \{q_1,q_2,q_3\}$.

\begin{tikzpicture}[auto, node distance=5cm, very thick, initial text=, >=latex,
                    state/.style={circle, draw, minimum size=2cm}]
    \node[state, accepting] (A) {\mbox{\huge $A$}};
    \node[state, initial right, right of=A] (B) {\mbox{\huge $B$}};
    \path[->] (A) edge[loop above] node{\mbox{\huge 1}} (A)
              (B) edge[above] node{\mbox{\huge 0}} (A)
              (B) edge[loop above] node{\mbox{\huge $0,1$}} (B) ;
\end{tikzpicture}

Brzozowski
==========

- Convertendo em um AFD.
   - $A = \{q_2,q_3\}$.
   - $B = \{q_1,q_2,q_3\}$.
   - $C = \{B\}$
   - $D = \{A,B\}$

\begin{tikzpicture}[auto, node distance=5cm, very thick, initial text=, >=latex,
                    state/.style={circle, draw, minimum size=2cm}]
    \node[state, initial] (C) {\mbox{\huge $C$}};
    \node[state, accepting, right of=C] (D) {\mbox{\huge $D$}};
    \path[->] (C) edge[loop above] node{\mbox{\huge 1}} (C)
              (C) edge[above] node{\mbox{\huge 0}} (D)
              (D) edge[loop above] node{\mbox{\huge $0,1$}} (D) ;
\end{tikzpicture}


Brzozowski
==========

- A correção do algoritmo de Brzozowski é consequência do seguinte resultado.

- Seja $M=(E,\Sigma,\delta,i,F)$ um AFD para $L$ sem estados inalcançáveis a partir de $i$.
Então, $determ(rev(M))$ é o AFD mínimo para $L^R$.

Brzozowski
==========

- Seja $M^R = (E, \Sigma, \delta', F, \{i\})$ o resultado de $rev\:M$.

- Seja $N = (E_N, \Sigma, \delta_N, i_N, F_N)$ o resultado de $determ\:M^R$.

Brzozowski
==========

- Para mostrar que $N$ é mínimo basta mostrar que $N$ não possui estados
equivalentes.

Brzozowski
==========

- Para isso, suponha $A,B \in E_N$ e que $A$ é equivalente a $B$
   - $A,B$ correspondem a conjuntos de estados em $M^R$.
   - Vamos mostrar que $A = B$.

Brzozowski
==========

- Suponha $e \in A$. Como todo estado de $M$ é alcançável a partir de $i$,
temos que existe $w$ tal que $\widehat{\delta}(i,w) = e$.

- Logo, $i \in \widehat{\delta}'(e,w^R)$.

- Portanto, $\widehat{\delta}_N(A,w^R) \in F_N$.

Brzozowski
==========

- Como $A$ é equivalente a $B$, temos que $\widehat{\delta}_N(B,w^R) \in F_N$.

- Logo, existe $e' \in B$ tal que $i \in \widehat{\delta}'(e',w^R)$ em $M^R$. 

- Portanto, $e' = \widehat{\delta}(i,w)$ em $M$.

Brzozowski
==========

- Como $M$ é um AFD e
   - $\widehat{\delta}(i,w) = e$
   - $\widehat{\delta}(i,w) = e'$
- Temos que que $e = e'$. Como $e \in A$ e $e' \in B$ são arbitrários, 
temos que $A = B$.

Brzozowski
==========

- Portanto, $determ(rev(M))$ é o AFD mínimo para $L^R$.

- Podemos concluir que o algoritmo de Brzozowski produz um 
AFD mínimo aplicando o teorema anterior duas vezes.

Minimização para AFN
====================


Minimização
===========

- Para minimizar AFNs é necessário nos valer do 
conceito de bissimulação.

Definições
==========

- Considere os seguintes AFNs.
    - $M_1 = (E_1,\Sigma,\delta_1,I_1,F_1)$
    - $M_2 = (E_2,\Sigma,\delta_2,I_2,F_2)$

- Seja $\approx$ uma relação entre  $E_1$ e  $E_2$. 

Definições
==========

- Para $B\subseteq E_2$, definimos:

$$
C_{\approx}(B) = \{e \in E_1\,|\, \exists e' \in B. e \approx e'\}
$$

Definições
==========

- Para $A \subseteq E_1$, definimos:

$$
C_{\approx}(A) = \{e' \in E_2\,|\, \exists e \in A. e \approx e'\}
$$

Definições
==========

- Podemos estender a relação $\approx$ para conjuntos de estados.

$$
A \approx B = A \subseteq C_{\approx}(B) \land B \subseteq C_{\approx}(A)
$$

Definições
==========

- Dizemos que uma relação $\approx$ é uma bissimulação:
   1. $i_1 \approx i_2$
   2. Se $e_1 \approx e_2$ então $\forall a\in\Sigma. \delta_1(e_1,a)\approx\delta_2(e_2,a)$
   3. Se $e_1 \approx e_2$ então $e_1 \in F_1$ sse $e_2 \in F_2$

Definições
==========

- Dizemos que AFNs $M_1$ e $M_2$ são bissimilares se existe uma bissimulação entre eles.

- Mostraremos que AFNs bissimilares aceitam a mesma linguagem.

Propriedades
============

- Bissimulações são relações simétricas e transitivas.

- A união de qualquer família de bissimulações é uma bissimulação.

Propriedades
============

- Seja $\approx$ uma bissimulação entre dois AFNs $M_1$ e $M_2$.

- Se $A \approx B$ então $\widehat{\delta}_1(A,w)\approx\widehat{\delta}_2(B,w)$.

Propriedades
============

- Autômatos bissimilares aceitam a mesma linguagem.

    - Suponha que $\approx$ é uma bissimulação de $M_1$ e $M_2$.

    - Temos então que $\widehat{\delta}_1(I_1,w)\approx\widehat{\delta}_2(I_2,w)$.

Propriedades
============

- Como, $\approx$ é uma bissimulação (item 3) temos que 
   - $\widehat{\delta}_1(I_1,w)\cap F_1 \neq \emptyset$ sse 
     $\widehat{\delta}_2(I_2,w)\cap F_2 \neq \emptyset$.

Propriedades
============

- Pela def. de aceitação em AFN, temos que $w \in L(M_1) \leftrightarrow w\in L(M_2)$.

Propriedades
============

- Como $w$ é arbitrário, temos que $L(M_1) = L(M_2)$.

Definição
=========

- Uma auto-bissimulação é uma bissimulação entre um autômato e si próprio.

Definição
=========

- Seja $\approx_M$ uma auto-bissimulação maximal para um AFN $M=(E,\Sigma,\delta,I,F)$.

- Definimos o AFN minimal $M' = (E',\Sigma,\delta',I',F')$ em que:
    - $E' = \{[e]\,|\,e \in E\}$
    - $\delta'([e],a) = [\delta(e,a)]$
    - $I' = \{[i]\,|\,i\in I\}$
    - $F' = \{[f]\,|\,f \in F\}$

Minimização
============

- Logo, o problema de minimizar um AFN consiste em determinar uma auto-bissimulação
maximal.

- Apresentaremos um algoritmo capaz de calcular uma bissimulação entre dois AFNs
   - Auto-bissimulação: considerar o mesmo AFN


Algoritmo 
=========

1. Escrever uma tabela de estados em que todas as entradas estão não marcadas.

2. Marcar pares de estados $e \in F_1$ e $e' \not\in F_2$ ou vice-versa.


Algoritmo
=========

3. Repetir - marque a entrada $(e,e')$:
    - Existe $e_1 \in \delta_1(e,a)$ para todo $e_2 \in \delta_2(e',a)$ 
      em que $(e_1,e_2)$ está marcado  ; ou
    - Existe $e_2 \in \delta_2(e',a)$ para todo $e_1 \in \delta_1(e,a)$ 
      em que $(e_2,e_1)$ está marcado.

Algoritmo
=========

4. Temos que $e \approx e'$ se a entrada $(e,e')$ não está marcada.

5. Se $I_1 \approx I_2$ então existe bissimulação. Caso contrário, não.
    - Note que $\approx$ é reflexiva, logo a existência da auto-bissimulação 
      é garantida.


Exemplo
=======

- Encontrar a auto-bissimulação para:

\begin{tikzpicture}[auto, node distance=5cm, very thick, initial text=, >=latex,
                    state/.style={circle, draw, minimum size=2cm}]
    \node[state, initial] (A) {\mbox{\huge $A$}};
    \node[state, right of=A] (B) {\mbox{\huge $B$}} ;
    \node[state, accepting, right of=B] (C) {\mbox{\huge $C$}};
    \path[->] (A) edge[loop above] node{\mbox{\huge $0,1$}} (A)
              (A) edge[above] node{\mbox{\huge 0}} (B)
              (B) edge[above] node{\mbox{\huge $0,1$}} (C) ;
\end{tikzpicture}

Exemplo
=======

1. Escrever uma tabela de estados em que todas as entradas estão não marcadas.

$$
\begin{array}{c|c|c|c}
   & A & B & C \\ \hline
 A &   &   &   \\ \hline 
 B &   &   &   \\ \hline
 C &   &   &   \\ 
\end{array}
$$

Exemplo
=======

2. Marcar pares de estados $e \in F$ e $e' \not\in F$ ou vice-versa.

$$
\begin{array}{c|c|c|c}
   & A & B & C \\ \hline
 A &   &   & X \\ \hline 
 B &   &   & X \\ \hline
 C & X & X &   \\ 
\end{array}
$$

Exemplo
=======

3. Se existe $e_1 \in \delta_1(e,a)$ para todo $e_2 \in \delta_2(e',a)$ 
    em que $(e_1,e_2)$ está marcado. Marcamos $(e,e')$.
    - Considerando $e = C$, temos que $\delta_1(e,a) = \emptyset$.

$$
\begin{array}{c|c|c|c}
   & A & B & C \\ \hline
 A &   &   & X \\ \hline 
 B &   &   & X \\ \hline
 C & X & X &   \\ 
\end{array}
$$

Exemplo
=======

3. Se existe $e_1 \in \delta_1(e,a)$ para todo $e_2 \in \delta_2(e',a)$ 
    em que $(e_1,e_2)$ está marcado. Marcamos $(e,e')$.
    - Considerando $e' = C$, temos que $\delta_2(e,a) = \emptyset$.

$$
\begin{array}{c|c|c|c}
   & A & B & C \\ \hline
 A &   &   & X \\ \hline 
 B &   &   & X \\ \hline
 C & X & X &   \\ 
\end{array}
$$

Exemplo
=======

3. Se existe $e_1 \in \delta_1(e,a)$ para todo $e_2 \in \delta_2(e',a)$ 
    em que $(e_1,e_2)$ está marcado. Marcamos $(e,e')$.
    - Considerando $e = A$, temos que $\delta_1(e,0) = \{A,B\}$.
    
Exemplo
=======

3. Se existe $e_1 \in \delta_1(e,a)$ para todo $e_2 \in \delta_2(e',a)$ 
    em que $(e_1,e_2)$ está marcado. Marcamos $(e,e')$.
    - Considerando $e = A$, temos que $\delta_1(e,1) = \{A\}$.
    - Considerando $e' = B$, temos que $\delta_2(e',a) = \{C\}$

Exemplo
=======

- Como as entradas $(A,C)$ e $(B,C)$ estão marcadas, devemos marcar
$(A,B)$ e $(B,A)$.

$$
\begin{array}{c|c|c|c}
   & A & B & C \\ \hline
 A &   & X & X \\ \hline 
 B & X &   & X \\ \hline
 C & X & X &   \\ 
\end{array}
$$


Exemplo
=======

- Logo, o AFN é minimal para a linguagem.

$$
\begin{array}{c|c|c|c}
   & A & B & C \\ \hline
 A &   & X & X \\ \hline 
 B & X &   & X \\ \hline
 C & X & X &   \\ 
\end{array}
$$

Exercício
=========

- AFNs produzidos pela minimização são minimais e não mínimos. Logo, 
pode existir dois ou mais AFNs diferentes para a mesma linguagem. 
Apresente um exemplo de AFNs minimais diferentes que aceitam a mesma 
linguagem.
