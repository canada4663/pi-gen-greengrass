#!/bin/sh
mkdir -p /greengrass/certs
mkdir -p /greengrass/config
cp /boot/greengrass/certs/* /greengrass/certs/
cp /boot/greengrass/config/* /greengrass/config/
