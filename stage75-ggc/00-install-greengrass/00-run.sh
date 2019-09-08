#!/bin/bash

cat <<EOF >>${ROOTFS_DIR}/etc/sysctl.d/98-rpi.conf
fs.protected_hardlinks = 1
fs.protected_symlinks = 1
EOF

wget -O files/greengrass.tar.gz ${GGC}
wget -O files/root.ca.pem https://www.amazontrust.com/repository/AmazonRootCA1.pem

sed -i 's/$/\ cgroup_enable=memory\ cgroup_memory=1/' ${ROOTFS_DIR}/boot/cmdline.txt

tar Czxf ${ROOTFS_DIR} files/greengrass.tar.gz

# Users should place the extracted keys/config into the fat32 partition.
rm -rf ${ROOTFS_DIR}/greengrass/certs \
       ${ROOTFS_DIR}/greengrass/config
mkdir -p ${ROOTFS_DIR}/boot/greengrass/certs
mkdir -p ${ROOTFS_DIR}/boot/greengrass/config

# Install greengrass service files
cp files/greengrass.service ${ROOTFS_DIR}/etc/systemd/system/greengrass.service
cp files/greengrasscertcopy.service ${ROOTFS_DIR}/etc/systemd/system/greengrasscertcopy.service
cp files/greengrasscertcopy.sh ${ROOTFS_DIR}/greengrass/greengrasscertcopy.sh

# copy root cert into /greengrass/certs
cp files/root.ca.pem ${ROOTFS_DIR}/boot/greengrass/certs/

# set resolution to 1280x720 for development
# enable picamera by default
cat <<EOF >>${ROOTFS_DIR}/boot/config.txt
framebuffer_width=1280
framebuffer_height=720
gpu_mem=128
start_x=1
disable_camera_led=1
EOF

# Grab samples which also has the dependencies checker utility.
if [ -d ${ROOTFS_DIR}/home/pi/aws-greengrass-samples ]; then
  cd ${ROOTFS_DIR}/home/pi/aws-greengrass-samples;
  git pull --rebase origin master
else
  git clone git://github.com/aws-samples/aws-greengrass-samples ${ROOTFS_DIR}/home/pi/aws-greengrass-samples
fi
