#!/bin/bash
which=${1:-1}

getfile() {
  if [ $which = 'today' ]; then
    today=`date +%Y-%m-%d`
    adb shell "ls /mnt/sdcard/Pictures/Screenshots/Sc*" | grep $today | tr -d '\r'
  else
    adb shell "ls /mnt/sdcard/Pictures/Screenshots/Sc*" | tail -n $which | head -1 | tr -d '\r\n'
  fi
}
path=`getfile`
echo $path
for file in $path; do
  adb pull $file
done
