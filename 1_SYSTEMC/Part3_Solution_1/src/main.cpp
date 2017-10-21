#include "./modules/analyseur/Analyseur.h"
#include "./gene/Generateur.h"
#include "./gene/ImageIn.h"
#include "./modules/YCbCr/Conversion.h"
#include "./modules/Wrapper/Serializer.h"
#include "./modules/DCT2d/DCT2d.h"
#include "./modules/Quantif/Quantification.h"
#include "./modules/ZigZag/ZigZag.h"
#include "./modules/RLE/RLE.h"

#include "./modules/iJPEG.h"

#include <iostream>
#include <math.h>

using namespace std;

//
// SOLUTION DE LA QUESTION 2 DU TP 4 DE SYSTEMC :
// - INTRODUCTION DES CONTRAINTES TEMPORELLES (TIME FUNCTIONNAL) DANS LE
//   MODELE DE LA CHAINE DE COMPRESSION AFIN D'EN ESTIMER LES PERFORMANCES
//
int main (int argc, char * argv []){
	cout << "Initialisation des composants..." << endl;
	ImageIn     	gene ("Data_Generator_1");
	ImageOut 		iterm("terminal");

	Conversion 		conv ("conversion");
	Serializer 		seri ("serializer");
	DCT2d 			dct2 ("dct2d");
	Quantification 	quan ("quantif");
	ZigZag 			zigz ("zigzag");
	RLE 			rle  ("rle");
	iJPEG 		    term ("terminal");

	//ImageOut 			term("Terminal_1");

	cout << "Mapping des composants..." << endl;
	sc_fifo<int>  s1("FIFO_1", 1);
	gene.s(s1);
	conv.e(s1);

	sc_fifo<int>  s2("FIFO_2", 1);
	conv.s(s2);
	seri.e(s2);

	sc_fifo<int>  s3("FIFO_3", 1);
	seri.s(s3);
	dct2.e(s3);

	sc_fifo<int>  s4("FIFO_4", 1);
	dct2.s(s4);
	quan.e(s4);

	sc_fifo<int>  s5("FIFO_5", 1);
	quan.s(s5);
	zigz.e(s5);

	sc_fifo<int>  s6("FIFO_6", 1);
	zigz.s(s6);
	rle.e (s6);

	sc_fifo<int>  s7("FIFO_7", 1);
	rle.s (s7);
	term.e(s7);

	sc_fifo<int>  s8("FIFO_8", 1);
	term.s(s8);
	iterm.e (s8);

	cout << "Lancement de la simulation du circuit..." << endl;
	sc_start(100,SC_MS);
	cout << "Fin de la simulation du circuit..." << endl;

    return 0;
}
