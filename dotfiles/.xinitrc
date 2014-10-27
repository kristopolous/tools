
# http://www.emacswiki.org/emacs/MovingTheCtrlKey
setxkbmap -option ctrl:nocaps  
xmodmap ~/.Xmodmap

xrdb -merge ~/.Xresources
xset b off
xsetroot -solid black 

notion &
autocutsel &
autocutsel -s PRIMARY & 

synclient FingerHigh=45
synclient PalmDetect=1
synclient TapButton1=0
synclient TapButton2=0
synclient VertTwoFingerScroll=1
synclient HorizTwoFingerScroll=0

xinput set-prop "TPPS/2 IBM TrackPoint" "Evdev Wheel Emulation" 1
xinput set-prop "TPPS/2 IBM TrackPoint" "Evdev Wheel Emulation Button" 2
xinput set-prop "TPPS/2 IBM TrackPoint" "Evdev Wheel Emulation Timeout" 200
xinput set-prop "TPPS/2 IBM TrackPoint" "Evdev Wheel Emulation Axes" 6 7 4 5

sudo ./laptop.sh

sleep 10000000
