#!/bin/sh

cd /home/pi/ml/ggc-mxnet/
chmod 755 ./mxnet_installer.sh
./mxnet_installer.sh
cd /home/pi/
chown pi -R ml/ggc-mxnet/ 

