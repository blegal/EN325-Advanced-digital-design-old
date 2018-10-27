/*
 *  Adder.h
 *  SystemC_SimpleAdder
 *
 *  Created by Le Gal on 07/05/07.
 *  Copyright 2007 __MyCompanyName__. All rights reserved.
 *
 */
#include "DCT2d.h"

#define PI 3.14159265

void doFFT(int* data){
	double DCT_tmp;
	double temp[64];

	for(int u=0;u<8;u++){
		for(int v=0;v<8;v++){
				DCT_tmp = 0;
				double C1 = (u == 0)?(1.0/sqrt(2)):1.0;
				double C2 = (v == 0)?(1.0/sqrt(2)):1.0;
				for(int i=0;i<8;i++)
				{
					for(int j=0;j<8;j++)
					{
						DCT_tmp = DCT_tmp + C1 * C2 * (double)(1/sqrt(16))*(double)(((data[(i*8)+j])-128)*(double)cos(PI*u/8*(i+0.5))*(double)cos(PI*v/8*(j+0.5)));
					}
				}
				temp[v+u*8] = round(DCT_tmp);
			}
		}

		for(int k=0;k<64;k++)
		{
			data[k] = (int)temp[k];
		}
}

void DCT2d::do_conversion(){
	int d[64];
	while( true ){
		// On attend de recevoir nos 64 donnees temporelles
		for(int i=0; i<64; i++) { d[i] = e.read(); wait( 10, SC_NS ); }

		// On procede au calcul de la FFT sur les 8x8 donnees
		doFFT( d );
		wait( (800 - 640), SC_NS );

		// On transfert les 64 donnŽes frequentielles au bloc suivant
		for(int i=0; i<64; i++) { s.write( d[i] ); wait( 10, SC_NS ); }
	}
}

