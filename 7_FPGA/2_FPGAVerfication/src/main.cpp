#include "./analyseur/ImageOut.h"
#include "./gene/ImageIn.h"
#include "./modules/Conversion.h"
#include "./modules/ConversionInverse.h"

#include <iostream>
#include <math.h>

using namespace std;

// POUR EVITER LES DISTORTIONS, IL EST NECESSAIRE D'ULISER DES CANAUX DE TYPE
// INT CAR SINON LES TRONCATURES INT => UNSIGNED INT SONT FAUSSE !
int sc_main (int argc, char * argv []){
	cout << "Initialisation des composants..." << endl;
	ImageIn      		gene ("Data_Generator_1");
	Conversion 			conv ("conversion");
	ConversionInverse 	iconv("iConversion");
	ImageOut 			term ("Terminal_1");

	cout << "Creation des signaux d'interconnexion..." << endl;
	sc_fifo<unsigned char>  s1("FIFO_1", 4096);
	sc_fifo<unsigned char>  s2("FIFO_2", 4096);
	sc_fifo<unsigned char>  s3("FIFO_3", 4096);

	cout << "Mapping des composants..." << endl;
	gene.s(s1);
	conv.e(s1);

	conv.s (s2);
	iconv.e(s2);

	iconv.s(s3);
	term.e (s3);

	cout << "Lancement de la simulation du circuit..." << endl;
	sc_start(100,SC_MS);
	cout << "Fin de la simulation du circuit..." << endl;

    return 0;
}
