#!/bin/sh

#Install DLR
cd /home/pi/ml/dlr/dlr*
chmod 755 install-dlr.sh
apt-get remove python-setuptools -y
pip install setuptools
pip install numpy
ls
easy_install --no-deps dlr*.egg
python tests/test-dlr.py

