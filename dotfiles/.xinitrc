# http://www.emacswiki.org/emacs/MovingTheCtrlKey
setxkbmap -option ctrl:nocaps  
xmodmap /home/chris/.Xmodmap
xbindkeys

xrdb -merge /home/chris/.Xresources
xset b off
xsetroot -mod 15 15 -bg rgb:2/2/2 -fg rgb:4/4/4

automonitor &
xrandr --output VGA-1 --above LVDS-1
su chris -c notion &

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

#sudo $HOME/bin/laptop.sh
#$HOME/bin/osd_time&
setxkbmap -option ctrl:nocaps  

sleep 10000000
