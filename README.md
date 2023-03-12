# *Evaluation-signature.txt
```
shasum Born2beRoot.vdi
```

# Evaluation-MandatoryPart-[Project overview]

## How a virtual machine works.
VM working through "Virtualization" technology. 
Virtualization uses software to simulate virtual hardware that allows 
VMs to run on a single host machine.
(borrowed CPU, memory, and storage from a physical host computer, such as your personal computer) 

## Their choice of operating system
Debian

## The basic differences between Rocky and Debian.
### Audience
- Debian: Operating system for individuals
- Rocky: HPC Managers, Linux Software Engineers, C-Suite Executive
*Debian is highly recommended if you are new to system administration.

## The purpose of virtual machines.
The big draw of virtualization is to operate multiple displays and even systems — Linux and Windows, for example — from the same console. his allows users to toggle among applications regardless of their OS. And resource consumption with VMware can be remarkably lower than resource consumption with multiple hardware-based systems.

## The difference between Apt and Aptitute
Aptitude is an enhanced version of apt. APT is a lower level package manager and aptitude is a higher level package manager. Another big difference is the functionality offered. Aptitude offers better functionality compared. 

## What is AppArmor
A security module of the Linux kernel that allows the system administrator to restrict the capabilities of a program.
```
sudo aa-status
```

# Evaluation-MandatoryPart-[Simple setup]

## Ensure that the machine does not have a graphical environment at launch. 
(A password will be requested before attempting to connect to this machine.Finally,connect with a user with the help of the student being evaluated. This user must not be root. Pay attention to the password chosen, it must follow the rules imposed in the subject.)
```
ls /usr/bin/*session
```
if we dont have a graphical environment:
```
/usr/bin/dbus-run-session
```

## Check that the UFW service is started with the help of the evaluator
```
sudo ufw status
```
```
sudo service ufw status
```

## Check that the SSH service is started with the help of the evaluator.
```
sudo service ssh status
```

## Check that the chosen operating system is Debian or Rocky
(with the help of the evaluator. If something does not work as expected or is not clearly explained,the evaluation stops here.)
```
uname -v
```

# Evaluation-MandatoryPart-[User]

## Check the user [login42] has been added and that it belongs to the "sudo" and "user42" groups.
```
getent group sudo
```
```
getent group user42
```

## Make sure the rules imposed in the subject concerning the password policy have been put in place
- Create a new user (for ex. named [newuser]).
```
sudo adduser newuser
```
- Befor that we had better to show the [Strong Password Policy]:
```
sudo vim /etc/login.defs
```
```
160 PASS_MAX_DAYS   30
161 PASS_MIN_DAYS   2
162 PASS_WARN_AGE   7
```
Set password to expire every 30 days, minimum number of days between password changes to 2 days, send user a warning message 7 days (defaults to 7 anyway) before password expiry.
```
sudo vim /etc/pam.d/common-password
```
```
25 password        requisite                       pam_pwquality.so retry=3 minlen=10 ucredit=-1 dcredit=-1 maxrepeat=3 reject_username difok=7 enforce_for_root 
```
Set password minimum length to 10 characters, Require password to contain at least an uppercase character and a numeric character, Set a maximum of 3 consecutive identical characters, Reject the password if it contains [username], Set the number of changes required in the new password from the old password to 7, Same policy on root.

- Create a new group named [evaluating].
```
sudo addgroup evaluating
```

- Add the new user [newuser] to group [evaluating].
```
sudo adduser newuser evaluating
```

- Check that the [newuser] belongs to group [evaluating].
```
sudo getent group evaluating
```

# Evaluation-MandatoryPart-[Hostname and partitions]

## Check that the hostname of the machine is correctly: login42.
```
hostname
```

## Modify this hostname by replacing the login with evaluator's, then restart the machine.
- Modify the name. 
```
sudo vim /etc/hostname
```
```
evaluator42
```

- Restart. 
```
sudo reboot
```

- Check the hostname.
```
hostname
```

- Restore the machine to the original hostname.
```
sudo vim /etc/hostname
```
```
login42
```
```
sudo reboot
```
```
hostname
```

## How to view the partitions for this virtual machine. (查看分区)
(Compare the output with the example given in the subject. Please note: if the student evaluated makes the bonuses, it will be necessary to refer to the bonus example.)(要获得奖金需要手动分配)
```
lsblk
```
## How LVM works and what it is all about.
LVM (Logical Volume Manager) is an abstraction layer between a storage device and a file system. By using LVM, we can expand the storage of any partition, we can do this with available storage located on different physical disks (which we cannot do with traditional partitions).

# Evaluation-MandatoryPart-[SUDO]

## Check that the "sudo" program is properly installed on the virtual machine.
```
which sudo
```

## What is sudo.
super user do

- Add your new user [newuser] to [sudo] group.
```
sudo adduser newuser sudo
```

- Check that the [newuser] belongs to [sudo] group.
```
sudo getent group sudo
```

- Show you the implementation of the rules imposed by the subject.
```
cat /etc/sudoers.d/sudoconfig
```
```
Defaults    passwd_tries=3 \\ 3 trise for password
Defaults	badpass_message="Incorrect sudo password, you have total 3 tries."
Defaults	logfile="/var/log/sudo/sudoconfig" \\ Log all sudo commands to /var/log/sudo/sudoconfig 把所有sudo命令记录到/var/log/sudo/sudoconfig
Defaults	log_input,log_output \\ Archive all sudo inputs & outputs to /var/log/sudo/ 把所有sudo输入和输出存档到/var/log/sudo/
Defaults	iolog_dir="/var/log/sudo"
Defaults	requiretty \\ Require TTY 要求TTY
Defaults	secure_path="/usr/local/sbin:/usr/local/bin:/usr/sbin:/usr/bin:/sbin:/bin:/snap/bin" \\ set sudo paths to ... 把sudo路径设置到这里
```

- *Test incorrect sudo password
```
sudo ufw status
```

- *What is TTY?

"TTY" is an acronym for "teletype", which refers to a computer's terminal interface. When using the sudo command, you may see the -t option followed by a TTY number, for example -t 1.

This option allows you to specify which terminal the sudo command should be run on. By default, the sudo command is run on the current terminal (the one you are currently on).

- Verify that the "/var/log/sudo/" folder

(You should see a history of the commands used with sudo.Try to run a command via sudo. See if the file (s) in the "/var/log/sudo/" folder have been updated.)
```
cat /var/log/sudo/sudoconfig
```
```
sudo ufw status
```
```
cat /var/log/sudo/sudoconfig
```

# Evaluation-MandatoryPart-[UFW/Firewalld]

## What is UFW and how it works.
UFW (Uncomplicated Firewall) is a software application responsible for ensuring that the system administrator can manage iptables in a simple way. Once we have UFW installed, we can choose which ports we want to allow connections, and which ports we want to close. This will also be very useful with SSH.

- Check that the UFW program is properly installed on the virtual machine
```
dpkg -s ufw
```

- Check that it is working properly.
```
sudo service ufw status
```
```
sudo ufw status
```

- List the active rules in UFW (or Firewalld).A rule must exist for port 4242.
```
sudo ufw status numbered
```

- Add a new rule to open port 8080. Check that this one has been added by listing the active rules.
add:
```
sudo ufw allow 8080
```
check:
```
sudo ufw status numbered
```

- Delete this new rule
delete:
```
sudo ufw delete [rule nbr]
```

# Evaluation-MandatoryPart-[SSH]

## What is SSH.
Secure Shell (SSH) is a network protocol that allows you to remotely connect to a computer and send it commands remotely. It is commonly used to access remote servers or computers in a secure and encrypted manner, using an encrypted connection.

- Check that the SSH service is properly installed on the virtual machine.
```
which ssh
```

- Check that it is working properly. Verify that the SSH service only uses port 4242.
```
sudo service ssh status
```

- Use SSH in order to log in with the newly created user [newuser]. 
```
ssh -p 2222 newuser@localhost
```

- Cannot use SSH with the "root" user as stated in the subject.
```
ssh -p 2222 root@localhost
```

# Monitoring & Crontab 

## Monitoring
- The architecture of your operating system and its kernel version.
- The number of physical processors.
- The number of virtual processors.
- The current available RAM on your server and its utilization rate as a percentage.
- The current available memory on your server and its utilization rate as a percentage.
- The current utilization rate of your processors as a percentage.
- The date and time of the last reboot.
- Whether LVM is active or not.
- The number of active connections.
- The number of users using the server.
- The IPv4 address of your server and its MAC (Media Access Control) address.
- The number of commands executed with the sudo program.

```
vim /home/monitoring.sh
```
```
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
```

- *wall

displays a message, or the contents of a file, or otherwise its standard input, on the terminals of all currently logged in users. The command will wrap lines that are longer than 79 characters. Short lines are whitespace padded to have 79 characters. The command will always put a carriage return and new line at the end of each line.(控制格式)

## Crontab
- edit
```
sudo crontab -u root -e
```
```
# m h  dom mon dow   command
*/10 * * * * /home/monitoring.sh
```
10 -> 1
从10分钟一次变成1分钟一次
- cat
```
sudo crontab -u root -l
```

# *Power off (0s) [0秒关机]
```
sudo shutdown 0
```

# *install oh my bash

## 1. install git (for debian)
```
apt update
```
```
apt install git
```

## 2. install oh my bash
```
bash -c "$(wget https://raw.githubusercontent.com/ohmybash/oh-my-bash/master/tools/install.sh -O -)"
```