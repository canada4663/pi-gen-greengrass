# How to use the grassbian image

1. grab a tool like [etcher](https://etcher.io) or any tool that burns images to SD cards
2. burn the image
3. eject and re-insert the card, go into the mounted drive partition (boot partition for Linux afficionados)
4. copy the certs/ and config/ folders from the .tar.gz you recieved when you created a greengrass core into the boot partition in the greengrass folder
6. (optional) add a file titled `ssh` with no extension if you want to ssh into your raspberry pi
7. (optional) [Set up WiFi headlessly](https://www.raspberrypi.org/documentation/configuration/wireless/headless.md)
7. eject sd and place it into raspberry pi and apply power to pi
8. if you haven't set wifi up on the SD card, [do so now](https://www.raspberrypi.org/documentation/configuration/wireless/wireless-cli.md) with an attached keybeard and mouse. Otherwise, you can ssh in if you completed the ssh and headless wifi step.
8. on Pi, after boot, run `sudo systemctl status greengrass.service` to ensure greengrass service has booted and is running
9. if not, `sudo systemctl stop greengrass.service` and `cd /greengrass/ggc/core/`, then `./greengrassd` to see output from startup sequences for troubleshooting