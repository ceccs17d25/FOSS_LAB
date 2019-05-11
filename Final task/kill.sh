#!/bin/bash

## Note: will kill the top-most process if the $CPU_LOAD is greater than the $CPU_THRESHOLD.
echo
echo checking for run-away process ...

CPU_LOAD=$(uptime | cut -d"," -f4 | cut -d":" -f2 | cut -d" " -f2 | sed -e "s/\.//g")
CPU_THRESHOLD=3 # CPU threshold to handle
# TOPPROCESS=$(ps -eo pid -eo pcpu -eo command | sort -k 2 -r | grep -v PID | head -n 1)
echo cpu load--- $CPU_LOAD

if [ $CPU_LOAD -gt $CPU_THRESHOLD ] ; then
  # below line will list all the processes more than cpu threshold with its PID, CPU USAGE, AND ITS COMMAND means the process name running and the path where the package is installed
  echo TOP PROCESSES---- $(ps aux --sort=-%cpu | awk 'NR==1{print $2,$3,$11}NR>1{if($3>'$CPU_THRESHOLD') print $2,$3,$11}')

  # below line will kill all the process greater than cpu threshold with its pid
  for pro in $(ps aux --sort=-%cpu | awk 'NR>1{if($3>'$CPU_THRESHOLD') print $2}'); do kill -9 $pro; done;

  echo system overloading!
  echo load average is at $CPU_LOAD
  echo Active processes...
  ps aux r # all running active processes
else
 echo
 echo no run-aways. 
 echo load average is at $CPU_LOAD
 echo 
 echo Active processes...
 ps aux r
fi
exit 0
