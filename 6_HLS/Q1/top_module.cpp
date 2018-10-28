
#include "tb_modules/Generator.h"
#include "tb_modules/Analyzer.h"
#include "my_module.h"

int main (int argc, char * argv []){
	cout << "Initialisation des composants..." << endl;
	Generator A("Data_Generator_1");
	my_module B("conversion");
	Analyzer  C("Terminal_1");

	cout << "Creation des signaux d'interconnexion..." << endl;
	sc_fifo  <int > s1(16);
	sc_fifo  <int > s2(16);
	sc_signal<bool> reset;

	cout << "Mapping des composants..." << endl;
	A.s(s1);
	B.e(s1);

	B.s(s2);
	C.e(s2);

	sc_clock clk("clk",10,SC_NS);
	B.clk  (   clk );
	B.reset( reset );

	cout << "Lancement de la simulation du circuit..." << endl;
	sc_start(4000,SC_NS);
	cout << "Fin de la simulation du circuit..." << endl;

    return 0;
}
