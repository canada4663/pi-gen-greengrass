#!/bin/bash

SWAPDIRECTORY=/var
SWAPSIZE=1
UNITTESTS="N"

function usage
{
    echo "usage: mxnet_installer [[-s swap_directory ] [-u] | [-h]]"
    echo "-u | --unittests Enable unittests to verify compatibility"
    echo "-s | --swapdir <swapdirectory>   Directory to create the swap file [1 GB]"
    echo "-h | --help  Print help"
}

while [ "$1" != "" ]; do
    case $1 in
        -s | --size )           shift 
                                SWAPDIRECTORY=$1
                                ;;
        -u | --unittests )      UNITTESTS="Y"
				;;
        -h | --help )           usage
                                exit
                                ;;
        * )                     usage
                                exit 1
    esac
    shift
done

echo "Starting MXNET installation on the system..."
echo "Unittests: " $UNITTESTS
echo "Swapfile location: " $SWAPDIRECTORY"/swap"
echo "Swapfile size: " $SWAPSIZE "GB"

sudo rm -rf mxnet/
sudo rm -rf tmp/
sudo rm -rf tests/

#sudo apt-get update
#sudo apt-get -y upgrade 

set +e

sudo apt-get install -y python-numpy
sudo apt-get install -y liblapack3 || (echo "Failed to install liblapack3. Exiting..." && exit)
sudo apt-get install -y libopenblas-dev || (echo "Failed to install libopenblas. Exiting..." && exit)
sudo apt-get install -y liblapack-dev || (echo "Failed to install liblapack. Exiting..." && exit)
sudo apt-get install -y python-dev python-nose python-pip || (echo "Failed to install required python dependencies. Exiting..." && exit)

sudo apt-get install -y python-opencv zip
#sudo dpkg --remove --force-depends python-numpy

sudo pip install --upgrade pip
sudo pip install wheel
sudo pip install --upgrade picamera
if [ ! -r /dev/raw1394 ]; then
	sudo ln /dev/null /dev/raw1394
fi

# echo "Checking numpy..."
# sudo pip install --upgrade numpy
# if [[ $? -ne 0 ]]; then
#   echo "Cannot install/upgrade numpy! Exiting..."
#   exit
# else
#   echo "'numpy' check complete!"
# fi
#
#sudo pip install --upgrade scipy
sudo apt-get install python-scipy
if [[ $? -ne 0 ]]; then
	echo "Cannot install/upgrade scipy! Exiting..."
	exit
else
	echo "'scipy' check complete!"
fi

echo "Creating " $SWAPSIZE "GB swap partition in " $SWAPDIRECTORY
sudo swapoff $SWAPDIRECTORY"/swap"
sudo fallocate -l 1G $SWAPDIRECTORY"/swap"
if [[ $? -eq 0 ]]; then
        ls -lh $SWAPDIRECTORY"/swap"
        sudo chmod 600 $SWAPDIRECTORY"/swap"
        ls -lh $SWAPDIRECTORY"/swap"
	sudo mkswap $SWAPDIRECTORY"/swap"
        sudo swapon $SWAPDIRECTORY"/swap"
        if [[ $? -ne 0 ]]; then
            echo "WARNING: Our attempt to increase swap partition size has just failed. We will still continue with MXNET installation, however please be informed that some MXNET functionalities (including a few unit-tests) that require high swap size might fail. Please refer to MXNET documentation or mailing groups to get more information."
        else
            swapon -s
            echo "Modifying /etc/fstab ..."
            SWAPFILE=$SWAPDIRECTORY"/swap"
            sudo sh -c 'echo "'$SWAPFILE' none swap sw 0 0" >> /etc/fstab'
            echo "Swap size increased! Moving forward with MXNET installation..."
        fi 
fi

sudo pip install mxnet-1.2.1-py2.py3-none-any.whl

if [ "$UNITTESTS" = "Y" ]; then
    tar xzf mxnet-python-unit-test.tar.gz || (echo "Unable to untar MXNET unittests. Exiting..." && exit)

    export MXNET_ENGINE_TYPE=NaiveEngine
    cd tests/unittest
    nosetests --verbosity=3

    if [[ $? -ne 0 ]]; then
            echo "WARNING: Some of MXNET unittests failed on this device. We strongly encourage you to get a full pass for all of the unittests before starting to use MXNET module in your GGC lambdas."
    else
            echo "MXNET verification succeeded! And MXNET enabled lambda project 'greengrass-ml-squeezenet-object-classification-raspi-python' and its ready-to-upload ZIP version 'greengrassObjectClassification.zip' was created in this folder."
    fi

    cd ../../
fi

rm -rf tmp/
rm -rf tests/

echo "Creating MXNET enabled lambda project 'greengrass-ml-squeezenet-object-classification-raspi-python' and its ready-to-upload ZIP version 'greengrassObjectClassification.zip'..."

tar xzf greengrass-ml-squeezenet-object-classification-raspi-python.tar.gz || (echo "Unable to untar sample lambda project. Please use newly created 'mxnet' python module to your lambda project folder to be able to import 'mxnet'. Exiting..." && exit)

cd greengrass-ml-squeezenet-object-classification-raspi-python/

zip -rq greengrassObjectClassification.zip * || ( "Unable to ZIP Lambda project. Please try to run the command 'zip -r greengrassObjectClassification.zip' inside 'greengrass-ml-squeezenet-object-classification-raspi-python' folder after fixing the issue on your device. This ZIP file can be uploaded to Lambda and then you will be able to attach it to your Greengrass group." && exit)

mv greengrassObjectClassification.zip ../

cd ../

echo "Lambda ZIP file creation succeeded! You can now upload 'greengrassObjectClassification.zip' to Lambda and then attach it to your Greengrass group."

set -e

echo "--------------------------------"
echo "WARNING: In order for greengrasssObjectClassification example to have access to camera on this board, you might need to enable the camera peripheral using the interface provided by the following command:"
echo "----"
echo "'sudo raspi-config'"
echo "----"
echo "or refer the link below:"
echo "https://www.raspberrypi.org/documentation/configuration/camera.md"

sudo tar xzf mxnet_examples.tar.gz || echo "WARNING: Failed to unpack mxnet_examples tarball!"
