#!/bin/bash

cat <<EOF >>${ROOTFS_DIR}/etc/sysctl.d/98-rpi.conf
fs.protected_hardlinks = 1
fs.protected_symlinks = 1
EOF

tar Czxf ${ROOTFS_DIR} files/greengrass*.tar.gz

git clone git://github.com/aws-samples/aws-greengrass-samples ${ROOTFS_DIR}/home/pi/aws-greengrass-samples
