# AOSP Starter VM
Goal is to build Android Open Source in a VirtualBox VM.

## VM

Why use a VM? 
- to avoid bogging down the host OS with all the AOSP tools
- to be able to reproduce an exact build environment

### ubuntu/trusty64 (14.04)
The nice thing about this is that it's got one root partition which uses all the available storage.

The downside is it's got no swap, so an OOM Java Heap was encountered even with 8192 MB VM.

> But does it matter when there's 16+ GB of RAM?

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

Success, ca 24,700 MB host memory (Chrome and IntelliJ were closed).

```sbtshell
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
## Links and references
A quick tuturial including an actual customization.

https://www.polidea.com/blog/How-to-Build-your-Own-Android-Based-on-AOSP/

[A tutorial targeting a bus-stop app build for Nexus 7](https://www.intellectsoft.net/blog/build-and-run-android-from-aosp-source-code-to-a-nexus-7/)

> Apparently for the Nexus 7 2013 - 'flo'

Nexus 7 Drivers download page:

https://developers.google.com/android/drivers





