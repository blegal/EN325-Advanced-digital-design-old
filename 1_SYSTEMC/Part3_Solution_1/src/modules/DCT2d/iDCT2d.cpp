/*
 *  Adder.h
 *  SystemC_SimpleAdder
 *
 *  Created by Le Gal on 07/05/07.
 *  Copyright 2007 __MyCompanyName__. All rights reserved.
 *
 */
#include "iDCT2d.h"

#define PI 3.14159265

void doiFFT(double* data){
	double C1=0;
	double C2=0;
	double DCT_tmp;
	double temp[64];
	for(int i=0;i<8;i++){
		for(int j=0;j<8;j++){
			DCT_tmp=0;
			for(int u=0;u<8;u++){
				for(int v=0;v<8;v++){
					C1 = (u == 0)?(1.0/sqrt(2)):1.0;
					C2 = (v == 0)?(1.0/sqrt(2)):1.0;
					double c = C1 * C2 * 1.0/sqrt(16) * cos(PI*u/8*(i+0.5)) * cos(PI*v/8*(j+0.5));
					DCT_tmp=DCT_tmp+ c * (double)data[u*8+v];
				}
			}
			temp[ j + 8*i ] = (round((double)DCT_tmp+128));
		}
	}
	for(int k=0;k<64;k++){
		data[k] = (double)temp[k];
	}
}


void iDCT2d::do_conversion(){
	double d[64];
	while( true ){
		// On attend de recevoir nos 64 donnees temporelles
		for(int i=0; i<64; i++) d[i] = e.read();

		// On procede au calcul de la FFT sur les 8x8 donnees
		doiFFT( d );

		// On transfert les 64 donnŽes frequentielles au bloc suivant
		for(int i=0; i<64; i++) s.write( d[i] );
	}
}

