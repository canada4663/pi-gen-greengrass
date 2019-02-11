#!/bin/sh

cd /home/pi/ml/ggc-mxnet-v1.2.1-python-raspi/
chmod 755 ./mxnet_installer.sh
./mxnet_installer.sh
cd /home/pi/
chown pi -R ml/ 

