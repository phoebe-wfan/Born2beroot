# Evaluation-MandatoryPart-[Project overview]

## How a virtual machine works.
Virtual machines are made possible through virtualization technology.
Virtualization is the process of creating a software-based, or "virtual" version of a computer, with dedicated amounts of CPU, memory, and storage that are "borrowed" from a physical host computer—such as your personal computer— and/or a remote server—such as a server in a cloud provider's datacenter. 

## Their choice of operating system
Debian

## The basic differences between Rocky and Debian.
### Audience
- Debian: Operating system for individuals
- Rocky: HPC Managers, Linux Software Engineers, C-Suite Executive

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
sudo adduser name_user evaluating
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
