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

SC_MODULE(o_wrapper)
{
public:
	sc_in<sc_logic>                  clk;
    sc_in      <sc_lv<24> >    i_data;
    sc_in      <sc_logic>      i_valid;
	sc_fifo_out<unsigned char> s;

	SC_CTOR(o_wrapper)
	{
		SC_CTHREAD(do_conversion, clk.pos());
	}

    void do_conversion();
 };
