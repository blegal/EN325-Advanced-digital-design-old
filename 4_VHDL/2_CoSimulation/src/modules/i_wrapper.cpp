/*
 *  Adder.h
 *  SystemC_SimpleAdder
 *
 *  Created by Le Gal on 07/05/07.
 *  Copyright 2007 __MyCompanyName__. All rights reserved.
 *
 */
#include "i_wrapper.h"


void i_wrapper::do_conversion(){
	while( true ){
		wait(); // ON ATTEND UN FRONT D'HORLOGE
		if( e.num_available() != 0 ){
			sc_uint<8> d1 = e.read();
			sc_uint<8> d2 = e.read();
			sc_uint<8> d3 = e.read();

			sc_lv<24> tmp = ( (sc_lv<8>)d3, (sc_lv<8>)d2, (sc_lv<8>)d1 );
		    o_data.write ( tmp );
		    o_valid.write( SC_LOGIC_1 );
			wait(); // ON ATTEND UN FRONT D'HORLOGE

		    o_data.write ( -1 );	// LE SIGNAL DATA_VALID. PUIS ON ATTEND ENCORE UN
		    o_valid.write( SC_LOGIC_0 );	// CYCLE AVANT DE CONTINUER LE PROCESSUS.
			wait(); // ON ATTEND UN FRONT D'HORLOGE
			wait(); // ON ATTEND UN FRONT D'HORLOGE
		}
	}
}
