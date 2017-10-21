#include "Analyzer.h"

void Analyzer::do_print()
{
	while( true ){
		int data   = e.read();
		cout << "Time " << sc_time_stamp() << " => Valeur recue : (" << data << ")" << endl;
	}
}
