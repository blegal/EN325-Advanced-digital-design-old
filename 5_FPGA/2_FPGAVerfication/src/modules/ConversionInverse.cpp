/*
 *  Adder.h
 *  SystemC_SimpleAdder
 *
 *  Created by Le Gal on 07/05/07.
 *  Copyright 2007 __MyCompanyName__. All rights reserved.
 *
 */
#include "ConversionInverse.h"


#define MIN(a,b) ((a<b)?a:b)
#define MAX(a,b) ((a<b)?b:a)
#define LIMIT(a,b,c) MIN(MAX(a,b),c)

void ConversionCouleursInverse(int ycbcr[3], int rvb[3]){
    double r = (double)ycbcr[0]  + 1.402   * ((double)ycbcr[2] - 128);
    double g = (double)ycbcr[0]  - 0.34414 * ((double)ycbcr[1] - 128)  - 0.71414 * ((double)ycbcr[2]-128);
    double b = (double)ycbcr[0]  + 1.772   * ((double)ycbcr[1] - 128);
    rvb[0] = (int)round(r);
    rvb[1] = (int)round(g);
    rvb[2] = (int)round(b);
    rvb[0] = LIMIT(rvb[0], 0, 255);
    rvb[1] = LIMIT(rvb[1], 0, 255);
    rvb[2] = LIMIT(rvb[2], 0, 255);
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
