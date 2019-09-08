#!/bin/bash

wget -O /tmp/dlr.tar.gz ${DLR}

mkdir -p ${ROOTFS_DIR}/home/pi/ml
mkdir -p ${ROOTFS_DIR}/home/pi/ml/dlr
tar Czxf ${ROOTFS_DIR}/home/pi/ml/dlr /tmp/dlr.tar.gz

# Grab samples which also has the dependencies checker utility.
if [ -d ${ROOTFS_DIR}/home/pi/aws-greengrass-samples ]; then
  cd ${ROOTFS_DIR}/home/pi/aws-greengrass-samples;
  git pull --rebase origin master
else
  git clone git://github.com/aws-samples/aws-greengrass-samples ${ROOTFS_DIR}/home/pi/aws-greengrass-samples
fi
