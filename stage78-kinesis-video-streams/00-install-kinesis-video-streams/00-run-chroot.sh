#!/bin/sh

#https://github.com/awslabs/amazon-kinesis-video-streams-producer-sdk-cpp/blob/master/install-instructions-linux.md
pip install pycairo
pip install PyGObject
pip3 install pycairo
pip3 install PyGObject

cd /opt/amazon-kvs/kinesis-video-native-build
source ./min-install-script
cp *.so downloads/local/lib/

echo "export LD_LIBRARY_PATH=/opt/amazon-kvs/kinesis-video-native-build/downloads/local/lib:$LD_LIBRARY_PATH" >> /home/pi/.profile
echo "export GST_PLUGIN_PATH=/opt/amazon-kvs/kinesis-video-native-build/downloads/local/lib:$LD_LIBRARY_PATH" >> /home/pi/.profile
