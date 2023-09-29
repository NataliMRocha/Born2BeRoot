#!/bin/bash

ARCH=$(uname -srvmo | sed 's/PREEMPT_DYNAMIC//g')
CPU_PHY=$(grep 'physical id' /proc/cpuinfo | uniq | wc -l)
VIRPROCESS=$(grep processor /proc/cpuinfo | uniq | wc -l)
USEDRAM=$(free -h | grep Mem | awk '{print $3}' | sed 's/Mi//g')
TOTALRAM=$(free -h | grep Mem | awk '{print $2}' | sed 's/Mi//g')
PERCENTRAM=$(free -k | grep Mem | awk '{printf("%.2f%%"), $3 / $2 * 100}')
USEDMEM=$(df -h --total | grep total | awk '{print $3}' | sed 's/G//g')
TOTALMEM=$(df -h --total | grep total | awk '{print $2}')
PERCENTMEM=$(df -k --total | grep total | awk '{print $5}')
CPU_LOAD=$( | grep all | awk '{printf("%s%%", 100 - $12)}')
LASTBOOT=$(who -b | awkmpstat '{print($4 " " $5)}')
LVMACTIVE=$(lsblk -f | grep LVM  -oq && echo yes || echo no)
ACTIVECONEC=$(ss -s | grep estab | awk '{print $4}' | sed 's/,//g')
USERUSING=$(who | wc -l)
IPV4=$(hostname -I | awk '{print $1}')
MAC=$(ip link show | grep link/ether | awk '{print $2}')
SUDONB=$(grep COMMAND /var/log/sudo/sudo.log | wc -l)

echo " # Architecture:  ${ARCH}"
echo " # CPU physical           ${CPU_PHY}"
echo " # vCPU:          ${VIRPROCESS}"
echo " # Memory Usage:  ${USEDRAM}/${TOTALRAM}MB (${PERCENTRAM})"
echo " # Disk Usage:            ${USEDMEM}/${TOTALMEM} (${PERCENTMEM})"
echo " # CPU load:              ${CPU_LOAD}"
echo " # Last Boot:             ${LASTBOOT}"
echo " # LVM use:               ${LVMACTIVE}"
echo " # Connections TCP:       ${ACTIVECONEC} ESTABLISHED"
echo " # User log:              ${USERUSING}"
echo " # Networks:              ${IPV4} (IP) / ${MAC} (MAC)"
echo " # Sudo:          ${SUDONB} cmd"
