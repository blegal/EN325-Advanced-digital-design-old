/*
 *  Adder.cpp
 *  SystemC_SimpleAdder
 *
 *  Created by Le Gal on 07/05/07.
 *  Copyright 2007 __MyCompanyName__. All rights reserved.
 *
 */

#include "ImageIn.h"

void ImageIn::do_gen()           // process
{
	CBitmap *fichier = new CBitmap();
	bool ok = fichier->LoadBMP("ImageEntree.bmp");
	if( ok == false ){
		cout << "(EE) Image file (ImageEntree.bmp) not found !" << endl;
		exit( 0 );
	}
	CImage   *img = fichier->getImage();

	cout << "(II) Starting pixel data sending" << endl;
	int largeur = img->getLigne(0)->size();
	int hauteur = img->size();

	wait( 50, SC_NS );
	for(int y=0; y<hauteur; y++){
		for(int x=0; x<largeur; x++){
			CPixel *p1 = img->getPixel(x, y);
			s.write  ( (unsigned char)p1->Red()   );
			s.write( (unsigned char)p1->Green() );
			s.write ( (unsigned char)p1->Blue()  );
			wait( 10, SC_NS );
		}
	}
	cout << "(II) Pixel sending finished" << endl;
	delete fichier;
}
