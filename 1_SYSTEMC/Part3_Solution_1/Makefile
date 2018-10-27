CC=g++ -O2 -Wall -I../systemc-2.3.0/include -m32
CFLAGS=
LDFLAGS=-L../systemc-2.3.0/lib-linux -lsystemc -m32 -lpthread
EXEC=main
SRC=./src/main.cpp               \
	./src/gene/ImageIn.cpp       \
	./src/gene/Generateur.cpp       \
	./src/modules/analyseur/ImageOut.cpp \
	./src/Image/CPixel.cpp       \
	./src/Image/CLigne.cpp       \
	./src/Image/CImage.cpp       \
	./src/Image/CBitmap.cpp      \
	./src/modules/DCT2d/DCT2d.cpp \
	./src/modules/DCT2d/iDCT2d.cpp \
	./src/modules/Quantif/Quantification.cpp \
	./src/modules/Quantif/iQuantification.cpp \
	./src/modules/RLE/RLE.cpp \
	./src/modules/RLE/iRLE.cpp \
	./src/modules/Wrapper/Serializer.cpp \
	./src/modules/Wrapper/iSerializer.cpp \
	./src/modules/ZigZag/ZigZag.cpp \
	./src/modules/ZigZag/iZigZag.cpp \
	./src/modules/YCbCr/Conversion.cpp \
	./src/modules/YCbCr/iConversion.cpp \
	./src/modules/ImageTools.cpp \
	./src/modules/analyseur/Analyseur.cpp

OBJ= $(SRC:.cpp=.o)

CFLAGS=

all: $(EXEC)
	./bin/main

main: $(OBJ)
	$(CC) $(CFLAGS) -o ./bin/$@ $^ $(LDFLAGS)

%.o: %.cpp
	$(CC) $(CFLAGS) -o $@ -c $< $(CFLAGS)

.PHONY: clean mrproper

clean: $(OBJ)
	rm ./src/main.o
	rm ./src/gene/ImageIn.o
	rm ./src/gene/Generateur.o
	rm ./src/modules/analyseur/ImageOut.o
	rm ./src/Image/CPixel.o
	rm ./src/Image/CLigne.o
	rm ./src/Image/CImage.o
	rm ./src/Image/CBitmap.o
	rm ./src/modules/DCT2d/DCT2d.o
	rm ./src/modules/DCT2d/iDCT2d.o
	rm ./src/modules/Quantif/Quantification.o
	rm ./src/modules/Quantif/iQuantification.o
	rm ./src/modules/RLE/RLE.o
	rm ./src/modules/RLE/iRLE.o
	rm ./src/modules/Wrapper/Serializer.o
	rm ./src/modules/Wrapper/iSerializer.o
	rm ./src/modules/ZigZag/ZigZag.o
	rm ./src/modules/ZigZag/iZigZag.o
	rm ./src/modules/YCbCr/Conversion.o
	rm ./src/modules/YCbCr/iConversion.o
	rm ./src/modules/ImageTools.o
	rm ./src/modules/analyseur/Analyseur.o

mrproper: clean
	rm $(EXEC)
