#!/bin/bash
n=0
arr=()
while [ 0 ]; do
  ping -q -w 2 -c 2 8.8.8.8 > /dev/null
  arr+=( $? )
  [[ $count -gt 20 ]] && arr=( ${arr[@]:1} )
  ttl=0
  count=0
  for x in ${arr[@]}; do ttl=$(( x + ttl )); done
  count=${#arr[@]}
  last=$(( 100 - ttl * 100 / count ))

  stats=$(links -dump http://admin:admin@192.168.1.1/status_deviceinfo.htm | grep -A 2 "SNR Margin" | grep -Po '[\d\.]*' | tr '\n' ' ')
  if [ -n "$stats" ]; then
    echo  "$n $last $stats" >> power-history
    n=$(( n + 1 ))
    fail=0
  else
    if (( fail < 5 )); then
      echo "$n $last 0.0 0.0 0.0 0.0 0.0 0.0 0.0 0.0" >> power-history
      sleep 3
      n=$(( n + 1 ))
    fi
    fail=$((fail + 1))
  fi

  tail -900 power-history| sed -E 's/^[0-9]* //g' | awk ' { print FNR" "$0 } ' > /tmp/power
  mv /tmp/power power-history
done
