#!/bin/bash
n=0
arr=()
ping_window=30
buffer_window=900
logfile=/tmp/signal-history
floor=4
ceil=15
range=$(( ceil - floor ))

echo "Using $logfile"
while [ 0 ]; do
  ping -q -w 2 -c 1 8.8.8.8 > /dev/null

  arr+=( $? )
  [[ $count -gt $ping_window ]] && arr=( ${arr[@]:1} )
  ttl=0
  for x in ${arr[@]}; do ttl=$(( x + ttl )); done
  count=${#arr[@]}
  last=$( bc -l <<< "scale=2; $floor + $ttl * $range / $count" )

  stats=$(links -dump http://admin:admin@192.168.1.1/status_deviceinfo.htm | grep -A 1 "SNR Margin" | grep -Po '[\d\.]*' | tr '\n' ' ')
  if [ -n "$stats" ]; then
    echo "$last $stats" >> ${logfile}.bak
    n=$(( n + 1 ))
    fail=0
  else
    if (( fail < 5 )); then
      echo "$last $floor $floor $floor $floor" >> ${logfile}.bak
      sleep 3
      n=$(( n + 1 ))
    fi
    fail=$(( fail + 1 ))
  fi

  tail -$buffer_window ${logfile}.bak | awk ' { print FNR" "$0 } ' > ${logfile}.holder
  mv ${logfile}.holder $logfile
done
