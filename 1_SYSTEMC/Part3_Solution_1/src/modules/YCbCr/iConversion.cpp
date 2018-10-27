/*
 *  Adder.h
 *  SystemC_SimpleAdder
 *
 *  Created by Le Gal on 07/05/07.
 *  Copyright 2007 __MyCompanyName__. All rights reserved.
 *
 */
#include "iConversion.h"

void ConversionCouleursInverse(int ycbcr[3], int rvb[3]){

}

void iConversion::do_conversion(){
	int d[3];
	while( true ){
		d[0] = e.read();
		d[1] = e.read();
		d[2] = e.read();
		ConversionCouleursInverse(d, t);
	    s.write( t[0] );
	    s.write( t[1] );
	    s.write( t[2] );
	}
}

