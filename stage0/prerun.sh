#!/bin/bash -e

ls -lart

if [ -d ./work ]; then
	ls -lart ./work/
fi

if [ ! -d "${ROOTFS_DIR}" ]; then
	bootstrap buster "${ROOTFS_DIR}" http://raspbian.raspberrypi.org/raspbian/
fi
