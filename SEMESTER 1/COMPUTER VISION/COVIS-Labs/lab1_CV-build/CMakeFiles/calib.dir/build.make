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
include CMakeFiles/calib.dir/depend.make

# Include the progress variables for this target.
include CMakeFiles/calib.dir/progress.make

# Include the compile flags for this target's objects.
include CMakeFiles/calib.dir/flags.make

CMakeFiles/calib.dir/src/grid_tracker.cpp.o: CMakeFiles/calib.dir/flags.make
CMakeFiles/calib.dir/src/grid_tracker.cpp.o: /user/eleves/gkregulan2017/projects/lab1_CV/src/grid_tracker.cpp
	@$(CMAKE_COMMAND) -E cmake_echo_color --switch=$(COLOR) --green --progress-dir=/user/eleves/gkregulan2017/projects/lab1_CV-build/CMakeFiles --progress-num=$(CMAKE_PROGRESS_1) "Building CXX object CMakeFiles/calib.dir/src/grid_tracker.cpp.o"
	/usr/bin/c++   $(CXX_DEFINES) $(CXX_INCLUDES) $(CXX_FLAGS) -o CMakeFiles/calib.dir/src/grid_tracker.cpp.o -c /user/eleves/gkregulan2017/projects/lab1_CV/src/grid_tracker.cpp

CMakeFiles/calib.dir/src/grid_tracker.cpp.i: cmake_force
	@$(CMAKE_COMMAND) -E cmake_echo_color --switch=$(COLOR) --green "Preprocessing CXX source to CMakeFiles/calib.dir/src/grid_tracker.cpp.i"
	/usr/bin/c++  $(CXX_DEFINES) $(CXX_INCLUDES) $(CXX_FLAGS) -E /user/eleves/gkregulan2017/projects/lab1_CV/src/grid_tracker.cpp > CMakeFiles/calib.dir/src/grid_tracker.cpp.i

CMakeFiles/calib.dir/src/grid_tracker.cpp.s: cmake_force
	@$(CMAKE_COMMAND) -E cmake_echo_color --switch=$(COLOR) --green "Compiling CXX source to assembly CMakeFiles/calib.dir/src/grid_tracker.cpp.s"
	/usr/bin/c++  $(CXX_DEFINES) $(CXX_INCLUDES) $(CXX_FLAGS) -S /user/eleves/gkregulan2017/projects/lab1_CV/src/grid_tracker.cpp -o CMakeFiles/calib.dir/src/grid_tracker.cpp.s

CMakeFiles/calib.dir/src/grid_tracker.cpp.o.requires:

.PHONY : CMakeFiles/calib.dir/src/grid_tracker.cpp.o.requires

CMakeFiles/calib.dir/src/grid_tracker.cpp.o.provides: CMakeFiles/calib.dir/src/grid_tracker.cpp.o.requires
	$(MAKE) -f CMakeFiles/calib.dir/build.make CMakeFiles/calib.dir/src/grid_tracker.cpp.o.provides.build
.PHONY : CMakeFiles/calib.dir/src/grid_tracker.cpp.o.provides

CMakeFiles/calib.dir/src/grid_tracker.cpp.o.provides.build: CMakeFiles/calib.dir/src/grid_tracker.cpp.o


CMakeFiles/calib.dir/src/cb_tracker.cpp.o: CMakeFiles/calib.dir/flags.make
CMakeFiles/calib.dir/src/cb_tracker.cpp.o: /user/eleves/gkregulan2017/projects/lab1_CV/src/cb_tracker.cpp
	@$(CMAKE_COMMAND) -E cmake_echo_color --switch=$(COLOR) --green --progress-dir=/user/eleves/gkregulan2017/projects/lab1_CV-build/CMakeFiles --progress-num=$(CMAKE_PROGRESS_2) "Building CXX object CMakeFiles/calib.dir/src/cb_tracker.cpp.o"
	/usr/bin/c++   $(CXX_DEFINES) $(CXX_INCLUDES) $(CXX_FLAGS) -o CMakeFiles/calib.dir/src/cb_tracker.cpp.o -c /user/eleves/gkregulan2017/projects/lab1_CV/src/cb_tracker.cpp

CMakeFiles/calib.dir/src/cb_tracker.cpp.i: cmake_force
	@$(CMAKE_COMMAND) -E cmake_echo_color --switch=$(COLOR) --green "Preprocessing CXX source to CMakeFiles/calib.dir/src/cb_tracker.cpp.i"
	/usr/bin/c++  $(CXX_DEFINES) $(CXX_INCLUDES) $(CXX_FLAGS) -E /user/eleves/gkregulan2017/projects/lab1_CV/src/cb_tracker.cpp > CMakeFiles/calib.dir/src/cb_tracker.cpp.i

CMakeFiles/calib.dir/src/cb_tracker.cpp.s: cmake_force
	@$(CMAKE_COMMAND) -E cmake_echo_color --switch=$(COLOR) --green "Compiling CXX source to assembly CMakeFiles/calib.dir/src/cb_tracker.cpp.s"
	/usr/bin/c++  $(CXX_DEFINES) $(CXX_INCLUDES) $(CXX_FLAGS) -S /user/eleves/gkregulan2017/projects/lab1_CV/src/cb_tracker.cpp -o CMakeFiles/calib.dir/src/cb_tracker.cpp.s

CMakeFiles/calib.dir/src/cb_tracker.cpp.o.requires:

.PHONY : CMakeFiles/calib.dir/src/cb_tracker.cpp.o.requires

CMakeFiles/calib.dir/src/cb_tracker.cpp.o.provides: CMakeFiles/calib.dir/src/cb_tracker.cpp.o.requires
	$(MAKE) -f CMakeFiles/calib.dir/build.make CMakeFiles/calib.dir/src/cb_tracker.cpp.o.provides.build
.PHONY : CMakeFiles/calib.dir/src/cb_tracker.cpp.o.provides

CMakeFiles/calib.dir/src/cb_tracker.cpp.o.provides.build: CMakeFiles/calib.dir/src/cb_tracker.cpp.o


CMakeFiles/calib.dir/src/vvs.cpp.o: CMakeFiles/calib.dir/flags.make
CMakeFiles/calib.dir/src/vvs.cpp.o: /user/eleves/gkregulan2017/projects/lab1_CV/src/vvs.cpp
	@$(CMAKE_COMMAND) -E cmake_echo_color --switch=$(COLOR) --green --progress-dir=/user/eleves/gkregulan2017/projects/lab1_CV-build/CMakeFiles --progress-num=$(CMAKE_PROGRESS_3) "Building CXX object CMakeFiles/calib.dir/src/vvs.cpp.o"
	/usr/bin/c++   $(CXX_DEFINES) $(CXX_INCLUDES) $(CXX_FLAGS) -o CMakeFiles/calib.dir/src/vvs.cpp.o -c /user/eleves/gkregulan2017/projects/lab1_CV/src/vvs.cpp

CMakeFiles/calib.dir/src/vvs.cpp.i: cmake_force
	@$(CMAKE_COMMAND) -E cmake_echo_color --switch=$(COLOR) --green "Preprocessing CXX source to CMakeFiles/calib.dir/src/vvs.cpp.i"
	/usr/bin/c++  $(CXX_DEFINES) $(CXX_INCLUDES) $(CXX_FLAGS) -E /user/eleves/gkregulan2017/projects/lab1_CV/src/vvs.cpp > CMakeFiles/calib.dir/src/vvs.cpp.i

CMakeFiles/calib.dir/src/vvs.cpp.s: cmake_force
	@$(CMAKE_COMMAND) -E cmake_echo_color --switch=$(COLOR) --green "Compiling CXX source to assembly CMakeFiles/calib.dir/src/vvs.cpp.s"
	/usr/bin/c++  $(CXX_DEFINES) $(CXX_INCLUDES) $(CXX_FLAGS) -S /user/eleves/gkregulan2017/projects/lab1_CV/src/vvs.cpp -o CMakeFiles/calib.dir/src/vvs.cpp.s

CMakeFiles/calib.dir/src/vvs.cpp.o.requires:

.PHONY : CMakeFiles/calib.dir/src/vvs.cpp.o.requires

CMakeFiles/calib.dir/src/vvs.cpp.o.provides: CMakeFiles/calib.dir/src/vvs.cpp.o.requires
	$(MAKE) -f CMakeFiles/calib.dir/build.make CMakeFiles/calib.dir/src/vvs.cpp.o.provides.build
.PHONY : CMakeFiles/calib.dir/src/vvs.cpp.o.provides

CMakeFiles/calib.dir/src/vvs.cpp.o.provides.build: CMakeFiles/calib.dir/src/vvs.cpp.o


# Object files for target calib
calib_OBJECTS = \
"CMakeFiles/calib.dir/src/grid_tracker.cpp.o" \
"CMakeFiles/calib.dir/src/cb_tracker.cpp.o" \
"CMakeFiles/calib.dir/src/vvs.cpp.o"

# External object files for target calib
calib_EXTERNAL_OBJECTS =

libcalib.so: CMakeFiles/calib.dir/src/grid_tracker.cpp.o
libcalib.so: CMakeFiles/calib.dir/src/cb_tracker.cpp.o
libcalib.so: CMakeFiles/calib.dir/src/vvs.cpp.o
libcalib.so: CMakeFiles/calib.dir/build.make
libcalib.so: /opt/ros/kinetic/lib/x86_64-linux-gnu/libvisp_vs.so.3.0.1
libcalib.so: /opt/ros/kinetic/lib/x86_64-linux-gnu/libvisp_tt_mi.so.3.0.1
libcalib.so: /opt/ros/kinetic/lib/x86_64-linux-gnu/libvisp_tt.so.3.0.1
libcalib.so: /opt/ros/kinetic/lib/x86_64-linux-gnu/libvisp_mbt.so.3.0.1
libcalib.so: /opt/ros/kinetic/lib/x86_64-linux-gnu/libvisp_klt.so.3.0.1
libcalib.so: /opt/ros/kinetic/lib/x86_64-linux-gnu/libvisp_robot.so.3.0.1
libcalib.so: /opt/ros/kinetic/lib/x86_64-linux-gnu/libvisp_gui.so.3.0.1
libcalib.so: /opt/ros/kinetic/lib/x86_64-linux-gnu/libvisp_detection.so.3.0.1
libcalib.so: /opt/ros/kinetic/lib/x86_64-linux-gnu/libvisp_ar.so.3.0.1
libcalib.so: /opt/ros/kinetic/lib/x86_64-linux-gnu/libvisp_sensor.so.3.0.1
libcalib.so: /usr/lib/x86_64-linux-gnu/libv4l2.so
libcalib.so: /usr/lib/x86_64-linux-gnu/libv4lconvert.so
libcalib.so: /usr/lib/x86_64-linux-gnu/libdc1394.so
libcalib.so: /usr/lib/x86_64-linux-gnu/libfreenect.so
libcalib.so: /usr/lib/x86_64-linux-gnu/libusb-1.0.so
libcalib.so: /opt/ros/kinetic/lib/x86_64-linux-gnu/libvisp_vision.so.3.0.1
libcalib.so: /opt/ros/kinetic/lib/x86_64-linux-gnu/libvisp_visual_features.so.3.0.1
libcalib.so: /opt/ros/kinetic/lib/x86_64-linux-gnu/libvisp_me.so.3.0.1
libcalib.so: /opt/ros/kinetic/lib/x86_64-linux-gnu/libvisp_blob.so.3.0.1
libcalib.so: /usr/lib/x86_64-linux-gnu/libSM.so
libcalib.so: /usr/lib/x86_64-linux-gnu/libICE.so
libcalib.so: /usr/lib/x86_64-linux-gnu/libX11.so
libcalib.so: /usr/lib/x86_64-linux-gnu/libXext.so
libcalib.so: /opt/ros/kinetic/lib/x86_64-linux-gnu/libvisp_io.so.3.0.1
libcalib.so: /usr/lib/x86_64-linux-gnu/libjpeg.so
libcalib.so: /usr/lib/x86_64-linux-gnu/libpng.so
libcalib.so: /usr/lib/x86_64-linux-gnu/libboost_thread.so
libcalib.so: /usr/lib/x86_64-linux-gnu/libboost_system.so
libcalib.so: /usr/lib/x86_64-linux-gnu/libboost_date_time.so
libcalib.so: /usr/lib/x86_64-linux-gnu/libboost_chrono.so
libcalib.so: /usr/lib/x86_64-linux-gnu/libboost_atomic.so
libcalib.so: /usr/lib/x86_64-linux-gnu/libOgreMain.so
libcalib.so: /usr/lib/x86_64-linux-gnu/libboost_thread.so
libcalib.so: /usr/lib/x86_64-linux-gnu/libboost_system.so
libcalib.so: /usr/lib/x86_64-linux-gnu/libboost_date_time.so
libcalib.so: /usr/lib/x86_64-linux-gnu/libboost_chrono.so
libcalib.so: /usr/lib/x86_64-linux-gnu/libboost_atomic.so
libcalib.so: /usr/lib/x86_64-linux-gnu/libOgreMain.so
libcalib.so: /usr/lib/x86_64-linux-gnu/libOIS.so
libcalib.so: /usr/lib/x86_64-linux-gnu/libGLU.so
libcalib.so: /usr/lib/x86_64-linux-gnu/libGL.so
libcalib.so: /usr/lib/x86_64-linux-gnu/libCoin.so
libcalib.so: /opt/ros/kinetic/lib/x86_64-linux-gnu/libvisp_core.so.3.0.1
libcalib.so: /opt/ros/kinetic/lib/libopencv_calib3d3.so.3.2.0
libcalib.so: /opt/ros/kinetic/lib/libopencv_core3.so.3.2.0
libcalib.so: /opt/ros/kinetic/lib/libopencv_features2d3.so.3.2.0
libcalib.so: /opt/ros/kinetic/lib/libopencv_flann3.so.3.2.0
libcalib.so: /opt/ros/kinetic/lib/libopencv_highgui3.so.3.2.0
libcalib.so: /opt/ros/kinetic/lib/libopencv_imgcodecs3.so.3.2.0
libcalib.so: /opt/ros/kinetic/lib/libopencv_imgproc3.so.3.2.0
libcalib.so: /opt/ros/kinetic/lib/libopencv_ml3.so.3.2.0
libcalib.so: /opt/ros/kinetic/lib/libopencv_objdetect3.so.3.2.0
libcalib.so: /opt/ros/kinetic/lib/libopencv_photo3.so.3.2.0
libcalib.so: /opt/ros/kinetic/lib/libopencv_shape3.so.3.2.0
libcalib.so: /opt/ros/kinetic/lib/libopencv_stitching3.so.3.2.0
libcalib.so: /opt/ros/kinetic/lib/libopencv_superres3.so.3.2.0
libcalib.so: /opt/ros/kinetic/lib/libopencv_video3.so.3.2.0
libcalib.so: /opt/ros/kinetic/lib/libopencv_videoio3.so.3.2.0
libcalib.so: /opt/ros/kinetic/lib/libopencv_videostab3.so.3.2.0
libcalib.so: /opt/ros/kinetic/lib/libopencv_viz3.so.3.2.0
libcalib.so: /opt/ros/kinetic/lib/libopencv_aruco3.so.3.2.0
libcalib.so: /opt/ros/kinetic/lib/libopencv_bgsegm3.so.3.2.0
libcalib.so: /opt/ros/kinetic/lib/libopencv_bioinspired3.so.3.2.0
libcalib.so: /opt/ros/kinetic/lib/libopencv_ccalib3.so.3.2.0
libcalib.so: /opt/ros/kinetic/lib/libopencv_cvv3.so.3.2.0
libcalib.so: /opt/ros/kinetic/lib/libopencv_datasets3.so.3.2.0
libcalib.so: /opt/ros/kinetic/lib/libopencv_dpm3.so.3.2.0
libcalib.so: /opt/ros/kinetic/lib/libopencv_face3.so.3.2.0
libcalib.so: /opt/ros/kinetic/lib/libopencv_fuzzy3.so.3.2.0
libcalib.so: /opt/ros/kinetic/lib/libopencv_hdf3.so.3.2.0
libcalib.so: /opt/ros/kinetic/lib/libopencv_line_descriptor3.so.3.2.0
libcalib.so: /opt/ros/kinetic/lib/libopencv_optflow3.so.3.2.0
libcalib.so: /opt/ros/kinetic/lib/libopencv_phase_unwrapping3.so.3.2.0
libcalib.so: /opt/ros/kinetic/lib/libopencv_plot3.so.3.2.0
libcalib.so: /opt/ros/kinetic/lib/libopencv_reg3.so.3.2.0
libcalib.so: /opt/ros/kinetic/lib/libopencv_rgbd3.so.3.2.0
libcalib.so: /opt/ros/kinetic/lib/libopencv_saliency3.so.3.2.0
libcalib.so: /opt/ros/kinetic/lib/libopencv_stereo3.so.3.2.0
libcalib.so: /opt/ros/kinetic/lib/libopencv_structured_light3.so.3.2.0
libcalib.so: /opt/ros/kinetic/lib/libopencv_surface_matching3.so.3.2.0
libcalib.so: /opt/ros/kinetic/lib/libopencv_text3.so.3.2.0
libcalib.so: /opt/ros/kinetic/lib/libopencv_xfeatures2d3.so.3.2.0
libcalib.so: /opt/ros/kinetic/lib/libopencv_ximgproc3.so.3.2.0
libcalib.so: /opt/ros/kinetic/lib/libopencv_xobjdetect3.so.3.2.0
libcalib.so: /opt/ros/kinetic/lib/libopencv_xphoto3.so.3.2.0
libcalib.so: /usr/lib/liblapack.so
libcalib.so: /usr/lib/libblas.so
libcalib.so: /usr/lib/x86_64-linux-gnu/libxml2.so
libcalib.so: /usr/lib/x86_64-linux-gnu/libz.so
libcalib.so: /usr/lib/x86_64-linux-gnu/libpthread.so
libcalib.so: /usr/lib/x86_64-linux-gnu/libzbar.so
libcalib.so: /usr/lib/x86_64-linux-gnu/libdmtx.so
libcalib.so: /usr/lib/x86_64-linux-gnu/libm.so
libcalib.so: /usr/lib/x86_64-linux-gnu/libnsl.so
libcalib.so: CMakeFiles/calib.dir/link.txt
	@$(CMAKE_COMMAND) -E cmake_echo_color --switch=$(COLOR) --green --bold --progress-dir=/user/eleves/gkregulan2017/projects/lab1_CV-build/CMakeFiles --progress-num=$(CMAKE_PROGRESS_4) "Linking CXX shared library libcalib.so"
	$(CMAKE_COMMAND) -E cmake_link_script CMakeFiles/calib.dir/link.txt --verbose=$(VERBOSE)

# Rule to build all files generated by this target.
CMakeFiles/calib.dir/build: libcalib.so

.PHONY : CMakeFiles/calib.dir/build

CMakeFiles/calib.dir/requires: CMakeFiles/calib.dir/src/grid_tracker.cpp.o.requires
CMakeFiles/calib.dir/requires: CMakeFiles/calib.dir/src/cb_tracker.cpp.o.requires
CMakeFiles/calib.dir/requires: CMakeFiles/calib.dir/src/vvs.cpp.o.requires

.PHONY : CMakeFiles/calib.dir/requires

CMakeFiles/calib.dir/clean:
	$(CMAKE_COMMAND) -P CMakeFiles/calib.dir/cmake_clean.cmake
.PHONY : CMakeFiles/calib.dir/clean

CMakeFiles/calib.dir/depend:
	cd /user/eleves/gkregulan2017/projects/lab1_CV-build && $(CMAKE_COMMAND) -E cmake_depends "Unix Makefiles" /user/eleves/gkregulan2017/projects/lab1_CV /user/eleves/gkregulan2017/projects/lab1_CV /user/eleves/gkregulan2017/projects/lab1_CV-build /user/eleves/gkregulan2017/projects/lab1_CV-build /user/eleves/gkregulan2017/projects/lab1_CV-build/CMakeFiles/calib.dir/DependInfo.cmake --color=$(COLOR)
.PHONY : CMakeFiles/calib.dir/depend

