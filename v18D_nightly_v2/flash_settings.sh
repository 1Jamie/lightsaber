adb wait-for-device &&
adb root &&
adb remount &&
adb push settings.json /system/b2g/defaults &&
adb shell rm -r /cache/* &&
adb shell mkdir /cache/recovery > /dev/null &&
adb shell 'echo "--wipe_data" > /cache/recovery/command' &&
adb reboot recovery