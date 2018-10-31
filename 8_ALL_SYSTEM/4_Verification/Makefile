CC=g++

#CFLAGS=-O2 -Wall -I../../systemc-2.3.0/include -m32
#LDFLAGS=-L../../systemc-2.3.0/lib-linux -lsystemc -m32 -lpthread

DEFINES ?=

CFLAGS=-O2 -Wall -I../systemc-2.3.0/include -m32 $(DEFINES)
LDFLAGS=-L../systemc-2.3.0/lib-linux -lsystemc -lpthread -m32

EXEC=main
SRC=./src/DataSource/DataSource.cpp \
	./src/Image/CBitmap.cpp \
	./src/Image/CImage.cpp \
	./src/Image/CLigne.cpp \
	./src/Image/CPixel.cpp \
	./src/DataSink/DataSink.cpp \
	./src/Encoder/HardEncoder.cpp \
	./src/main.cpp

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
