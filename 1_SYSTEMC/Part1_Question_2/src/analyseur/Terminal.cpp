/*
 *  Adder.cpp
 *  SystemC_SimpleAdder
 *
 *  Created by Le Gal on 07/05/07.
 *  Copyright 2007 __MyCompanyName__. All rights reserved.
 *
 */

#include "Terminal.h"

void Terminal::do_print()
{
	while( true ){
		int d2 = e.read();
		int d1 = e.read();
		int d0 = e.read();
		cout << "Time = " << sc_time_stamp() << " => Valeurs recues : (R=" << d0 << ", G=" << d1 << ", B=" << d2  << ")" << endl;
	}
}
