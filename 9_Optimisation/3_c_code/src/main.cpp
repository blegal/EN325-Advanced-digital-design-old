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

	int MBps;
	int cpt = 0;
    while( true )
    {

      unsigned int values;
      int rBytes = read( fileDescriptor, &values, 4 );
      if( read < 0 ) exit( 0 );
      if( rBytes == 4 )
      {
      	MBps = __bswap_32(values);
        printf("Performance = %d MB/s OR %d Pixels/s", MBps, 64 * MBps);
        if( (cpt & 0x01) == 0) printf("(-)\r");
        if( (cpt & 0x01) == 1) printf("(+)\r");
        fflush( stdout );
        
        cpt += 1;
        
        if( cpt == 16 ) break;
      }
    }

    printf("\n");
    printf("DECODING THROUGHPUT MEASURE\n");
    printf("---------------------------\n");
    printf("- FORMAT PAL   : ( 768 x  576) = %f Pic/Sec\n", (64.0f*MBps) / ( 768.0f* 576.0f));
    printf("- FORMAT XVGA  : (1024 x  768) = %f Pic/Sec\n", (64.0f*MBps) / (1024.0f* 768.0f));
    printf("- FORMAT 720p  : (1280 ×  720) = %f Pic/Sec\n", (64.0f*MBps) / (1280.0f* 720.0f));
    printf("- FORMAT 1080p : (1920 × 1080) = %f Pic/Sec\n", (64.0f*MBps) / (1920.0f*1080.0f));
    printf("- FORMAT 4K2K  : (4096 x 2160) = %f Pic/Sec\n", (64.0f*MBps) / (4096.0f*2160.0f));
    printf("\n");
    printf("\n");
    printf("DECODING LATENCY MEASURE\n");
    printf("---------------------------\n");
    printf("- FORMAT PAL   : ( 768 x  576) = %f ms\n", 1000.0f / ((64.0f*MBps) / ( 768.0f* 576.0f)));
    printf("- FORMAT XVGA  : (1024 x  768) = %f ms\n", 1000.0f / ((64.0f*MBps) / (1024.0f* 768.0f)));
    printf("- FORMAT 720p  : (1280 ×  720) = %f ms\n", 1000.0f / ((64.0f*MBps) / (1280.0f* 720.0f)));
    printf("- FORMAT 1080p : (1920 × 1080) = %f ms\n", 1000.0f / ((64.0f*MBps) / (1920.0f*1080.0f)));
    printf("- FORMAT 4K2K  : (4096 x 2160) = %f ms\n", 1000.0f / ((64.0f*MBps) / (4096.0f*2160.0f)));
    printf("\n");

 	close( fileDescriptor );

 	return 0;
}
