#!/bin/bash -e

<<<<<<< HEAD
echo "Europe/London" > "${ROOTFS_DIR}/etc/timezone"
=======
echo "${TIMEZONE_DEFAULT}" > "${ROOTFS_DIR}/etc/timezone"
>>>>>>> upstream/master
rm "${ROOTFS_DIR}/etc/localtime"

on_chroot << EOF
dpkg-reconfigure -f noninteractive tzdata
EOF
