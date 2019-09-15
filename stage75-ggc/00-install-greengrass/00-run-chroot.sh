#!/bin/sh

adduser --disabled-password -q --gecos "" ggc_user
addgroup ggc_group
adduser ggc_user ggc_group

#install greengrass service
chmod 755 /greengrass/greengrasscertcopy.sh
systemctl enable greengrass
systemctl enable greengrasscertcopy

#DEBUG: list greengrass directory
ls /greengrass/
