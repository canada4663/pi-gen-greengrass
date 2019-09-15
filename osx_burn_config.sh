#!/usr/local/bin/bash


#$1 --> image file
#$2 --> sd card path on mac os x
#$3 --> directory to unzipped greengrass core 

#Unmount Disk
diskutil unmountDisk ${2}

#Burn SD Card
sudo dd if=${1} of=${2} bs=2M

#Mount Disk
diskutil mountDisk ${2}

#Copy Files
cp ${3}/certs/* /Volumes/boot/greengrass/certs/
cp ${3}/config/* /Volumes/boot/greengrass/config/

#Unmount Disk
diskutil unmountDisk ${2}
