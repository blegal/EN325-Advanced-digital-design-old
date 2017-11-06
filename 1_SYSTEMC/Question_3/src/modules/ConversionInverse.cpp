/*
 *  Adder.h
 *  SystemC_SimpleAdder
 *
 *  Created by Le Gal on 07/05/07.
 *  Copyright 2007 __MyCompanyName__. All rights reserved.
 *
 */
#include "ConversionInverse.h"


void ConversionCouleursInverse(int ycbcr[3], int rvb[3]){
}

void ConversionInverse::do_conversion(){
	int d[3];
	while( true ){
		d[0] = (int)e.read();
		d[1] = (int)e.read();
		d[2] = (int)e.read();
		
		ConversionCouleursInverse(d, t);
	   
		s.write( (unsigned char)t[0] );
	   s.write( (unsigned char)t[1] );
	   s.write( (unsigned char)t[2] );
	}
}

