#!/bin/bash
n=0
arr=()
ping_window=20
buffer_window=900
logfile=/tmp/signal-history
echo "Using $logfile"
while [ 0 ]; do
  ping -q -w 2 -c 2 8.8.8.8 > /dev/null

  arr+=( $? )
  [[ $count -gt $ping_window ]] && arr=( ${arr[@]:1} )
  ttl=0
  count=0
  for x in ${arr[@]}; do ttl=$(( x + ttl )); done
  count=${#arr[@]}
  last=$(( 100 - ttl * 100 / count ))

  stats=$(links -dump http://admin:admin@192.168.1.1/status_deviceinfo.htm | grep -A 2 "SNR Margin" | grep -Po '[\d\.]*' | tr '\n' ' ')
  if [ -n "$stats" ]; then
    echo "$n $last $stats" >> $logfile
    n=$(( n + 1 ))
    fail=0
  else
    if (( fail < 5 )); then
      echo "$n $last 0 0 0 0 0 0 0" >> $logfile
      sleep 3
      n=$(( n + 1 ))
    fi
    fail=$((fail + 1))
  fi

  tail -$buffer_window $logfile | sed -E 's/^[0-9]* //g' | awk ' { print FNR" "$0 } ' > ${logfile}.bak
  mv ${logfile}.bak $logfile
done
