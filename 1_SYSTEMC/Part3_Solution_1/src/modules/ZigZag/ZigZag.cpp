/*
 *  Adder.h
 *  SystemC_SimpleAdder
 *
 *  Created by Le Gal on 07/05/07.
 *  Copyright 2007 __MyCompanyName__. All rights reserved.
 *
 */
#include "ZigZag.h"

void Permuttation(int buffer_in[64]){
	int conv[64] = { 0,  1,  8, 16,  9,  2,  3, 10,
					17, 24, 32, 25, 18, 11,  4,  5,
					12, 19, 26, 33, 40, 48, 41, 34,
					27, 20, 13,  6,  7, 14, 21, 28,
					35, 42, 49, 56, 57, 50, 43, 36,
					29, 22, 15, 23, 30, 37, 44, 51,
					58, 59, 52, 45, 38, 31, 39, 46,
					53, 60, 61, 54, 47, 55, 62, 63 };
	int tmp[64];
	for(int k=0;k<64;k++){
		tmp[k] = buffer_in[ conv[k] ];
	}
	for(int k=0;k<64;k++){
		buffer_in[k] = tmp[k];
	}
}

void ZigZag::do_conversion(){

	int buffer_in[64];

	while( true ){

		//
		// On memorise les 64 donnees provenant de la DCT
		//
		for(int p=0; p<64; p++){
			buffer_in[p] = e.read();
			wait( 10, SC_NS );
		}

		Permuttation( buffer_in );

		//
		// On transpose les donnees et on les retransmet
		//
		for(int k=0;k<64;k++){
			s.write( buffer_in[k] );
			wait( 10, SC_NS );
		}
	}
}

