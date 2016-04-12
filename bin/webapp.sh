#!/bin/bash

ex=`basename $0`
slack=waivecar.slack.com
hipchat=crowdfunder.hipchat.com/chat
skype=web.skype.com

bins() {
  for i in slack hipchat skype; do
    [ -e $i ] || ln $PWD/webapp.sh $i
  done
}

echo $ex
if [ "$ex" == "webapp.sh" ]; then
  bins
else
  finished=1
  for i in slack hipchat skype; do
    if [ "$0" == "$i" ]; then
      echo google-chrome --app=https://$i/
      finished=0
    fi
  done
fi

if [ ! $finished ]; then
  echo "Woops, don't know how to start $0"
fi

