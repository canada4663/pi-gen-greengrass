#!/bin/bash

wget -O /tmp/opencv.zip https://github.com/opencv/opencv/archive/4.1.1.zip
wget -O /tmp/opencv_contrib.zip https://github.com/opencv/opencv_contrib/archive/4.1.1.zip

unzip -o -d ${ROOTFS_DIR}/tmp/ /tmp/opencv.zip
unzip -o -d ${ROOTFS_DIR}/tmp/ /tmp/opencv_contrib.zip
