/*
 *  Adder.h
 *  SystemC_SimpleAdder
 *
 *  Created by Le Gal on 07/05/07.
 *  Copyright 2007 __MyCompanyName__. All rights reserved.
 *
 */
#include "iRLE.h"

void iRLE::do_conversion(){
	while( true ){
		int pos = e.read();
		int val = e.read();

		for(int y=0; y<pos; y++)
			s.write( val );
	}
}
