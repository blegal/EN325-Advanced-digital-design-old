#include "Generator.h"

void Generator::do_gen()
{
	while(1){
		int data = (int)(rand()%32);
		s.write( data );
		cout << "Time " << sc_time_stamp() << " => Valeur emise : (" << data << ")" << endl;
		wait( 20, SC_NS );
	}
}
