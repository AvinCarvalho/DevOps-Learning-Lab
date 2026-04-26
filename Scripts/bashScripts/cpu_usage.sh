#!/bin/bash

THRESHOLD=80

CPU_USAGE = $(top -bn1 | grep "Cpu(s)" | awk '{print 100 - $8}')
CPU_INT = ${CPU_USAGE%.*}

if ["$CPU_INT"-gt "$THRESHOLD"]; then
   echo "Alert CPU is usage is more : $CPU_INT"
else
   echo "CPU Usage is Normal : $CPU_INT "
fi 

*/5 * * * * /home/DevOps_Learning-Lab/bashScripts/Cpu_usage.sh >> cpu.log

 
