# Validation fonctionnelle du matériel (VHDL)

##	Introduction

Dans la partie précédente vous avez générer plusieurs architectures matérielles permettant d'implantater la fonction de conversion colorimétrique.

Ces dernières ont été validées par des simulation avant et apres synthèse HLS. Cependant, nous allons maintenant vérifier que le fonctionnement sur circuit FPGA (et donc après synthèse logique) est valide.

##	Validation fonctionnelle (1/2)

Dans un premier temps, vous allez vous rendre dans le repertoire **XXX** dans lequel vous attend un projet Vivado. Ce dernier inclut les composants nécessaire à la communication avec le FPGA via la liaison UART.

- A
- B
- C
- D

##	Validation fonctionnelle (2/2)

Maintenant que vous avez valider fonctionnellement le comportement de l'architecture séquentielle produite par l'outil Vivado HLS, vous allez faire de même pour l'architecture pipeline. Cela vous permettra de vous assurer que cela n'était pas un coup de chance...

- Rendez vous dans le repertoire **XXX**.
- Recommencer le processus décrit dans la question précédente en faisait attention à sélectionner l'architecture pipeline.
- Validez le comportement du module sur carte à l'aide de la même description SystemC que précedement.

## Conclusion
