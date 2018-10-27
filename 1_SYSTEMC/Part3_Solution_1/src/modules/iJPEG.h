#include "./YCbCr/iConversion.h"
#include "./Wrapper/iSerializer.h"
#include "./DCT2d/iDCT2d.h"
#include "./Quantif/iQuantification.h"
#include "./ZigZag/iZigZag.h"
#include "./RLE/iRLE.h"
#include "./analyseur/ImageOut.h"

SC_MODULE(iJPEG)
{
public:
	sc_fifo_in  <int> e;
	sc_fifo_out <int> s;

	SC_CTOR(iJPEG)
	{
		iSerializer 	*isier = new iSerializer("iserializer");
		iDCT2d 			*idct2 = new iDCT2d("idct2d");
		iQuantification *iquan = new iQuantification("iquantif");
		iZigZag 		*izigz = new iZigZag("izigzag");
		iRLE 			*irle  = new iRLE("irle");
		iConversion 	*iconv = new iConversion("iconversion");

		irle->e(e);

		cout << "Mapping des composants..." << endl;
		sc_fifo<int>  *s1 = new sc_fifo<int>("iFIFO_1", 128);
		irle->s (*s1);
		izigz->e(*s1);

		sc_fifo<int>  *s2 = new sc_fifo<int>("iFIFO_2", 128);
		izigz->s(*s2);
		iquan->e(*s2);

		sc_fifo<int>  *s3 = new sc_fifo<int>("iFIFO_3", 128);
		iquan->s(*s3);
		idct2->e(*s3);

		sc_fifo<int>  *s4 = new sc_fifo<int>("iFIFO_4", 128);
		idct2->s(*s4);
		isier->e(*s4);

		sc_fifo<int>  *s5 = new sc_fifo<int>("iFIFO_5", 128);
		isier->s(*s5);
		iconv->e(*s5);

		iconv->s(s);
	}

 };
