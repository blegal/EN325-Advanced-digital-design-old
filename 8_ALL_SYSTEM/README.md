# Gestion du système complet

##	Introduction

Jusqu'à maintenant vous avez **joué** avec une pauvre fonction contenant 3 lignes de code... Il est temps pour vous de vous confronter à un cas d'usage plus réel. Pour ce faire, vous allez maintenant devoir intégrer une grande partie de la chaine de compression JPEG sur FPGA. Pour des raisons pratiques, la étapes de compression VLC et Huffman ne seront pas considérées dans le cadre de cette étude.

Afin de vous simplifier la vie, et de rendre ce travail réalisable dans le temps imparti, votre enseignant met à votre disposition une chaine en SystemC qui implante la compression JPEG. Cependant, avant d'ouvrir les fichiers source fournis dans le répertoire **1_Simulation**, prenez le temps de vous documenter un peu...

REFERENCES INTERNET

##	Simulation de la chaine de compression

Dans un premier temps, vous allez vous rendre dans le repertoire **1_Simulation** dans lequel vous attend la chaine de simulation SystemC.

**RECUPEREZ LE FICHIER MAKEFILE DANS LE GITHUB ET N'UTILISEZ PAS LE CMAKE !!!**

- Compilez la chaine de compression à l'aide du Makefile.
- Lancez l'éxécution du modèle.
- Ouvrez le fichier JPEG généré post-simulation. Normalement il se nomme **ofile.jpeg**.
- Ouvrez les modèles SystemC utilisés pour modéliser le traitement et confrontez les à votre comprehension du système.

##	Synthèse HLS de la chaine de compression

Maintenant que vous avez observer le bon fonctionnement du modèle SystemC décrivant l'encodage JPEG Vivado HLS, vous allez générer l'architecture matérielle associée à ce modèle.

- Creez un projet Vivado HLS ciblant la carte Nexys 4 dans le repertoire **2_SyntheseHLS**.
- Ajoutez comme top module le modèle nommé uart_wrapper présent dans le repertoire **1_Simulation/src/Encoder**. Prenez soin d'ajouter tous les fichiers (cpp) nécessaires à la construction du système.
- Lancez le processus de synthèse HLS et exporter l'IP en VHDL.

##	Synthèse logique de la chaine de compression

Afin de valider l'architecture sur carte FPGA il est nécessaire de realiser la synthèse logique du circuit et d'associer à ce dernier un module pour la communication UART.

- Ouvrez le projet Vivado situé dans le repertoire **3_SyntheseLogique**.
- Ajoutez au projet l'IP que vous avez générée à la question précedante.
- Lancez la synthèse logique, générez le bitstream et configurez la carte FPGA.

##	Vérification sur carte

Rendez vous dans le repertoire **4_Verification** afin de lancer le modèle SystemC qui va se charger de vérifier le bon fonctionnement du système sur la carte.

## And then...

Vous avez devant vous une architecture matérielle qui implante un encodeur JPEG. Cette dernière a été intégrallement générée à partir de modèles (naifs) décrit en SystemC. A partir de maintenant votre objectif durant les dernieres séances consiste à améliorer les performances de l'architecture d'encodage JPEG. Vous pouvez, modifier les modèles, inserer des directives, modifier l'architecture globale du système... Le principal métrique de performance sera le débit, puis viendra l'éfficacité (débit/slices).

A vous de jouer ;-)

Afin d'estimer plus précisément les performances de votre architecture matérielle, vous pouvez vous rendre dans le repertoire **9_Optimisation**. Ce dernier contient les outils nécessaire pour mesurer le débit de votre architecture sur carte FPGA. Toutefois, il ne vérifie pas la fonctionnalité de l'encodeur JPEG !