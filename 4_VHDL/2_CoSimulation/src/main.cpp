#include "./Analyseur/ImageOut.h"
#include "./Gene/ImageIn.h"
#include "./modules/i_wrapper.h"
#include "./modules/o_wrapper.h"
#include "./modules/Conversion.h"
#include "./modules/ConversionInverse.h"
#include "rgb2ycbcr_16b.h"

#include <iostream>
#include <math.h>

SC_MODULE(logic_clock_adapt)          // module (class) declaration
{
    sc_in<bool> clk;
	sc_out<sc_logic> logic_clk;

    void do_gen(){
		if( clk )
			logic_clk = SC_LOGIC_1;
		else
			logic_clk = SC_LOGIC_0;
	}

	SC_CTOR(logic_clock_adapt)
	{
		SC_METHOD(do_gen);
		sensitive << clk;
	}
};


using namespace std;
#ifdef MTI_SYSTEMC

SC_MODULE(top) {
	ImageIn      		gene;
	rgb2ycbcr_16b		conv;
	ConversionInverse 	iconv;
	ImageOut 			term;
	i_wrapper 			iw;
	o_wrapper   		ow;

	sc_clock the_clock;
	logic_clock_adapt   clk_adater;
	sc_signal<sc_logic> clk;

	sc_fifo<unsigned char>  s1;
	sc_fifo<unsigned char>  s2;
	sc_fifo<unsigned char>  s3;

	sc_buffer<sc_lv<24> > s5;
	sc_buffer<sc_logic>       s6;

	sc_buffer<sc_lv<24> > s7;
	sc_buffer<sc_logic>       s8;


	SC_CTOR(top) :
		gene ("Data_Generator_1"),
		conv ("conversion", "rgb2ycbcr_16b"),
		iconv("iConversion"),
		term ("Terminal_1"),
	    iw("i_wrapper"),
		ow("o_wrapper"),
		the_clock("clk100", 10, SC_NS),
		clk_adater("clk_adapter"),
		clk("clk"),
		s1("FIFO_1", 128),
		s2("FIFO_2", 128),
		s3("FIFO_3", 128),
		s5("FIFO_5"),
		s6("FIFO_4"),
		s7("FIFO_7"),
		s8("FIFO_6")
	{
		cout << "Mapping des composants..." << endl;
		// LE GENERATEUR DE DONNEES
        clk_adater.clk( the_clock );
        clk_adater.logic_clk( clk );

		// LE GENERATEUR DE DONNEES
		gene.s(s1);

		// LE MODULE DE CONVERSION RGB => YCbCr
		conv.clk(clk);
		conv.i_data (s5);
		conv.i_valid(s6);
		conv.o_data (s7);
		conv.o_valid(s8);

		// L'ADAPTATEUR DE PROTOCOLE
		iw.clk(clk);
		iw.e      (s1);
		iw.o_data (s5);
		iw.o_valid(s6);

		// L'ADAPTATEUR DE PROTOCOLE (Inverse)
		ow.clk(clk);
		ow.i_data (s7);
		ow.i_valid(s8);
		ow.s      (s2);

		// LE MODULE DE CONVERSION RGB => YCbCr
		iconv.e(s2);
		iconv.s(s3);

		// LE MODULE DE SAUVEGARDE DES DONNEES
		term.e (s3);

	}
};

SC_MODULE_EXPORT(top)
#else

// POUR EVITER LES DISTORTIONS, IL EST NECESSAIRE D'ULISER DES CANAUX DE TYPE
// INT CAR SINON LES TRONCATURES INT => UNSIGNED INT SONT FAUSSE !
int sc_main (int argc, char * argv []){
	cout << "Initialisation des composants..." << endl;
	ImageIn      		  gene ("Data_Generator_1");
	Conversion 			  conv ("conversion");
	ConversionInverse iconv("iConversion");
	ImageOut 			    term ("Terminal_1");
	i_wrapper 			  iw("i_wrapper");
	o_wrapper   		  ow("o_wrapper");

	sc_time t10(10, SC_NS);
	sc_clock the_clock("clk100", t10);


	cout << "Creation des signaux d'interconnexion..." << endl;
	sc_fifo<unsigned char>  s1("FIFO_1", 128);
	sc_fifo<unsigned char>  s2("FIFO_2", 128);
	sc_fifo<unsigned char>  s3("FIFO_3", 128);

	sc_buffer<sc_lv<24> > s5("FIFO_5");
	sc_buffer<bool>         s6("FIFO_4");

	sc_buffer<sc_lv<24> > s7("FIFO_7");
	sc_buffer<bool>         s8("FIFO_6");

	cout << "Mapping des composants..." << endl;

	// LE GENERATEUR DE DONNEES
	gene.s(s1);

	// L'ADAPTATEUR DE PROTOCOLE
	iw.clk(the_clock);
	iw.e      (s1);
	iw.o_data (s5);
	iw.o_valid(s6);

	// LE MODULE DE CONVERSION RGB => YCbCr
	conv.clk(the_clock);
	conv.i_data (s5);
	conv.i_valid(s6);
	conv.o_data (s7);
	conv.o_valid(s8);

	// L'ADAPTATEUR DE PROTOCOLE (Inverse)
	ow.clk(the_clock);
	ow.i_data (s7);
	ow.i_valid(s8);
	ow.s      (s2);

	// LE MODULE DE CONVERSION RGB => YCbCr
	iconv.e(s2);
	iconv.s(s3);

	// LE MODULE DE SAUVEGARDE DES DONNEES
	term.e (s3);

	cout << "Lancement de la simulation du circuit..." << endl;
	sc_start(100,SC_MS);
	cout << "Fin de la simulation du circuit..." << endl;

    return 0;
}
#endif
