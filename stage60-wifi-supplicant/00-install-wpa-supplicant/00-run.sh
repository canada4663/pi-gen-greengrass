#!/bin/bash

mkdir -p ${ROOTFS_DIR}/boot/opt

cp files/wifisupplicantcopy.service ${ROOTFS_DIR}/etc/systemd/system/wifisupplicantcopy.service
cp files/wifisupplicantcopy.sh ${ROOTFS_DIR}/opt/wifisupplicantcopy.sh
