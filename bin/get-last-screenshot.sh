#!/bin/bash
which=${1:-1}
getfile() {
  adb shell "ls /mnt/sdcard/Pictures/Screenshots/Sc*" | tail -n $which | head -1 | tr -d '\r\n'
}
path=`getfile`
adb pull $path
