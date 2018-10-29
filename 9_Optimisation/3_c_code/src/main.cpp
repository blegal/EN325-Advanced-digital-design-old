#include <cstdlib>
using namespace std;

#include <stdio.h>
#include <string.h>
#include <unistd.h>
#include <fcntl.h>
#include <sys/ioctl.h>
#include <errno.h>
#include <paths.h>
#include <termios.h>
#include <sysexits.h>
#include <sys/param.h>
#include <sys/select.h>
#include <sys/time.h>
#include <time.h>
#include <cassert>
#include <stdint.h>
#include <signal.h>

#include <iostream>
#include <fstream>
#include <string>
#include <vector>
#include <chrono>


int main (int argc, char * argv []){

    int fileDescriptor = open("/dev/ttyUSB1", O_RDWR | O_NOCTTY );
    if(fileDescriptor == -1)
    {
        printf("Impossible d'ouvrir ttyUSB1 !\n");
        exit( 0 );
    }
    struct termios t;
    tcgetattr(fileDescriptor, &t); // recupère les attributs
    cfmakeraw(&t); // Reset les attributs
    t.c_cflag     = CREAD | CLOCAL;     // turn on READ
    t.c_cflag    |= CS8;
    t.c_cc[VMIN]  = 0;
    t.c_cc[VTIME] = 127;     // 5 sec timeout
    //cfsetspeed(&t, B115200); // règle la vitesse
    cfsetispeed(&t, B921600);
    cfsetospeed(&t, B921600);
    tcsetattr(fileDescriptor, TCSAFLUSH, &t); // envoie le tout au driver

    while( true )
    {

      unsigned int values;
      int rBytes = read( fileDescriptor, &values, 4 );
      if( read < 0 ) exit( 0 );
      if( rBytes == 4 )
      {
        printf("Performance = %d Macroblocs par seconde\r", __bswap_32(values));
        fflush( stdout );
      }
    }

  close( fileDescriptor );

  return 0;
}
