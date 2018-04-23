#!/bin/bash

cat <<EOF >>/etc/sysctl.d/98-rpi.conf
fs.protected_hardlinks = 1
fs.protected_symlinks = 1
EOF

apt-get install sqlite3

tar Czxf ${ROOTFS_DIR} files/greengrass*.tar.gz
