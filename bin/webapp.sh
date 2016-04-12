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

if [ "$ex" == "webapp.sh" ]; then
  make_bins
else
  google-chrome --app=https://${!ex}/ &
fi
