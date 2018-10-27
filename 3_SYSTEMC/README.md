# Raffinement de la conversion colorimétrique

## Introduction

Maintenant que vous avez pleinement conscience du cout des opérateurs arithmétiques flottants et entiers sur cible FPGA, et indirectement sur cibl ASIC vous allez prendre « plaisir » à mettre en œuvre le codage en virgule fixe…

## Q1. Transformation en virgule fixe des calculs

Nous souhaitons concevoir une architecture matérielle permettant de réaliser la conversion RGB_2_YCbCr. Dans des systèmes ou les calculs flottants sont complexes à implanter et/ou onéreux. Pour cette raison, ces calculs manipulant des données flottantes doivent être transformés en calculs en virgule fixe. Vous allez donc procéder à cette transformation. On limitera cette étude à la fonction RGB_2_YCbCr.

Pour simplifier cette tache ardue, le langage SystemC propose un ensemble de classes dédiées à ce raffinement. Pour mener à bien votre tache, vous disposerez des classes suivantes :

```
sc_fixed <wl, iwl, q_mode, o_mode> var_signed;
sc_ufixed<wl, iwl, q_mode, o_mode> var_unsigned;

// EXAMPLE D'UTILISATION
float adder(float a, float b)
{
	sc_fixed<4,2,SC_RND,SC_SAT> Inputa = a;
	sc_fixed<6,3,SC_RND,SC_SAT> Inputb = b;
	sc_fixed<7,4,SC_RND,SC_SAT> Output;
	Output = (Inputa + Inputb);
	return Output;
}
```

Les paramètres du template de classe ont les significations suivantes :
-	**wl** : nombre total de bits dans le mot;
-	**iwl** : nombre de bits alloué à la partie entière;
-	**q_mode** : mode de quantification;
-	**o_mode** : gestion de la saturation en cas de dépassement.

Afin de limiter la difficulté de cette tache que vous effectuez pour la première fois, nous considérons que tous les coefficients fractionnaires seront codés de la manière uniforme. Votre objectif est de trouver le bon format pour les coefficients et les opérations afin de limiter le bruit de calcul.

Dans un premier temps, reprenez votre modèle:
-	Copiez le répertoire de lié à la question précédente (1_SYSTEMC/Question_4), placez le dans le repertoire (3_SYSTEMC) et renommez le en Question_1.

Maintenant:
-	Demandez des explications à votre enseignant si vous ne maîtriser pas les concepts de codage en virgule fixe.
-	Modifier la description de la fonction RGB_2_YCbCr pour la transformer en virgule fixe.
-	Compilez le modèle puis lancez la simulation.
-	Faites plusieurs tentatives afin de trouver un format permettant de limiter les pertes. Plus le format de codage est faible moins l'architecture matérielle sera onéreuse.
Vous avez du regarder les métriques mathématiques afin de vous guider lors de l'étape de raffinement. Toutefois, la qualité visuelle n'évolue pas de manière similaire à ces valeurs.
-	Recommencer votre étude en considérant votre perception visuelle. Jusqu'à combien de bits pouvez-vous descendre avant de percevoir visuellement une dégradation ?
Vous venez de dimensionner la taille des données et des opérations contenues votre algorithme. Comme vous venez le constater un dimensionnement bien réalisé vous permet de gagner sur le cout silicium de votre architecture. Une fois de plus vous remarquerez qu'une telle étude est dure à réaliser en VHDL.

## Q2. Virgule fixe sans utiliser les classes SystemC

Les classes sc_fixed et sc_ufixed sont très pratiques mais vous serez incapable d'écrire le VHDL équivalent. Afin de simplifier cette tache (l'écriture du VHDL) vous allez traduire votre codage en virgule fixe utilisant les classes **sc_fixed** par du code manipulant des **sc_int<T>** ou **sc_uint<T>**. Ces classes vous permettent d'avoir un niveau de description identique à celui que vous avez avec les type SIGNED et UNSIGNED en VHDL.

Pour cela:
-	Dupliquez le répertoire de lié à la question précédente et renommez le en Part1_Question_6.
-	Modifiez la description de la fonction RGB_2_YCbCr pour ne plus utiliser que des type sc_int<T> et sc_uint<T>.
-	Compilez le modèle puis lancez la simulation.
-	Validez les performances de votre modèle par rapport à celui qui utilisait des sc_fixed et sc_ufixed.
Vous avez maintenant un code VHDL dont le niveau d'abstraction est identique a celui du VHDL. Vous remarquerez qu'une traduction de l'un à l'autre n'est pas très complexe.

## Q3. Raffinement des interfaces au cycle-près

Maintenant que le comportement interne du composant a été étudié, nous allons raffiner les interfaces de communication du module.

Le système dans lequel votre composant sera intégré produit un triplet RGB tout les 30 ns. Ces données sont produites et transmises en même temps à votre composant. Ces données seront valides 10 ns et durant ce temps, un signal data_valid sera positionné à 1 (et 0 les 20 ns restantes).

Le comportement des sorties de votre composant devra être similaire: les sorties se feront sur 24 bits durant 10 ns. Un signal out_valid validera la présence de nouvelles sorties durant 10 ns.

Le temps de calcul entre la réception des données dans votre composant et la production des sorties sera fixé à 20 ns.

Afin de ne pas modifier le générateur de données ni le module de conversion **YCbCr_2_RGB**, la méthode la plus simple consiste à développer 2 wrappers permettant de transformer les liens actuels au protocole défini ci-dessus. De plus pour synchroniser l'ensemble des composants, une horloge de type **sc_clock** sera nécessaire.

Maintenant:
-	Dessinez le système que vous devez modéliser.
-	Dupliquez le répertoire de lié à la question précédente et renommez le en Part1_Question_7.
-	Créez les deux modules d'interfaçage en charge de la traduction du protocole **FIFO** en protocole cycle près.
-	Modifiez le module **RGB_2_YCbCr** afin de le rendre uniquement sensible à l'horloge (VHDL-like) et implanter le comportement décrit ci-dessus.
-	Compilez le modèle puis lancez la simulation.
-	Valider le fonctionnement de votre modèle.
Vous venez de valider fonctionnellement votre modèle. Cette validation vous a permis de valider la fonctionnalité du modèle, mais en aucun cas le comportement temporel des composants. Afin de valider le comportement temporel du système, le plus simple est d'étudier les signaux d'entrée et de sortie de votre module.
-	Instrumentez votre modèle à l'aide des fonctions SystemC spécialisées dans l'extraction de chronogrammes (sc_trace, etc.).
-	Compilez le modèle puis lancez la simulation.
-	Ouvrez le fichier contenant les chronogrammes à l'aide de l'outil nommé gtkwave.
 
