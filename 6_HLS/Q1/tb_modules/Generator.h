#include "systemc.h"

SC_MODULE(Generator)          // module (class) declaration
{
	sc_fifo_out<int> s;

    void do_gen();

	SC_CTOR(Generator)
	{
		SC_THREAD(do_gen);
	}

};
