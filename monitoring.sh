#!/bin/bash
arc=$(uname -a) #architecture (linux debian...)
pcpu=$(grep "physical id" /proc/cpuinfo | sort | uniq | wc -l) #nbr physical cpu
vcpu=$(grep "^processor" /proc/cpuinfo | wc -l) #nbr virtual cpu
fram=$(free -m | awk '$1 == "Mem:" {print $2}') #memory total(memory内存)
uram=$(free -m | awk '$1 == "Mem:" {print $3}') #memory used
pram=$(free | awk '$1 == "Mem:" {printf("%.2f"), $3/$2*100}') #memory percentage(%)
fdisk=$(df -Bg | grep '^/dev/' | grep -v '/boot$' | awk '{ft += $2} END {print ft}') #disk total(disk硬盘)
udisk=$(df -Bm | grep '^/dev/' | grep -v '/boot$' | awk '{ut += $3} END {print ut}') #disk used
pdisk=$(df -Bm | grep '^/dev/' | grep -v '/boot$' | awk '{ut += $3} {ft+= $2} END {printf("%d"), ut/ft*100}') #(%)
cpul=$(top -bn1 | grep '^%Cpu' | cut -c 9- | xargs | awk '{printf("%.1f%%"), $1 + $3}') #(cpu使用率)cpu usage%
lb=$(who -b | awk '$1 == "system" {print $3 " " $4}') #last boot date and time
lvmt=$(lsblk | grep "lvm" | wc -l) #LVM active?
lvmu=$(if [ $lvmt -eq 0 ]; then echo no; else echo yes; fi) 
ctcp=$(cat /proc/net/sockstat{,6} | awk '$1 == "TCP:" {print $3}') #cat (tcp协议)
ulog=$(users | wc -w) #nbr user log
ip=$(hostname -I) #ipv4 address
mac=$(ip link show | awk '$1 == "link/ether" {print $2}') #mac adress
cmds=$(journalctl _COMM=sudo | grep COMMAND | wc -l) #nbr sudo commands
wall "	#Architecture: $arc
	#CPU physical: $pcpu
	#vCPU: $vcpu
	#Memory Usage: $uram/${fram}MB ($pram%)
	#Disk Usage: $udisk/${fdisk}Gb ($pdisk%)
	#CPU load: $cpul
	#Last boot: $lb
	#LVM use: $lvmu
	#Connexions TCP: $ctcp ESTABLISHED
	#User log: $ulog
	#Network: IP $ip ($mac)
	#Sudo: $cmds cmd" 
