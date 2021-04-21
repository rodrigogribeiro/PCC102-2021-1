---
author: PCC102 - Teoria da Computação - Prof. Rodrigo Ribeiro
title: Expressões livres de contexto
---

Objetivos
=========

- Apresentar a sintaxe e semântica de expressões livres de 
contexto ($\mu$-regular expressions).

Objetivos
=========

- Estender as derivadas parciais para expressões livres de 
contexto.

Objetivos
=========

- Apresentar como usar derivadas parciais para obter um 
autômato de pilha não determinístico equivalente a uma 
expressão livre de contexto.


Expressões LC
=============

- Expressões livres de contexto estendem a sintaxe de 
expressões regulares com um operador de recursão.
    
Sintaxe
=======

- A sintaxe de expressões LC sobre um alfabeto $\Sigma$ e
um conjunto de variáveis $V$ é definida como:

$$
\begin{array}{l}
0 \in E(\Sigma,V)\\
1 \in E(\Sigma,V)\\
a \in E(\Sigma,V);\text{ se } a\in\Sigma\\
\end{array}
$$

Sintaxe
=======

- Considere $e_1, e_2 \in E(\Sigma,V)$.

$$
\begin{array}{l}
e_1\:e_2 \in E(\Sigma,V)\\
e_1 + e_2 \in E(\Sigma,V)\\
e_1^* \in E(\Sigma,V)\\
\end{array}
$$

Sintaxe
=======

- Considere $e_1 \in E(\Sigma,V \cup \{v\})$.

$$
\begin{array}{l}
v \in E(\Sigma,V); \text{ se }v \in V\\
\mu v. e_1 \in E(\Sigma,V)\\
\end{array}
$$

Sintaxe
=======

- Dizemos que uma expressão $e_1$ é fechada se 

$$
e_1 \in E(\Sigma, \emptyset)
$$

Semântica
=========

- Para definirmos a semântica denotacional
de ELC devemos utilizar um ambiente que associa
variáveis a linguagens.

- $\eta : V \to \mathcal{P}(\Sigma^*)$

Semântica
=========

- Casos base.

$$
\begin{array}{lcl}
  [\![\emptyset]\!]_\eta & = & \emptyset \\
  [\![\lambda]\!]_\eta & = & \{\lambda\} \\
  [\![a]\!]_\eta & = & \{a\},\:a\in\Sigma \\
  [\![v]\!]_\eta & = & \eta(v),\:v\in V \\
\end{array}
$$

Semântica
=========

- União, concatenação e Kleene

$$
\begin{array}{lcl}
[\![e_1\:e_2]\!]_\eta & = & [\![e_1]\!]_\eta\:[\![e_2]\!]_\eta \\
[\![e_1 + e_2]\!]_\eta & = & [\![e_1]\!]_\eta\cup[\![e_2]\!]_\eta \\
[\![e_1^*]\!]_\eta & = & ([\![e_1]\!]_\eta)^*\\
\end{array}
$$

Semântica
=========

- Para definir a semântica do operador $\mu$, precisamos recorrer 
ao teorema de Knaster-Tarski.

Semântica
=========

- Porém, para enunciar o teorema, precisamos de algumas definições.

Semântica
=========

- Conjunto parcialmente ordenado $(S,\le)$.
   - $\le$ relação de ordem sobre $S$

Semântica
=========

- $a$ é um limite inferior para $S$:

$$
\forall x. x \in S \to a \le x
$$

Semântica
=========

- $b$ é o maior limite inferior de $S$:

$$
\forall y. (\forall x. x \in S \to (y \le x))\to y \le b
$$


Semântica
=========

- $a$ é um limite superior para $S$:

$$
\forall x. x \in S \to x \le a
$$

Semântica
=========

- $b$ é o menor limite superior de $S$:

$$
\forall y. (\forall x. x \in S \to (x \le y))\to b \le y
$$

Semântica
=========

- Dizemos que o conjunto parcialmente ordenado $(S,\le)$ é um 
reticulado completo se todo $X \subseteq S$ possui 
maior limite inferior e menor limite superior.

- Consequência: reticulados completos são não vazios.

Semântica
=========

- Função monotônica.

$\forall x\:y. x < y \to f(x) < f(y)$.

Semântica
=========

- Ponto fixo: $x$ é ponto fixo de $f$, se:

$$
f(x) = x
$$


Semântica
=========

- Teorema: Seja $L$ um reticulado completo e $f : L \to L$ uma função 
monotônica. Então, o conjunto de pontos fixos de $f$ forma um reticulado
completo.

Semântica
=========

- O teorema de Knarster-Tarski garante a existência de um ponto fixo
para funções monotônicas sobre reticulados completos.


Semântica
=========

- O conjunto parcialmente ordenado $(\mathcal{P}(\Sigma^*), \subseteq)$
forma um reticulado completo.

- Logo, funções monotônicas sobre esse conjunto admitem ponto fixo.

Semântica
=========

- A notação $\eta[v \mapsto L]$ denota a função finita 
$\eta'$ tal que

$$
\begin{array}{lcl}
\eta'(v_1) & = & \left\{
              \begin{array}{lcl}
                L & \text{se }v = v_1\\
                \eta(v_1) & \text{caso contrário}\\
              \end{array}
            \right .
\end{array}
$$

Semântica
=========

- Seja $e \in E(\Sigma,V \cup \{v\})$. A função $L \mapsto [\![e]\!]_{\eta[v \mapsto L]}$ é 
monotônica.

- Isto é, se $L \subseteq L'$ então 
$[\![e]\!]_{\eta[v \mapsto L]} \subseteq [\![e]\!]_{\eta[v \mapsto L']}$.

Semântica
=========

- Denote por lfp o operador de menor ponto fixo no reticulado $\mathcal{P}(\Sigma^*)$.

$$
\begin{array}{lcl}
[\![\mu v.e]\!] & = & \text{lfp}\,[\![e]\!]_{\eta[v\mapsto L]}\\
\end{array}
$$

Derivadas
==========

- Usando a definição da semântica, podemos especificar a 
derivada parcial para uma expressão livre de contexto.

Derivadas
=========

- Primeiramente, vamos estender a definição do teste $\lambda\in[\![e]\!]_\eta$.

- Para isso, vamos usar um ambiente, $\nu : V \to \{\top,\bot\}$, que vai armazenar
se a expressão associada a uma variável é ou não anulável.

Derivadas
=========

- Verificando se uma expressão é anulável.

$$
\begin{array}{lcl}
  \mathcal{N}(\emptyset)_\nu & = & \bot \\
  \mathcal{N}(\lambda)_\nu   & = & \top \\
  \mathcal{N}(a)_\nu         & = & \bot \\
  \mathcal{N}(v)_\nu         & = & \nu(v) \\
\end{array}
$$

Derivadas
=========

- Verificando se uma expressão é anulável.

$$
\begin{array}{lcl}
  \mathcal{N}(e_1\:e_2)_\nu & = & \mathcal{N}(e_1)_\nu \land \mathcal{N}(e_2)_\nu \\
  \mathcal{N}(e_1 + e_2)_\nu & = & \mathcal{N}(e_1)_\nu \lor \mathcal{N}(e_2)_\nu \\
  \mathcal{N}(e_1^*)_\nu   & = & \top \\
  \mathcal{N}(\mu\,v.e)_\nu & = & \mathcal{N}(e)_{\nu[v\mapsto \bot]}\\
\end{array}
$$

Exemplo
=======

- Considere a expressão $e = 1 + \mu v. v a$.

$$
\begin{array}{lc}
\mathcal{N}(1 + \mu v. v a)_\emptyset & = \\
\end{array}
$$

Exemplo
=======

- Considere a expressão $e = 1 + \mu v. v a$.

$$
\begin{array}{lc}
\mathcal{N}(1 + \mu v. v a)_\emptyset & = \\
\mathcal{N}_\emptyset(1) \lor \mathcal{N}_\emptyset(\mu v. v a) & = \\
\end{array}
$$

Exemplo
=======

- Considere a expressão $e = 1 + \mu v. v a$.

$$
\begin{array}{lc}
\mathcal{N}(1 + \mu v. v a)_\emptyset & = \\
\mathcal{N}_\emptyset(1) \lor \mathcal{N}_\emptyset(\mu v. v a) & = \\
\top \lor \mathcal{N}_{\emptyset[v \mapsto \bot]}(v a) & = \\
\end{array}
$$

Exemplo
=======

- Considere a expressão $e = 1 + \mu v. v a$.

$$
\begin{array}{lc}
\mathcal{N}(1 + \mu v. v a)_\emptyset & = \\
\mathcal{N}_\emptyset(1) \lor \mathcal{N}_\emptyset(\mu v. v a) & = \\
\top \lor \mathcal{N}_{\emptyset[v \mapsto \bot]}(v a) & = \\
\top \lor \mathcal{N}_{[v\mapsto\bot]}(v a) & = \\
\end{array}
$$

Exemplo
=======

- Considere a expressão $e = 1 + \mu v. v a$.

$$
\begin{array}{lc}
\mathcal{N}(1 + \mu v. v a)_\emptyset & = \\
\mathcal{N}_\emptyset(1) \lor \mathcal{N}(\mu v. v a)_\emptyset & = \\
\top \lor \mathcal{N}(v a)_{\emptyset[v \mapsto \bot]} & = \\
\top \lor \mathcal{N}(v a)_{[v\mapsto\bot]} & = \\
\top \lor (\mathcal{N}_{[v\mapsto\bot]}(v)\land \mathcal{N}_{[v\mapsto\bot]}(a)) & = \\
\end{array}
$$

Exemplo
=======

- Considere a expressão $e = 1 + \mu v. v a$.

$$
\begin{array}{lc}
\mathcal{N}(1 + \mu v. v a)_\emptyset & = \\
\mathcal{N}_\emptyset(1) \lor \mathcal{N}(\mu v. v a)_\emptyset & = \\
\top \lor \mathcal{N}(v a)_{\emptyset[v \mapsto \bot]} & = \\
\top \lor \mathcal{N}(v a)_{[v\mapsto\bot]} & = \\
\top \lor (\mathcal{N}_{[v\mapsto\bot]}(v)\land \mathcal{N}_{[v\mapsto\bot]}(a)) & = \\
\top \lor (\bot \land \bot) & = \\
\top
\end{array}
$$


Derivadas
=========

- A derivada de uma expressão livre de contexto produz uma lista
não vazia de expressões regulares.

Derivadas
=========

- A ideia é que essa lista simule a execução de uma pilha de um
autômato de pilha não determinístico.

- Porém, como lidar com expressões envolvendo $\mu$?

Derivadas
=========

- Uma abordagem seria usar a equivalência:

$$
\nabla_a(\mu v.e) = \nabla_a([v \mapsto \mu v. e] e) : [1]
$$

Derivadas
=========

- Porém, considere a seguinte expressão que gera palavras da forma $a^*$:

$$\mu v. 1 + v a$$

Derivadas
=========

- Qual seria o resultado de $\nabla_a(\mu v. 1 + v a)$ ?

$$
\begin{array}{lc}
\nabla_a(\mu v. 1 + v a) & = \\
\end{array}
$$

Derivadas
=========

- Qual seria o resultado de $\nabla_a(\mu v.1 + v a)$ ?

$$
\begin{array}{lc}
\nabla_a(\mu v. 1 + v a) & = \\
\nabla_a(1) \cup \nabla_a(\mu v. v a) & = \\
\end{array}
$$

Derivadas
=========

- Qual seria o resultado de $\nabla_a(\mu v.1 + v a)$ ?

$$
\begin{array}{lc}
\nabla_a(\mu v. 1 + v a) & = \\
\nabla_a(1) \cup \nabla_a(\mu v. v a) & = \\
\emptyset \cup \nabla_a(\mu v. v a) & =\\
\end{array}
$$

Derivadas
=========

- Qual seria o resultado de $\nabla_a(\mu v.1 + v a)$ ?

$$
\begin{array}{lc}
\nabla_a(\mu v. 1 + v a) & = \\
\nabla_a(1) \cup \nabla_a(\mu v. v a) & = \\
\emptyset \cup \nabla_a(\mu v. v a) & =\\
\nabla_a(\mu v. v a) & =\\
\end{array}
$$

Derivadas
=========

- Qual seria o resultado de $\nabla_a(\mu v.1 + v a)$ ?

$$
\begin{array}{lc}
\nabla_a(\mu v. 1 + v a) & = \\
\nabla_a(1) \cup \nabla_a(\mu v. v a) & = \\
\emptyset \cup \nabla_a(\mu v. v a) & =\\
\nabla_a(\mu v. v a) & =\\
\nabla_a([v \mapsto \mu v. v a] (v a)) & = \\
\nabla_a((\mu v. v a)a) & = \\
\end{array}
$$

Derivadas
=========

- Veja que uma definição ingênua da derivada não consegue lidar
com expressões equivalentes à gramáticas com recursão à esquerda.

Derivadas
=========

- Para evitar esse problema, a derivada guarda uma substituição 
para todas as variáveis não precedidas por não terminais.

Derivadas
=========

- Além da substituição, a operação de derivada usa um ambiente
para variáveis anuláveis.


Derivadas
=========

- Denotaremos uma substituição qualquer por $\sigma$ e aplicação 
por $\sigma(e)$.

Derivadas
=========

- Denotamos por $\nabla_\alpha^{\sigma,\,\nu}(e)$ a derivada para
uma expressão $e$ e $a \in \Sigma \cup\{\lambda\}$.

Derivadas
=========

- Definição da derivada

$$
\begin{array}{lcl}
  \nabla_\alpha^{\sigma,\,\nu}(\emptyset) & = & \emptyset\\
  \nabla_\alpha^{\sigma,\,\nu}(\lambda) & = & \emptyset\\
  \nabla_\alpha^{\sigma,\,\nu}(a) & = & \{[1]\,|\,\alpha = a\}\\
  \nabla_\alpha^{\sigma,\,\nu}(e_1 + e_2) & = & \nabla_\alpha^{\sigma,\,\nu}(e_1) \cup 
                                                \nabla_\alpha^{\sigma,\,\nu}(e_2)\\
\end{array}
$$

Derivadas
=========

- Definição de derivada

$$
\begin{array}{lcl}
  \nabla_\alpha^{\sigma,\,\nu}(e_1\:e_2) & = & \nabla_\alpha^{\sigma,\,\nu}(e_1)(\sigma(e_2)) \cup\\ 
                                         &   & \{\overline{e}\,|\,\mathcal{N}_{\nu}(e_1) \land 
                                               \overline{e}\in\nabla_\alpha^{\sigma,\,\nu}(\:e_2)\}\\
  \nabla_\alpha^{\sigma,\,\nu}(e_1^*)    & = & \nabla_\alpha^{\sigma,\,\nu}(e_1)(\sigma(e_1^*))\\
\end{array}
$$

Derivadas
=========

- Definição de derivada

$$
\begin{array}{lcl}
  \nabla_\alpha^{\sigma,\,\nu}(\mu\,v.e) & = & \nabla_\alpha^{\sigma[v\mapsto \mu v.e],\,
                                               [v \mapsto \mathcal{N}_{\nu[v\mapsto \bot]}(e)]}(e) 
                                               : [1]\\
  \nabla_\alpha^{\sigma,\,\nu}(v) & = & \{[\sigma(v)]\,|\,\alpha = \lambda\}\\
\end{array}
$$

Exemplo
=======

- Calcular: $\nabla_a^{\emptyset,\emptyset}(\mu v.1 + v a)$

$$
\begin{array}{lc}
  \nabla_a^{\emptyset,\emptyset}(\mu v.1 + v a) & = \\
\end{array}
$$

Exemplo
=======

- Calcular: $\nabla_a^{\emptyset,\emptyset}(\mu v.1 + v a)$
   - $\sigma = [v\mapsto \mu v. 1 + v a]$
   - $\nu = [v\mapsto \top]$

$$
\begin{array}{lc}
  \nabla_a^{\emptyset,\emptyset}(\mu v.1 + v a) & = \\
  \nabla_a^{\sigma, \nu}(1 + v a) & = \\
\end{array}
$$

Exemplo
=======

- Calcular: $\nabla_a^{\emptyset,\emptyset}(\mu v.1 + v a)$
   - $\sigma = [v\mapsto \mu v. 1 + v a]$
   - $\nu = [v\mapsto \top]$


$$
\begin{array}{lc}
  \nabla_a^{\emptyset,\emptyset}(\mu v.1 + v a) & = \\
  \nabla_a^{\sigma, \nu}(1 + v a) & = \\
  \nabla_a^{\sigma, \nu}(1) \cup \nabla_a^{\sigma, \nu}(v a) & =
\end{array}
$$

Exemplo
=======

- Calcular: $\nabla_a^{\emptyset,\emptyset}(\mu v.1 + v a)$
   - $\sigma = [v\mapsto \mu v. 1 + v a]$
   - $\nu = [v\mapsto \top]$


$$
\begin{array}{lc}
  \nabla_a^{\emptyset,\emptyset}(\mu v.1 + v a) & = \\
  \nabla_a^{\sigma, \nu}(1 + v a) & = \\
  \nabla_a^{\sigma, \nu}(1) \cup \nabla_a^{\sigma, \nu}(v a) & =\\
  \emptyset  \cup \nabla_a^{\sigma, \nu}(v a) & =
\end{array}
$$

Exemplo
=======

- Calcular: $\nabla_a^{\emptyset,\emptyset}(\mu v.1 + v a)$

$$
\begin{array}{lc}
  \nabla_a^{\emptyset,\emptyset}(\mu v.1 + v a) & = \\
  \nabla_a^{\sigma, \nu}(1 + v a) : [1] & = \\
  \nabla_a^{\sigma, \nu}(1) \cup \nabla_a^{\sigma, \nu}(v a) : [1] & =\\
  \emptyset  \cup \nabla_a^{\sigma, \nu}(v a) : [1] & =\\
  \nabla_a^{\sigma, \nu}(v a) :[1]& = \\
\end{array}
$$

Exemplo
=======

- Calcular: $\nabla_a^{\emptyset,\emptyset}(\mu v.1 + v a)$

$$
\begin{array}{l}
  ... = \\
  \nabla_a^{\sigma, \nu}(v)(\sigma(a)) : [1] \cup \\ 
  \{e \,|\, \nu(v) = \top, e \in \nabla_a^{\sigma,\nu}(a)\} = \\
\end{array}
$$

Exemplo
=======

- Calcular: $\nabla_a^{\emptyset,\emptyset}(\mu v.1 + v a)$

$$
\begin{array}{l}
  ... = \\
  \nabla_a^{\sigma, \nu}(v)(\sigma(a)) : [1] \cup \\ 
  \{e \,|\, \nu(v) = \top, e \in \nabla_a^{\sigma,\nu}(a)\} = \\
  \emptyset \cup \{e \,|\, \nu(v) = \top, e \in \nabla_a^{\sigma,\nu}(a)\} : [1] = \\
  \{[1]\} : [1] = \\
\end{array}
$$


Exemplo
=======

- Calcular: $\nabla_a^{\emptyset,\emptyset}(\mu v.1 + v a)$

$$
\begin{array}{l}
  ... = \\
  \nabla_a^{\sigma, \nu}(v)(\sigma(a)) : [1] \cup \\ 
  \{e \,|\, \nu(v) = \top, e \in \nabla_a^{\sigma,\nu}(a)\} = \\
  \emptyset \cup \{e \,|\, \nu(v) = \top, e \in \nabla_a^{\sigma,\nu}(a)\} : [1] = \\
  \{[1]\} : [1] = \\
  \{[1,1]\}
\end{array}
$$

Derivadas
=========

- O número de derivadas produzidas a partir de uma expressão é finito.

Derivadas
=========

- A construção de um autômato de pilha reside nesse fato.
   - Cada derivada corresponderá a um símbolo do alfabeto de pilha.
   
Derivadas
=========

- Conjunto de derivadas, $\Delta(e)$, é definido como:
   - $1\,e \in\Delta(e)$
   - Se $e'\in\Delta(e)$ e $[e_1,...e_n]\in\nabla_\alpha^{\emptyset,\emptyset}(e)$ então 
     $\forall k. 1 \leq k \leq n \to e_k \in \Delta(e)$
     

Autômato
========

- Autômato de pilha não determinístico $M=(E,\Sigma,\Gamma,\delta,i)$:
   - $E$: conjunto finito de estados
   - $\Sigma$: alfabeto de entrada
   - $\Gamma$: alfabeto de pilha
   - $\delta: E \times (\Sigma\cup\{\lambda\})\times\Gamma \to (E\times \Gamma^*)$ 

Autômato 
========

- Linguagem aceita por um APN:

$$
L(M) = \{w \in \Sigma^*\,|\,[i,w,\lambda]\vdash^*[e,\lambda,\lambda]\}
$$

Autômato
========

- O APN equivalente a uma expressão fechada $e$ é $M=(E,\Sigma,\Gamma,\delta,i)$:
   - $E = \{q\}$
   - $\Gamma = \Delta(e)$

Autômato
========

- A função de transição é definida como:
   - $\delta(q,a,e') = [q,\nabla_a^{\emptyset,\emptyset}(e')]$, para $a \in \Sigma$.
   - $\delta(q,\lambda,e') = [q,\nabla_\lambda^{\emptyset,\emptyset}(e')]$.
   
Exercício
=========

- Apresente uma definição para uma expressão livre de contexto para a linguagem de palíndromos
sobre $\Sigma = \{0,1\}$.

- Calcule o conjunto $\Delta(e)$ para a expressão produzida por você para a linguagem de palíndromos.

Referências
===========

- Thiemann, Peter. Partial Derivatives for Context-Free Languages:
From $\mu$-Regular Expressions to Pushdown Automata.

