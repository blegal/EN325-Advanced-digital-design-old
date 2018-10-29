cmake_minimum_required(VERSION 2.8)
project(JPEG_4_HLS)

SET (CMAKE_CXX_STANDARD 14)
SET (CMAKE_CXX_FLAGS "")
SET (CMAKE_CXX_FLAGS "${CMAKE_CXX_FLAGS} -W -Wall -Wno-overloaded-virtual -I/usr/local/systemc-2.3.2/include")
SET (CMAKE_CXX_FLAGS "${CMAKE_CXX_FLAGS} -I/opt/local/include")
SET (CMAKE_CXX_FLAGS "${CMAKE_CXX_FLAGS} -Ofast -std=c++11 -march=native -mtune=native")
SET (CMAKE_CXX_FLAGS "${CMAKE_CXX_FLAGS} -D_SIMULATION_ -Wno-unknown-pragmas -Wno-unused-parameter")
SET (CMAKE_EXE_LINKER_FLAGS "")
SET (CMAKE_EXE_LINKER_FLAGS "${CMAKE_EXE_LINKER_FLAGS} -L/usr/local/systemc-2.3.2/lib-linux64 -lsystemc")
#SET (CMAKE_EXE_LINKER_FLAGS "${CMAKE_EXE_LINKER_FLAGS} -L/opt/local/lib -lopencv_stitching -lopencv_superres -lopencv_videostab -lopencv_highgui -lopencv_videoio -lopencv_imgcodecs -lopencv_photo -lopencv_imgproc -lopencv_core")
# pkg-config --cflags --libs opencv
SET (SOURCE_FILES 
        ./src/DataSource/DataSource.cpp
        ./src/Image/CBitmap.cpp
        ./src/Image/CImage.cpp
        ./src/Image/CLigne.cpp
        ./src/Image/CPixel.cpp
        ./src/DataSink/DataSink.cpp
        ./src/Encoder/HardEncoder.cpp
        ./src/main.cpp)

add_executable(JPEG_processing ${SOURCE_FILES})
