# CMAKE generated file: DO NOT EDIT!
# Generated by "Unix Makefiles" Generator, CMake Version 3.5

# Delete rule output on recipe failure.
.DELETE_ON_ERROR:


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

# The top-level source directory on which CMake was run.
CMAKE_SOURCE_DIR = /user/eleves/gkregulan2017/projects/lab1_CV

# The top-level build directory on which CMake was run.
CMAKE_BINARY_DIR = /user/eleves/gkregulan2017/projects/lab1_CV-build

# Include any dependencies generated for this target.
include CMakeFiles/record.dir/depend.make

# Include the progress variables for this target.
include CMakeFiles/record.dir/progress.make

# Include the compile flags for this target's objects.
include CMakeFiles/record.dir/flags.make

CMakeFiles/record.dir/main/record.cpp.o: CMakeFiles/record.dir/flags.make
CMakeFiles/record.dir/main/record.cpp.o: /user/eleves/gkregulan2017/projects/lab1_CV/main/record.cpp
	@$(CMAKE_COMMAND) -E cmake_echo_color --switch=$(COLOR) --green --progress-dir=/user/eleves/gkregulan2017/projects/lab1_CV-build/CMakeFiles --progress-num=$(CMAKE_PROGRESS_1) "Building CXX object CMakeFiles/record.dir/main/record.cpp.o"
	/usr/bin/c++   $(CXX_DEFINES) $(CXX_INCLUDES) $(CXX_FLAGS) -o CMakeFiles/record.dir/main/record.cpp.o -c /user/eleves/gkregulan2017/projects/lab1_CV/main/record.cpp

CMakeFiles/record.dir/main/record.cpp.i: cmake_force
	@$(CMAKE_COMMAND) -E cmake_echo_color --switch=$(COLOR) --green "Preprocessing CXX source to CMakeFiles/record.dir/main/record.cpp.i"
	/usr/bin/c++  $(CXX_DEFINES) $(CXX_INCLUDES) $(CXX_FLAGS) -E /user/eleves/gkregulan2017/projects/lab1_CV/main/record.cpp > CMakeFiles/record.dir/main/record.cpp.i

CMakeFiles/record.dir/main/record.cpp.s: cmake_force
	@$(CMAKE_COMMAND) -E cmake_echo_color --switch=$(COLOR) --green "Compiling CXX source to assembly CMakeFiles/record.dir/main/record.cpp.s"
	/usr/bin/c++  $(CXX_DEFINES) $(CXX_INCLUDES) $(CXX_FLAGS) -S /user/eleves/gkregulan2017/projects/lab1_CV/main/record.cpp -o CMakeFiles/record.dir/main/record.cpp.s

CMakeFiles/record.dir/main/record.cpp.o.requires:

.PHONY : CMakeFiles/record.dir/main/record.cpp.o.requires

CMakeFiles/record.dir/main/record.cpp.o.provides: CMakeFiles/record.dir/main/record.cpp.o.requires
	$(MAKE) -f CMakeFiles/record.dir/build.make CMakeFiles/record.dir/main/record.cpp.o.provides.build
.PHONY : CMakeFiles/record.dir/main/record.cpp.o.provides

CMakeFiles/record.dir/main/record.cpp.o.provides.build: CMakeFiles/record.dir/main/record.cpp.o


# Object files for target record
record_OBJECTS = \
"CMakeFiles/record.dir/main/record.cpp.o"

# External object files for target record
record_EXTERNAL_OBJECTS =

record: CMakeFiles/record.dir/main/record.cpp.o
record: CMakeFiles/record.dir/build.make
record: /opt/ros/kinetic/lib/x86_64-linux-gnu/libvisp_vs.so.3.0.1
record: /opt/ros/kinetic/lib/x86_64-linux-gnu/libvisp_tt_mi.so.3.0.1
record: /opt/ros/kinetic/lib/x86_64-linux-gnu/libvisp_tt.so.3.0.1
record: /opt/ros/kinetic/lib/x86_64-linux-gnu/libvisp_mbt.so.3.0.1
record: /opt/ros/kinetic/lib/x86_64-linux-gnu/libvisp_klt.so.3.0.1
record: /opt/ros/kinetic/lib/x86_64-linux-gnu/libvisp_robot.so.3.0.1
record: /opt/ros/kinetic/lib/x86_64-linux-gnu/libvisp_gui.so.3.0.1
record: /opt/ros/kinetic/lib/x86_64-linux-gnu/libvisp_detection.so.3.0.1
record: /opt/ros/kinetic/lib/x86_64-linux-gnu/libvisp_ar.so.3.0.1
record: /opt/ros/kinetic/lib/x86_64-linux-gnu/libvisp_sensor.so.3.0.1
record: /usr/lib/x86_64-linux-gnu/libv4l2.so
record: /usr/lib/x86_64-linux-gnu/libv4lconvert.so
record: /usr/lib/x86_64-linux-gnu/libdc1394.so
record: /usr/lib/x86_64-linux-gnu/libfreenect.so
record: /usr/lib/x86_64-linux-gnu/libusb-1.0.so
record: /opt/ros/kinetic/lib/x86_64-linux-gnu/libvisp_vision.so.3.0.1
record: /opt/ros/kinetic/lib/x86_64-linux-gnu/libvisp_visual_features.so.3.0.1
record: /opt/ros/kinetic/lib/x86_64-linux-gnu/libvisp_me.so.3.0.1
record: /opt/ros/kinetic/lib/x86_64-linux-gnu/libvisp_blob.so.3.0.1
record: /usr/lib/x86_64-linux-gnu/libSM.so
record: /usr/lib/x86_64-linux-gnu/libICE.so
record: /usr/lib/x86_64-linux-gnu/libX11.so
record: /usr/lib/x86_64-linux-gnu/libXext.so
record: /opt/ros/kinetic/lib/x86_64-linux-gnu/libvisp_io.so.3.0.1
record: /usr/lib/x86_64-linux-gnu/libjpeg.so
record: /usr/lib/x86_64-linux-gnu/libpng.so
record: /usr/lib/x86_64-linux-gnu/libboost_thread.so
record: /usr/lib/x86_64-linux-gnu/libboost_system.so
record: /usr/lib/x86_64-linux-gnu/libboost_date_time.so
record: /usr/lib/x86_64-linux-gnu/libboost_chrono.so
record: /usr/lib/x86_64-linux-gnu/libboost_atomic.so
record: /usr/lib/x86_64-linux-gnu/libOgreMain.so
record: /usr/lib/x86_64-linux-gnu/libboost_thread.so
record: /usr/lib/x86_64-linux-gnu/libboost_system.so
record: /usr/lib/x86_64-linux-gnu/libboost_date_time.so
record: /usr/lib/x86_64-linux-gnu/libboost_chrono.so
record: /usr/lib/x86_64-linux-gnu/libboost_atomic.so
record: /usr/lib/x86_64-linux-gnu/libOgreMain.so
record: /usr/lib/x86_64-linux-gnu/libOIS.so
record: /usr/lib/x86_64-linux-gnu/libGLU.so
record: /usr/lib/x86_64-linux-gnu/libGL.so
record: /usr/lib/x86_64-linux-gnu/libCoin.so
record: /opt/ros/kinetic/lib/x86_64-linux-gnu/libvisp_core.so.3.0.1
record: /opt/ros/kinetic/lib/libopencv_calib3d3.so.3.2.0
record: /opt/ros/kinetic/lib/libopencv_core3.so.3.2.0
record: /opt/ros/kinetic/lib/libopencv_features2d3.so.3.2.0
record: /opt/ros/kinetic/lib/libopencv_flann3.so.3.2.0
record: /opt/ros/kinetic/lib/libopencv_highgui3.so.3.2.0
record: /opt/ros/kinetic/lib/libopencv_imgcodecs3.so.3.2.0
record: /opt/ros/kinetic/lib/libopencv_imgproc3.so.3.2.0
record: /opt/ros/kinetic/lib/libopencv_ml3.so.3.2.0
record: /opt/ros/kinetic/lib/libopencv_objdetect3.so.3.2.0
record: /opt/ros/kinetic/lib/libopencv_photo3.so.3.2.0
record: /opt/ros/kinetic/lib/libopencv_shape3.so.3.2.0
record: /opt/ros/kinetic/lib/libopencv_stitching3.so.3.2.0
record: /opt/ros/kinetic/lib/libopencv_superres3.so.3.2.0
record: /opt/ros/kinetic/lib/libopencv_video3.so.3.2.0
record: /opt/ros/kinetic/lib/libopencv_videoio3.so.3.2.0
record: /opt/ros/kinetic/lib/libopencv_videostab3.so.3.2.0
record: /opt/ros/kinetic/lib/libopencv_viz3.so.3.2.0
record: /opt/ros/kinetic/lib/libopencv_aruco3.so.3.2.0
record: /opt/ros/kinetic/lib/libopencv_bgsegm3.so.3.2.0
record: /opt/ros/kinetic/lib/libopencv_bioinspired3.so.3.2.0
record: /opt/ros/kinetic/lib/libopencv_ccalib3.so.3.2.0
record: /opt/ros/kinetic/lib/libopencv_cvv3.so.3.2.0
record: /opt/ros/kinetic/lib/libopencv_datasets3.so.3.2.0
record: /opt/ros/kinetic/lib/libopencv_dpm3.so.3.2.0
record: /opt/ros/kinetic/lib/libopencv_face3.so.3.2.0
record: /opt/ros/kinetic/lib/libopencv_fuzzy3.so.3.2.0
record: /opt/ros/kinetic/lib/libopencv_hdf3.so.3.2.0
record: /opt/ros/kinetic/lib/libopencv_line_descriptor3.so.3.2.0
record: /opt/ros/kinetic/lib/libopencv_optflow3.so.3.2.0
record: /opt/ros/kinetic/lib/libopencv_phase_unwrapping3.so.3.2.0
record: /opt/ros/kinetic/lib/libopencv_plot3.so.3.2.0
record: /opt/ros/kinetic/lib/libopencv_reg3.so.3.2.0
record: /opt/ros/kinetic/lib/libopencv_rgbd3.so.3.2.0
record: /opt/ros/kinetic/lib/libopencv_saliency3.so.3.2.0
record: /opt/ros/kinetic/lib/libopencv_stereo3.so.3.2.0
record: /opt/ros/kinetic/lib/libopencv_structured_light3.so.3.2.0
record: /opt/ros/kinetic/lib/libopencv_surface_matching3.so.3.2.0
record: /opt/ros/kinetic/lib/libopencv_text3.so.3.2.0
record: /opt/ros/kinetic/lib/libopencv_xfeatures2d3.so.3.2.0
record: /opt/ros/kinetic/lib/libopencv_ximgproc3.so.3.2.0
record: /opt/ros/kinetic/lib/libopencv_xobjdetect3.so.3.2.0
record: /opt/ros/kinetic/lib/libopencv_xphoto3.so.3.2.0
record: /usr/lib/liblapack.so
record: /usr/lib/libblas.so
record: /usr/lib/x86_64-linux-gnu/libxml2.so
record: /usr/lib/x86_64-linux-gnu/libz.so
record: /usr/lib/x86_64-linux-gnu/libpthread.so
record: /usr/lib/x86_64-linux-gnu/libzbar.so
record: /usr/lib/x86_64-linux-gnu/libdmtx.so
record: /usr/lib/x86_64-linux-gnu/libm.so
record: /usr/lib/x86_64-linux-gnu/libnsl.so
record: CMakeFiles/record.dir/link.txt
	@$(CMAKE_COMMAND) -E cmake_echo_color --switch=$(COLOR) --green --bold --progress-dir=/user/eleves/gkregulan2017/projects/lab1_CV-build/CMakeFiles --progress-num=$(CMAKE_PROGRESS_2) "Linking CXX executable record"
	$(CMAKE_COMMAND) -E cmake_link_script CMakeFiles/record.dir/link.txt --verbose=$(VERBOSE)

# Rule to build all files generated by this target.
CMakeFiles/record.dir/build: record

.PHONY : CMakeFiles/record.dir/build

CMakeFiles/record.dir/requires: CMakeFiles/record.dir/main/record.cpp.o.requires

.PHONY : CMakeFiles/record.dir/requires

CMakeFiles/record.dir/clean:
	$(CMAKE_COMMAND) -P CMakeFiles/record.dir/cmake_clean.cmake
.PHONY : CMakeFiles/record.dir/clean

CMakeFiles/record.dir/depend:
	cd /user/eleves/gkregulan2017/projects/lab1_CV-build && $(CMAKE_COMMAND) -E cmake_depends "Unix Makefiles" /user/eleves/gkregulan2017/projects/lab1_CV /user/eleves/gkregulan2017/projects/lab1_CV /user/eleves/gkregulan2017/projects/lab1_CV-build /user/eleves/gkregulan2017/projects/lab1_CV-build /user/eleves/gkregulan2017/projects/lab1_CV-build/CMakeFiles/record.dir/DependInfo.cmake --color=$(COLOR)
.PHONY : CMakeFiles/record.dir/depend

