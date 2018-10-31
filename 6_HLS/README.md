# Synthèse HLS des modules SystemC


**Résumé**

L’objectif de cette partie est de vous permettre d’utiliser les connaissances acquises durant le cours dédié à la synthèse de haut niveau (HLS). Dans le cadre de ce TP nous utiliserons un outil industriel développé par Xilinx pour générer des architectures matérielles sous contraintes.

**Note**

Pour toute question spécifique à l’outil « Vivado HLS » et/ou au langage C, C++ ou SystemC supporté par ce dernier, référez vous au document UG902 fourni par Xilinx.

## INTRODUCTION

Lors des TPs précédents vous avez raffiné progressivement votre algorithme afin de le passer d’une description comportementale de type Matlab à une description matérielle de niveau RTL. Les dernières transformations que vous avez réalisées ont été particulièrement complexes et chronophages (le passage des modèles au niveau CABA).

Pour accélérer l’implantation des modèles algorithmiques décrits en C/C++, C++ ou SystemC des outils de HLS ont été développés. Ces derniers conçoivent à votre place l’architecture matérielle qui implémente l’algorithme (instanciation des ressources de calcul, des mémoires RAM, des registres et conception du séquenceur).

Afin de mieux appréhender ce type de méthodologie, vous allez dans un premier temps implanter une application « foo ». Dans un second temps vous vous ferez vos armes avec votre module de conversion colorimétrique « RGB2YUV ». Puis en fonction du temps restant vous essayerez d’implanter efficacement les différents modules de la chaine de compression JPEG.

## PRISE EN MAIN DE L’OUTIL VIVADO-HLS

La première partie du TP vise à vous familiariser avec l’outil Vivado de Xilinx. Vous implanterez votre premier circuit RTL décrit en langage C/C++ et étudierez l’impact des pragma supportés par l’outil sur les architectures générées. Dans un premier temps, réalisez les étapes suivantes :

- Lancez l’outil « Vivado HLS 2018.2 »
- Créez un nouveau projet « File : New project ». Nommez ce premier projet « test_tp_3a_se ». N’ajoutez pas de fichiers dans le projet pour le moment. Dans le dernier onglet lorsque vous devez indiquer la cible, utiliser le sous-menu « Boards » puis « Kintex-7 KC705 ». Valider et créez le projet vide.
- Maintenant commencez par ajouter 2 fichiers dans votre projets. Pour cela cliquez sur l'item « **source** » dans le panneau de gauche et faites « **Add files** ». Cherchez les fichiers nommés « **my_module.cpp** » et « **my_module.h** ».
- Cliquez sur votre projet à l’aide du bouton droit de la souris (dans le panneau de gauche) et sélectionnez « **project settings** » Dans le panneau nommé « **synthesis** », indiquez que le nom du module SystemC à implanter en VHDL est « **my_module** ».
- Décrivez en SystemC un module nommé « **my_module** ». Ce module sera compose d’une entrée “**x**” de type **sc_fifo**, une sortie “**y**” de type **sc_fifo** et de deux entrées de type **sc_in<bool>** pour l’horloge “**clk**” et le signal de **reset**.
- Implantez le comportement du module (Y = 1000 / (2 * (X * X) – 7 * X + 1)) à l’aide d’un SC_CTHREAD sensible au front montant de l’horloge. Vous prendrez soin de déclarer « x » et « y » comme des données entières (int).
- Appuyez sur le bouton « **Run C synthesis** » afin de vérifier que votre code SystemC est syntaxiquement correct.
- Avant de générer l’architecture VHDL, vous allez vérifier le bon fonctionnement du code logiciel que vous avez écrit....  Pour cela, récupérez les fichiers qui décrivant un testbench ici. Ajouter ces fichiers dans votre projet dans la section testbench. Enfin, lancez la simulation de votre système (Run C Simulation) et valider les valeurs obtenues en sortie.
- Maintenant que vous avez démontré/observé que le comportement de votre module SystemC est correct, réalisez sa synthèse HLS. Pour cela cliquez, sur la petite flèche verte dans la barre d’outil.
- Une fois l’opération terminée, une nouvelle fenêtre est apparue. Analysez les informations fournies par l’outil après synthèse. Une vue plus détaillée des informations post-synthèse est disponible si vous cliquez sur la perspective « Analysis » en haut à droite de l’outil. Activez cette perspective et analysez toutes les informations fournies (performances, ressources).
- Vous venez de générer une architecture matérielle de niveau RTL (sans vous en rendre compte). Les fichiers VHDL, Verilog et SystemC correspondant sont disponibles dans le panneau de gauche dans la sous rubrique « solution 1 ». Ouvrez les fichiers VHDL et observez les.
- Reconstituez le circuit conçu pour vous par l’outil Vivado.

A partir du rapport de synthèse (ordonnancement des opérations dans le temps) + des fichiers VHDL essayer de dessiner le circuit que l’outil a conçu pour vous.
- Les caractéristiques matérielles que vous avez analysées précédemment sont des estimations faites par l’outil Vivado. Afin de connaître de manière précise les performances du système, cliquez sur le menu « **Solution** » puis sur « **Export RTL** ». Sélectionnez « **Evaluate** » et choisissez le mode « **VHDL** » puis validez. Comparez les performances fournies dans ce nouveau rapport avec les estimations fournies précédemment par l’outil.
- Vous venez d’analyser les performances du circuit, mais vous avez oubliez de vérifier son fonctionnement… Corriger cela en lançant une simulation du circuit en mode SystemC CABA (Cycle Accurate, Bit Accurate).
- **POUR CETTE ANNEE VOUS ALLEZ SAUTER CETTE ETAPE !!!** Afin de rendre la simulation possible, remplacer l’instanciation de « my_module » par l’instanciation de « my_module_rtl_wrapper » dans votre testbench.
- Transformez votre programme source afin de faire en sorte que l'entrée « **x** » et la sortie « **y** » soient codées sur 16 bits (tout comme les calculs intermédiaires). Recommencez toutes les étapes et comparez les performances des deux implantations.

Pour vous simplifier la vie, nous vous conseillons d’utiliser la génération de solutions multiples & la comparaison de design dans les questions suivantes:
- Transformez à nouveau votre programme source afin manipuler des données de type « int ». Modifiez la fréquence d’horloge ciblée post-synthèse. Essayez avec les périodes 5 ns, 10 ns, 20 ns et 50 ns.
- Observer l’impact de ces modifications sur les résultats de synthèse et calculez les performances en terme de débit et de latence pour chacun des circuits générés. Mettez ces chiffres en regard avec la complexité matérielle.
- Maintenant vous allez changer la cible matérielle indiquée dans les paramètres de synthèse. Choisissez d’abord le FPGA présent sur la carte d’évaluation « Virtex-7 VC707 ». Faites la synthèse de votre description et interprétez les résultats.
- Faites de même lorsque la cible est un Kintex-7 (carte KC705).

## IMPLANTATION DU MODULE RGB_2_YUV

Maintenant que vous maitrisez les concepts de base de l’outil Vivado HLS, vous allez mettre en œuvre vos connaissances afin d’intégrer votre module **RGB_2_YUV** développé en durant les séances de TPs précédentes. Dans cette partie, vous focaliserez votre attention sur les performances obtenues en fonction du niveau de description du modèle SystemC.

- Reprenez le modèle SystemC réalisant la conversion **RGB_2_YUV** à l’aide d’opérations flottantes.
- Adaptez cette description afin de la rendre synthétisable. Procédez ensuite à la synthèse du modèle à l’aide de l’outil Vivado HLS.
- Analyser les résultats de synthèse.
- Procéder de la même manière avec le modèle SystemC qui réalise la conversion **RGB_2_YUV** à l’aide de données de type **sc_fixed**.
- Faites la synthèse de du modèle à l’aide de l’outil Vivado HLS. Réitérez pour différents formats de codage (nombre de bits pour la partie fractionnaire).
- Analyser les résultats de synthèse.
- Faites de même avec le modèle SystemC réalisant la conversion **RGB_2_YUV** à l’aide de données de type **sc_int**.
- Faites la synthèse de du modèle à l’aide de l’outil Vivado HLS. Réitérez pour différents formats de codage (nombre de bits pour la partie fractionnaire).
- Analysez les résultats de synthèse.
- Comparez les performances obtenues vis-à-vis du module VHDL que vous avec décrit à la main durant les TP précédents.
- Comparez les performances obtenues vis à vis du module VHDL que vous avec décrit à la main durant les TP précédents.
- Afin d’améliorer les performances, il est possible de travailler sur plusieurs données en parallèle (données provenant d’itérations successives). Pour cela, étudiez les pragmas [HLS PIPELINE], [HLS INLINE] et/ou [HLS UNROLL] présentés dans la documentation de l’outil Vivado HLS.
- Améliorez les performances de votre module en prenant en considération le fait que 64 échantillons sont toujours traités.
