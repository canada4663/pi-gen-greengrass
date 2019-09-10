#!/bin/bash

wget -O /tmp/mxnet.tar.gz ${MXNET}

#extract mxnet tarball
if [ -f /tmp/mxnet.tar.gz ]; then
  mkdir -p ${ROOTFS_DIR}/home/pi/ml/
  tar Czxf ${ROOTFS_DIR}/home/pi/ml/ /tmp/mxnet.tar.gz 
  mv ${ROOTFS_DIR}/home/pi/ml/ggc-mxnet* ${ROOTFS_DIR}/home/pi/ml/ggc-mxnet
else
  echo "files/mxnet.tar.gz does not exist"
fi
