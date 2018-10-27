#include "systemc.h"

SC_MODULE(Analyzer)
{
	sc_fifo_in<int> e;

	void do_print();

	SC_CTOR(Analyzer)
	{
		SC_THREAD(do_print);
	}
};
