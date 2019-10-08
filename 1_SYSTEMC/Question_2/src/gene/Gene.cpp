/*
 *  Adder.cpp
 *  SystemC_SimpleAdder
 *
 *  Created by Le Gal on 07/05/07.
 *  Copyright 2007 __MyCompanyName__. All rights reserved.
 *
 */

#include "Gene.h"

void Gene::do_gen()           // process
{
	int d[3];
	while(1){
		d[0] = (int)(rand()%256);
		d[1] = (int)(rand()%256);
		d[2] = (int)(rand()%256);
		cout << "Time = " << sc_time_stamp() << " => Valeurs emises : (R=" << d[0] << ", G=" << d[1] << ", B=" << d[2]  << ")" << endl;
		s.write( d[0] );
		s.write( d[1] );
		s.write( d[2] );
		wait( 10, SC_NS );
	}
}
