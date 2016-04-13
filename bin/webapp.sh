#!/bin/bash

ex=`basename $0`

declare -A url_list
url_list[slack]=waivecar.slack.com
url_list[hipchat]=crowdfunder.hipchat.com/chat
url_list[skype]=web.skype.com
url_list[hangouts]=hangouts.google.com

make_bins() {
  for i in "${!url_list[@]}"; do
    if [ -e $i ]; then
      echo "$i already exists"
    else
      echo "Creating $i"
      ln -s $PWD/webapp.sh $i
    fi
  done
}

if [ "$ex" == "webapp.sh" ]; then
  make_bins
else
  google-chrome --app=https://${url_list[$ex]}/
fi
