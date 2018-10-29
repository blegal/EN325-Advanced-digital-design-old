/*
 *  Adder.h
 *  SystemC_SimpleAdder
 *
 *  Created by Le Gal on 07/05/07.
 *  Copyright 2007 __MyCompanyName__. All rights reserved.
 *
 */
#ifndef _t_measure_
#define _t_measure_

#include "Encoder.h"

SC_MODULE(t_measure)
{
public:
    sc_in<bool> clk;
    sc_in<bool> reset;

    sc_fifo_out<unsigned char> s;

	SC_CTOR(t_measure):
		enc  ("Encoder"   ),
		fin  ("FIFO_R", 192),
    	fou  ("FIFO_O", 192)
	{
		enc.clk(clk); enc.reset(reset);
		enc.e(fin);
		enc.s(fou);

		SC_CTHREAD(do_generate_mb, clk.pos());
		reset_signal_is(reset, true);

		SC_CTHREAD(do_count_mb, clk.pos());
		reset_signal_is(reset, true);

		SC_CTHREAD(do_action, clk.pos());
		reset_signal_is(reset, true);
	}

private:
    Encoder enc;
	sc_fifo<unsigned char>  fin;
	sc_fifo<signed  short>  fou;

	sc_signal< sc_uint<32> > i_cnt;
	sc_signal< sc_uint<32> > o_cnt;

	//
	// Processus qui genere les MB en entree du decodeur
	//

	void do_generate_mb(){
		i_cnt = 0;
		wait();
		while( true ){
			for(unsigned char i = 0; i < 192; i += 1){
	#pragma HLS PIPELINE
				fin.write( i );
			}
			i_cnt.write( i_cnt.read() + 1 );
		}
	}

	//
	// Processus qui recupere les MB en sortie du decodeur
	//

	void do_count_mb(){
		o_cnt = 0;
		wait();
		while( true ){
			for(unsigned char i = 0; i < 192; i += 1){
	#pragma HLS PIPELINE
				fou.read();
			}
			o_cnt.write( o_cnt.read() + 1 );
		}
	}

	//
	// Processus qui toutes les secondes transmet le debit a l'uart
	//

	void do_action(){
		while( true ){

			sc_uint<32> start = i_cnt.read();
			sc_uint<32> c_counter = 99999999 - 6; // cf rapport de synthese HLS
			do
			{
				c_counter -= 1;
				wait();
			}while( c_counter != 0 );

			sc_uint<32> stop = o_cnt.read();
			sc_uint<32> time = stop - start;
			s.write( (time >> 24) & 0xFF );
			s.write( (time >> 16) & 0xFF );
			s.write( (time >>  8) & 0xFF );
			s.write( (time      ) & 0xFF );
		}
	}
};

#endif
