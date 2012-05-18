#!/bin/bash

# Yesme
# by Dan Barrett
# http://theblahman.net

# v1.1 - 18/05/2012
# Initial release

# This script looks to see how many cores the Mac
# has before running multiple sessions of yes
# for each core.

# Function that cleans the yes sessions before exiting
control_c()
{
	echo "\n*** Exiting… ***"
	killall yes
	exit $?
}

# Hook so if the script is quited, kill the yes'
trap control_c SIGINT

# Get the number of cores from System Profiler/Information
info=`system_profiler SPHardwareDataType | grep 'Cores:'`
# Start the string at the core numbers
info=${info:29}
# Remove any whitespace at the end
info=`echo $info | sed 's/ *$//g'`
# Add a extra core because...
info=$[$info+1]

# Set our loop var
i="1"

while [ $i -lt $info ]
	do
	echo "Stressing Core: $i"
	# Start a yes session in the background
	yes > /dev/null &
	i=$[$i+1]
done

echo "Press Control + C to quit script and kill yes"

# Adding this while means the script doesn't return
# straight after running
while true;
	do
	read x;
done