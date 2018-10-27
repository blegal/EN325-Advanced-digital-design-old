/*
 *  Adder.cpp
 *  SystemC_SimpleAdder
 *
 *  Created by Le Gal on 07/05/07.
 *  Copyright 2007 __MyCompanyName__. All rights reserved.
 *
 */

#include "ImageOut.h"

void ImageOut::do_print()
{
	CBitmap *fichier = new CBitmap();
	fichier->LoadBMP("ImageEntree.bmp");
	CImage   *img = fichier->getImage();

	cout << "(II) Starting pixel data receiving" << endl;
	int largeur = img->getLigne(0)->size();
	int hauteur = img->size();

	/*for(int y=0; y<hauteur; y++){
		for(int x=0; x<largeur; x++){
			CPixel *p1   = img->getPixel(x, y);
			p1->Red  ( (int)e.read() );
			p1->Green( (int)e.read() );
			p1->Blue ( (int)e.read() );
		}
	}*/

	for(int y=0; y<hauteur; y+=8){
		if( y%32 == 0) cout << "(II) Receiving pixel line " << (y+1) << "/" << hauteur << endl;
		for(int x=0; x<largeur; x+=8){
			for(int yy=0; yy<8; yy++){
				for(int xx=0; xx<8; xx++){
					CPixel *p1 = img->getPixel(x+xx, y+yy);
					p1->Red  ( (int)e.read() );
					p1->Green( (int)e.read() );
					p1->Blue ( (int)e.read() );
				}
			}
		}
	}

	//
	// ON SAUVEGARDE L'IMAGE RECONSTRUITE
	//
	fichier->SaveBMP("ImageSortie.bmp");
	cout << "(II) Pixel receiving finished" << endl;
	cout << "SystemC Time = " << sc_time_stamp() << endl;

	//
	// ON CALCULE LA DIFFERENCE ENTRE L'IMAGE D'ORIGINE ET CELLE RECONSTRUITE
	//
	CBitmap *original = new CBitmap();
	original->LoadBMP("ImageEntree.bmp");
	CImage   *tmp     = original->getImage();

	ComputeDifference(img, tmp);
	original->SaveBMP("ImageDiff_x1.bmp");

	IncreaseDifference(tmp, 32);
	original->SaveBMP("ImageDiff_x16.bmp");

	delete fichier;
	delete original;
}
