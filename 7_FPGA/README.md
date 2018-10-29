# Validation fonctionnelle du matériel (VHDL)

##	Introduction

Dans la partie précédente vous avez générer plusieurs architectures matérielles à l'aide de l'outil Vivado HLS. Durant vos expérimentations, vous avez générer différentes architectures implantatant la fonction de conversion colorimétrique.

Ces dernières ont été validées par des simulation avant et apres synthèse HLS. Cependant, nous allons maintenant vérifier que le fonctionnement sur circuit FPGA (et donc après synthèse logique) est valide.

##	Validation fonctionnelle (1/2)

Dans un premier temps, vous allez vous rendre dans le repertoire **1_FPGASynthesis** dans lequel vous attend un projet Vivado. Ce dernier inclut les composants nécessaire à la communication avec le FPGA via la liaison UART.

- Vérifiez que vous avez bien exporté (Export RTL) l'architecture VHDL du composant que vous avez générez dans Vivado HLS.
- Ouvrez le projet **1_FPGASynthesis** dans l'outil Vivado.
- Allez dans les paramètres du projet (Settings) puis déplacer vous dans IP et Repository. Ajoutez un nouveau dépot dont la localisation est consituée du repertoire ou vous avez fait votre synthèse HLS, le nom de la solution puis "impl/ip". Validez votre choix. L'outil doit vous informer qu'il à identifier un IP dans votre dépot.
- Rendez vous ensuite dans "IP catalog". Vous devez y retrouver votre dépot. Ajouter un composant dans votre projet. Si ce dernier ne match pas parfaitement au niveau du nom à sa décalration dans le code VHDL, mettez à jour le VHDL.
- Lancez la synthèse, générez le bitstream et configuez la Nexys 4.

##	Validation fonctionnelle (2/2)

Maintenant que la carte est configurée, rendez vous dans le repertoire **2_FPGAVerification**. Ce dernier contient le code SystemC permettant de communiquer avec la carte comme dans la partie 5_FPGA.

- Compilez le code logiciel.
- Vérifiez que l'image de sortie correspond à l'attendu.
