#!/bin/bash

# Yesme
# by Dan Barrett
# http://theblahman.net

# v1.1 - 18/05/2012
# Initial release

# This script looks to see how many cores the Mac
# has before running multiple sessions of yes
# for each core.

control_c()
{
	echo "\n*** Exiting… ***"
	killall yes
	exit $?
}

trap control_c SIGINT

info=`system_profiler SPHardwareDataType | grep 'Cores:'`
info=${info:29}
info=`echo $info | sed 's/ *$//g'`
info=$[$info+1]

i="1"

while [ $i -lt $info ]
	do
	echo "Stressing Core: $i"
	yes > /dev/null &
	i=$[$i+1]
done

echo "Press Control + C to quit script and kill yes"

while true;
	do
	read x;
done