# AOSP Starter VM
Goal is to build Android Open Source in a VirtualBox VM.

> As a specific case, this project will target a Nexus 7 2012 "grouper" Android tablet.

## VM
Why use a VM? 
- to avoid bogging down the host OS with all the AOSP tools
- to be able to reproduce an exact build environment

> It's strongly recommended that the host system has 32 GB or more of RAM.
> Without sufficient RAM, the build will fail with out of memory errors.

### ubuntu/trusty64 (14.04)
The nice thing about this is that it's got one root partition which can use all the available storage.

> Only python 3.4.3 is available on 14.04

## Fresh start

With trusty64, 400 GB, 16384 MB, 4 cpus

``vagrant up``

Chef provisioning: 16/21 (some were up to date)

``vagrant ssh``

``source /vagrant/setup.sh``

``git config --global user.email <email>``

``git config --global user.name <name>``

## Next try for Nexus 7
Specificaly, for Nexus 7 2012 Wifi (grouper) 5.1.1

List available branches: https://android.googlesource.com/platform/manifest/+refs

Pick the latest, android-5.1.1_r38

``repo init -u https://android.googlesource.com/platform/manifest -b android-5.1.1_r38``

``repo sync -c``

Vendor device drivers. These come with license agreements from:
- ASUSTek
- Broadcom Corporation
- Elan Microelectronics Corporation
- Invense?
- Nvidia Corporation
- NXP Semiconductors Netherlands B.V
Google, Inc.

> The order may be important, e.g. broadcom overwrites stuff in asus

```
curl https://dl.google.com/dl/android/aosp/asus-grouper-lmy47v-f395a331.tgz | tar -xvzf - ; bash ./extract-asus-grouper.sh
curl https://dl.google.com/dl/android/aosp/broadcom-grouper-lmy47v-5671ab27.tgz | tar -xvzf - ; bash ./extract-broadcom-grouper.sh
curl https://dl.google.com/dl/android/aosp/elan-grouper-lmy47v-6a10e8f3.tgz | tar -xvzf - ; bash ./extract-elan-grouper.sh
curl https://dl.google.com/dl/android/aosp/invensense-grouper-lmy47v-ccd43018.tgz | tar -xvzf - ; bash ./extract-invensense-grouper.sh
curl https://dl.google.com/dl/android/aosp/nvidia-grouper-lmy47v-c9005750.tgz | tar -xvzf - ; bash ./extract-nvidia-grouper.sh
curl https://dl.google.com/dl/android/aosp/nxp-grouper-lmy47v-18820f9b.tgz | tar -xvzf - ; bash ./extract-nxp-grouper.sh
curl https://dl.google.com/dl/android/aosp/widevine-grouper-lmy47v-e570494f.tgz | tar -xvzf - ; bash ./extract-widevine-grouper.sh
```

``. build/envsetup.sh``

``lunch aosp_grouper-userdebug``

``make -j2``

Success, ca 24,700 MB host memory (includes other running app on the host).

```
Installed file list: out/target/product/grouper/installed-files.txt
Target system fs image: out/target/product/grouper/obj/PACKAGING/systemimage_intermediates/system.img
Running:  mkuserimg.sh -s out/target/product/grouper/system out/target/product/grouper/obj/PACKAGING/systemimage_intermediates/system.img ext4 system 681574400 -j 0 out/target/product/grouper/root/file_contexts
make_ext4fs -s -T -1 -S out/target/product/grouper/root/file_contexts -l 681574400 -J -a system out/target/product/grouper/obj/PACKAGING/systemimage_intermediates/system.img out/target/product/grouper/system
Creating filesystem with parameters:
    Size: 681574400
    Block size: 4096
    Blocks per group: 32768
    Inodes per group: 6944
    Inode size: 256
    Journal blocks: 0
    Label:
    Blocks: 166400
    Block groups: 6
    Reserved block group size: 47
Created filesystem with 1357/41664 inodes and 72678/166400 blocks
Install system fs image: out/target/product/grouper/system.img
out/target/product/grouper/system.img+out/target/product/grouper/obj/PACKAGING/recovery_patch_intermediates/recovery_from_boot.p maxsize=695844864 blocksize=4224 total=288627210 reserve=7028736

#### make completed successfully (03:08:42 (hh:mm:ss)) ####
```

## Flashing the device
Copy the Android image files to the host so that flashing can be done form the host.

> See section below for failed attempt to flash directly from VM.

On the guest VM:
```
mkdir -p /vagrant/out/target/product/grouper
cp out/target/product/grouper/*.img out/target/product/grouper/android-info.txt ./out/target/product/grouper
```

On the host:

``set ANDROID_PRODUCT_OUT=out/target/product/grouper``
``fastboot flashall``

Tried using platform tools 30.0.3. Use 26 instead

```
E:\Programs\platform-tools>fastboot flashall
target didn't report max-download-size
--------------------------------------------
Bootloader Version...: 4.23
Baseband Version.....: N/A
Serial Number........: 015d4a826a07fe05
--------------------------------------------
checking product...
OKAY [  0.030s]
sending 'boot' (5238 KB)...
OKAY [  0.657s]
writing 'boot'...
OKAY [  0.223s]
sending 'recovery' (5790 KB)...
OKAY [  0.733s]
writing 'recovery'...
OKAY [  0.244s]
erasing 'system'...
OKAY [  0.835s]
sending 'system' (281483 KB)...
OKAY [ 34.467s]
writing 'system'...
OKAY [ 16.991s]
rebooting...

finished. total time: 54.294s
```
Takes a while to reboot


## Failed attempt to access device from guest VM
The follwoing to get adb to access device.

``PATH=~/aosp/out/host/linux-x86/bin:$PATH``

``lsusb``

Note the id, example ``18d1:4e40``

``sudo vi /etc/udev/rules.d/51-android.rules``

Add:

```
SUBSYSTEMS=="usb", ATTRS{idVendor}=="18d1", ATTRS{idProduct}=="4e40", MODE="0666" GROUP="androiddev", SYMLINK+="nexus7"
SUBSYSTEM=="usb", ATTRS{idVendor}=="18d1", ATTRS{idProduct}=="4e40", MODE="0666" GROUP="plugdev", SYMLINK+="nexus7"
```

Replacing idVendor, idProduct, SYMLINK

``usermod -a -G plugdev vagrant``

``sudo service udev restart``

Maybe

``vi ~/.android/adb_usb.ini``

Add 

``0x18d1``

``adb kill-server && adb start-server``

Reattach device

``adb devices``

https://android.stackexchange.com/questions/144966/how-do-i-get-my-device-detected-by-adb-on-linux

### Notes

Turn off USB MTP, so no drive appears on the host.

- Settings > Storage
- Top right menu > USB computer connection
- Media device (MTP) turn off
- but lsusb was empty because nbot in bootloader mode

Looking for /dev/bus/usb/002

try USB 2.0 VB bridge
- now /dev/usb/002 shows up
- actually
-  udevadm info -q all -n /dev/bus/usb/001/002
-  aka /dev/nexus7
-  adb v1.0.32
 
Try

``sudo apt install virtualbox-ext-pack`` not found, even apt-get

### USB tunnel for adb
Try use VB to forward port 5037

https://stackoverflow.com/questions/12477987/android-usb-debugging-in-virtualbox

On the host, instal adb tools.
-- adb devices

On VB, remove the USB bridge

On guest check connection
- telnet 10.0.2.2 5037

``sudo apt-get autoshh``
``autossh -nNL5037:localhost:5037 -oExitOnForwardFailure=yes 10.0.2.2``
This doesn't work, expects ssh on host.

## Links and references
A quick tuturial including an actual customization.

https://www.polidea.com/blog/How-to-Build-your-Own-Android-Based-on-AOSP/

[A tutorial targeting a bus-stop app build for Nexus 7](https://www.intellectsoft.net/blog/build-and-run-android-from-aosp-source-code-to-a-nexus-7/)

> Apparently for the Nexus 7 2013 - 'flo'

Nexus 7 Drivers download page:

https://developers.google.com/android/drivers





