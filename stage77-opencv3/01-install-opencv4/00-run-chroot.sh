#!/bin/sh

#Install DLR
cd /tmp/opencv-*
pip2 install numpy
pip3 install numpy
mkdir build
cd build
cmake -D CMAKE_BUILD_TYPE=RELEASE \
    -D CMAKE_INSTALL_PREFIX=/usr/local \
    -D INSTALL_PYTHON_EXAMPLES=ON \
    -D OPENCV_EXTRA_MODULES_PATH=../../opencv_contrib-3.3.0/modules \
    -D BUILD_EXAMPLES=ON ..
make -j16
make install
ldconfig
cd /tmp
rm -Rf /tmp/opencv*
