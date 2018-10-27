/*
 *  Adder.h
 *  SystemC_SimpleAdder
 *
 *  Created by Le Gal on 07/05/07.
 *  Copyright 2007 __MyCompanyName__. All rights reserved.
 *
 */
#include "iQuantification.h"

void iQuantificationFX(int tab[8][8], int _qualite){
	int K= 25-(_qualite/4);

	for(int y=0;y<8;y++)
	{
		for(int x=0;x<8;x++)
			{
			double qf = 1 + K * (1 + x + y);
			tab[y][x] =  tab[y][x] * qf;
		}
	}
}

void iQuantification::do_conversion(){
	int tmp[8][8];
	while( true ){

		for(int y=0;y<8;y++)
			for(int x=0;x<8;x++)
				tmp[y][x] = e.read();

		iQuantificationFX( tmp, _qualite );

		for(int y=0;y<8;y++)
			for(int x=0;x<8;x++)
				s.write( tmp[y][x] );
	}
}

void iQuantification::set_quality(int value){
	_qualite = value;
}
