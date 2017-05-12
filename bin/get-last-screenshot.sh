#!/bin/sh
path=`adb shell "ls /mnt/sdcard/Pictures/Screenshots/Sc* | tail -1" | tr -d '\r\n'`
adb pull $path
