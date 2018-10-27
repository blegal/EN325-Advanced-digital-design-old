/*
 *  Adder.h
 *  SystemC_SimpleAdder
 *
 *  Created by Le Gal on 07/05/07.
 *  Copyright 2007 __MyCompanyName__. All rights reserved.
 *
 */
#include "systemc.h"

SC_MODULE(Analyseur)
{
private:
	int erreur;
	int data;
public:
	sc_fifo_in<int> e1;
	sc_fifo_in<int> e2;

	void do_print();

	SC_CTOR(Analyseur)
	{
		SC_THREAD(do_print);
		erreur = 0;
		data   = 0;
	}

	~Analyseur(){
		cout << name() << " => DATA (" << data << "), ERREURS (" << erreur << "), MOYENNE (" << (((double)erreur)/data) << ")" << endl;
	}
};
