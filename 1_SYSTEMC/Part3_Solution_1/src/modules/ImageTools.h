/*
 * ImageTools.h
 *
 *  Created on: 8 déc. 2008
 *      Author: legal
 */

#ifndef IMAGETOOLS_H_
#define IMAGETOOLS_H_

#include "../Image/CBitmap.h"

void ComputeDifference(CImage *original, CImage *tmp);
void IncreaseDifference(CImage *tmp, int factor);

void Show64valuesVector(int *tab);
void Show64valuesVector(int *tab, string name);

void ShowIntegerVector(int *tab, int size);

void GenerateMacroblocStructure();
void ShowMacroblocStructure(int *tab);


#endif /* IMAGETOOLS_H_ */
