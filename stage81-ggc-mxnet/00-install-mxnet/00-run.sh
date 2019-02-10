#!/bin/bash

#extract mxnet tarball
if [ -f ../files/ggc-mxnet-v1.2.1-python-raspi.tar.gz ]; then
  mkdir -p ${ROOTFS_DIR}/home/pi/ml/
  tar Czxf ${ROOTFS_DIR}/home/pi/ml/ ../files/ggc-mxnet-v1.2.1-python-raspi.tar.gz 
  chmod 755 ${ROOTFS_DIR}/home/pi/ml/ggc-mxnet-v1.2.1-python-raspi/mxnet_installer.sh
else
  echo "files/ggc-* does not exist"
fi
