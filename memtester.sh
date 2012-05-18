#!/bin/bash

# Memtester
# by Dan Barrett
# http://theblahman.net

# v1.0 - 18/05/2012
# Initial release

# Assuming you have the memtest CLI utility,
# this script copies memtest to the /usr/bin
# folder before adding aliases to /etc/profile
# so when the Mac boots to single user mode,
# it will be executed on boot completion

# 99% of the time, disk0s2 is the Mac boot volume
disk=`diskutil list | grep 'disk0s2'`
# Get the stuff between partition type and size
disk=${disk:33:24}
# Remove any whitespace from end of name
disk=`echo $disk | sed 's/ *$//g'`
# If there's spaces in the disk name, add an escape slash
disk=`echo $disk | sed -e 's/ /\\\ /g'`

finalPath='/Volumes/'$disk'/usr/bin';

# Copy memtest to users HDD
sudo cp /Applications/memtest "$finalPath"

# Write our mt alias
echo "alias mt='memtest all -L 3'" | sudo tee -a /etc/profile
# Writes an alias to PRAM reset on reboot
echo "alias sreboot='nvram boot-args=\"-p -r\"'; reboot" | sudo tee -a /etc/profile

# Make our mt alias be run at root login
echo "echo ------- Memory Test -------" | sudo tee -a /var/root/.profile
echo "mt" | sudo tee -a /var/root/.profile
echo "echo ---- Ended Memory Test ----" | sudo tee -a /var/root/.profile

# Sets bootup to Single User Mode
sudo nvram boot-args="-s"

# Reboot
sudo reboot