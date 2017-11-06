/*
 *  Adder.h
 *  SystemC_SimpleAdder
 *
 *  Created by Le Gal on 07/05/07.
 *  Copyright 2007 __MyCompanyName__. All rights reserved.
 *
 */
 #include "systemc.h"

SC_MODULE(Conversion)
{
public:
	sc_in <sc_logic>    clk;
    sc_in <sc_lv<24> >  i_data;
    sc_in <sc_logic>    i_valid;
    sc_out<sc_lv<24> >  o_data;
    sc_out<sc_logic>    o_valid;

	SC_CTOR(Conversion)
	{
		SC_THREAD(do_conversion);
		sensitive << clk.posedge_event();
	}

    void do_conversion();
 };
