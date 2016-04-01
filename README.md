Various helper scripts that I use day to day along with my personal dotfiles for things such as tmux, zsh, and xinit. 

Most scripts are further commented if you click through the link. 

## Description

 * <a href='https://github.com/kristopolous/tools/blob/master/bin/authadd'>authadd</a>: Similar to ssh-copy-id but seems to work more.
 * <a href='https://github.com/kristopolous/tools/blob/master/bin/brightness'>brightness</a>: x86 screen brightness tool for xbindkeys.
 * <a href="https://github.com/kristopolous/tools/blob/master/bin/chooser">chooser</a>: An 802.11 scanner and chooser.
 * <a href="https://github.com/kristopolous/tools/blob/master/bin/config-all">config-all</a>: Used with ./configure, fills in all the prefix, lib, bin, sbin, man, info etc directories to point to a single install point.
 * <a href="https://github.com/kristopolous/tools/blob/master/bin/external">external</a>: A script I use to dock the laptop and rerun keyboard mappings.
 * <a href="https://github.com/kristopolous/tools/blob/master/bin/git_diff_wrapper">git_diff_wrapper</a>: A wrapper to put in .git/config (read the file to find out how to use it).
 * <a href="https://github.com/kristopolous/tools/blob/master/bin/git-last-modified">git-last-modified</a>: A way to view the last modified dates (with respect to git) of the files in a directory.
 * <a href="https://github.com/kristopolous/tools/blob/master/bin/hotspot">hotspot</a>: A script I use to test mobile from my laptop.
 * <a href="https://github.com/kristopolous/tools/blob/master/bin/indiff">indiff</a>: A tool for comparing code differences. See [this reddit post](https://www.reddit.com/r/vim/comments/1tapo8/indiff_inline_visual_diff_comparisons/).
 * [internal](https://github.com/kristopolous/tools/blob/master/bin/internal): A script I use when undocking my laptop. This is the companion script to external.
 * [inotify](https://github.com/kristopolous/tools/blob/master/bin/inotify): A way to see when a collection of files is accessed. Also see the [sysdig](https://github.com/draios/sysdig) project I contribute to.
 * [laptop-power-saving](https://github.com/kristopolous/tools/blob/master/bin/laptop-power-saving): The various tricks I've learned to make the most of my laptop battery
 * minimal: A minimal-level battery saving setting (used in conjunction with the prior script)
 * my_xterm: Just a dumb xterm wrapper in acidx for notion.
 * nvmsh: Starts nvm (which has a multi-second load time, so it's not in .zshrc)
 * osd_time: Puts a tiny clock in the top right
 * reassoc: A tool that agressively gets a new ip address because sometimes dhclient just isn't enough
 * ssh_config: Just a base level system with the control master settings that
 * sshot: A poor man's screen sharing application.
 * strace-all: This will do a ps and grep for the string that is the last argument, then it will strace the pids of all of them simultaneously with parallelized xargs, following vforks
 * update-tags: Updates ctags and cscope ; useful for emacs and vim code navigation
 * waitfor: A blocking thing of the above (see description in the c file)
 * wpa: A script that maintains wpa_supplicant sanely (used with reassoc)
 * youtube-dl: From http://rg3.github.com/youtube-dl/download.html

## Install

There's an installer that will put these into your `$HOME/bin` directory
If you trust me just run

    $ ./installer

And then add `$HOME/bin` to your path.

## History

The earliest file here goes back to 2000 (dotfiles/.twmrc) ... I began using Linux I believe in 1998.
