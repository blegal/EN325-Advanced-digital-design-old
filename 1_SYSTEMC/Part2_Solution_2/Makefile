CC=g++ -O2 -Wall -I../systemc-2.3.0/include -m32
CFLAGS=
LDFLAGS=-L../systemc-2.3.0/lib-linux -lsystemc -m32 -lpthread
EXEC=main
SRC=./src/main.cpp               \
	./src/gene/Generateur.cpp       \
	./src/modules/analyseur/Analyseur.cpp \
	./src/modules/RLE/RLE.cpp \
	./src/modules/RLE/iRLE.cpp

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
	rm ./src/gene/Generateur.o
	rm ./src/modules/analyseur/Analyseur.o
	rm ./src/modules/RLE/RLE.o
	rm ./src/modules/RLE/iRLE.o

mrproper: clean
	rm $(EXEC)
