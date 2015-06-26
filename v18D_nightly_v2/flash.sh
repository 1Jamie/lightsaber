update_time()
{
        if [ `uname` == Darwin ]; then
                SETTIME="-s `date -j "+%Y%m%d.%H%M%S"`"
                OFFSET=`date +%z`
                OFFSET=${OFFSET:0:3}
                TIMEZONE=`date +%Z$OFFSET|tr +- -+`
        else
                SETTIME=`date +%s`
                TIMEZONE=`date +%Z%:::z|tr +- -+`
        fi
        echo Attempting to set the time on the device on `uname` platform
        adb wait-for-device &&
        adb shell toolbox date $SETTIME &&
        adb shell setprop persist.sys.timezone $TIMEZONE
}

## Main ##

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

echo "Updating time..."
update_time

echo "Just close the windows as you wish."
adb logcat
