/*
 *  Adder.h
 *  SystemC_SimpleAdder
 *
 *  Created by Le Gal on 07/05/07.
 *  Copyright 2007 __MyCompanyName__. All rights reserved.
 *
 */
 #define SC_INCLUDE_FX
 #include "systemc.h"

SC_MODULE(i_wrapper)
{
public:
	sc_in<sc_logic>                  clk;
	sc_fifo_in <unsigned char> e;
    sc_out     <sc_lv<24> >    o_data;
    sc_out     <sc_logic>          o_valid;

	SC_CTOR(i_wrapper)
	{
		SC_CTHREAD(do_conversion, clk.pos());
	}

    void do_conversion();
 };
