#!/bin/bash
n=0
while [ 0 ]; do
  stats=$(links -dump http://admin:admin@192.168.1.1/status_deviceinfo.htm | grep -A 2 "SNR Margin" | grep -Po '[\d\.]*' | tr '\n' ' ')
  if [ -n "$stats" ]; then
    echo  "$n $stats" >> power-history
    n=$(( n + 1 ))
    fail=0
  else
    if (( fail < 5 )); then
      echo "$n 0.0 0.0 0.0 0.0 0.0 0.0 0.0 0.0" >> power-history
      sleep 3
      n=$(( n + 1 ))
    fi
    fail=$((fail + 1))
  fi
  sleep 0.75
  tail -900 power-history| sed -E 's/^[0-9]*//g' | awk ' { print FNR" "$0 } ' > /tmp/power
  mv /tmp/power power-history
done
