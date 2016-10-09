
# http://www.emacswiki.org/emacs/MovingTheCtrlKey
setxkbmap -option ctrl:nocaps  
xmodmap ~/.Xmodmap
xbindkeys

xrdb -merge ~/.Xresources
xset b off
xsetroot -solid black 

automonitor &
notion &

pkill autocutsel
autocutsel &
autocutsel -s PRIMARY & 

cat << ENDL | xargs synclient
  FingerHigh=45
  PalmDetect=1
  TapButton1=0
  TapButton2=0
  VertTwoFingerScroll=1
  HorizTwoFingerScroll=0
  CoastingSpeed=0 
ENDL

xinput set-prop "TPPS/2 IBM TrackPoint" "Evdev Wheel Emulation" 1
xinput set-prop "TPPS/2 IBM TrackPoint" "Evdev Wheel Emulation Button" 2
xinput set-prop "TPPS/2 IBM TrackPoint" "Evdev Wheel Emulation Timeout" 200
xinput set-prop "TPPS/2 IBM TrackPoint" "Evdev Wheel Emulation Axes" 6 7 4 5

sudo $HOME/bin/laptop.sh
$HOME/bin/osd_time&

sleep 10000000
