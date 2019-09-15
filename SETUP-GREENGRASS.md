# How to use the grassbian image (from Mac OSX)


* Clone this repository:
 `https://github.com/canada4663/pi-gen-greengrass.git` 

* Unzip downloaded image in repository base directory.

* Download Greengrass Core certificate and config bundle.  This can be found from AWS IoT Greengrass console -> Security -> Certificates -> Select Your Certificate -> Download from Action Menu

* Unzip Greengrass Core cerficate and config bundle.  Note the path to the directory produced.

* Copy and edit WPA supplicant file to match your wifi configuration:
   
  `cp wpa_supplicant.conf.sample wpa_supplicant.conf`

* Plug-in SD card into local computer, inspect diskutil to identify the SD card path - external / physical disk:
  `diskutil list | grep external`
  
  **DO NOT USE INTERNAL DISK**

* Run helper script to burn SD card and apply configuration to /boot volume:

  `source ./osx_burn_config.sh <image file.img> <SD card path> <Greengrass config path> <wpa-supplicant file>`

* (optional) Remount drive and inspect contents of boot volume to ensure everything in place.

* Put SD Card in Pi, and boot it up.  Check that Greengrass service is running:

  `ps -ef | grep green`


### Old Instructions for Reference

1. Grab a tool like [etcher](https://etcher.io) or any tool that burns images to SD cards
2. Burn the image
3. Eject and re-insert the card, go into the mounted drive partition (boot partition for Linux afficionados)
4. Copy the certs/ and config/ folders from the .tar.gz you recieved when you created a greengrass core into the boot partition in the greengrass folder
6. (optional) Add a file titled `ssh` with no extension if you want to ssh into your raspberry pi
7. (optional) [Set up WiFi headlessly](https://www.raspberrypi.org/documentation/configuration/wireless/headless.md)
7. Eject sd and place it into raspberry pi and apply power to pi
8. If you haven't set wifi up on the SD card, [do so now](https://www.raspberrypi.org/documentation/configuration/wireless/wireless-cli.md) with an attached keybeard and mouse. Otherwise, you can ssh in if you completed the ssh and headless wifi step.
8. On the Pi, after boot, run `sudo systemctl status greengrass.service` to ensure greengrass service has booted and is running
9. If not, `sudo systemctl stop greengrass.service` and `cd /greengrass/ggc/core/`, then `./greengrassd` to see output from startup sequences for troubleshooting
