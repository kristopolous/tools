#!/bin/bash

filename=${1:-Screenshot_`date +%Y-%m-%d_%H-%m-%S`.png}
adb shell screencap -p > $filename
if [ "$(file -b $filename)" = "data" ]; then
  sed -i 's/\r$//' $filename
fi
echo $filename
