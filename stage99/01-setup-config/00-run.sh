#!/bin/bash
# Users should place the extracted keys/config into the fat32 partition.
rm -rf ${ROOTFS_DIR}/greengrass/certs \
       ${ROOTFS_DIR}/greengrass/config
ln -s /boot/certs/ ${ROOTFS_DIR}/greengrass/certs
ln -s /boot/config/ ${ROOTFS_DIR}/greengrass/config
