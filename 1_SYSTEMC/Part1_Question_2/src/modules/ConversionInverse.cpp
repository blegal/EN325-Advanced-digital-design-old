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
	while( true ){
		for(int i=0; i<3; i++){
			d[i] = e.read();
		}

    	ConversionCouleursInverse(d, t);

		for(int i=0; i<3; i++){
			s.write( t[i] );
		}
	}
}

