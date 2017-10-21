/*
 *  Adder.cpp
 *  SystemC_SimpleAdder
 *
 *  Created by Le Gal on 07/05/07.
 *  Copyright 2007 __MyCompanyName__. All rights reserved.
 *
 */

#include "Analyseur.h"

void Analyseur::do_print()
{
	bool first = true;
	while( true ){
		int p1 = e1.read();
		int p2 = e2.read();

		data += 1;

		if( p1 != p2 ){
			if( first )
				cout << name() << " => DONNEE (" << data << ") LES RESULTATS DIVERGENT (" << p1 << " != " << p2 << ")" << endl;
			first = false;
			erreur += abs(p1 - p2);
		}
	}
}
