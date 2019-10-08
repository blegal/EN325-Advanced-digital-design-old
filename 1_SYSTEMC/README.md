# Etude de la conversion colorimétrique

##	Introduction

Avant de vous lancer dans la modélisation, le raffinement et l’implémentation du système de compression complet, vous allez apprendre à dompter le langage SystemC sur un sous-bloc de la chaîne JPEG. La première partie de votre travail consiste à modéliser et à étudier le premier bloc de la chaîne de compression. Ce bloc de « faible complexité calculatoire » est en charge du changement d'espace colorimétrique ([+ d'infos](https://en.wikipedia.org/wiki/YCbCr)).

Le changement d'espace colorimétrique, de l'espace de couleur RGB (rouge, vert, bleu) vers l'espace YCbCr (luminance, chrominances) a pour objectif d'améliorer l'efficacité du processus de compression JPEG. En effet l’œil humain est peu sensible à l’altération de la chrominance.

La conversion entre les 2 espaces colorimétriques est réalisée à l'aide des formules mathématiques fournies ci-dessous :

```
Y   =  0.299  × R + 0.587  × G + 0.114  × B
Cb  = −0.1687 × R − 0.3313 × G + 0.5    × B + 128
Cr  =  0.5    × R − 0.4187 × G − 0.0813 × B + 128
```

L’opération inverse qui convertit les informations de l’espace YCbCr vers l’espace RGB est réalisée à partir des équations fournies ci-dessous :

```
R = Y + 1.402   × (Cr − 128)
G = Y − 0.34414 × (Cb − 128) − 0.71414 ×  (Cr − 128)
B = Y + 1.772   × (Cb − 128)
```

Pour des raisons partiques, les valeurs des composantes {R, G, B} et {Y, Cb, Cr} sont représentées à l’aide de données entières et appartiennent à l'intervalle [0, 255].

Dans un premier temps vous allez implanter un modèle système réalisant juste ces conversions colorimétriques afin de vous familiariser avec les concepts de SystemC.

##	Q1. Modèle fonctionnel sans SystemC

Vous allez commencer par écrire un programme en C/C++. Ce programme en C/C++ aura pour vocation de vous permettre de tester les 2 fonctions *RGB_2_YCbCr* et *YCbCr_2_RGB* que vous allez écrire. Ces 2 fonctions réaliserons les transformations définies dans les équations fournies précédemment.

Afin d'uniformiser vos différents développements et aussi simplifier votre travail durant cette séquence pédagogique, vous utiliserez les prototypes suivants pour vos deux fonctions :

```
void RGB_2_YCbCr (int rvb[3],   int ycbcr[3]);
void YCbCr_2_RGB (int ycbcr[3], int rvb[3]  );
```

**Remarque**

Par convention, les éléments notés rvb[0], rvb[1], rvb[2] désigneront respectivement les canaux *rouge*, *vert* et *bleu*. De manière analogue, les éléments notés ycbcr[0], ycbcr[1], ycbcr[2] désigneront respectivement la luminance *Y* et les chrominances *Cb* et *Cr*.

**A partir de ces informations :**

- Ouvrez le fichier;
- Écrivez les deux fonctions et votre programme *main*;
- Testez votre programme à l'aide des triplets de données fournis ci-dessous.

```
RGB = {  0,   0,   0}
RGB = {  0,   0, 128}
RGB = {  0, 128,   0}
RGB = {128,   0,   0}
```

Cette première description algorithmique des fonctions de conversion sera le point de départ du raffinement des fonctions mathématiques vers une implantation VHDL.

## Q2. Encapsulation dans un modèle SystemC

A partir de maintenant nous allons rentrer dans le vif du sujet. En effet, nous allons utiliser le langage SystemC afin de progressivement transformer vos codes source algorithmiques en codes VHDL synthétisables (ou tout au moins vers des versions s'en rapprochant).

Dans un premier temps, nous allons réécrire votre programme main sous la forme d'un modèle SystemC. Vos fonctions vont être incluses dans un modèle, tout comme la génération des données de test et l'analyse des résultats.

A vous de jouer :
- Récupérez les fichiers fournis par votre enseignant [URL].
- Décompressez les et modifiez les en ajoutant les fonctions C que vous avez précédemment écrites.
- Dessinez le modèle SystemC tel qu'il est décrit.
- Expliquez en quoi vous venez de réaliser une encapsulation de vos fonctions.
- Compilez votre programme à l'aide du makefile fourni puis lancez la simulation.

Vous venez de simuler votre premier système décrit en SystemC. Toutefois comme vous venez de vous en rendre compte le système que nous avons décrit n'est pas très pratique pour valider le fonctionnement de vos fonctions.

##	Q3. Modélisation du système d'acquisition des images

Afin de se rapprocher de la modélisation d'un système réel, nous allons modifier notre description SystemC : nous allons maintenant travailler sur des images (flux de données) réelles. Pour faire évoluer votre modèle, il est seulement nécessaire de remplacer le générateur de données et l'analyseur présent en bout de chaine.

A vous de jouer :

-	Copiez les fichiers cpp que vous avez modifiez à la question précédente dans le répertoire relatif à cette question.
-	Ouvrez les modules en charge de la génération et de l'analyse des données.
-	Dessinez le modèle SystemC tel qu'il est actuellement décrit.
-	Compilez le nouveau modèle à l'aide du makefile fourni puis lancez la simulation.
-	Vérifiez que l'image générée est conforme.
-	Analysez les images présentant les différences entre les images et expliquez les.
Vous aurez remarqué à la fin de la simulation qu'un nombre important d'informations est affiché dans le terminal. Ces informations sont des métriques mathématiques permettant d'évaluer les dégradations induites par vos transformations sur l'image de sortie. Cela vous permettra dans les questions suivantes d'évaluer la pertinence de vos décisions (ou les bugs éventuels).

##	Q4. Raffinement des interfaces de communication (1)

Jusqu'à maintenant les communications au sein du système se sont fait en manipulant des données sur 32 bits (int). Toutefois ce format de données n'est pas celui utilisé dans le monde réel. En effet les informations de type RGB et YCbCr sont codées sur 8 bits.

Vous allez donc modifier les modèles SystemC de la question précédente afin refléter plus efficacement le comportement réel du système. Pour cela, vous pourrez utiliser à votre convenance soit le type unsigned char soit la classe SystemC prévue à cet effet sc_uint<T>.

A vous de jouer :

- Dupliquez le répertoire de la question précédente et renommez le en **Question_4**.
- Modifiez les fichiers afin d'incorporer ce raffinement des interfaces de communication.
- Compilez le modèle modifié puis lancez la simulation.
- Vérifiez que l'image générée est conforme à l’original.
Normalement, vous avez du découvrir que la simulation ne fourni plus les résultats attendus. Pour ceux qui ne l'auraient pas vu, deux solutions, votre modèle est faux (vous n'avez pas bien appliqué les modifications demandées) soit vous n'avez pas validé correctement l'image de sortie.
A vous de rejouer :
•	Corrigez vos algorithmes afin de résoudre le problème observé.
•	Compilez le modèle corrigé puis lancez la simulation.
•	Vérifiez que l'image générée est maintenant conforme.
Comme vous venez de le remarquer une modification insignifiante peut relever des problèmes réels. Imaginez la difficulté pour identifier et corriger ce genre de problème lorsque l'on se trouve en VHDL et que l'on manipule des vecteurs de bits.

##	Conclusion

Maintenant que vous avez un modèle fonctionnel. Vous allez remplacer les calculs flottants réalisés dans les modules de conversion par des calculs en virgule fixe. Cependant avant d’entreprendre cette tache au combien fastidieuse, vous allez faire un peu de VHDL de manière à vous convaincre de l’intérêt de cette transformation.

Rendez-vous ici pour poursuivre votre aventure !
