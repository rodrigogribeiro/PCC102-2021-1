---
author: PCC102 - Teoria da Computação - Prof. Rodrigo Ribeiro
title: Bit-codes e containment
---

Objetivos
=========

- Aplicar a interpretação de tipos para representação
de árvores de parsing como códigos de bits. 

Objetivos
=========

- Apresentar um sistema de provas para o problema de 
containment para RE 


Objetivos
=========

- Apresentar a interpretação computacional do sistema 
de containment para RE como coerções entre árvores 
de parsing.

Parsing
=======

- Na última aula, apresentamos o problema de parsing para RE.

- Mostramos como intepretando REs como tipos, obtemos uma 
representação para árvores como termos.

Parsing
=======

- Porém, representar o resultado como árvores possui um custo
de espaço maior que a própria string.

- Será possível melhorar o custo de espaço?

Parsing
=======

- Sim! Resposta: representar árvores usando bits 

Parsing
=======

- Intuitivamente, bits representam:
    - Qual sub-expressão da união foi usada no casamento
    - Marcam início e fim de um casamento para o operador
      Kleene star.

Parsing
=======

- Codificação de árvores em bits.
    - Codificação guiada por tipos (RE).

- Casos base: $\lambda$ e um símbolo.
    
```haskell
code :: Tree -> RE -> [Bit]
code ()       Lambda  = []
code (TChr a) (Sym _) = []
-- omitted
```

Parsing
=======

- Codificação de árvores para união
    - Bit 0: árvore para RE esquerda
    - Bit 1: árvore para RE direita

```haskell
code :: Tree -> RE -> [Bit]
-- code from previous slides
code (Inl t)  (e :+: _)  = 0 : code t e 
code (Inr t') (_ :+: e') = 1 : code t' e'
-- omitted
```

Parsing
=======

- Codificação de árvores para concatenação

```haskell
code :: Tree -> RE -> [Bit]
-- code from previous slides
code (t, t')  (e :@: e') = code t e ++ code e' t' 
-- omitted
```

Parsing
=======

- Codificação de árvores para o fecho de Kleene.

```haskell
code :: Tree -> RE -> [Bit]
-- code from previous slides
code []       (Star _)   = [1]
code (t : ts) (Star e) = code t e ++ 0 : code ts (Star e)
```

Parsing
=======

- Decodificamos bits em árvores usando a estrutura
da RE subjacente.
    - Essencialmente, a decodificação consiste em 
      um parser de bits em árvores.
      

Parsing
=======

- Decodificação de bits.
    - Casos base
    
```haskell
decode' :: [Bit] -> RE -> (Tree, [Bit])
decode' bs Lambda = ((), bs)
decode' bs (Chr a) = (TChr a, bs)
-- omitted
```

Parsing
=======

- Decodificação de bits
    - União: usa marcadores para continuar decodificação.
    
```haskell
decode' :: [Bit] -> RE -> (Tree, [Bit])
-- code from previous slides
decode' (0 : bs) (e :+: _) = let (t,bs') = decode' bs e 
                              in (Inl t, bs')
decode' (1 : bs) (_ :+: e') = let (t,bs') = decode' bs e' 
                              in (Inr t, bs')
-- omitted
```

Parsing
=======

- Decodificação de bits
    - Concatenação: passagem de estado para continuidade do parsing.
    
```haskell
decode' :: [Bit] -> RE -> (Tree, [Bit])
-- code from previous slides
decode' bs (e :@: e')
  = let (t, bs1) = decode' bs e
        (t', bs') = decode' bs1 e' 
    in ((t, t'), bs')
-- omitted
```

Parsing
=======

- Decodificação de bits
    - Fecho de Kleene.

```haskell
decode' :: [Bit] -> RE -> (Tree, [Bit])
-- code from previous slides
decode' (1 : bs) (Star e) = ([], bs)
decode' (0 : bs) (Star e)
  = let (t, bs1) = decode' bs e
        (ts, bs') = decode bs1 (Star e)
    in (t : ts, bs')
```

Parsing
=======

- Decodificação

```haskell
decode :: [Bit] -> RE -> Maybe Tree
decode bs e = let (t,bs') = decode' bs e
              in if null bs' then Just t 
                 else Nothing
```

Parsing
=======

- Propriedade: Se $\vdash e : t$ então `code t e = bs` e `decode bs e = Just t`.

Coercions
=========

- Se temos que $e \equiv e'$ e $\vdash t : e$ como obter uma árvore 
$t'$ tal que $\vdash t' : e'$ e $|t| = |t'|$?

Coercions
=========

- Se expressões regulares são interpretadas como tipos, podemos 
obter uma intepretação computacional de equivalências?

- Sim! Basta intepretarmos equivalências como coerções entre tipos.

Coercions
=========

- Intuitivamente, entendemos que uma RE é subtipo de outra se 
temos uma relação de subconjunto entre as linguagens por elas 
denotadas, isto é: 

$$
e \le e' \Leftrightarrow [\![e]\!] \subseteq [\![e']\!]
$$

Coercions
=========

- Formalmente, denominamos por coerção uma função 

$$
f : \mathcal{T}(e) \to \mathcal{T}(e')_{\bot}
$$

tal que para todo $t$, tal que $\vdash t : e$, temos 
$|t| = |f(t)|$.


Coercions
=========

- Funções de coerção serão termos de um sistema de prova 
para deduzir $\Gamma \vdash p : e \le e'$.

- $\Gamma$: conjunto de hipóteses sobre coerções da forma
       $x : e \le e'$.

Coercions
=========

- $\Gamma \vdash e \equiv e'$ denota o par 

$$(\Gamma \vdash p : e \le e', \Gamma \vdash p^{-1} : e' \le e)$$.


Coercions
=========

- Sistema de coerções

$$
\begin{array}{c}
   \dfrac{}{\Gamma \vdash \textrm{shuffle} : e_1 + (e_2 + e_3) \equiv (e_1 + e_2) + e_3} \\ 
\end{array}
$$

Coercions
=========

- Sistema de coerções

$$
\begin{array}{c}
   \dfrac{}{\Gamma \vdash\textrm{distL} : e_1(e_2 + e_3) \equiv (e_1\,e_2)+(e_1\,e_3)}\\
\end{array}
$$


Coercions
=========

- Sistema de coerções

$$
\begin{array}{c}
   \dfrac{}{\Gamma \vdash\textrm{distR} : (e_1 + e_2)e_3 \equiv (e_1\,e_3)+(e_2\,e_3)}\\
\end{array}
$$

Coercions
=========

- Sistema de coerções

$$
\begin{array}{cc}
  \dfrac{}{\Gamma \vdash\textrm{retag} : e_1 + e_2 \equiv e_2 + e_1} & 
  \dfrac{}{\Gamma\vdash\textrm{untagL} : \emptyset + e_1 \equiv e_1} 
\end{array}
$$

Coercions
=========

- Sistema de coerções

$$
\begin{array}{cc}
   \dfrac{}{\Gamma \vdash\textrm{tagL} : e \le e + e'} & 
   \dfrac{}{\Gamma \vdash\textrm{untag} : e + e \le e}
\end{array}
$$

Coercions 
=========

- Sistema de coerções

$$
\begin{array}{cc}
   \dfrac{}{\Gamma\vdash\textrm{assoc}: e_1(e_2\,e_3) \equiv (e_\,e_2)e_3} &
   \dfrac{}{\Gamma\vdash\textrm{swap} : e\,\lambda \equiv \lambda\,e}
\end{array}
$$

Coercions
=========

- Sistema de coerções 

$$
\begin{array}{cc}
   \dfrac{}{\Gamma\vdash\textrm{proj} : \lambda\,e \equiv e} & 
   \dfrac{}{\Gamma\vdash\textrm{abortR} : e\,\emptyset \equiv \emptyset}
\end{array}
$$

Coercions
=========

- Sistema de coerções

$$
\begin{array}{cc}
   \dfrac{}{\Gamma\vdash\textrm{abortL} : \emptyset\,e \equiv \emptyset} &
   \dfrac{}{\Gamma\vdash\textrm{wrap} : \lambda + e\,e^* \equiv e^*} \\ & \\
   \dfrac{}{\Gamma\vdash\textrm{id} : e \equiv e}
\end{array}
$$

Coercions
=========

- Sistema de coerções

$$
\begin{array}{c}
   \dfrac{\Gamma \vdash p : e_1 \le e_2\:\:\:\:\Gamma \vdash p' : e_2 \le e_3}{\Gamma\vdash p;p' : e_1 \le e_3}
\end{array}
$$


Coercions
=========

- Sistema de coerções

$$
\begin{array}{c}
   \dfrac{\Gamma \vdash p : e_1 \le e_2\:\:\:\:\Gamma \vdash p' : e'_1 \le e'_2}{\Gamma\vdash p + p' : e_1 + e'_1 \le e_2 + e'_2}
\end{array}
$$


Coercions
=========

- Sistema de coerções

$$
\begin{array}{c}
   \dfrac{\Gamma \vdash p : e_1 \le e_2\:\:\:\:\Gamma \vdash p' : e'_1 \le e'_2}{\Gamma\vdash p + p' : e_1 \times e'_1 \le e_2 \times e'_2}
\end{array}
$$

Coercions
=========

- Sistema de coerções 

$$
\dfrac{}{\Gamma,\,f : e \le e' \vdash f : e \le e' }
$$

Coercions
=========

- Sistema de coerções: regra de co-indução
   - Sujeita a condições de boa formação para garantir a correção.

$$
\dfrac{\Gamma, f : e \le e' \vdash c : e \le e'}{\Gamma\vdash\textrm{fix }f.\:c : e\le e'}
$$

Coercions
=========

- Left-guardedness: Seja $\Gamma \vdash\textrm{fix }f.\:c : e \le e'$. Dizemos que uma ocorrência
de $f$ em $c$ é left-guarded se:
   - Existe um sub-termo $d$ tal que a ocorrência de $f$ está em $d'$ em um termo $d \times d'$ em 
     $c$.

Coercions
=========

- Exemplo:

$$
\textrm{fix }f.\underbrace{(\textrm{id} \times f)}_{left-guarded}
$$

Coercions
=========

- Dizemos que um uso da regra de co-indução é correto se toda ocorrência de $f$ em $c$
é left-guarded por um $d : e \le e'$ tal que que $\lambda \not\in[\![e]\!]$.

Coercions
=========

- Depois de definir o sistema de coerções, falta apresetnar sua intepretação 
computacional.

- A semântica de coerções consiste em funções para manipulação de árvores de parsing.

Coercions
=========

- $\textrm{shuffle} : e_1 + (e_2 + e_3) \equiv (e_1 + e_2) + e_3$.
    - Representamos por `shuffle'` a coerção $\textrm{shuffle}^{-1}$.

```haskell
shuffle (Inl t) = Inl (Inl t)
shuffle (Inr (Inl t)) = Inl (Inr t)
shuffle (Inr (Inr t)) = Inr t

shuffle' (Inl (Inl t)) = Inl t
shuffle' (Inl (Inr t)) = Inr (Inl t)
shuffle' (Inr t)       = Inr (Inr t)
```

Coercions
=========

- $\textrm{retag} : e + e' \equiv e' + e$.

```haskell
retag (Inl t) = Inr t
retag (Inr t) = Inl t

retag' (Inr t) = Inl t
retag' (Inl t) = Inr t
```

Coercions
=========

- $\textrm{untagL} : \emptyset + e \equiv e$.

```haskell
untagL (Inr t) = t
```

Coercions
=========

- $\textrm{untag} : e + e \equiv e$

```haskell
untag (Inl t) = t
untag (Inr t) = t
```

Coercions
=========

- $\textrm{tagL} : e \le e + e'$

```haskell
tagL t = Inl t
```

Coercions
=========

- $\textrm{assoc} : e_1(e_2\,e_3) \equiv (e_1\,e_2)e_3$.

```haskell
assoc (t1, (t2, t3)) = ((t1, t2), t3)

assoc' ((t1, t2), t3) = (t1, (t2, t3))
```

Coercions
=========

- $\textrm{swap} : \lambda\,e \equiv e\,\lambda$

```haskell
swap ((), t) = (t, ())

swap' (t, ()) = ((), t)
```

Coercions
=========

- $\textrm{proj} : \lambda\,e \equiv e$

```haskell
proj ((), t) = t

proj' t = ((), t)
```

Coercions
=========

- $\textrm{distL} : e_1(e_2 + e_3) \equiv (e_1\,e_2)+(e_1\,e_3)$

```haskell
distL (t, Inl t') = Inl (t, t')
distL (t, Inr t') = Inr (t, t')

distL' (Inl (t, t')) = (t, Inl t')
distL' (Inr (t, t')) = (t, Inr t')
```

Coercions
=========

- $\textrm{distR} : (e_1 + e_2)e_3 \equiv (e_1\,e_3) + (e_2\,e_3)$

```haskell
distR (Inl t, t') = Inl (t, t')
distR (Inr t, t') = Inr (t, t')

distR' (Inl (t, t')) = (Inl t, t')
distR' (Inr (t, t')) = (Inr t, t')
```

Coercions
=========

- $\textrm{wrap} : \lambda + ee^* \equiv e^*$

```haskell
wrap t = toList t

wrap' [] = ()
wrap' (t : ts) = (t, wrap' ts)
```

Coercions
=========

- Composição

```haskell
(c ; d) t = d (c t)
(c + d) (Inl t) = Inl (c t)
(c + d) (Inr t) = Inr (d t)
(c * d) (t, t') = (c t, d t')
```

Coercions
=========

- Ponto-fixo

$$
(\textrm{fix }f.c)\: t = ([f \mapsto \textrm{fix }f. c]\,c)\,t 
$$

Coercions
=========

- Coerções que atendem a restrição sobre a regra de co-indução
são corretas e completas.
    - São capazes de provar todas as equivalências sobre 
      expressões regulares.
      
Coercions
=========

- Usando a interpretação computacional, conseguimos converter
árvores de parsing entre expressões equivalentes.

Exercício
=========

- Prove, por indução, a seguinte propriedade: 
 Se $\vdash e : t$ então `code t e = bs` e `decode bs e = Just t`.

Referências
===========

Henglein, Fritz; Nielsen, Lasse. Regular Expression Containment:
Coinductive Axiomatization and Computational Interpretation.
