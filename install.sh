#!/bin/bash
for i in `find -maxdepth 1 -executable -type f`; do
  if [ $i != $0 ]; then
    name=`basename $i`
    if [ ! -e $HOME/bin/$name ]; then
      echo "Installing $name"
      cp $i $HOME/bin
    fi
  fi
done
