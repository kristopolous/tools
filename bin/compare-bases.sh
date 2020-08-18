#!/bin/bash
store=$(mktemp -d)

keep=$1
toss=$2

{ 
  cd $keep
  find . -type f > $store/keep
}
{
  cd $toss
  find . -type f > $store/toss
}

for i in $(cat $store/keep $store/toss | sort | uniq -d); do
  keep_size=$(stat -c %s $keep/$i)
  toss_size=$(stat -c %s $toss/$i)

  if [[ $keep_size == $toss_size ]]; then
    keep_md5=$(cat $keep/$i | md5sum)
    toss_md5=$(cat $toss/$i | md5sum)
    if [[ $keep_md5 == $toss_md5 ]]; then
      echo "rm $toss/$i"
    fi
  fi
done

