#!/bin/bash
# This will be run when the lid closes.
# The process will go to sleep here
sleep 10

# When it comes back online, it will resume with the following:

# Start the PM system
tlp start

# Disable the watch dog timer
echo 0 > /proc/sys/kernel/nmi_watchdog

# Enable HD power saving
echo Y > /sys/module/snd_hda_intel/parameters/power_save_controller
echo 1 > /sys/module/snd_hda_intel/parameters/power_save

# Make the cache busting of the vm very lazy
echo 120000 > /proc/sys/vm/dirty_writeback_centisecs 

# Put the PCI devices in power control
for i in /sys/bus/pci/devices/*/power/control; do 
  echo auto > $i
done

# Say we want to manage our VM in laptop (power effecient) mode.
echo 5 > /proc/sys/vm/laptop_mode

# Bring the screen brightness down
echo 3 > /sys/devices/*/*/backlight/acpi_video0/brightness

# Enable on-demand frequency scaling
for i in `cat /proc/cpuinfo | grep processor | awk ' { print $NF } '`; do
  cpufreq-set -c $i -g ondemand 
done

# Turn off unneeded LEDS
for i in /sys/class/leds/*/brightness; do 
  echo 0 > $i
done
