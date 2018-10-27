/*
 *  Adder.cpp
 *  SystemC_SimpleAdder
 *
 *  Created by Le Gal on 07/05/07.
 *  Copyright 2007 __MyCompanyName__. All rights reserved.
 *
 */

#include "Generateur.h"

void Generateur::do_gen()
{
	for(int k=0;k<65536;k++){
		int d = rand()%4096 - 2048;
		s1.write( d );
		s2.write( d );
	}
}
