# shell tools

Various helper scripts that I use day to day along with my personal dotfiles for things such as tmux, zsh, and xinit. 

Most scripts are further commented if you click through the link. 

## Description

 * <a href='https://github.com/kristopolous/tools/blob/master/bin/authadd'>authadd</a>: Similar to ssh-copy-id but seems to work more.
 * <a href='https://github.com/kristopolous/tools/blob/master/bin/automonitor'>automonitor</a>: A tool that detects when monitor cables get plugged in to change from internal to external.
 * <a href='https://github.com/kristopolous/tools/blob/master/bin/brightness'>brightness</a>: x86 screen brightness tool for xbindkeys.
 * <a href="https://github.com/kristopolous/tools/blob/master/bin/chooser">chooser</a>: An 802.11 scanner and chooser.
 * <a href="https://github.com/kristopolous/tools/blob/master/bin/config-all">config-all</a>: Used with ./configure, fills in all the prefix, lib, bin, sbin, man, info etc directories to point to a single install point.
 * <a href="https://github.com/kristopolous/tools/blob/master/bin/dec2hex">dec2hex</a>: A very simple one liner to go from decimal to hex at the command line, something I often want to do.
 * <a href="https://github.com/kristopolous/tools/blob/master/bin/external">external</a>: A script I use to dock the laptop and rerun keyboard mappings.
 * <a href="https://github.com/kristopolous/tools/blob/master/bin/get-current-screenshot">get-current-screenshot</a>: Grabs the current screenshot from a connected android phone over adb.
 * <a href="https://github.com/kristopolous/tools/blob/master/bin/get-last-screenshot">get-last-screenshot</a>: Grabs the previous *N* screenshots from a connected android phone over adb.
 * <a href="https://github.com/kristopolous/tools/blob/master/bin/git_diff_wrapper">git_diff_wrapper</a>: A wrapper to put in .git/config (read the file to find out how to use it).
 * <a href="https://github.com/kristopolous/tools/blob/master/bin/git-last-modified">git-last-modified</a>: A way to view the last modified dates (with respect to git) of the files in a directory.
 * <a href="https://github.com/kristopolous/tools/blob/master/bin/hex2dec">hex2dec</a>: A very simple one liner to go from hex to decimal at the command line, something I often want to do.
 * <a href="https://github.com/kristopolous/tools/blob/master/bin/hotspot">hotspot</a>: A script I use to test mobile from my laptop.
 * <a href="https://github.com/kristopolous/tools/blob/master/bin/indiff">indiff</a>: A tool for comparing code differences. See [this reddit post](https://www.reddit.com/r/vim/comments/1tapo8/indiff_inline_visual_diff_comparisons/).
 * [internal](https://github.com/kristopolous/tools/blob/master/bin/internal): A script I use when undocking my laptop. This is the companion script to external.
 * [inotify](https://github.com/kristopolous/tools/blob/master/src/inotify.c): A way to see when a collection of files is accessed. Also see the [sysdig](https://github.com/draios/sysdig) project I contribute to.
 * [laptop-power-saving](https://github.com/kristopolous/tools/blob/master/bin/laptop-power-saving): The various tricks I've learned to make the most of my laptop battery
 * [meta-rotate](https://github.com/kristopolous/tools/blob/master/bin/meta-rotate): A simple almost reminder tool that quickly and losslessly rotates a video using the meta-information with ffmpeg.
 * [minimal](https://github.com/kristopolous/tools/blob/master/bin/minimal): A minimal-level battery saving setting (used in conjunction with the prior script)
 * [my_xterm](https://github.com/kristopolous/tools/blob/master/bin/my_xterm): Just a dumb xterm wrapper in [acidx](https://github.com/kristopolous/acidx) for [notion](http://notion.sourceforge.net/).
 * [nvmsh](https://github.com/kristopolous/tools/blob/master/bin/nvmsh): Starts [nvm](https://github.com/creationix/nvm) (which has a multi-second load time, so it's not in .zshrc)
 * [osd_time](https://github.com/kristopolous/tools/blob/master/bin/osd_time): Puts a tiny clock in the top right. Needs osd_cat.
 * [reassoc](https://github.com/kristopolous/tools/blob/master/bin/reassoc): A tool that agressively gets a new ip address because sometimes dhclient just isn't enough. It also brings down eth0 just so the networking stack doesn't get confused on how to route packets.
 * [screencast](https://github.com/kristopolous/tools/blob/master/bin/screencast): A tool for piping multiple video streams and routing pulseaudio for multi-streaming to platforms like youtube and twitch
 * [sshot](https://github.com/kristopolous/tools/blob/master/bin/sshot): A poor man's screen sharing application. Note: the imgur cli tool it's using is broken as of 2016-03-31. [See issue #1](https://github.com/kristopolous/tools/issues/1)
 * [strace-all](https://github.com/kristopolous/tools/blob/master/bin/strace-all): This will do a ps and grep for the string that is the last argument, then it will strace the pids of all of them simultaneously with parallelized xargs, following vforks
 * [transfer-and-delete](https://github.com/kristopolous/tools/blob/master/bin/transfer-and-delete): For android phones connected over adb, this will recursively transfer entire directory trees off a phone on to the local machine and then delete the phone's copy.
 * [update-tags](https://github.com/kristopolous/tools/blob/master/bin/update-tags): Updates ctags and cscope; useful for emacs and vim code navigation. There's companion versions for different types of code bases.
 * [uuidb64](https://github.com/kristopolous/tools/blob/master/bin/uuidb64): A python2 script that outputs a computer-friendly *almost* Base64 version of a UUID (a few potentially problematic b64 characters get substituted out). For use when you need a sufficiently random string but don't want some long base16 hyphenated UUID.
 * [volume](https://github.com/kristopolous/tools/blob/master/bin/volume): A bash script that works with xbindkeys to make the volume buttons work
 * [waitfor](https://github.com/kristopolous/tools/blob/master/src/waitfor.c): A blocking thing of the above (see description in the c file)
 * [wpa](https://github.com/kristopolous/tools/blob/master/bin/wpa): A script that maintains wpa_supplicant sanely (used with reassoc)
 * [youtube-dl](https://github.com/kristopolous/tools/blob/master/bin/youtube-dl): From http://rg3.github.com/youtube-dl/download.html

## Install

There's an installer that will put these into your `$HOME/bin` directory
If you trust me just run

    $ ./install

And then add `$HOME/bin` to your path.  If you already have a file in your `$HOME/bin` directory that this conflicts, an
MD5 checksum is done and if they don't match then you get prompted whether you want to install it.  You can view a diff of the changes, skip the file, or install it anyway.

## History

The earliest file here goes back to 2000 (dotfiles/.twmrc) although I use notion now.  I began using Linux I believe in 1998.
