/*
 *  Adder.h
 *  SystemC_SimpleAdder
 *
 *  Created by Le Gal on 07/05/07.
 *  Copyright 2007 __MyCompanyName__. All rights reserved.
 *
 */
#include "Quantification.h"

//
// Fonction C réalisant la quantification d'un macrobloc
// passé en paramètre avec une qualité fixée dans la fonction.
//
void QuantificationFX(int tab[8][8], int _qualite){
	int K= 25-(_qualite/4);

	for(int y=0;y<8;y++)
	{
		for(int x=0;x<8;x++)
			{
			double qf = 1 + K * (1 + x + y);
			tab[y][x] =  round( tab[y][x] / qf);
		}
	}
}

void Quantification::do_conversion(){
	int tmp[8][8];
	while( true ){

		//
		// MODELISATION DE LA RECEPTION DES DONNEES
		//
		for(int y=0;y<8;y++)
			for(int x=0;x<8;x++)
				tmp[y][x] = e.read();

		//
		// REALISATION DE LA QUANTIFICATION DES 64 DONNEES
		//
		QuantificationFX( tmp, _qualite );

		//
		// MODELISATION DU TRANSFERT DES DONNEES
		//
		for(int y=0;y<8;y++)
			for(int x=0;x<8;x++)
				s.write( tmp[y][x] );
	}
}

void Quantification::set_quality(int value){
	_qualite = value;
}
