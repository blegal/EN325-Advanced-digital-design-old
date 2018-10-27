/*
 * ImageTools.cpp
 *
 *  Created on: 8 dŽc. 2008
 *      Author: legal
 */

/*
 *  Adder.h
 *  SystemC_SimpleAdder
 *
 *  Created by Le Gal on 07/05/07.
 *  Copyright 2007 __MyCompanyName__. All rights reserved.
 *
 */
#include "ImageTools.h"

void ComputeDifference(CImage *original, CImage *tmp){
	int largeur = original->getLigne(0)->size();
	int hauteur = original->size();
	for(int y=0; y<hauteur; y++){
		for(int x=0; x<largeur; x++){
			CPixel *p1   = original->getPixel(x, y);
			CPixel *p2   = tmp->getPixel(x, y);
			p2->Red  ( abs(p1->Red()   - p2->Red()   ) );
			p2->Green( abs(p1->Green() - p2->Green() ) );
			p2->Blue ( abs(p1->Blue()  - p2->Blue()  ) );
		}
	}
}

void IncreaseDifference(CImage *tmp, int factor){
	int largeur = tmp->getLigne(0)->size();
	int hauteur = tmp->size();
	for(int y=0; y<hauteur; y++){
		for(int x=0; x<largeur; x++){
			CPixel *p   = tmp->getPixel(x, y);
			p->Red  ( factor * p->Red()   );
			p->Green( factor * p->Green() );
			p->Blue ( factor * p->Blue()  );
		}
	}
}


void Show64valuesVector(int *tab){
	cout << "(II) Printing data : ";
	for(int y=0; y<64; y++){
		cout << tab[y] << ",";
	}
	cout << endl;
}


void Show64valuesVector(int *tab, string name){
	cout << "(II) " << name << " : ";
	for(int y=0; y<64; y++){
		cout << tab[y] << ",";
	}
	cout << endl;
}


void ShowIntegerVector(int *tab, int size){
	cout << "(II) Printing data : ";
	for(int y=0; y<size; y+=2){
		cout << "(" << tab[y] << "x" << tab[y+1] << ")";
	}
	cout << endl;
}


void GenerateMacroblocStructure(){
	for(int y=0; y<64; y++){
		if( (y%8 == 0) && (y!=0) ) cout << endl;
		if(y > 9)  cout << y << ",";
		else cout << "0" << y << ",";
	}
	cout << endl;
}


void ShowMacroblocStructure(int *tab){
	cout << "[ [";
	for(int y=0; y<64; y++){
		if( (y%8 == 0) && (y!=0) ) cout << "]" << endl << "  [";
		if(tab[y] > 9)  cout << tab[y] << ",";
		else cout << "0" << tab[y] << ",";
	}
	cout << endl;
	cout << endl;
}

