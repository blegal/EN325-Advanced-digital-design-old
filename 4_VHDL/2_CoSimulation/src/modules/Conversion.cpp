/*
 *  Adder.h
 *  SystemC_SimpleAdder
 *
 *  Created by Le Gal on 07/05/07.
 *  Copyright 2007 __MyCompanyName__. All rights reserved.
 *
 */
#include "Conversion.h"

#define MIN(a,b) ((a<b)?a:b)
#define MAX(a,b) ((a<b)?b:a)
#define LIMIT(a,b,c) MIN(MAX(a,b),c)

const int Wl = 8; // 5 EST LA VALEUR MINIMUM AFIN D'ASSURER LA QUALITE VISUELLE
const int C1 = ((1<<Wl) * 0.299);
const int C2 = ((1<<Wl) * 0.587);
const int C3 = ((1<<Wl) * 0.114);
const int C4 = ((1<<Wl) * 0.16874);
const int C5 = ((1<<Wl) * 0.33126);
const int C6 = ((1<<Wl) * 0.5);
const int C7 = ((1<<Wl) * 0.41869);
const int C8 = ((1<<Wl) * 0.08131);
const int C9 = ((1<<Wl) * 128);

void ConversionCouleurs(int rvb[3], int ycbcr[3]){
	int vR    = rvb[0];
	int vG    = rvb[1];
	int vB    = rvb[2];
	int Y     =      (int)C1 * vR + (int)C2 * vG + (int)C3 * vB;
	int Cb    = C9 - (int)C4 * vR - (int)C5 * vG + (int)C6 * vB;
	int Cr    = C9 + (int)C6 * vR - (int)C7 * vG - (int)C8 * vB;
	int fY    =  Y >> (Wl);
	int fCb   = Cb >> (Wl);
	int fCr   = Cr >> (Wl);
    ycbcr[0]  = LIMIT(fY,  0, 255);
    ycbcr[1]  = LIMIT(fCb, 0, 255);
    ycbcr[2]  = LIMIT(fCr, 0, 255);	
}

void Conversion::do_conversion(){
	int d[3], t[3];
	while( true ){
		wait();

		o_data.write ( 0 );
		o_valid.write( SC_LOGIC_0 );

//		cout << "(II) conversion : data valid = (" << i_valid.read() << ")" << endl;

		if( i_valid.read() == 1  ){
			sc_uint<24> tmp = i_data.read();
			d[0] = (sc_uint<8>)tmp.range(23, 16);
			d[1] = (sc_uint<8>)tmp.range(15,  8);
			d[2] = (sc_uint<8>)tmp.range( 7,  0);

		    ConversionCouleurs(d, t);
		    wait();
		    wait();

			sc_uint<8> t1 = t[0];
			sc_uint<8> t2 = t[1];
			sc_uint<8> t3 = t[2];
			sc_lv<24> tm2 = ( (sc_lv<8>)t1, (sc_lv<8>)t2, (sc_lv<8>)t3 );
		    o_data.write ( tm2 );
		    o_valid.write( SC_LOGIC_1 );
		}
	}
}

