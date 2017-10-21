#include "./modules/analyseur/Analyseur.h"
#include "./gene/Generateur.h"
#include "./modules/RLE/RLE.h"
#include "./modules/RLE/iRLE.h"

#include <iostream>
#include <math.h>

using namespace std;

int main (int argc, char * argv []){

	cout << "Initialisation des composants..." << endl;
	Generateur  g1("GENERATEUR_RLE");
	RLE        rle("RLE_TEST");
	iRLE      irle("iRLE_TEST");
	Analyseur ana1("ANALYSEUR_RLE");

	cout << "Initialisation des canaux de communication..." << endl;
	sc_fifo<int>  t1("FIFO_TRLE_1", 128);
	sc_fifo<int>  t2("FIFO_TRLE_2", 128);
	sc_fifo<int>  t3("FIFO_TRLE_3", 128);
	sc_fifo<int>  t4("FIFO_TRLE_4", 128);

	cout << "Mapping des composants..." << endl;
	g1.s1(t1); rle.e(t1); rle.s(t2); irle.e(t2); irle.s(t3);
	g1.s2(t4);
	ana1.e1(t3); ana1.e2(t4);

	cout << "Lancement de la simulation du circuit..." << endl;
	sc_start(100,SC_MS);
	cout << "Fin de la simulation du circuit..." << endl;

	return 0;
}
