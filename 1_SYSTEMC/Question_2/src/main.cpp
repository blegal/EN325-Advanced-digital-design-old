#include "./analyseur/Terminal.h"
#include "./gene/Gene.h"
#include "./modules/Conversion.h"
#include "./modules/ConversionInverse.h"

#include <iostream>
#include <math.h>

using namespace std;


int main (int argc, char * argv []){
	Gene							gene ("Data_Generator_1");
	Conversion				conv ("conversion");
	ConversionInverse iconv("iConversion");
	Terminal					term ("Terminal_1");

	cout << "Creation des signaux d'interconnexion..." << endl;
	sc_fifo<int>  s1(16);
	sc_fifo<int>  s2(16);
	sc_fifo<int>  s3(16);

	cout << "Mapping des composants..." << endl;
	gene.s(s1);
	conv.e(s1);

	conv.s (s2);
	iconv.e(s2);

	iconv.s(s3);
	term.e (s3);

	cout << "Lancement de la simulation du circuit..." << endl;
	sc_start(100,SC_NS);
	cout << "Fin de la simulation du circuit..." << endl;

  return 0;
}
