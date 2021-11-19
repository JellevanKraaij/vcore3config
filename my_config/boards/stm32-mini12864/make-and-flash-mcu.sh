#!/bin/bash

VENDORDEVICEID=0483:df11
cp -f /home/pi/klipper_config/my_config/boards/stm32-mini12864/firmware.config /home/pi/klipper/.config
cd /home/pi/klipper
make olddefconfig
make clean
make
sudo service klipper stop

echo "Flashing display via vendor and device ids"
make flash FLASH_DEVICE=$VENDORDEVICEID

sleep 5
if [ $? -eq 0 ]; then
    echo "Flashing succesful!"
else
    echo "Flashing failed :("
    sudo service klipper start
    exit 1
fi
sudo service klipper start