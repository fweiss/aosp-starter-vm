## File space
Ubuntu box only 64MB on /
reso sync failed out of space

Fix: modified Vagrantfile and use box that has large root filesystem

## Unspecified soong failures
Likely OOM

Fix: increas VM memory to 8192 GB

## Commands

lsblk
df
sudo parted /dev/sda print free
sudo fdisk -l /dev/sda
fdisk -l /dev/sda
swapoff -a

1. /dev/sda2 overlaps /dev/sda5
Try sudo parted /dev/sda rm 2
OK lsblk
reboot
no ssh
also, lost parted
looks like root is lost

sda
+ sda1
+ sda2
+ sda5
  + vagrant--vg-root
  + vagrant--vg-swap_1
  
sudo parted /dev/sda resizepart 5
can't have overlapping partitions



