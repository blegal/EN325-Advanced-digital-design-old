CC=g++ -O2 -Wall -I../systemc-2.3.0/include -m32
CFLAGS=
LDFLAGS=-L../systemc-2.3.0/lib-linux -lsystemc -m32 -lpthread
EXEC=main
SRC=./src/main.cpp \
	./src/modules/Conversion.cpp \
	./src/modules/ConversionInverse.cpp \
	./src/gene/Gene.cpp       \
	./src/analyseur/Terminal.cpp
	
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
	rm ./src/modules/Conversion.o
	rm ./src/modules/ConversionInverse.o
	rm ./src/gene/Gene.o
	rm ./src/analyseur/Terminal.o

mrproper: clean
	rm $(EXEC)
