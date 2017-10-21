/*
 *  Adder.h
 *  SystemC_SimpleAdder
 *
 *  Created by Le Gal on 07/05/07.
 *  Copyright 2007 __MyCompanyName__. All rights reserved.
 *
 */
#include "systemc.h"
#include "../../Image/CBitmap.h"
#include "../ImageTools.h"

SC_MODULE(Analyseur)
{
	sc_fifo_in<int> e;

	void do_print();

	SC_CTOR(Analyseur)
	{
		SC_THREAD(do_print);
	}

};
