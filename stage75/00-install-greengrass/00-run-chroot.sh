#!/bin/sh

#Temporary Fix to Allow Overlay File System to Work till GGC Fix Available for new kernels
rpi-update eefe4b161f5e9730183c8dc1605e14c85b15cf51 

adduser --disabled-password -q --gecos "" ggc_user
addgroup ggc_group
adduser ggc_user ggc_group

cat <<EOF >/etc/init.d/S02greengrass
#!/bin/sh
mkdir -p /greengrass/certs
mkdir -p /greengrass/config
cp /boot/greengrass/certs/* /greengrass/certs/
cp /boot/greengrass/config/* /greengrass/config/
cd /greengrass/ggc/core
./greengrassd \$@
EOF
chmod 755 /etc/init.d/S02greengrass

cat <<EOF >/etc/systemd/system/greengrass.service
[Unit]
Description=AWS Greengrass Service

[Service]
Type=notify
ExecStart=/etc/init.d/S02greengrass start
Restart=on-failure

[Install]
WantedBy=multi-user.target
EOF
systemctl enable greengrass.service
