#!/bin/sh

#Temporary Fix to Allow Overlay File System to Work till GGC Fix Available for new kernels
rpi-update eefe4b161f5e9730183c8dc1605e14c85b15cf51 

adduser --disabled-password -q --gecos "" ggc_user
addgroup ggc_group
adduser ggc_user ggc_group

#install greengrass service
chmod 755 /greengrass/greengrasscertcopy.sh
systemctl enable greengrass
systemctl enable greengrasscertcopy

#DEBUG: list greengrass directory
ls /greengrass/
