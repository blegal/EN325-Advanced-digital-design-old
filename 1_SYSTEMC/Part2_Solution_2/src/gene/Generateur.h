/*
 *  Adder.h
 *  SystemC_SimpleAdder
 *
 *  Created by Le Gal on 07/05/07.
 *  Copyright 2007 __MyCompanyName__. All rights reserved.
 *
 */
#include "systemc.h"

SC_MODULE(Generateur)          // module (class) declaration
{
	sc_fifo_out<int> s1;
	sc_fifo_out<int> s2;

    void do_gen();           // process

	SC_CTOR(Generateur)
	{
		SC_THREAD(do_gen);
	}

};
