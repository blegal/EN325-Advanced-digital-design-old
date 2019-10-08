# Etude de la conversion colorimétrique

##	Introduction

Avant de vous lancer dans la modélisation, le raffinement et l’implémentation du système de compression complet, vous allez apprendre à dompter le langage SystemC sur un sous-bloc de la chaîne JPEG. La première partie de votre travail consiste à modéliser et à étudier le premier bloc de la chaîne de compression. Ce bloc de « faible complexité calculatoire » est en charge du changement d'espace colorimétrique.

Le changement d'espace colorimétrique, de l'espace de couleur RGB (rouge, vert, bleu) vers l'espace YCbCr (luminance, chrominances) a pour objectif d'améliorer l'efficacité du processus de compression JPEG. En effet l’œil humain est peu sensible à l’altération de la chrominance.

La conversion entre les 2 espaces colorimétriques est réalisée à l'aide des formules mathématiques fournies ci-dessous :

L'objectif de cette séquence pédagogique est de vous faire prendre conscience des disparités fortes entre les couts d'implantation des différentes opérations arithmétiques que vous utilisez classiquement lorsque vous programmez en C, C++, etc.

Afin de vous convaincre des performances calamiteuses par exemple du format de codage flottant et par voie de conséquence du bien fondé du codage en virgule fixe, vous allez réaliser quelques synthèses logiques. Vous pourrez ainsi observer l’évolution des ressources matérielles nécessaire à la mise en oeuvre des opérations arithmétiques manipulant des données entières et flottantes.

L’évaluation que vous allez effectuer sera basée sur la technologie FPGA. La famille Artix-7 (XC7A100T-1CSG324C) de Xilinx sera considérée et l’outil de synthèse employé sera Xilinx Vivado (version 2018.2).

## Q1. Addition de nombres entiers

La première série d’expériences va cibler l’évaluation des caractéristiques des opérations d’addition entre des nombres entiers signés. Pour cela, vous allez utiliser un additionneur combinatoire (aucun registre ne sera ajouté en amont et en aval de l’opérateur).

**Remarque**

Pour des raisons de simplicité, nous omettrons dans cette étude la propagation de la retenue. L’opérateur d’addition que vous devez implanter consomme deux données sur *N* bits et produit une donnée sur *N* bits.

A partir de ces informations :
- Créez un projet Vivado ciblant une carte d'évaluation Nexys-4.
- Récupérer la description VHDL de l'opérateur d'addition disponible sur le site internet de votre enseignant et intégrer la dans votre projet.
- Réalisez la synthèse logique du module et notez la complexité matérielle de l’opérateur (nombre de LUTs) ainsi que la durée du chemin critique.
- Faites varier la largeur des données d’entrée avec les valeurs suivantes [8, 16, 24, 32, 64] afin d'avoir une idée plus précise de l'évolution de la complexité matérielle.

**Attention**

Afin de ne pas fausser les mesures de performance, vous devez ajouter l'option "-mode out_of_context" dans les options de synthèse de Vivado (Synthesis => More options). Dans le cas contraire les résultats post-implantation rapportant le timing seront faussés.

**Remarque**

Notez dans un tableau les résultats de synthèse obtenus pour chaque largeur de mots. Vous pouvez représenter les résultats sous forme de courbes.

## Q2. Multiplication de nombres entiers

L’opérateur d’addition est l’opérateur matériel le plus simple. Dans la majorité des applications, d’autres types d’opérations sont nécessaires. Vous allez maintenant étudier le second opérateur le plus employé : la multiplication. Comme cela a été réalisé dans la première partie, vous allez étudier un multiplieur combinatoire manipulant des nombres entiers signés.

**Remarque**

Une multiplication de deux données signées codées respectivement sur *N* bits produit un résultat sur *2N* bits.
Pour des raisons de simplicité, nous omettrons la propagation des *N* bits de poids fort en sortie de la multiplication.

A partir de ces informations :
- Récuperer le fichier VHDL fourni par votre enseignant [MUL_SIGNED.vhd](./MUL_SIGNED/MUL_SIGNED.vhd).
- Réalisez la synthèse logique de votre module. Notez la complexité matérielle de l’opérateur (nombre de LUTs) ainsi que la durée du chemin critique. Attention, vous prendrez soin dans un premier temps de désactiver l’utilisation des DSP Blocks dans les options de synthèse logique.
- Faites varier la largeur des données d’entrée avec les valeurs suivantes [8, 16, 24, 32, 64] afin d'avoir une idée plus précise de l'évolution de la complexité matérielle.
- Réactivez l’utilisation des DSP Blocks dans les options de synthèse logique et recommencez la campagne de mesure.
- Comparez les résultats que vous venez d’obtenir et comparez les avec ceux obtenus sans blocs DSP.


## Q3. Multiplication d'un nombre par une constante

Vous allez maintenant étudier un cas particulier. Vous allez implanter quelques multiplications par des valeurs constantes afin de voir comment l’outil de synthèse les gère.

- Ecrivez un premier multiplieur 32 bits qui multiplie une entrée codée sur N bits avec une constante codée sur 10 bits. La constante aura pour valeur 8. Désactivez l’utilisation des DSP Blocs.
- Réalisez la synthèse logique de votre module. Interprétez les résultats obtenus.
- Refaites les mêmes opérations lorsque la constante vaut 261.


## Q4. Division de nombres entiers

Vous allez terminer l’étude des opérateurs entiers avec l’étude de l’opérateur de division. Cette étude se limitera à l’opérateur de division 32 bits manipulant des données non signées.
- Dessinez la structure de deux étages « élémentaires » de l’opérateur de division.
- Récupérer le diviseur 32 bits que votre enseignant a mis à votre disposition afin de vous faire gagner beaucoup de temps.
- Réalisez la synthèse logique du module de division. Interprétez le résultat obtenu.


## Q5. Synthèse préliminaire des données récoltées

Vous venez de récolter un nombre important de mesures. Il est temps d’en faire une synthèse. Positionnez les informations de complexité, latence des différents opérateurs les uns par rapport aux autres. Essayer d’en tirer des enseignements.


## Q6. Multiplication de nombres flottants (32 bits)

Maintenant que vous maitrisez l’implantation des opérations entières, vous allez étudier les opérateurs flottants. Pour commencer, vous allez essayer de comprendre la manière dont est réalisé une multiplication flottante entre deux nombres. Le format de codage des nombres flottants sur 32 bits est décrit dans la figure suivante :

Pour vous aider dans votre travail vous avez à votre disposition le code VHDL décrivant l’opération de multiplication disponible ici ainsi que divers documents disponibles sur internet.
- Analysez le code VHDL de l’opérateur de multiplication afin de retrouver la description algorithmique de l’opération.
- Dessinez l’architecture matérielle mise en œuvre dans le code VHDL.
- Faites une synthèse du multiplieur flottant afin d’estimer ses performances (slices, chemin critique).
- Comparez les performances relevées avec celles des multiplieurs entiers.

## Q7. : Addition de nombres flottants (32 bits)

Maintenant que vous savez comment sont codés les nombres flottants et que vous maitrisez leur multiplication, nous allons maintenant étudiez le processus d’addition. Téléchargez le code VHDL décrivant l’opération d’addition disponible ici et retournez vous documenter sur le principe de base de l’adition flottante par exemple ici ou bien là (cours de guyot).
- Analysez le code VHDL de l’opérateur de multiplication afin de retrouver la description algorithmique de l’opération.
- Dessinez l’architecture matérielle mise en œuvre dans le code VHDL.
- Faites une synthèse de l’additionneur flottant afin d’extraire ses caractéristiques.
- Comparez les performances relevées avec celles obtenues précédemment.

## Q8. Amélioration des performances

Les performances des opérateurs flottants peuvent être améliorées en ajoutant par exemple des tranches de pipeline en interne (réduction des chemins critiques). Nous ne réaliserons pas cette étape fastidieuse manuellement dans le cadre de ce TP. Cependant, afin d'observer ce les niveaux de performances que l'on peut atteindre:

- Ouvrez l’outil "IP catalog" présent dans paneau gauche de Vivado. Ce dernier vous permet d'utiliser dans vos developpements les composants matériels développés par les ingénieurs de chez Xilinx.
- Cherchez l'IP dont le nom contient "float".
- Développez plusieurs solutions de multiplieurs et d’additionneurs afin de regarder les compromis surface & débits accessibles.
- Essayer de synthétiser au moins un opérateur afin de valider les estimations de performance fournies.
- L’utilisation de Core Generator est elle intéressantes vis à vis des opérations décrites manuellement ? Pour quelles caractéristiques ? Quel est le cout d’un tel outil ?
- Cherchez maintenant un opérateur dont le nom est "multiplieur" dans la liste des IP fournis. Que ce composant vous permet il de faire ?

## Conclusion & synthèse

Cette séquence pédagogique est maintenant terminée. Il ne vous reste plus qu’à comparer les différentes solutions que vous avez expérimentées dans le cadre de ce TP.
