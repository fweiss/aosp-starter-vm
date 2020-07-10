# AOSP Starter VM
Goal is to build Android Open Source in a VirtualBox VM.

## VM

Why use a VM? 
- to avoid bogging down the host OS with all the AOSP tools
- to be able to reproduce an exact build environment

### ubuntu/trusty64
The nice thing about this is that it's got one root partition which uses all the available storage.

The downside is it's got no swap, so an OOM Java Heap was encountered even with 8192 MB VM.

> But does it matter when there's 16+ GB of RAM?

## Fresh start

With trusty64, 400 GB, 16384 MB, 4 cpus

``vagrant up``

Chef provisioning: 16/21 (some were up to date)

``vagrant ssh``

``source /vagrant/setup.sh``

``git config --global user.email <email>``

``git config --global user.name <name>``

``repo init --depth 1 -u https://android.googlesource.com/platform/manifest``

> Here's where to choose a particular branch, such as ``android-6.0.1_r55``

``repo sync -c --no-tags --no-clone-bundle -j2``

``source build/envsetup.sh``

``lunch aosp_flo-userdebug``

Can not locate config makefile for product "aosp_flo"

``lunch``

Menu choose pixel3-mainline-userdebug

``make -j2``

you are building with 15,xxx MB ram, need 16 or more

``#### build completed successfully (09:20:53 (hh:mm:ss)) ####``

Host system memory usage about 30,962 MB, but not sure:
- how much was other host system processes
- if it was in use - it was still shown after make exited

```
ls -l out/target/product/generic/system.img
-rw-rw-r-- 1 vagrant vagrant 1000849408 Jul  8 04:37 out/target/product/generic/system.img
```

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

## Links and references
A quick tuturial including an actual customization.

https://www.polidea.com/blog/How-to-Build-your-Own-Android-Based-on-AOSP/

[A tutorial targeting a bus-stop app build for Nexus 7](https://www.intellectsoft.net/blog/build-and-run-android-from-aosp-source-code-to-a-nexus-7/)

> Apparently for the Nexus 7 2013 - 'flo'

Nexus 7 Drivers download page:

https://developers.google.com/android/drivers





