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
sudo vi /etc/login.defs
```
```
160 PASS_MAX_DAYS   30
161 PASS_MIN_DAYS   2
162 PASS_WARN_AGE   7
```
Set password to expire every 30 days, minimum number of days between password changes to 2 days, send user a warning message 7 days (defaults to 7 anyway) before password expiry.
```
sudo vi /etc/pam.d/common-password
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

# *Power off (0s) [0秒关机]
```
sudo shutdown 0
```