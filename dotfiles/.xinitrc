# http://www.emacswiki.org/emacs/MovingTheCtrlKey
automonitor &
notion &
#xrandr --output eDP-1 --scale 0.85x0.85
setxkbmap -option ctrl:nocaps  
xmodmap ~/.Xmodmap

mouse=/sys/devices/rmi4-00/rmi4-00.fn03/serio2
echo 100 | sudo tee $mouse/speed
echo 250 | sudo tee $mouse/sensitivity 
# There's a lot of interrupts from the controller, this effects battery life
echo 50 | sudo tee $mouse/rate

xrdb -merge ~/.Xresources
xset b off
xsetroot -solid black 

pkill autocutsel
autocutsel &
autocutsel -s PRIMARY & 

cat << ENDL | xargs synclient
  FingerHigh=45
  AccelFactor=1
  PressureMotionMinZ=1
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
echo 200 | sudo tee -a /sys/devices/platform/i8042/serio1/serio2/sensitivity

sudo $HOME/bin/laptop.sh
$HOME/bin/osd_time&

{ pgrep xbindkeys || xbindkeys } > /dev/null
sleep 10000000
