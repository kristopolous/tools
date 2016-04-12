#!/bin/bash

ex=`basename $0`
slack=waivecar.slack.com
hipchat=crowdfunder.hipchat.com/chat
skype=web.skype.com

make_bins() {
  for i in slack hipchat skype; do
    [ -e $i ] || ln $PWD/webapp.sh $i
  done
}

echo $ex
if [ "$ex" == "webapp.sh" ]; then
  make_bins
else
  for i in slack hipchat skype; do
    if [ "$0" == "$i" ]; then
      echo google-chrome --app=https://$i/
      exit
    fi
  done
  echo "Woops, don't know how to start $ex"
fi
