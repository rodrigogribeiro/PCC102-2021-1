---
author: PCC102 - Teoria da Computação - Prof. Rodrigo Ribeiro
title: Regular Expression Parsing
---


Objetivos
=========

- Definir o problema de parsing para 
expressões regulares.

- Apresentar a interpretação baseada
em tipos para o parsing.

Objetivos
=========

- Apresentar o problema de ambiguidade
e as estratégias greedy e POSIX de 
desambiguação.

Objetivos
=========

- Discutir como derivadas podem ser 
utilizadas para solucionar o problema 
de parsing.


Anteriormente
=============

- Estudamos RE: sintaxe e semântica

- Derivadas: algoritmo eficiente e de simples 
implementação para problema de _casamento_ para
RE. 

Anteriormente
=============

- Problema de casamento: Dados uma RE $e$ e uma string 
$s$, determinar se $s \in[\![e]\!]$.

- Apesar de relevante, o casamento não é útil para a 
solução de muitos problemas envolvendo RE.

Problema
========

- Vamos entender as limitações do casamento no contexto
de um problema prático.

Problema
========

- Considere a tarefa de formatar texto que possui strings
denotando valores monetários.

Problema
========

- O texto utiliza dois formatos distintos: 
    - Algumas strings utilizam "." como agrupador outras usam ","

Problema
========

- Como converter todas essas strings para um único formato?

Problema
========

- Como representar esses formatos como uma RE?
    - Representando dígitos.
    
$$
\begin{array}{lcl}
  D   & = & 0 + 1 + 2 + 3 + 4 + 5 + 6 + 7 + 8 + 9 \\
\end{array}
$$

Problema
========

- Primeiro formato:
   - Agrupando dígitos usando "."
   
$$
\begin{array}{lcl}
  F_1 & = & (\underbrace{(D\:D^*)}_{1}\,.)^*(\underbrace{(D\:D^*)}_{2}\,.)\,,(\underbrace{(D\:D^*)}_{3})^*\\
\end{array}
$$

Problema
========

- Segundo formato:
   - Agrupando dígitos usando ","

$$
\begin{array}{lcl}
  F_2 & = & (\underbrace{(D\:D^*)}_{1}\,,)^*(\underbrace{(D\:D^*)}_{2}\,,)\,.(\underbrace{(D\:D^*)}_{3})^*\\
\end{array}
$$

Problema 
========

- Usando _casamento_ de REs, não é simples identificar os agrupamentos de dígitos e separadores.

Problema
========

- O problema ocorre quando temos um padrão de interesse em um operador Kleene star.
    - Nessa situação, ocorre o problema de _ambiguidade_.


Problema
========

- Considere a string 1.234.567,89
    - Temos que o padrão "1" gera dois casamentos na string.
    - Como identificar esses sub casamentos?

$$
\underbrace{1}_{1}.\underbrace{234}_{1}.\underbrace{567}_{2},\underbrace{89}_{3}
$$

Problema
========

- Para solucionar o problema apresentado é conveniente nos valermos de uma 
generalização.

Problema
========

- Ao invés de retornarmos apenas as posições do texto que foram reconhecidas,
o melhor é produzir uma **estrutura de dados** que representa como o 
casamento ocorreu.

Parsing
=======

- Denominamos por _parsing_ o problema de construir uma árvore de parsing
que denota o casamento de uma string por uma expressão regular.

Parsing
=======

- Para isso, é conveniente intepretarmos expressões regulares como tipos.

- Árvores de parsing são termos que possuem o tipo de sua expressão subjacente.

Parsing
=======

- O conjunto de árvores $\mathcal{T}(e)$ é definido como:

$$
\begin{array}{lcl}
\mathcal{T}(\emptyset) & = & \emptyset \\
\mathcal{T}(\lambda)   & = & \{()\} \\
\mathcal{T}(a)         & = & \{a\} \\
\mathcal{T}(e_1\:e_2)  & = & \mathcal{T}(e_1)\times\mathcal{T}(e_2)\\
\end{array}
$$

Parsing
=======

- O conjunto de árvores $\mathcal{T}(e)$ é definido como:

$$
\begin{array}{lcl}
\mathcal{T}(e_1 + e_2)  & = & \{\textrm{inl }t\,|\,t \in\mathcal{T}(e_1)\} \cup \\
                        &   & \{\textrm{inr }t\,|\,t \in\mathcal{T}(e_2)\} \\
\mathcal{T}(e_1^*)      & = & \{[t_0,...,t_n]\,|\,t_i \in \mathcal{T}(e_1)\}\\
\end{array}
$$

Parsing
=======

- Exemplo: 

$$
\begin{array}{lc}
\mathcal{T}((a + b)^*) & = \\
\end{array}
$$


Parsing
=======

- Exemplo: 

$$
\begin{array}{lc}
\mathcal{T}((a + b)^*) & = \\
\{[t_0,...,t_n]\,|\,t_i \in \mathcal{T}(a + b)\} & = \\
\end{array}
$$

Parsing
=======

- Exemplo: 

$$
\begin{array}{lc}
\mathcal{T}((a + b)^*) & = \\
\{[t_0,...,t_n]\,|\,t_i \in \mathcal{T}(a + b)\} & = \\
\{[t_0,...,t_n]\,|\,t_i \in \{\textrm{inl }v\,|\,v \in \mathcal{T}(a)\}\:\cup \\
\:\:\:\:\:\:\:\:\:\:\:\:\:\:\:\:\:\:\:\:\:\:\:\:\:\:\:\:\:\:\:\:\:\{\textrm{inr }w\,|\,w \in \mathcal{T}(b)\}\} & = 
\end{array}
$$

Parsing
=======

- Exemplo: 

$$
\begin{array}{lc}
\{[t_0,...,t_n]\,|\,t_i \in \{\textrm{inl }v\,|\,v \in \mathcal{T}(a)\}\:\cup \\
\:\:\:\:\:\:\:\:\:\:\:\:\:\:\:\:\:\:\:\:\:\:\:\:\:\:\:\:\:\:\:\:\:\{\textrm{inr }w\,|\,w \in \mathcal{T}(b)\}\} & = \\
\{[t_0,...,t_n]\,|\,t_i \in \{\textrm{inl }v\,|\,v \in \{a\}\}\:\cup \\
\:\:\:\:\:\:\:\:\:\:\:\:\:\:\:\:\:\:\:\:\:\:\:\:\:\:\:\:\:\:\:\:\:\{\textrm{inr }w\,|\,w \in \{b\}\}\} & = 
\end{array}
$$


Parsing
=======

- Exemplo: 

$$
\begin{array}{lc}
\{[t_0,...,t_n]\,|\,t_i \in \{\textrm{inl }v\,|\,v \in \{a\}\}\:\cup \\
\:\:\:\:\:\:\:\:\:\:\:\:\:\:\:\:\:\:\:\:\:\:\:\:\:\:\:\:\:\:\:\:\:\{\textrm{inr }w\,|\,w \in \{b\}\}\} & = \\
\{[t_0,...,t_n]\,|\,t_i \in \{\textrm{inl a},\,\textrm{inr b}\}\} &  \\
\end{array}
$$

Parsing
=======

- Árvore de parsing para $((ab)+c)^*$ e string $abcab$

\begin{tikzpicture}[tlabel/.style={font=\Large}, every node/.style={scale=2.0}]
    \node{$[\,]$}
    child{
        node{inl}
        child{
            node {$\langle,\rangle$}
            child{node{a}}
            child{node{b}}
        }
    }
    child{
        node{inr}
        child{node {c}}
    }
    child{
        node{inl}
        child{
            node {$\langle,\rangle$}
            child{node{a}}
            child{node{b}}
        }
    };
\end{tikzpicture}



Parsing
=======

- Como relacionar árvores de parsing a strings e expressões regulares?

- Para isso, vamos utilizar algumas definições auxiliares.

Parsing
=======

- Flattening converte uma árvore de parsing na string por ela representada.

$$
\begin{array}{lcl}
  |()|                      & = & \lambda \\
  |a|                       & = & a \\
  |\langle t_1, t_2\rangle| & = & |t_1|\,|t_2|\\
  |\textrm{inl }t|          & = & |t|\\
  |\textrm{inr }t|          & = & |t|\\
  |t :: ts|                 & = & |t|\,|ts|\\
\end{array}
$$

Parsing
=======

- Parsing: Dados uma RE $e$ e uma string $s$, o problema de _parsing_ é 
o de encontrar uma árvore $t \in \mathcal{T}(e)$ tal que $|t| = s$.

Parsing
=======

- Representamos $t \in \mathcal{T}(e)$ usando um sistema de regras para 
atribuir tipos (RE) a árvores.

$$
\begin{array}{ccc}
    \dfrac{}{\vdash () : \lambda} & \dfrac{}{\vdash a : a} & \dfrac{\vdash t_1 : e_1}{\vdash \textrm{inl }t_1 : e_1 + e_2}\\
\end{array}
$$

Parsing
=======

- Representamos $t \in \mathcal{T}(e)$ usando um sistema de regras para 
atribuir tipos (RE) a árvores.

$$
\begin{array}{cc}
   \dfrac{\vdash t_1 : e_1\:\:\:\:\vdash t_2 : e_2}{\vdash \langle t_1 , t_2 \rangle : e_1\,e_2} & \dfrac{\vdash t_2 : e_2}{\vdash \textrm{inr }t_2 : e_1 + e_2}\\
\end{array}
$$


Parsing
=======

- Representamos $t \in \mathcal{T}(e)$ usando um sistema de regras para 
atribuir tipos (RE) a árvores.

$$
\begin{array}{cc}
   \dfrac{}{\vdash [] : e_1^*} & \dfrac{\vdash t_1 : e_1\:\:\:\:\vdash t_2 : e_1^*}{\vdash t_1 :: t_2 : e_1^*}\\
\end{array}
$$

Ambiguidade
===========

- Dizemos que uma RE é ambígua se: 

$$
\exists t_1,\,t_2\in\mathcal{T}(e). t_1 \neq t_2 \land |t_1| = |t_2| 
$$

Ambiguidade
===========

- Um algoritmo de parsing deve calcular uma única árvore de parsing para 
uma dada RE $e$ e string $s$.

- Para garantir o determinismo, algoritmos recorrem a uma política para 
remoção de ambiguidade.

Ambiguidade
============

- Políticas para remoção de ambiguidade são definidas em termos de uma 
relação de ordem sobre árvores de parsing.

- Uma política garante que o maior / menor elemento da ordem é o escolhido.

Ambiguidade
===========

- Política greedy: 
   - Em $e_1 + e_2$: tentar o parsing usando $e_1$.
   - Em $e_1^*$: considerar a igualdade $e_1^* = e_1e_1^* + \lambda$.
   
Ambiguidade
===========

- Política greedy, formalmente: menor elemento de acordo com a ordem:

$$
\begin{array}{lcl}
() < () & = & \bot\\
a < a  & = & \bot\\
\langle t_1, t_2 \rangle < \langle t'_1 , t'_2\rangle & = & (t_1 < t'_1) \lor (t_1 = t'_1 \land t_2 < t_2')\\
\end{array}
$$

Ambiguidade
===========

$$
\begin{array}{lcl}
\textrm{inl }t_1 < \textrm{inl }t'_1 & = & t_1 < t'_1\\
\textrm{inl }t_1 < \textrm{inr }t_2  & = & \top \\
\textrm{inr }t_2 < \textrm{inl }t_1  & = & \bot\\
\textrm{inr }t_2 < \textrm{inr }t'_2 & = & t_2 < t'_2\\
\end{array}
$$

Ambiguidade
===========

$$
\begin{array}{lcl}
[] < t & = & t \neq [] \\
t :: ts < t' :: ts' & = & (t < t') \land (ts < ts') \\
t :: ts < [] & = & \bot \\
\end{array}
$$

Ambiguidade
===========

- **Expressões problemáticas.**  Dizemos que uma expressão $e$ é problemática se 
existe $e_1$ tal que $e = e_1^*$ e $\lambda \in [\![e_1]\!]$.

Ambiguidade
===========

- Algoritmos seguindo a política greedy podem não terminar na presença de 
expressões problemáticas.
    - Algoritmos greedy tentam construir a maior árvore de parsing.

Ambiguidade
===========

- Outra possível estratégia é o POSIX, que intuitivamente resolve a 
ambiguidade ao considerar que uma RE deve processar o maior prefixo de uma 
string.

Ambiguidade
===========

- Ordenação POSIX

$$
\begin{array}{cc}
    \dfrac{t_1 = t'_1\:\:\:\:t_2 < t'_2}
          {\langle t_1, t_2\rangle < \langle t'_1, t'_2\rangle} &
     \dfrac{t_1 < t'_1}
          {\langle t_1, t_2\rangle < \langle t'_1, t'_2\rangle} \\ 
\end{array}
$$

Ambiguidade
===========

- Ordenação POSIX

$$
\begin{array}{cc}
    \dfrac{\textrm{length }|t_2| > \textrm{length }|t_1|}
          {\textrm{inr }t_2 < \textrm{inl }t_1} &
     \dfrac{\textrm{length }|t_1| \geq \textrm{length }|t_2|}
           {\textrm{inl }t_1 < \textrm{inr }t_2} \\ 
\end{array}
$$

Ambiguidade
===========

- Ordenação POSIX

$$
\begin{array}{cc}
    \dfrac{t_1 < t'_1}
          {\textrm{inl }t_1 < \textrm{inl }t'_1} &
     \dfrac{t_2 < t'_2}
           {\textrm{inr }t_2 < \textrm{inr }t'_2} \\ 
\end{array}
$$

Ambiguidade
===========

- Ordenação POSIX

$$
\begin{array}{cc}
   \dfrac{|t :: ts| = \lambda}{[] < t :: ts} & 
   \dfrac{|t :: ts| \neq \lambda}{t :: ts < []}\\
\end{array}
$$

Ambiguidade
===========

- Ordenação POSIX

$$
\begin{array}{cc}
    \dfrac{t_1 < t_2}{t_1 :: ts_1 < t_2 :: ts_2} & 
    \dfrac{t_1 = t_2\:\:\:\:ts_1 < ts_2}{t_1 :: ts_1 < t_2 :: ts_2}
\end{array}
$$

Parsing
=======

- Ao contrário da política greedy, POSIX não é influenciada por 
expressões problemáticas.

- Além disso, a política POSIX pode ser implementada facilmente
em termos de derivadas.

Parsing
=======

- A ideia do algoritmo de parsing consiste em uma adaptação 
do algoritmo de matching baseado em derivadas.

Parsing
=======

- Ao término do matching, o algoritmo constrói uma árvore de parsing
para representar para $\lambda$.

- No retorno de chamadas recursivas, uma função realiza o "injection"
de um símbolo da string modificando a árvore de parsing.

Parsing
=======

- Construindo uma árvore de parsing para $\lambda$.

$$
\begin{array}{lcl}
\textrm{mkEps}(e^*) & = & [] \\
\textrm{mkEps}(e_1\,e_2) & = & \langle \textrm{mkEps}(e_1),\textrm{mkEps}(e_2)\rangle \\
\textrm{mkEps}(e_1+e_2) & = & \textrm{inl (mkEps(}e_1\textrm{)), se } \lambda\in[\![e_1]\!]\\
\textrm{mkEps}(e_1+e_2) & = & \textrm{inr (mkEps(}e_2\textrm{)), se } \lambda\in[\![e_2]\!]\\
\textrm{mkEps}(\lambda) & = & ()
\end{array}
$$

Parsing
=======

- Injection de um símbolo em uma árvore.
    - Lembre-se: $\partial(e^*,a) = \partial(e,a)e^*$

$$
\begin{array}{lcl}
\textrm{inj}(\partial(e^*, a), \langle t, ts \rangle) & = & \textrm{inj}(\partial(e,a), t) :: ts\\
\end{array}
$$

Parsing
=======

- Injection de um símbolo em uma árvore.

$$
\begin{array}{l}
\textrm{inj}(\partial(e_1\,e_2,a), \langle t_1,t_2\rangle) = \langle \textrm{inj}(\partial(e_1,a), t_1), t_2\rangle\\
\textrm{inj}(\partial(e_1\,e_2,a),\textrm{inl}(\langle t_1, t_2\rangle)) = \langle \textrm{inj}(\partial(e_1,a), t_1), t_2\rangle\\
\textrm{inj}(\partial(e_1\,e_2,a),\textrm{inr }t_2) = \langle \textrm{mkEps}(e_1), \textrm{inj}(\partial(e_2,a),t_2)\rangle\\
\end{array}
$$

Parsing
=======

- Injection de um símbolo em uma árvore

$$
\begin{array}{lcl}
\textrm{inj}(\partial(e_1 + e_2,a), \textrm{inl }t_1) & = & \textrm{inl}(\textrm{inj}(\partial(e_1,a), t_1))\\
\textrm{inj}(\partial(e_1 + e_2,a), \textrm{inr }t_2) & = & \textrm{inr}(\textrm{inj}(\partial(e_2,a), t_2))\\
\textrm{inj}(\partial(a,a),()) & = & a \\
\end{array}
$$

Parsing
=======

- Função de parsing

$$
\begin{array}{lcl}
parse(e,\lambda) & = & \textrm{mkEps}(e)\textrm{; se } \lambda\in [\![e]\!] \\
parse(e,ay)      & = & \textrm{inj}(\partial(e,a),parse(\partial(e,a), y))\\
\end{array}
$$

Exercício
=========

- Implemente o algoritmo de parsing de expressões regulares em sua linguagem de programação preferida.


Referências
===========

- Frisch, Alain; Cardelli, Luca. Greedy Regular Expression Parsing.

- Nielsen, Lasse; Heinglein, Fritz. Bit-coded Regular Expression Parsing.

Referências
===========

- Sulzmann, Martin; Lu, Kenny. POSIX regular expression parsing with derivatives.

