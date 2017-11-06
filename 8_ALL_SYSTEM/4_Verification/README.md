# Instructions

Afin de tester la validité de votre architecture sur FPGA vous devez:

- Chargez le bitstream de la question precédente sur votre carte Nexys 4,

Maintenant que le FPGA est pret, vous allez construire la chaine de simulation qui va transmettre les données sur la carte.

- Créez un repertoire pour construire la chaine de simulation SystemC:

```
mkdir build
```

- Rendez vous dans le repertoire que vous venez de creer et construisez l'executable:

```
cd build
cmake ..
make
```

Afin de valider le comportement de la chaine d'encodage sur FPGA, il ne vous reste plus qu'a lancer l'executable:

```
./JPEG_processing
```

**Attention** la co-vérification de l'architecture matérielle prend un temps certains à cause du nombre important de données à transmettre vers/depuis le FPGA.
