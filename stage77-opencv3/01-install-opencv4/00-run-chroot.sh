#!/bin/sh


cwd=$(pwd)
sudo apt-get -y remove x264 libx264-dev
 
## Install dependencies
apt-get -y install build-essential checkinstall cmake pkg-config yasm
apt-get -y install git gfortran
apt-get -y install libjpeg8-dev libjasper-dev libpng12-dev
apt-get -y install libtiff5-dev
apt-get -y install libtiff-dev
apt-get -y install libavcodec-dev libavformat-dev libswscale-dev libdc1394-22-dev
apt-get -y install libxine2-dev libv4l-dev
cd /usr/include/linux
ln -s -f ../libv4l1-videodev.h videodev.h
cd $cwd
apt-get -y install libgstreamer0.10-dev libgstreamer-plugins-base0.10-dev
apt-get -y install libgtk2.0-dev libtbb-dev qt5-default
apt-get -y install libatlas-base-dev
apt-get -y install libmp3lame-dev libtheora-dev
apt-get -y install libvorbis-dev libxvidcore-dev libx264-dev
apt-get -y install libopencore-amrnb-dev libopencore-amrwb-dev
apt-get -y install libavresample-dev
apt-get -y install x264 v4l-utils
apt-get -y install libglu1-mesa-dev freeglut3-dev mesa-common-dev
 
# Optional dependencies
apt-get -y install libprotobuf-dev protobuf-compiler
apt-get -y install libgoogle-glog-dev libgflags-dev
apt-get -y install libgphoto2-dev libeigen3-dev libhdf5-dev doxygen

apt-get -y install python3-dev python3-pip
apt-get -y install python3-testresources
apt-get -y install python-dev python-pip
apt-get -y install python-testresources

#Install OpenCV4
cd /tmp/opencv-*
pip2 install numpy
pip3 install numpy
mkdir -p build
cd build

ln -s /usr/include/eigen3/Eigen /usr/include/Eigen

cmake -D CMAKE_BUILD_TYPE=RELEASE \
            -D CMAKE_INSTALL_PREFIX=/usr/local \
            -D INSTALL_C_EXAMPLES=ON \
            -D INSTALL_PYTHON_EXAMPLES=ON \
            -D WITH_TBB=ON \
            -D WITH_V4L=ON \
        -D WITH_QT=ON \
        -D WITH_OPENGL=OFF \
        -D OPENCV_EXTRA_MODULES_PATH=../../opencv_contrib-4.1.1/modules \
        -D BUILD_EXAMPLES=ON ..

# cmake -D CMAKE_BUILD_TYPE=RELEASE \
#     -D CMAKE_INSTALL_PREFIX=/usr/local \
#     -D INSTALL_PYTHON_EXAMPLES=ON \
#     -D OPENCV_EXTRA_MODULES_PATH=../../opencv_contrib-3.3.0/modules \
    # -D BUILD_EXAMPLES=ON ..
make -j`nproc`
make install
ldconfig
cd /tmp
rm -Rf /tmp/opencv*
