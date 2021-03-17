---
author: PCC102 - Teoria da Computação - Prof. Rodrigo Ribeiro
title: Expressões regulares
---


Objetivos
=========

\newcommand{\conf}[1]{\langle #1 \rangle}

- Apresentar a sintaxe de expressões regulares.

- Apresentar a semântica denotacional de expressões regulares.

Objetivos
=========

- Apresentar a semântica operacional big-step de expressões 
regulares.

- Apresentar a semântica operacional small-step de expressões 
regulares.


Expressões regulares
====================

- Especificação algébrica de linguagens regulares.

- Criada por Kleene em 1951 como uma forma de especificar 
linguagens regulares usando o que ele concebeu como _regular events_.


Expressões regulares
====================

- Amplamente utilizadas em computação para casamento de padrões em texto.

- Resultados conhecidos da teoria de linguagens formais mostram que 
expressões regulares são equivalentes à autômatos finitos.


Sintaxe
=======

- Seja $\Sigma$ um alfabeto e $a \in \Sigma$. 
- A sintaxe de expressões regulares sobre $\Sigma$ é: 

$$
e \to \emptyset\,|\,\lambda \,|\,a\,|\,e + e\,|\,e\:e\,|\,e^{*}
$$

Sintaxe
=======

- Definimos o tamanho de uma expressão regular como o número de 
símbolos do alfabeto somado ao número de operadores.

- Denotamos por $size(e)$ o tamanho de uma expressão regular $e$.

Sintaxe
=======

- Sejam $s$ e $s'$ duas strings. Definimos $s \prec_s s'$ como:

$$
s \prec_s s' \equiv |s| < |s'|
$$

Sintaxe
=======

- Podemos definir uma relação bem formada entre expressões regulares 
e strings usando uma ordem lexicográfica baseada no tamanho de uma
expressão regular e na relação $\prec_s$.

Semântica
=========

- Tradicionalmente, a semântica de expressões regulares é 
especificada de forma denotacional.

- Para isso, define-se uma função $[\![\_]\!] : e\to \mathcal{P}(\Sigma^*)$
que associa a uma expressão a linguagem por ela denotada.

Semântica
=========

- Semântica denotacional

$$
\begin{array}{lcl}
[\![\emptyset]\!] & = & \emptyset\\
[\![\lambda ]\!]  & = & \{\lambda\}\\
[\![ a ]\!]       & = & \{a\} \\
[\![e_1 + e_2]\!] & = & [\![e_1]\!] \cup [\![e_2]\!] \\
[\![e_1\:e_2]\!]  & = & [\![e_1]\!]\:[\![e_2]\!]\\
[\![e^*]\!]       & = & ([\![e]\!])^*\\
\end{array}
$$

Semântica
=========

- Como definir uma semântica operacional para expressões regular?

- A idéia é definir um sistema de provas para determinar quando um
string $s$ pertence a linguagem denotada por uma expressão $e$.

Semântica
=========

- Representaremos a semântica operacional big-step por um sistema de
regras para concluir $s \in |\!|e|\!|$ que denotará que a string $s$ pertence
à linguagem de $e$.

Semântica
=========

- Regras base: $\lambda$ e um símbolo de $\Sigma$.

$$
\begin{array}{cc}
  \dfrac{}{\lambda \in |\!|\lambda|\!|} & 
  \dfrac{a \in \Sigma}{a \in |\!|a|\!|} 
\end{array}
$$

Semântica
=========

- Regras para União.

$$
\begin{array}{cc}
  \dfrac{s \in |\!|e_1|\!|}{s \in |\!|e_1 + e_2|\!|} &
  \dfrac{s \in |\!|e_2|\!|}{s \in |\!|e_1 + e_2|\!|} 
\end{array}
$$

Semântica 
=========

- Regra para concatenação.

$$
\dfrac{s \in |\!|e_1|\!|\:\:\:s' \in|\!|e_2|\!|}{ss' \in |\!|e_1\:e_2|\!|}
$$

Semântica
=========

- Regras para o fecho de Kleene.

$$
\begin{array}{cc}
\dfrac{}{\lambda \in |\!|e^*|\!|} &
\dfrac{s \in |\!|e|\!|\:\:\:\:s'\in |\!|e^*|\!|}{ss'\in|\!|e^*|\!|}
\end{array}
$$

Semântica
=========

- Teorema: Para todo $s\in\Sigma^*$ e para todo $e$, temos que $s \in [\![e]\!]$ se 
e somente se $s\in |\!| e |\!|$.
   - $(\to)$ Prova por indução bem formada sobre $(e,s)$
   - $(\leftarrow)$ Prova por indução bem formada sobre $(e,s)$


Semântica
=========

- Alguns casos da prova para primeira implicação.

- Primeiro, supomos que $s \in [\![e]\!]$.


Semântica
=========

- Caso $e = \lambda$. Temos que $s \in [\![\lambda]\!]$. Logo, temos que:

$$
\begin{array}{lc}
s \in [\![\lambda]\!] & \Leftrightarrow \\ 
s \in \{\lambda\}     & \Leftrightarrow \\ 
s = \lambda
\end{array}
$$

- Como $s = \lambda$, temos que $s \in |\!|\lambda|\!|$, como requerido.


Semântica
=========

- Caso $e = e_1 + e_2$. Temos que $s \in [\![e_1 + e_2]\!]$. Logo, temos que 
$s \in [\![e_1]\!] \cup [\![e_2]\!]$. Considere os seguintes casos:
    - $s \in [\![e_1]\!]$: Pela hipótese de indução, temos que $s \in |\!| e_1|\!|$. Desse fato, 
    decorre que  $s \in |\!|e_1 + e_2|\!|$.
    - $s \in [\![e_2]\!]$: Similar.
    

Semântica
=========

- Alguns casos da prova para segunda implicação.

- Primeiro, supomos que $s \in |\!|e|\!|$.

Semântica
=========

- Caso $e = a$, para $a \in \Sigma$. Como $s \in |\!|a|\!|$, temos que 
$s = a$. Logo, temos:

$$
\begin{array}{lc}
a \in \{a\}     & \Leftrightarrow \\
\end{array}
$$

Semântica
=========

- Caso $e = a$, para $a \in \Sigma$. Como $s \in |\!|a|\!|$, temos que 
$s = a$. Logo, temos:

$$
\begin{array}{lc}
a \in \{a\}     & \Leftrightarrow \\
a \in [\![a]\!] & \Leftrightarrow \\
\end{array}
$$


Semântica
=========

- Caso $e = a$, para $a \in \Sigma$. Como $s \in |\!|a|\!|$, temos que 
$s = a$. Logo, temos:

$$
\begin{array}{lc}
a \in \{a\}     & \Leftrightarrow \\
a \in [\![a]\!] & \Leftrightarrow \\
s \in [\![a]\!] & \\
\end{array}
$$

Semântica
=========

- Caso $e = e_1\:e_2$. Como $s \in |\!|e_1\:e_2|\!|$, temos que
    - $s = s_1s_2$;
    - $D_1 : s_1 \in |\!|e_1|\!|$ e;
    - $D_2 : s_2 \in |\!|e_2|\!|$.
- Pela HI sobre $D_1$ e $D_2$, temos que $s_1\in[\![e_1]\!]$ e 
$s_2\in[\![e_2]\!]$.

Semântica
=========

- Como $s_1\in[\![e_1]\!]$ e $s_2\in[\![e_2]\!]$, temos que:

$$
\begin{array}{lc}
  s_1s_2\in[\![e_1]\!]\:[\![e_2]\!] & \Leftrightarrow \\
\end{array}
$$

Semântica
=========

- Como $s_1\in[\![e_1]\!]$ e $s_2\in[\![e_2]\!]$, temos que:

$$
\begin{array}{lc}
  s_1s_2\in [\![e_1]\!]\:[\![e_2]\!] & \Leftrightarrow \\
  s_1s_2\in [\![e_1\:e_2]\!]         & \Leftrightarrow \\ 
\end{array}
$$

Semântica
=========

- Como $s_1\in[\![e_1]\!]$ e $s_2\in[\![e_2]\!]$, temos que:

$$
\begin{array}{lc}
  s_1s_2\in [\![e_1]\!]\:[\![e_2]\!] & \Leftrightarrow \\
  s_1s_2\in [\![e_1\:e_2]\!]         & \Leftrightarrow \\ 
  s \in [\![e_1\:e_2]\!]
\end{array}
$$

Semântica
=========

- Apresentamos como definir a semântica de expressões regulares
usando semântica denotacional e operacional _big-step_.

- Como definir a semântica small-step para expressões regulares?

Semântica
=========

- Para representar a semântica small-step de expressões regulares 
vamos nos inspirar na conhecida equivalência com autômatos 
conhecida como construção de Thompson.

Semântica
=========

- A construção de Thompson mostra como construir um AFN-$\lambda$ a 
partir de uma expressão regular qualquer.

Semântica
=========

- AFN para $e = \emptyset$

\begin{tikzpicture}[auto, node distance=24mm, very thick, initial text=, >=latex, 
                    state/.style={circle, draw, minimum size=2cm}]
  \node[state, initial, fill=white]   (q_1) [] {};
\end{tikzpicture}


Semântica
=========

- AFN para $e= \lambda$ 

\begin{tikzpicture}[auto, node distance=5cm, very thick, initial text=, >=latex, 
                    state/.style={circle, draw, minimum size=2cm, 
                    every edge quotes/.append style={font=\Large, align=center, auto}}]
  \node[state, initial, fill=white]   (q_1) [] {};
  \node[state, accepting, fill=white] (q_2) [right of=q_1] {};

  \path[->] (q_1) edge [] node {$\mbox{\huge $\lambda$}$}  (q_2); 
\end{tikzpicture}


Semântica
=========

- AFN para $e= a$, para $a \in \Sigma$ 

\begin{tikzpicture}[auto, node distance=5cm, very thick, initial text=, >=latex, 
                    state/.style={circle, draw, minimum size=2cm, 
                    every edge quotes/.append style={font=\Large, align=center, auto}}]
      \node[state, initial, fill=white]   (q_1) [] {};
      \node[state, accepting, fill=white] (q_2) [right of=q_1] {};

      \path[->] (q_1) edge [] node {$\mbox{\huge $a$}$}  (q_2);
\end{tikzpicture}


Semântica
=========

- AFN para $e = e_1 + e_2$

\begin{tikzpicture}[auto, node distance=5cm, very thick, initial text=, >=latex, 
                    state/.style={circle, draw, minimum size=2cm, 
                    every edge quotes/.append style={font=\Large, align=center, auto}}]
  \node[state, initial]  (s_i)   []                   {};
  \node[state]        (a_1)   [above right of=s_i] {};
  \node[draw=none,fill=none]            (namea) [right of=a_1] {$\mbox{\huge $N(e_1)$}$};
  \node[state]         (a_2)   [right of=namea]     {};

  \node[state]        (b_1)   [below right of=s_i] {};
  \node[draw=none]            (nameb) [right of=b_1]           {$\mbox{\huge $N(e_2)$}$};
  \node[state]         (b_2)   [right of=nameb]     {};

  \node[state, accepting] (s_a)   [below right of=a_2] {};

  \path[->] (s_i) edge [below right] node {$\mbox{\huge $\lambda$}$} (a_1)
                  edge [above right] node {$\mbox{\huge $\lambda$}$} (b_1)
             (a_2) edge [below left]  node {$\mbox{\huge $\lambda$}$} (s_a)
            (b_2) edge []            node {$\mbox{\huge $\lambda$}$} (s_a);
  \begin{scope}[on background layer]
    \node[ellipse, draw=black, very thick, aspect=5
         , minimum width=145mm, minimum height=50mm, right of=b_1] {};
    \node[ellipse, draw=black, very thick, aspect=5
         , minimum width=145mm, minimum height=50mm, right of=a_1] {};
  \end{scope}
\end{tikzpicture}


Semântica
=========

- AFN para $e = e_1\:e_2$

\begin{tikzpicture}[auto, node distance=5cm, very thick, initial text=, >=latex, 
                    state/.style={circle, draw, minimum size=2cm, 
                    every edge quotes/.append style={font=\Large, align=center, auto}}]
  \node[state, initial]   (a_1)   []               {};
  \node[draw=none,fill=none]             (namea) [right of=a_1]   {$\mbox{\huge $N(e_1)$}$};
  \node[state] (a_2)   [right of=namea] {};

  \node[draw=none]             (nameb) [right of=a_2]   {$\mbox{\huge $N(e_2)$}$};
  \node[state, accepting]  (b_2)   [right of=nameb] {};

  \begin{scope}[on background layer]
    \node[ellipse, draw=black, aspect=5, minimum width=130mm, minimum height=50mm, right of=a_1] {};
    \node[ellipse, draw=black, aspect=5, minimum width=130mm, minimum height=50mm, right of=a_2] {};
  \end{scope}
\end{tikzpicture}


Semântica
=========

- AFN para $e = e_1^*$.

\begin{tikzpicture}[auto, node distance=5cm, very thick, initial text=, >=latex, 
                    state/.style={circle, draw, minimum size=2cm, 
                    every edge quotes/.append style={font=\Large, align=center, auto}}]
  \node[state, initial]  (s_i)   []               {};
  \node[state]        (a_1)   [right of=s_i]   {};
  \node[draw=none]            (namea) [right of=a_1]   {$\mbox{\huge $N(e_1)$}$};
  \node[state]         (a_2)   [right of=namea] {};

  \node[state, accepting] (s_a)   [right of=a_2]   {};

  \path[->] (s_i) edge []                     node {$\mbox{\huge $\lambda$}$} (a_1)
                  edge [bend right=40, below] node {$\mbox{\huge $\lambda$}$} (s_a)
            (a_2) edge []                     node {$\mbox{\huge $\lambda$}$} (s_a)
                  edge [bend right=90, above] node {$\mbox{\huge $\lambda$}$} (a_1);
   \begin{scope}[on background layer]
     \node[ellipse, draw=black, aspect=5, very thick
          , minimum width=130mm, minimum height=60mm, right of=a_1] {};
   \end{scope}
\end{tikzpicture}

Semântica
=========

- Ideia geral: Simular as configurações instântaneas do AFN de Thompson ao executar
uma expressão regular sobre uma string.

- Vamos usar contextos de avaliação para definir em qual sub-autômato estamos no 
momento.

Semântica
=========

- Cada regra da semântica representará uma transição do AFN de Thompson.

- Indicaremos que uma configuração inicia um sub-AFN por $B$ e termina por $F$.

Semântica
=========

- Configurações serão formadas por $\conf{S,e,E,s}$, em que
   - $S$: indica se a configuração é inicial ou final.
   - $e$: expressão regular atual.
   - $E$: contexto de avaliação.
   - $s$: string atualmente processada.

Semântica 
=========

- Contextos de avaliação para expressões regulares.

$$
E[\,] \to E[\,]+ e\,\mid\,e + E[\,]\,\mid\,E[\,]\,e\,\mid\,e\,E[\,]\,\mid\,\star
$$

Semântica 
=========

- Regra para $e = \lambda$.

$$
\dfrac{}{\conf{B,\lambda,c,s} \to \conf{F,\lambda,c,s}}
$$

Semântica
=========

- Regra para $e = a$.

$$
\dfrac{}{\conf{B,a,c,a:s} \to \conf{F,a,c,s}}
$$

Semântica
=========

- Regras para $e = e_1 + e_2$.

$$
\begin{array}{c}
  \dfrac{c' = E[\,]+e_2 : c}{\conf{B,e_1+e_2,c,s}\to\conf{B,e_1,c',s}}\\ \\
  \dfrac{c' = e_1 + E[\,] : c }{\conf{B,e_1+e_2,c,s}\to\conf{B,e_2,c',s}}
\end{array}
$$

Semântica 
=========

- Regras para $e = e_1 + e_2$.

$$
\begin{array}{c}
  \dfrac{c = E[\,]+e_2 : c'}{\conf{F,e_1,c,s}\to\conf{F,e_1+e_2,c',s}}\\ \\
  \dfrac{e_1 + E[\,] : c'}{\conf{F,e_2,c,s}\to\conf{F,e_1+e_2,c',s}}
\end{array}
$$

Semântica 
=========

- Regras para $e = e_1\:e_2$.

$$
\begin{array}{c}
  \dfrac{c' = E[\,]e_2 : c}{\conf{B,e_1\,e_2,c,s}\to\conf{B,e_1,c',s}} \\ \\
  \dfrac{c'=e_1E[\,]:c}{\conf{F,e_1,E[\,]e_2:c,s}\to\conf{B,e_2,c',s}}
\end{array}
$$

Semântica
=========

- Regras para $e = e_1\:e_2$.

$$
\dfrac{}{\conf{F,e',eE[\,]:c,s}\to\conf{F,e_1e_2,c,s}}
$$

Semântica
=========

- Regras para $e = e_1^*$.

$$
\begin{array}{c}
  \dfrac{}{\conf{B,e_1^\star,c,s}\to\conf{B,e_1,\star : c, s}} \\ \\
  \dfrac{}{\conf{B,e_1^\star,c,s}\to\conf{F,e_1^\star, c, s}} 
\end{array}
$$

Semântica
=========

- Regras para $e = e_1^*$.

$$
\begin{array}{c}
  \dfrac{}{\conf{F,e_1,\star:c,s}\to\conf{B,e_1,\star:c,s}} \\ \\
  \dfrac{}{\conf{F,e_1,\star:c,s}\to\conf{F,e_1^\star,c,s}}
\end{array}
$$

Semântica
=========

- Dizemos que uma string $s$ é aceita pela semântica small-step
se a execução da semântica termina em uma configuração de aceitação.

Semântica
=========

- Dizemos que uma configuração é de aceitação se ela é da forma
$\conf{F, e, [], \lambda}$, para alguma expressão $e$.

- A configuração inicial é $\conf{B,e,[],\lambda}$.

Semântica
=========

- Teorema: Temos $\conf{B,e,[],s}\to^*\conf{F,e,[],\lambda}$ se
e somente se $s\in [\![e]\!]$.
    - Prova por indução sobre $(e,s)$.
    
Exercícios
==========

- Complete as demonstrações da equivalência entre a semântica denotacional
e big-step para expressões regulares.

- Explique porque as demonstrações devem ser feitas usando indução bem formada 
e não indução sobre a estrutura de uma expressão regular.

Referências
===========

Delfino, Thales; Ribeiro, Rodrigo. Towards certified virtual machine-based 
regular expression parsing. In XXII Brazilian Symposium on Programming Languages,
SBLP 2018, Fortaleza, 2018.

