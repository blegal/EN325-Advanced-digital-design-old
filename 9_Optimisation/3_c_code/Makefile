CC=g++
CFLAGS=-Wall -O2 -std=c++11
LDFLAGS=
EXEC=main
SRC=./src/main.cpp

OBJ= $(SRC:.cpp=.o)

all: $(EXEC)

main: $(OBJ)
	$(CC) $(CFLAGS) -o ./bin/$@ $^ $(LDFLAGS)

%.o: %.cpp
	$(CC) $(CFLAGS) -o $@ -c $< $(CFLAGS)

.PHONY: clean mrproper

clean: $(OBJ)
	find ./src/ -name "*.o"  -exec rm {} \;
	find ./bin/ -name "main" -exec rm {} \;

mrproper: clean
	rm $(EXEC)
