/*
 *  Adder.h
 *  SystemC_SimpleAdder
 *
 *  Created by Le Gal on 07/05/07.
 *  Copyright 2007 __MyCompanyName__. All rights reserved.
 *
 */
#include "RLE.h"

int RLEfx(int *in, int* out){

}

void RLE::do_conversion(){
	int tabIn[64]   = {0};
	int tabOut[128] = {0};
	while( true ){
		for(int y=0; y<64; y++){
			tabIn[y] = e.read();
		}

		int nb = RLEfx( tabIn, tabOut );

		for(int y=0; y<nb; y++){
			s.write( tabOut[y] );
		}
	}
}
