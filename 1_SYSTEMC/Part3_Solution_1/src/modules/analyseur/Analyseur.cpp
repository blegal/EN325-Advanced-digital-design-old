/*
 *  Adder.cpp
 *  SystemC_SimpleAdder
 *
 *  Created by Le Gal on 07/05/07.
 *  Copyright 2007 __MyCompanyName__. All rights reserved.
 *
 */

#include "Analyseur.h"

void Analyseur::do_print()
{
	int tab[64];
	while( true ){
		for(int y=0; y<64; y++) tab[y] = e.read();
		ShowMacroblocStructure( tab );
	}
}
