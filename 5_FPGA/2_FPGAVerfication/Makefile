CC=g++

#CFLAGS=-O2 -Wall -I../../systemc-2.3.0/include -m32
#LDFLAGS=-L../../systemc-2.3.0/lib-linux -lsystemc -m32 -lpthread

CFLAGS=-O2 -Wall -I/usr/local/systemc-2.3.2/include
LDFLAGS=-L/usr/local/systemc-2.3.2/lib-linux64 -lsystemc -lpthread -static

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

all: $(EXEC)

main: $(OBJ)
	$(CC) -o ./bin/$@ $^ $(LDFLAGS)

%.o: %.cpp
	$(CC) $(CFLAGS) -o $@ -c $<

.PHONY: clean mrproper

clean:
	find -name "*.o" -delete
	rm ./bin/$(EXEC)

mrproper: clean
	rm $(EXEC)
