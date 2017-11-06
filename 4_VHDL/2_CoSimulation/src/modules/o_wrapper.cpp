/*
 *  Adder.h
 *  SystemC_SimpleAdder
 *
 *  Created by Le Gal on 07/05/07.
 *  Copyright 2007 __MyCompanyName__. All rights reserved.
 *
 */
#include "o_wrapper.h"

void o_wrapper::do_conversion(){
	while( true ){
		wait(); // ON ATTEND UN FRONT D'HORLOGE
		if( i_valid.read() == 1 ){
			sc_uint<24>  tmp = i_data.read();
			unsigned char d3 = (sc_uint<8>)tmp.range(23, 16);
			unsigned char d2 = (sc_uint<8>)tmp.range(15,  8);
			unsigned char d1 = (sc_uint<8>)tmp.range( 7,  0);
			s.write( (unsigned char)d1 );
			s.write( (unsigned char)d2 );
			s.write( (unsigned char)d3 );
		}
	}
}

