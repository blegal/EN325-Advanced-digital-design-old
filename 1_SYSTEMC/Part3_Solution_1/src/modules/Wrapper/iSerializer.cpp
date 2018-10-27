/*
 *  Adder.h
 *  SystemC_SimpleAdder
 *
 *  Created by Le Gal on 07/05/07.
 *  Copyright 2007 __MyCompanyName__. All rights reserved.
 *
 */
#include "iSerializer.h"

void iSerializer::do_conversion(){
	int y[64];
	int cr[64];
	int cb[64];

	while( true ){
		for(int p=0; p<64; p++) y[p]  = e.read();
		for(int p=0; p<64; p++) cb[p] = e.read();
		for(int p=0; p<64; p++) cr[p] = e.read();

		for(int k=0;k<64;k++){
			s.write( y[k]   );
			s.write( cb[k]  );
			s.write( cr[k]  );
		}
	}
}

