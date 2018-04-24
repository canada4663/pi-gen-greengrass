#!/bin/bash

cat <<EOF >>${ROOTFS_DIR}/etc/sysctl.d/98-rpi.conf
fs.protected_hardlinks = 1
fs.protected_symlinks = 1
EOF

tar Czxf ${ROOTFS_DIR} files/greengrass*.tar.gz

# Users should place the extracted keys/config into the fat32 partition.
rm -rf ${ROOTFS_DIR}/greengrass/certs \
       ${ROOTFS_DIR}/greengrass/config
mkdir -p ${ROOTFS_DIR}/boot/greengrass/certs
mkdir -p ${ROOTFS_DIR}/boot/greengrass/config
ln -s /boot/greengrass/certs ${ROOTFS_DIR}/greengrass/certs
ln -s /boot/greengrass/config ${ROOTFS_DIR}/greengrass/config
# For twitch stream we want viewers to see our text BIG!
cat <<EOF >>${ROOTFS_DIR}/boot/config.txt
framebuffer_width=800
framebuffer_height=400
EOF

# Grab samples which also has the dependencies checker utility.
if [ -d ${ROOTFS_DIR}/home/pi/aws-greengrass-samples ]; then
  cd ${ROOTFS_DIR}/home/pi/aws-greengrass-samples;
  git pull --rebase origin master
else
  git clone git://github.com/aws-samples/aws-greengrass-samples ${ROOTFS_DIR}/home/pi/aws-greengrass-samples
fi

cat <<EOF >${ROOTFS_DIR}/etc/init.d/S02greengrassd
#!/bin/bash
cd /greengrass/ggc/core
./greengrassd $@
EOF
chmod 755 ${ROOTFS_DIR}/etc/init.d/S02greengrassd
ln -s /etc/init.d/S02greengrassd ${ROOTFS_DIR}/etc/rc5.d/
