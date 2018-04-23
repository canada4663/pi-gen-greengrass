#!/bin/bash
# Users should place the extracted keys/config into the fat32 partition.
rm -rf ${ROOTFS_DIR}/greengrass/certs \
       ${ROOTFS_DIR}/greengrass/config
ln -s ${ROOTFS_DIR}/greengrass/certs /boot/greengrass/certs
ln -s ${ROOTFS_DIR}/greengrass/config /boot/greengrass/config

# For twitch stream we want viewers to see our text BIG!
cat <<EOF >>/boot/config.txt
framebuffer_width=800
framebuffer_height=400
EOF
