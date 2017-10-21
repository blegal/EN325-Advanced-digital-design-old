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
	cout << "(II) Pixel sending starting" << endl;
	for(int k=0;k<64;k++) s.write( k );
	for(int k=0;k<64;k++) s.write( 64+k );
	for(int k=0;k<64;k++) s.write( 128+k );

	for(int k=0;k<64;k++) s.write( 128+k );
	for(int k=0;k<64;k++) s.write( 64+k );
	for(int k=0;k<64;k++) s.write( k );
	cout << "(II) Pixel sending finished" << endl;
}
