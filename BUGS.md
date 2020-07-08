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

## soong
```[ 98% 20375/20767] soong_build docs out/soong/.primary/docs/soong_build.html
   FAILED: out/soong/.primary/docs/soong_build.html
   out/soong/.bootstrap/bin/soong_build -t -l out/.module_paths/Android.bp.list -b out/soong --docs out/soong/.primary/docs/soong_build.html ./Android.bp
   panic: Get() called before Once()
   
   goroutine 1 [running]:
   android/soong/android.(*OncePer).Get(0xc0001c56a8, 0xac1f40, 0xc0000e00c0, 0x28dc27c2f6d24a9, 0xc049580600)
           /home/vagrant/aosp/build/soong/android/onceper.go:76 +0xed
   android/soong/android.ReadSoongMetrics(...)
           /home/vagrant/aosp/build/soong/android/metrics.go:34
   android/soong/android.collectMetrics(0xc0001c4c00, 0x0)
           /home/vagrant/aosp/build/soong/android/metrics.go:61 +0x97
   android/soong/android.WriteMetrics(0xc0001c4c00, 0xc0168c8000, 0x20, 0xc0168c8000, 0x20)
           /home/vagrant/aosp/build/soong/android/metrics.go:75 +0x2f
   main.main()
           /home/vagrant/aosp/build/soong/cmd/soong_build/main.go:139 +0x6e6```


