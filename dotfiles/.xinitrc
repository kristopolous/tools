xrandr --output DP-0 --rotate left --auto
xrandr --output HDMI-0 --auto --rotate left --right-of DP-0

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

# The fonts, sizes and colors of xterm I'd like to have instead
xrdb -merge ~/.Xresources

# Disable the bell.
xset b off

xsetroot -mod 15 15 -bg rgb:2/2/2 -fg rgb:4/4/4

# An attempt to merge all the clipboards together
# (there are 3 last I counted)
pkill autocutsel
autocutsel &
autocutsel -s PRIMARY & 
# A small clock/cpu load/battery level/temperature monitor
$HOME/bin/osd_time&

# Instead of pivoting on things that may crash, thus crashing the X
# server and crashing everything running on the x server, I use a very
# stable program that won't crash ... /bin/cat would work here too
# I guess, but I've been using this trick since I was a teenager and
# really haven't fundamentally questioned it.
xset dpms 0 0 0
sleep 10000000

