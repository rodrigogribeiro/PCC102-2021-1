---
author: PCC102 - Teoria da Computação - Prof. Rodrigo Ribeiro
title: Tipos para expressões livres de contexto.
---

Objetivos
=========

- Apresentar um sistema de tipos para expressões $\mu$-regulares.

Objetivos
=========

- Descrever um algoritmo de parsing para expressões $\mu$-regulares
aceitas pelo sistema de tipos descrito.

Ambiguidade
===========

- Como apresentado, expressões $\mu$-regulares são equivalentes a
GLC.

- Pergunta: Se são equivalentes, há expressões $\mu$-regulares ambíguas?

Ambiguidade
===========

- Sim! Expressões $\mu$-regulares são sujeitas a problemas de ambiguidade.

Ambiguidade
===========

- $e_1 + e_2$: é possível definir de maneira única qual expressão aceita a
string em questão? 

Ambiguidade
===========

- $e_1\,e_2$: é possível definir de maneira única a divisão da palavra $w$
em $w = w_1\,w_2$ de forma que $w_1 \in [\![e_1]\!]_{\eta}$ e 
$w_2 \in [\![e_2]\!]_{\eta}$?

Ambiguidade
===========

- Sistema de tipos: caso uma expressão seja válida então ela é equivalente 
a uma gramática LL(1) e, portanto, não é ambígua.

Tipos
=====

- Tipos para expressões $\mu$-regulares são um registro que contém as seguintes
informações:
   - $null(e)$: determina se $\lambda\in [\![e]\!]_{\eta}$.
   - $first(e) = \{a\,|\,aw \in [\![e]\!]_{\eta}\}$.
   - $flast(e) = \{a\,|\,waw' \in [\![e]\!]_{\eta} \land w \neq \lambda\}$.

Tipos
=====

- Operações sobre tipos.

$$
\begin{array}{lcl}
\tau_1 \otimes \tau_2 & = & (\tau_1.\text{flast} \cap \tau_2.\text{flast} = \emptyset) \land \neg \tau_1.\text{null}\\
\tau_1 \# \tau_2      & = & (\tau_1.\text{first} \cap \tau_2.\text{first} = \emptyset) \land \\
                      &   & \neg (\tau_1.\text{null} \land \tau_2.\text{null})\\
b \Longrightarrow S   & = & \text{se }b\text{ então } S\text{ senão }\emptyset \\
\end{array}
$$

Tipos
=====

- Operações sobre tipos.

$$
\begin{array}{lcl}
\tau_\bot & = & \{\text{null} = \text{false}; \text{first} = \emptyset ; \text{flast} = \emptyset\}\\
\tau_\lambda & = & \{\text{null} = \text{true}; \text{first} = \emptyset ; \text{flast} = \emptyset\}\\
\tau_c & = & \{\text{null} = \text{false}; \text{first} = \{c\} ; \text{flast} = \emptyset\}\\
\end{array}
$$

Tipos
=====

- Operações sobre tipos.

$$
\begin{array}{lcl}
\tau_1 \lor \tau_2 & = & \left\{
                            \begin{array}{lcl}
                              \text{null}  & = & \tau_1.\text{null} \lor \tau_2.\text{null}\\
                              \text{first} & = & \tau_1.\text{first} \cup \tau_2.\text{first}\\
                              \text{flast} & = & \tau_1.\text{flast} \cup \tau_2.\text{flast}\\
                            \end{array}
                         \right .
\end{array}
$$

Tipos
=====

- Operações sobre tipos.

$$
\begin{array}{lcl}
\tau_\bot \bullet \tau & = & \tau_\bot\\
\tau \bullet \tau_\bot & = & \tau_\bot\\
\end{array}
$$

Tipos
=====

- Operações sobre tipos.

$$
\begin{array}{lcl}
  \tau_1 \bullet \tau_2 & = & \left\{
                            \begin{array}{lcl}
                               \text{null}  & = & \tau_1.\text{null} \land \tau_2.\text{null}\\
                               \text{first} & = & \left\{\begin{array}{l}
                                                    \tau_1.\text{first}\, \cup \\ 
                                                    \tau_1.\text{null}
                                                    \Longrightarrow \tau_2.\text{first}\\
                                                  \end{array} \right . \\
                               \text{flast} & = & \left\{\begin{array}{l}
                                                    \tau_1.\text{flast}\, \cup \\ 
                                                    \tau_2.\text{null}
                                                    \Longrightarrow (\tau_2.\text{first} \cup \\
                                                      \tau_1.\text{flast})\\
                                                  \end{array} \right . \\
                            \end{array}
                            \right .
\end{array}
$$

Tipos
=====

- Operações sobre tipos. 

$$
\begin{array}{lcl}
   \tau^* & = & \left\{
                    \begin{array}{lcl}
                      \text{null}  & = & \text{true}\\
                      \text{first} & = & \tau.\text{first}\\
                      \text{flast} & = & \tau.\text{first}\cup\tau.\text{flast}\\
                    \end{array}
                \right .
\end{array}
$$

Tipos
=====

- Definição de satisfazibilidade de uma linguagem por um tipo.

$$
\begin{array}{lcl}
L \models \tau & = & \left\{
                    \begin{array}{l}
                       \text{null}(L) \to \tau.\text{null} \land \\
                       \text{first}(L) \subseteq \tau.\text{first} \land \\
                       \text{flast}(L) \subseteq \tau.\text{flast}
                    \end{array}
                    \right .
\end{array}
$$

Propriedades
=====

- A relação de satisfazibilidade atende:
   - $L \models \tau_\bot$ sse $L = \emptyset$
   - $L \models \tau_\lambda$ sse $L =\{\lambda\}$
   - $L \models \tau_a$ sse $L = \{a\}$.


Propriedades
=====

- Se $L_1 \models \tau_1$, $L_2 \models \tau_2$ e $\tau_1 \otimes \tau_2$ então 
  $L_1L_2 \models \tau_1 \bullet \tau_2$.
  
- Se $L_1 \models \tau_1$, $L_2 \models \tau_2$ e $\tau_1 \# \tau_2$ então 
  $L_1\cup L_2 \models \tau_1 \lor \tau_2$.

Propriedades
=====

- Se $L \models \tau$ e $\tau \otimes \tau$ então $L^* \models \tau^*$.

- Se $\forall L. L \models \tau$ implica $f(L)\models \tau$ então $\mu F \models \tau$.
   - $f$ é monotônica.

Sistema de tipos
================

- Regras da forma $\Gamma ; \Delta \vdash e : \tau$
   - $\Gamma$: contexto de hipóteses.
   - $\Delta$: contexto de hipóteses não "guarded".
   - $e$: expressão $\mu$-regular
   - $\tau$: tipo

Sistema de tipos
================

- Regras

$$
\begin{array}{cc}
    \dfrac{}{\Gamma ; \Delta \vdash \lambda : \tau_\lambda} & 
    \dfrac{}{\Gamma ; \Delta \vdash a : \tau_a} \\ \\
    \dfrac{}{\Gamma ; \Delta \vdash \emptyset : \tau_\bot} &
    \dfrac{x : \tau \in \Gamma}{\Gamma ; \Delta \vdash x : \tau}\\ \\
\end{array}
$$


Sistema de tipos
================

- Regras

$$
\begin{array}{c}
   \dfrac{\Gamma;\Delta \vdash e : \tau\:\:\:\:\:\:\Gamma \cup \Delta ; [] \vdash e' : \tau'\:\: \:\:\:\: \tau\otimes \tau' }{\Gamma ; \Delta \vdash e\,e' : \tau \bullet \tau'} \\ \\
   \dfrac{\Gamma;\Delta \vdash e : \tau\:\:\:\:\:\:\Gamma ; \Delta \vdash e' : \tau'\:\: \:\:\:\: \tau\# \tau' }{\Gamma ; \Delta \vdash e + e' : \tau \lor \tau'} \\ \\   
\end{array}
$$

Sistema de tipos
================

- Regras

$$
   \dfrac{\Gamma ; \Delta, v : \tau \vdash e : \tau}{\Gamma ; \Delta \vdash \mu v. e : \tau}
$$

Parsing
=======

- Podemos definir um algoritmo de parsing descendente recursivo sobre 
a estrutura da derivação de tipos.

Parsing
=======

- Algoritmo definido sobre a derivação e dois ambientes que armazenam
expressões associadas a variáveis.

Parsing
=======

$$
\begin{array}{lcl}
    \mathcal{P}(\Gamma ; \Delta \vdash \emptyset : \tau_\bot)\:\:\:\gamma\:\:\:\delta\:\:\:s & = &
    \text{erro}\\
    \mathcal{P}(\Gamma ; \Delta \vdash \lambda : \tau_\lambda)\:\:\:\gamma\:\:\:\delta\:\:\:s & = &
    s\\
\end{array}
$$

Parsing
=======

$$
\begin{array}{lcl}
    \mathcal{P}(\Gamma ; \Delta \vdash a : \tau_a)\:\:\:\gamma\:\:\:\delta\:\:\:(a\,s) & = & s \\
    \mathcal{P}(\Gamma ; \Delta \vdash a : \tau_a)\:\:\:\gamma\:\:\:\delta\:\:\:\_ & = &
    \text{erro}\\
\end{array}
$$

Parsing
=======

$$
\begin{array}{l}
   \mathcal{P}(\Gamma ; \Delta \vdash e_1\,e_2 : \tau_1\bullet\tau_2)\:\:\:\gamma\:\:\:\delta\:\:\:s
   = \\
   \:\:\:\:\text{let }s' = \mathcal{P}(\Gamma ; \Delta \vdash e_1 : \tau_1)
   \:\:\:\gamma\:\:\:\delta\:\:\:s\\
   \:\:\:\:\text{in }\mathcal{P}(\Gamma ; \Delta \vdash e_2 :
   \tau_2)\:\:\:(\gamma\,\cup\,\delta)\:\:\:[]\:\:\:s'\\
\end{array}
$$

Parsing
=======

$$
\begin{array}{lc}
\mathcal{P}(\Gamma ; \Delta \vdash e_1 + e_2 : \tau_1\lor\tau_2)\:\:\:\gamma\:\:\:\delta\:\:\:\lambda
   & = \\ \left\{
           \begin{array}{ll}
              \lambda & \text{se }\text{null}(\tau_1\lor\tau_2)\\
              \text{erro} & \text{caso contrário}\\
           \end{array}
         \right .
\end{array}
$$

Parsing
=======

$$
\begin{array}{lc}
\mathcal{P}(\Gamma ; \Delta \vdash e_1 + e_2 : \tau_1\lor\tau_2)\:\:\:\gamma\:\:\:\delta\:\:\:(a\,s)
   & = \\ 
   \mathcal{P}(\Gamma ; \Delta \vdash e_1 : \tau_1)\:\:\:\gamma\:\:\:\delta\:\:\:s & \\
   \text{se }a \in \tau_1.\text{first} \lor (\tau_1.\text{null} \land a \not\in (\tau_1\lor\tau_2).\text{first})  
\end{array}
$$

Parsing
=======

$$
\begin{array}{lc}
\mathcal{P}(\Gamma ; \Delta \vdash e_1 + e_2 : \tau_1\lor\tau_2)\:\:\:\gamma\:\:\:\delta\:\:\:(a\,s)
   & = \\ 
   \mathcal{P}(\Gamma ; \Delta \vdash e_2 : \tau_2)\:\:\:\gamma\:\:\:\delta\:\:\:s & \\
   \text{se }a \in \tau_2.\text{first} \lor (\tau_2.\text{null} \land a \not\in (\tau_1\lor\tau_2).\text{first})  
\end{array}
$$

Parsing
=======

$$
\begin{array}{lc}
\mathcal{P}(\Gamma ; \Delta \vdash e_1 + e_2 : \tau_1\lor\tau_2)\:\:\:\gamma\:\:\:\delta\:\:\:(a\,s)
   & = \text{erro}\\ 
   \text{caso contrário}\\
\end{array}
$$

Parsing
=======

$$
\begin{array}{lc}
\mathcal{P}(\Gamma ; \Delta \vdash v : \tau)\:\:\:\gamma\:\:\:\delta\:\:\:s & = \gamma(x)\,s
\end{array}
$$

Parsing
=======

$$
\begin{array}{lc}
\mathcal{P}(\Gamma ; \Delta \vdash \mu v : \tau. e : \tau)\:\:\:\gamma\:\:\:\delta\:\:\:s & = \\
\text{fix}(\lambda f \to \mathcal{P}(\Gamma ; \Delta, v : \tau \vdash e : \tau) \gamma\:\:\: 
(\delta, f/v))\:s
\end{array}
$$

Parsing
=======

- O algoritmo apresentado é correto, isto é, se $w \in [\![e]\!]_{\eta}$ e 
$\emptyset;\emptyset\vdash e : \tau$ então o algoritmo consegue fazer o parsing de $w$.

Exercício
=========

- O algoritmo de parsing apresentado não lida com o operador de fecho de Kleene. 
Como ele poderia ser modificado para lidar com este operador?

Referências
===========

- Krishnaswami, Neel; Yallop,Jeremy. A typed, algebraic approach to parsing. PLDI 2019.
