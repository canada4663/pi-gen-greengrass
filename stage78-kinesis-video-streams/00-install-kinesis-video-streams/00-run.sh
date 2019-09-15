#!/bin/bash

wget -O /tmp/kvs.tar.gz ${KVS}
tar Czxf ${ROOTFS_DIR}/opt/ /tmp/kvs.tar.gz
mv ${ROOTFS_DIR}/opt/amazon-kinesis* ${ROOTFS_DIR}/opt/amazon-kvs

NUM_PROC=`nproc`

sed -i "s/max_parallel=2/max_parallel=$NUM_PROC/" ${ROOTFS_DIR}/opt/amazon-kvs/kinesis-video-native-build/min-install-script
