# CMAKE generated file: DO NOT EDIT!
# Generated by "Unix Makefiles" Generator, CMake Version 2.8

#=============================================================================
# Special targets provided by cmake.

# Disable implicit rules so canonical targets will work.
.SUFFIXES:

# Remove some rules from gmake that .SUFFIXES does not remove.
SUFFIXES =

.SUFFIXES: .hpux_make_needs_suffix_list

# Suppress display of executed commands.
$(VERBOSE).SILENT:

# A target that is always out of date.
cmake_force:
.PHONY : cmake_force

#=============================================================================
# Set environment variables for the build.

# The shell in which to execute make rules.
SHELL = /bin/sh

# The CMake executable.
CMAKE_COMMAND = /usr/bin/cmake

# The command to remove a file.
RM = /usr/bin/cmake -E remove -f

# Escaping for special characters.
EQUALS = =

# The program to use to edit the cache.
CMAKE_EDIT_COMMAND = /usr/bin/ccmake

# The top-level source directory on which CMake was run.
CMAKE_SOURCE_DIR = /run/media/legal/BEE6-A08E/EN325-Advanced-digital-design/8_ALL_SYSTEM/4_Verification

# The top-level build directory on which CMake was run.
CMAKE_BINARY_DIR = /run/media/legal/BEE6-A08E/EN325-Advanced-digital-design/8_ALL_SYSTEM/4_Verification/build

# Include any dependencies generated for this target.
include CMakeFiles/JPEG_processing.dir/depend.make

# Include the progress variables for this target.
include CMakeFiles/JPEG_processing.dir/progress.make

# Include the compile flags for this target's objects.
include CMakeFiles/JPEG_processing.dir/flags.make

CMakeFiles/JPEG_processing.dir/src/DataSource/DataSource.cpp.o: CMakeFiles/JPEG_processing.dir/flags.make
CMakeFiles/JPEG_processing.dir/src/DataSource/DataSource.cpp.o: ../src/DataSource/DataSource.cpp
	$(CMAKE_COMMAND) -E cmake_progress_report /run/media/legal/BEE6-A08E/EN325-Advanced-digital-design/8_ALL_SYSTEM/4_Verification/build/CMakeFiles $(CMAKE_PROGRESS_1)
	@$(CMAKE_COMMAND) -E cmake_echo_color --switch=$(COLOR) --green "Building CXX object CMakeFiles/JPEG_processing.dir/src/DataSource/DataSource.cpp.o"
	/bin/c++   $(CXX_DEFINES) $(CXX_FLAGS) -o CMakeFiles/JPEG_processing.dir/src/DataSource/DataSource.cpp.o -c /run/media/legal/BEE6-A08E/EN325-Advanced-digital-design/8_ALL_SYSTEM/4_Verification/src/DataSource/DataSource.cpp

CMakeFiles/JPEG_processing.dir/src/DataSource/DataSource.cpp.i: cmake_force
	@$(CMAKE_COMMAND) -E cmake_echo_color --switch=$(COLOR) --green "Preprocessing CXX source to CMakeFiles/JPEG_processing.dir/src/DataSource/DataSource.cpp.i"
	/bin/c++  $(CXX_DEFINES) $(CXX_FLAGS) -E /run/media/legal/BEE6-A08E/EN325-Advanced-digital-design/8_ALL_SYSTEM/4_Verification/src/DataSource/DataSource.cpp > CMakeFiles/JPEG_processing.dir/src/DataSource/DataSource.cpp.i

CMakeFiles/JPEG_processing.dir/src/DataSource/DataSource.cpp.s: cmake_force
	@$(CMAKE_COMMAND) -E cmake_echo_color --switch=$(COLOR) --green "Compiling CXX source to assembly CMakeFiles/JPEG_processing.dir/src/DataSource/DataSource.cpp.s"
	/bin/c++  $(CXX_DEFINES) $(CXX_FLAGS) -S /run/media/legal/BEE6-A08E/EN325-Advanced-digital-design/8_ALL_SYSTEM/4_Verification/src/DataSource/DataSource.cpp -o CMakeFiles/JPEG_processing.dir/src/DataSource/DataSource.cpp.s

CMakeFiles/JPEG_processing.dir/src/DataSource/DataSource.cpp.o.requires:
.PHONY : CMakeFiles/JPEG_processing.dir/src/DataSource/DataSource.cpp.o.requires

CMakeFiles/JPEG_processing.dir/src/DataSource/DataSource.cpp.o.provides: CMakeFiles/JPEG_processing.dir/src/DataSource/DataSource.cpp.o.requires
	$(MAKE) -f CMakeFiles/JPEG_processing.dir/build.make CMakeFiles/JPEG_processing.dir/src/DataSource/DataSource.cpp.o.provides.build
.PHONY : CMakeFiles/JPEG_processing.dir/src/DataSource/DataSource.cpp.o.provides

CMakeFiles/JPEG_processing.dir/src/DataSource/DataSource.cpp.o.provides.build: CMakeFiles/JPEG_processing.dir/src/DataSource/DataSource.cpp.o

CMakeFiles/JPEG_processing.dir/src/DataSink/DataSink.cpp.o: CMakeFiles/JPEG_processing.dir/flags.make
CMakeFiles/JPEG_processing.dir/src/DataSink/DataSink.cpp.o: ../src/DataSink/DataSink.cpp
	$(CMAKE_COMMAND) -E cmake_progress_report /run/media/legal/BEE6-A08E/EN325-Advanced-digital-design/8_ALL_SYSTEM/4_Verification/build/CMakeFiles $(CMAKE_PROGRESS_2)
	@$(CMAKE_COMMAND) -E cmake_echo_color --switch=$(COLOR) --green "Building CXX object CMakeFiles/JPEG_processing.dir/src/DataSink/DataSink.cpp.o"
	/bin/c++   $(CXX_DEFINES) $(CXX_FLAGS) -o CMakeFiles/JPEG_processing.dir/src/DataSink/DataSink.cpp.o -c /run/media/legal/BEE6-A08E/EN325-Advanced-digital-design/8_ALL_SYSTEM/4_Verification/src/DataSink/DataSink.cpp

CMakeFiles/JPEG_processing.dir/src/DataSink/DataSink.cpp.i: cmake_force
	@$(CMAKE_COMMAND) -E cmake_echo_color --switch=$(COLOR) --green "Preprocessing CXX source to CMakeFiles/JPEG_processing.dir/src/DataSink/DataSink.cpp.i"
	/bin/c++  $(CXX_DEFINES) $(CXX_FLAGS) -E /run/media/legal/BEE6-A08E/EN325-Advanced-digital-design/8_ALL_SYSTEM/4_Verification/src/DataSink/DataSink.cpp > CMakeFiles/JPEG_processing.dir/src/DataSink/DataSink.cpp.i

CMakeFiles/JPEG_processing.dir/src/DataSink/DataSink.cpp.s: cmake_force
	@$(CMAKE_COMMAND) -E cmake_echo_color --switch=$(COLOR) --green "Compiling CXX source to assembly CMakeFiles/JPEG_processing.dir/src/DataSink/DataSink.cpp.s"
	/bin/c++  $(CXX_DEFINES) $(CXX_FLAGS) -S /run/media/legal/BEE6-A08E/EN325-Advanced-digital-design/8_ALL_SYSTEM/4_Verification/src/DataSink/DataSink.cpp -o CMakeFiles/JPEG_processing.dir/src/DataSink/DataSink.cpp.s

CMakeFiles/JPEG_processing.dir/src/DataSink/DataSink.cpp.o.requires:
.PHONY : CMakeFiles/JPEG_processing.dir/src/DataSink/DataSink.cpp.o.requires

CMakeFiles/JPEG_processing.dir/src/DataSink/DataSink.cpp.o.provides: CMakeFiles/JPEG_processing.dir/src/DataSink/DataSink.cpp.o.requires
	$(MAKE) -f CMakeFiles/JPEG_processing.dir/build.make CMakeFiles/JPEG_processing.dir/src/DataSink/DataSink.cpp.o.provides.build
.PHONY : CMakeFiles/JPEG_processing.dir/src/DataSink/DataSink.cpp.o.provides

CMakeFiles/JPEG_processing.dir/src/DataSink/DataSink.cpp.o.provides.build: CMakeFiles/JPEG_processing.dir/src/DataSink/DataSink.cpp.o

CMakeFiles/JPEG_processing.dir/src/Encoder/HardEncoder.cpp.o: CMakeFiles/JPEG_processing.dir/flags.make
CMakeFiles/JPEG_processing.dir/src/Encoder/HardEncoder.cpp.o: ../src/Encoder/HardEncoder.cpp
	$(CMAKE_COMMAND) -E cmake_progress_report /run/media/legal/BEE6-A08E/EN325-Advanced-digital-design/8_ALL_SYSTEM/4_Verification/build/CMakeFiles $(CMAKE_PROGRESS_3)
	@$(CMAKE_COMMAND) -E cmake_echo_color --switch=$(COLOR) --green "Building CXX object CMakeFiles/JPEG_processing.dir/src/Encoder/HardEncoder.cpp.o"
	/bin/c++   $(CXX_DEFINES) $(CXX_FLAGS) -o CMakeFiles/JPEG_processing.dir/src/Encoder/HardEncoder.cpp.o -c /run/media/legal/BEE6-A08E/EN325-Advanced-digital-design/8_ALL_SYSTEM/4_Verification/src/Encoder/HardEncoder.cpp

CMakeFiles/JPEG_processing.dir/src/Encoder/HardEncoder.cpp.i: cmake_force
	@$(CMAKE_COMMAND) -E cmake_echo_color --switch=$(COLOR) --green "Preprocessing CXX source to CMakeFiles/JPEG_processing.dir/src/Encoder/HardEncoder.cpp.i"
	/bin/c++  $(CXX_DEFINES) $(CXX_FLAGS) -E /run/media/legal/BEE6-A08E/EN325-Advanced-digital-design/8_ALL_SYSTEM/4_Verification/src/Encoder/HardEncoder.cpp > CMakeFiles/JPEG_processing.dir/src/Encoder/HardEncoder.cpp.i

CMakeFiles/JPEG_processing.dir/src/Encoder/HardEncoder.cpp.s: cmake_force
	@$(CMAKE_COMMAND) -E cmake_echo_color --switch=$(COLOR) --green "Compiling CXX source to assembly CMakeFiles/JPEG_processing.dir/src/Encoder/HardEncoder.cpp.s"
	/bin/c++  $(CXX_DEFINES) $(CXX_FLAGS) -S /run/media/legal/BEE6-A08E/EN325-Advanced-digital-design/8_ALL_SYSTEM/4_Verification/src/Encoder/HardEncoder.cpp -o CMakeFiles/JPEG_processing.dir/src/Encoder/HardEncoder.cpp.s

CMakeFiles/JPEG_processing.dir/src/Encoder/HardEncoder.cpp.o.requires:
.PHONY : CMakeFiles/JPEG_processing.dir/src/Encoder/HardEncoder.cpp.o.requires

CMakeFiles/JPEG_processing.dir/src/Encoder/HardEncoder.cpp.o.provides: CMakeFiles/JPEG_processing.dir/src/Encoder/HardEncoder.cpp.o.requires
	$(MAKE) -f CMakeFiles/JPEG_processing.dir/build.make CMakeFiles/JPEG_processing.dir/src/Encoder/HardEncoder.cpp.o.provides.build
.PHONY : CMakeFiles/JPEG_processing.dir/src/Encoder/HardEncoder.cpp.o.provides

CMakeFiles/JPEG_processing.dir/src/Encoder/HardEncoder.cpp.o.provides.build: CMakeFiles/JPEG_processing.dir/src/Encoder/HardEncoder.cpp.o

CMakeFiles/JPEG_processing.dir/src/main.cpp.o: CMakeFiles/JPEG_processing.dir/flags.make
CMakeFiles/JPEG_processing.dir/src/main.cpp.o: ../src/main.cpp
	$(CMAKE_COMMAND) -E cmake_progress_report /run/media/legal/BEE6-A08E/EN325-Advanced-digital-design/8_ALL_SYSTEM/4_Verification/build/CMakeFiles $(CMAKE_PROGRESS_4)
	@$(CMAKE_COMMAND) -E cmake_echo_color --switch=$(COLOR) --green "Building CXX object CMakeFiles/JPEG_processing.dir/src/main.cpp.o"
	/bin/c++   $(CXX_DEFINES) $(CXX_FLAGS) -o CMakeFiles/JPEG_processing.dir/src/main.cpp.o -c /run/media/legal/BEE6-A08E/EN325-Advanced-digital-design/8_ALL_SYSTEM/4_Verification/src/main.cpp

CMakeFiles/JPEG_processing.dir/src/main.cpp.i: cmake_force
	@$(CMAKE_COMMAND) -E cmake_echo_color --switch=$(COLOR) --green "Preprocessing CXX source to CMakeFiles/JPEG_processing.dir/src/main.cpp.i"
	/bin/c++  $(CXX_DEFINES) $(CXX_FLAGS) -E /run/media/legal/BEE6-A08E/EN325-Advanced-digital-design/8_ALL_SYSTEM/4_Verification/src/main.cpp > CMakeFiles/JPEG_processing.dir/src/main.cpp.i

CMakeFiles/JPEG_processing.dir/src/main.cpp.s: cmake_force
	@$(CMAKE_COMMAND) -E cmake_echo_color --switch=$(COLOR) --green "Compiling CXX source to assembly CMakeFiles/JPEG_processing.dir/src/main.cpp.s"
	/bin/c++  $(CXX_DEFINES) $(CXX_FLAGS) -S /run/media/legal/BEE6-A08E/EN325-Advanced-digital-design/8_ALL_SYSTEM/4_Verification/src/main.cpp -o CMakeFiles/JPEG_processing.dir/src/main.cpp.s

CMakeFiles/JPEG_processing.dir/src/main.cpp.o.requires:
.PHONY : CMakeFiles/JPEG_processing.dir/src/main.cpp.o.requires

CMakeFiles/JPEG_processing.dir/src/main.cpp.o.provides: CMakeFiles/JPEG_processing.dir/src/main.cpp.o.requires
	$(MAKE) -f CMakeFiles/JPEG_processing.dir/build.make CMakeFiles/JPEG_processing.dir/src/main.cpp.o.provides.build
.PHONY : CMakeFiles/JPEG_processing.dir/src/main.cpp.o.provides

CMakeFiles/JPEG_processing.dir/src/main.cpp.o.provides.build: CMakeFiles/JPEG_processing.dir/src/main.cpp.o

# Object files for target JPEG_processing
JPEG_processing_OBJECTS = \
"CMakeFiles/JPEG_processing.dir/src/DataSource/DataSource.cpp.o" \
"CMakeFiles/JPEG_processing.dir/src/DataSink/DataSink.cpp.o" \
"CMakeFiles/JPEG_processing.dir/src/Encoder/HardEncoder.cpp.o" \
"CMakeFiles/JPEG_processing.dir/src/main.cpp.o"

# External object files for target JPEG_processing
JPEG_processing_EXTERNAL_OBJECTS =

JPEG_processing: CMakeFiles/JPEG_processing.dir/src/DataSource/DataSource.cpp.o
JPEG_processing: CMakeFiles/JPEG_processing.dir/src/DataSink/DataSink.cpp.o
JPEG_processing: CMakeFiles/JPEG_processing.dir/src/Encoder/HardEncoder.cpp.o
JPEG_processing: CMakeFiles/JPEG_processing.dir/src/main.cpp.o
JPEG_processing: CMakeFiles/JPEG_processing.dir/build.make
JPEG_processing: CMakeFiles/JPEG_processing.dir/link.txt
	@$(CMAKE_COMMAND) -E cmake_echo_color --switch=$(COLOR) --red --bold "Linking CXX executable JPEG_processing"
	$(CMAKE_COMMAND) -E cmake_link_script CMakeFiles/JPEG_processing.dir/link.txt --verbose=$(VERBOSE)

# Rule to build all files generated by this target.
CMakeFiles/JPEG_processing.dir/build: JPEG_processing
.PHONY : CMakeFiles/JPEG_processing.dir/build

CMakeFiles/JPEG_processing.dir/requires: CMakeFiles/JPEG_processing.dir/src/DataSource/DataSource.cpp.o.requires
CMakeFiles/JPEG_processing.dir/requires: CMakeFiles/JPEG_processing.dir/src/DataSink/DataSink.cpp.o.requires
CMakeFiles/JPEG_processing.dir/requires: CMakeFiles/JPEG_processing.dir/src/Encoder/HardEncoder.cpp.o.requires
CMakeFiles/JPEG_processing.dir/requires: CMakeFiles/JPEG_processing.dir/src/main.cpp.o.requires
.PHONY : CMakeFiles/JPEG_processing.dir/requires

CMakeFiles/JPEG_processing.dir/clean:
	$(CMAKE_COMMAND) -P CMakeFiles/JPEG_processing.dir/cmake_clean.cmake
.PHONY : CMakeFiles/JPEG_processing.dir/clean

CMakeFiles/JPEG_processing.dir/depend:
	cd /run/media/legal/BEE6-A08E/EN325-Advanced-digital-design/8_ALL_SYSTEM/4_Verification/build && $(CMAKE_COMMAND) -E cmake_depends "Unix Makefiles" /run/media/legal/BEE6-A08E/EN325-Advanced-digital-design/8_ALL_SYSTEM/4_Verification /run/media/legal/BEE6-A08E/EN325-Advanced-digital-design/8_ALL_SYSTEM/4_Verification /run/media/legal/BEE6-A08E/EN325-Advanced-digital-design/8_ALL_SYSTEM/4_Verification/build /run/media/legal/BEE6-A08E/EN325-Advanced-digital-design/8_ALL_SYSTEM/4_Verification/build /run/media/legal/BEE6-A08E/EN325-Advanced-digital-design/8_ALL_SYSTEM/4_Verification/build/CMakeFiles/JPEG_processing.dir/DependInfo.cmake --color=$(COLOR)
.PHONY : CMakeFiles/JPEG_processing.dir/depend

