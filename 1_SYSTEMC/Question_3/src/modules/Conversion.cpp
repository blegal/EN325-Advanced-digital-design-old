/*
 *  Adder.h
 *  SystemC_SimpleAdder
 *
 *  Created by Le Gal on 07/05/07.
 *  Copyright 2007 __MyCompanyName__. All rights reserved.
 *
 */
#include "Conversion.h"

void ConversionCouleurs(int rvb[3], int ycbcr[3]){
}

void Conversion::do_conversion(){
	int d[3];
	while( true ){
		d[0] = (int)e.read();
		d[1] = (int)e.read();
		d[2] = (int)e.read();

    	ConversionCouleurs(d, t);

	   s.write( t[0] );
	   s.write( t[1] );
	   s.write( t[2] );
	}
}

