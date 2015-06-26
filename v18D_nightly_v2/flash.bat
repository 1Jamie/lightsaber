adb kill-server                                                                                                                                            
adb devices
adb reboot bootloader
fastboot devices

echo "Partition table..."
fastboot flash partition gpt_both0.bin

echo "Flash nCPU..."
fastboot flash modem NON-HLOS.bin
fastboot flash rpm rpm.mbn
fastboot flash tz tz.mbn
fastboot flash sbl1 sbl1.mbn
fastboot flash sdi sdi.mbn
fastboot flash fsg study.img

echo "Flash Apps..."
fastboot flash aboot emmc_appsboot.mbn
fastboot flash boot boot.img
fastboot flash system system.img
fastboot flash persist persist.img
fastboot flash recovery recovery.img
fastboot flash cache cache.img
fastboot flash userdata userdata.img
fastboot flash usbmsc usbdisk.img

echo "erase modemst1 modemst2"
fastboot erase modemst1
fastboot erase modemst2

echo "Done..."
fastboot reboot

echo "Just close the windows as you wish."

adb logcat
