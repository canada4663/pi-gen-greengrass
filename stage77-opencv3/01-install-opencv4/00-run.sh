#!/bin/bash

wget -O /tmp/opencv.zip https://github.com/Itseez/opencv/archive/3.3.0.zip
wget -O /tmp/opencv_contrib.zip https://github.com/Itseez/opencv_contrib/archive/3.3.0.zip

unzip -d ${ROOTFS_DIR}/tmp/ /tmp/opencv.zip
unzip -d ${ROOTFS_DIR}/tmp/ /tmp/opencv_contrib.zip
