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

	if( hauteur%8 != 0 ){
		cout << "(EE) La hauteur de l'image n'est pas multiple de 8..." << endl;
		cout << "(EE) L'application va s'arreter !" << endl;
		exit( 0 );
	}

	if( largeur%8 != 0 ){
		cout << "(EE) La largeur de l'image n'est pas multiple de 8..." << endl;
		cout << "(EE) L'application va s'arreter !" << endl;
		exit( 0 );
	}


	for(int y=0; y<hauteur; y+=8){
		for(int x=0; x<largeur; x+=8){
			for(int yy=0; yy<8; yy++){
				for(int xx=0; xx<8; xx++){
				CPixel *p1 = img->getPixel(x+xx, y+yy);
				s.write  ( p1->Red()   );
				wait( 10, SC_NS );
				s.write( p1->Green() );
				wait( 10, SC_NS );
				s.write ( p1->Blue()  );
				wait( 10, SC_NS );
				}
			}
		}
	}
	cout << "(II) Pixel sending finished" << endl;
	delete fichier;
}
