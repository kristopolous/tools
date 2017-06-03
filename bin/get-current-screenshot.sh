#!/bin/bash

filename=Screenshot_`date +%Y-%m-%d_%H-%m-%S`.png
adb shell screencap -p | sed 's/\r$//' > $filename
echo $filename
