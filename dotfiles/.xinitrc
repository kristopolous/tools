# A tool to detect when I plug the monitor in, see bin/automonitor
# in this repository
automonitor &

# The window manager I use: https://notionwm.net/
notion &

# Early in the 4k monitor days, linux things just didn't scale right
# things were sooo tiny ... this is not really needed that much these days
# Also this broke other things.
#xrandr --output eDP-1 --scale 0.85x0.85

# http://www.emacswiki.org/emacs/MovingTheCtrlKey
setxkbmap -option ctrl:nocaps  

# This is honestly a mess ... I should probably fix it.
xmodmap ~/.Xmodmap

# A USB footpad to act as modifier keys.
footpad() {
  # ref: https://superuser.com/questions/760602/how-to-remap-keys-under-linux-for-a-specific-keyboard-only/869064#869064
  local base=/tmp/xkb
  local path=$base/symbols
  local id=9
  local name=foot
  mkdir -p $path

  cat > $path/foot << EOF
  xkb_symbols "foot" {
    key <LCTL> { [ CTRL_L ALT_L ] };
    key <LALT> { [ Hyper_R ] };
    key <LWIN> { [ Hyper_L ]  };
  };
EOF

  setxkbmap -device $id -print \
   | sed 's/\(xkb_symbols.*\)"/\1+foot('$name')"/' \
   | xkbcomp -I$base -i $id -synch - :0
}

# For the lenovo laptops, their default settings were always
# not to my liking.
mouse=/sys/devices/rmi4-00/rmi4-00.fn03/serio2
echo 100 | sudo tee $mouse/speed
echo 250 | sudo tee $mouse/sensitivity 
# There's a lot of interrupts from the controller, this effects battery life
echo 50 | sudo tee $mouse/rate

# The fonts, sizes and colors of xterm I'd like to have instead
xrdb -merge ~/.Xresources

# Disable the bell.
xset b off

# Black, neutral background
xsetroot -solid black 

# An attempt to merge all the clipboards together
# (there 3 last I counted)
pkill autocutsel
autocutsel &
autocutsel -s PRIMARY & 

# More touch pad things.
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

# Oh right more again.
xinput set-prop "TPPS/2 IBM TrackPoint" "Evdev Wheel Emulation" 1
xinput set-prop "TPPS/2 IBM TrackPoint" "Evdev Wheel Emulation Button" 2
xinput set-prop "TPPS/2 IBM TrackPoint" "Evdev Wheel Emulation Timeout" 200
xinput set-prop "TPPS/2 IBM TrackPoint" "Evdev Wheel Emulation Axes" 6 7 4 5
echo 200 | sudo tee -a /sys/devices/platform/i8042/serio1/serio2/sensitivity

# Some things similar to powertop but custom designed.
# These things are less needed these days then when I first
# wrote this script around 2005
sudo $HOME/bin/laptop.sh

# A small clock/cpu load/battery level/temperature monitor
$HOME/bin/osd_time&

footpad

# Hijacks some of the keystrokes for things like screen brightness
{ pgrep xbindkeys || xbindkeys } > /dev/null

# Instead of pivoting on things that may crash, thus crashing the X
# server and crashing everything running on the x server, I use a very
# stable program that won't crash ... /bin/cat would work here too
# I guess, but I've been using this trick since I was a teenager and
# really haven't fundamentally questioned it.
sleep 10000000
