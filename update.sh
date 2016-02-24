#!/bin/sh
for i in *; do 
  [ -e ~/bin/$i ] && cp ~/bin/$i .
done
