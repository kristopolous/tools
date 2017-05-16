#!/bin/bash
which=${1:-1}
path=`adb shell "ls /mnt/sdcard/Pictures/Screenshots/Sc* | tail -$which | head -1" | tr -d '\r\n'`
adb pull $path
