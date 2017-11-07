# Validation fonctionnelle du matériel (VHDL)

##	Introduction

Maintenant que vous avez développé votre module VHDL et que ce dernier fonctionne en simulation, nous allons nous assurer qu'il en est toujours pareil après synthèse logique. Pour cela nous allons procéder à une validation fonctionnelle sur carte FPGA.

##	Validation fonctionnelle (1/2)

Pour pouvoir réaliser cette vérification fonctionnelle sur FPGA nous allons avoir besoin d'un support de communication afin de transmettre des données sur la carte ainsi que pour récupérer les résultats de calcul. Pour ce faire nous allons utiliser des modules VHDL développés par Yannick B. qui simplifient l'utilisation de l'UART. Ces modules de communication vont être associés à votre entité VHDL.

Ce travail a déjà été réalisé pour vous. Afin de générer le bitstream permettant de tester votre module, vous devez simplement:

- Lancez l'outil Vivado;
- Ouvrir le projet situé dans le répertoire **1_FPGASynthesis**;
- Remplacer le code VHDL du module RGB2YCbCr par votre code VHDL;
- Lancer la génération du bitstream.

Pendant que la synthèse du système s'exécute, prenez le temps de dessiner l'architecture du système qui va être mise en oeuvre dans le FPGA.

Une fois la synthèse terminée, connectez une carte de type Nexys 4 à l'ordinateur et charger le bitstream dans le FPGA afin de le configurer.

##	Validation fonctionnelle (2/2)

Maintenant que la cible matérielle est prete, il ne vous reste plus qu'à lancer la simulation de votre modèle SystemC préféré. Cependant pour transmettre des informations que le FPGA, le code C++ du module de conversion a été modifié.

- Ouvrer le fichier afin de mesurer l'ampleur des modificaitions;
- Compilez le modèle SystemC à l'aide du Makefile fourni;
- Lancez la simulation conjointe;
- Une fois la simulation terminez comparez les performances obtenues par rapport au modèle en virgule fixe (sc_fixed) développé quelques questions plus tot.
