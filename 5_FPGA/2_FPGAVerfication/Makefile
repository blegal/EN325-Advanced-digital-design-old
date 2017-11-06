CC=g++ -O2 -Wall -I../systemc-2.3.0/include -m32
CFLAGS=
LDFLAGS=-L../systemc-2.3.0/lib-linux -lsystemc -m32 -lpthread
EXEC=main
SRC=./src/main.cpp \
	./src/modules/Conversion.cpp \
	./src/modules/ConversionInverse.cpp \
	./src/Image/CPixel.cpp     \
	./src/Image/CLigne.cpp     \
	./src/Image/CImage.cpp     \
	./src/Image/CBitmap.cpp    \
	./src/gene/ImageIn.cpp       \
	./src/analyseur/ImageOut.cpp

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
	rm ./src/*.o
	rm ./src/modules/*.o
	rm ./src/Image/*.o
	rm ./src/gene/*.o
	rm ./src/analyseur/*.o

mrproper: clean
	rm $(EXEC)
