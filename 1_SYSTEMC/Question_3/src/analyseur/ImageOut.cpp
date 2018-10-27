/*
 *  Adder.cpp
 *  SystemC_SimpleAdder
 *
 *  Created by Le Gal on 07/05/07.
 *  Copyright 2007 __MyCompanyName__. All rights reserved.
 *
 */

#define MIN(a,b) ((a<b)?a:b)
#define MAX(a,b) ((a<b)?b:a)
#define SQR(a)   ((a)*(a))

#include "ImageOut.h"

void ImageOut::do_print()
{
	CBitmap *fichier = new CBitmap();
	fichier->LoadBMP("ImageEntree.bmp");
	CImage   *img = fichier->getImage();

	cout << "(II) Starting pixel data receiving" << endl;
	int largeur = img->getLigne(0)->size();
	int hauteur = img->size();

	for(int y=0; y<hauteur; y++){
		for(int x=0; x<largeur; x++){
			CPixel *p1   = img->getPixel(x, y);
			p1->Red  ( (int)e.read() );
			p1->Green( (int)e.read() );
			p1->Blue ( (int)e.read() );
		}
	}

	//
	// ON SAUVEGARDE L'IMAGE RECONSTRUITE
	//
	fichier->SaveBMP("ImageSortie.bmp");
	cout << "(II) Pixel receiving finished" << endl;

	//
	// ON CALCULE LA DIFFERENCE ENTRE L'IMAGE D'ORIGINE ET CELLE RECONSTRUITE
	//
	CBitmap *original = new CBitmap();
	original->LoadBMP("ImageEntree.bmp");
	CImage   *tmp = original->getImage();

	int    min_error[3] = {256, 256, 256};
	int    max_error[3] = {  0,   0,   0};
	double avg_error[3] = {  0,   0,   0};
	double mse_error[3] = {  0,   0,   0};

	for(int y=0; y<hauteur; y++){
		for(int x=0; x<largeur; x++){
			CPixel *p1   = img->getPixel(x, y);
			CPixel *p2   = tmp->getPixel(x, y);

			min_error[0]  = MIN(min_error[0], (p1->Red()   - p2->Red()));
			min_error[1]  = MIN(min_error[1], (p1->Green() - p2->Green()));
			min_error[2]  = MIN(min_error[2], (p1->Blue()  - p2->Blue()));

			max_error[0]  = MAX(max_error[0], (p1->Red()   - p2->Red()));
			max_error[1]  = MAX(max_error[1], (p1->Green() - p2->Green()));
			max_error[2]  = MAX(max_error[2], (p1->Blue()  - p2->Blue()));

			avg_error[0] += abs(p1->Red()   - p2->Red() );
			avg_error[1] += abs(p1->Green() - p2->Green());
			avg_error[2] += abs(p1->Blue()  - p2->Blue());

			mse_error[0] += SQR(abs(p1->Red()   - p2->Red() ));
			mse_error[1] += SQR(abs(p1->Green() - p2->Green()));
			mse_error[2] += SQR(abs(p1->Blue()  - p2->Blue()));

			//
			// ON TRANSFORME L'IMAGE DE SORTIE !!!
			//
			p1->Red  ( abs(p1->Red()   - p2->Red()   ) );
			p1->Green( abs(p1->Green() - p2->Green() ) );
			p1->Blue ( abs(p1->Blue()  - p2->Blue()  ) );

		}
	}
	fichier->SaveBMP("ImageAbsDiff.bmp");

	avg_error[0] /= (largeur * hauteur);
	avg_error[1] /= (largeur * hauteur);
	avg_error[2] /= (largeur * hauteur);

	mse_error[0] /= (largeur * hauteur);
	mse_error[1] /= (largeur * hauteur);
	mse_error[2] /= (largeur * hauteur);

	cout << "MIN/MAX PIXEL ERROR :" << endl;
	cout << " - RED   CHANNEL [" << min_error[0] << ", " << max_error[0] << "]" << endl;
	cout << " - GREEN CHANNEL [" << min_error[1] << ", " << max_error[1] << "]" << endl;
	cout << " - BLUE  CHANNEL [" << min_error[2] << ", " << max_error[2] << "]" << endl;

	cout << "AVERAGE VALUE ERROR :" << endl;
	cout << " - RED   CHANNEL [" << avg_error[0] << " err/pixel]" << endl;
	cout << " - GREEN CHANNEL [" << avg_error[1] << " err/pixel]" << endl;
	cout << " - BLUE  CHANNEL [" << avg_error[2] << " err/pixel]" << endl;

	cout << "MSE VALUE ERROR :" << endl;
	cout << " - RED   CHANNEL [" << sqrt(mse_error[0]) << " err/pixel]" << endl;
	cout << " - GREEN CHANNEL [" << sqrt(mse_error[1]) << " err/pixel]" << endl;
	cout << " - BLUE  CHANNEL [" << sqrt(mse_error[2]) << " err/pixel]" << endl;

	cout << "Picture SNR VALUES :" << endl;
	cout << " - RED   CHANNEL [" << (10.0 * log10((255.0*255.0) / mse_error[0])) << " dB]" << endl;
	cout << " - GREEN CHANNEL [" << (10.0 * log10((255.0*255.0) / mse_error[1])) << " dB]" << endl;
	cout << " - BLUE  CHANNEL [" << (10.0 * log10((255.0*255.0) / mse_error[2])) << " dB]" << endl;

	//
	// ON SAUVEGARDE LA DIFFERENCE ENTRE LES 2 IMAGES
	//

	for(int y=0; y<hauteur; y++){
		for(int x=0; x<largeur; x++){
			CPixel *p1   = img->getPixel(x, y);
			p1->Red  ( 255 * (p1->Red()   != 0) );
			p1->Green( 255 * (p1->Green() != 0) );
			p1->Blue ( 255 * (p1->Blue()  != 0) );
		}
	}
	fichier->SaveBMP("ImageBinDiff.bmp");


	delete fichier;
	delete original;
}
