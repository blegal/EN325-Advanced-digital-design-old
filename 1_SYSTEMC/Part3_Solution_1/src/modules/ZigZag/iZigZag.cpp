/*
 *  Adder.h
 *  SystemC_SimpleAdder
 *
 *  Created by Le Gal on 07/05/07.
 *  Copyright 2007 __MyCompanyName__. All rights reserved.
 *
 */
#include "iZigZag.h"

void iPermuttation(int buffer_in[64]){
	int conv[64] = { 0,   1,  5,  6, 14, 15, 27, 28,
					 2,   4,  7, 13, 16, 26, 29, 42,
					 3,   8, 12, 17, 25, 30, 41, 43,
					 9,  11, 18, 24, 31, 40, 44, 53,
					 10, 19, 23, 32, 39, 45, 52, 54,
					 20, 22, 33, 38, 46, 51, 55, 60,
					 21, 34, 37, 47, 50, 56, 59, 61,
					 35, 36, 48, 49, 57, 58, 62, 63 };
		int tmp[64];
		for(int k=0;k<64;k++){
			tmp[k] = buffer_in[ conv[k] ];
		}
		for(int k=0;k<64;k++){
			buffer_in[k] = tmp[k];
		}
	}


void iZigZag::do_conversion(){

		int buffer_in[64];

		while( true ){

			//
			// On memorise les 64 donnees provenant de la DCT
			//
			for(int p=0; p<64; p++){
				buffer_in[p] = e.read();
			}

			iPermuttation( buffer_in );

			//
			// On transpose les donnees et on les retransmet
			//
			for(int k=0;k<64;k++){
				s.write( buffer_in[k] );
			}
		}
	}
