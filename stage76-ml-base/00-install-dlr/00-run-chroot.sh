#!/bin/sh

#Install DLR
cd /home/pi/ml/dlr/dlr*
chmod 755 install-dlr.sh
pip install setuptools
pip install numpy
easy_install dlr*.egg
python tests/test-dlr.py

