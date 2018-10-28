#include "systemc.h"

SC_MODULE(my_module)
{
	sc_in <bool> clk;
    sc_in <bool> reset;

    sc_fifo_in <int> e;
	sc_fifo_out<int> s;

	SC_CTOR(my_module)
	{
		SC_CTHREAD(do_action, clk.pos());
        reset_signal_is(reset,true);
	}

	void do_action();
};
