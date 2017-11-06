/*
 *  CPixel.h
 *  P_Bitmap
 *
 *  Created by Le Gal on 24/10/06.
 *  Copyright 2006 __MyCompanyName__. All rights reserved.
 *
 */
/*
 *  CPixel.h
 *  P_Bitmap
 *
 *  Created by Le Gal on 24/10/06.
 *  Copyright 2006 __MyCompanyName__. All rights reserved.
 *
 */

#ifndef CPIXEL_H_
#define CPIXEL_H_

class CPixel{
private:
	int red;
	int green;
	int blue;
	
public:
	CPixel(int r, int g, int b);
	CPixel();
	
	void Red(int r);
	void Green(int g);
	void Blue(int b);
	
	int Red();
	int Green();
	int Blue();
	
//	void RGB(int r, int g, int b);
//	void RGB(int R, int G, int B);
};

#endif /*CPIXEL_H_*/
