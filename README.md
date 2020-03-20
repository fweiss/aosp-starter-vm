# AOSP Starter VM
Goal is to build Android Open Source in a VirtualBox VM.

Why use a VM? 
- to avoid bogging down the host OS with all the AOSP tools
- to be able to reproduce an exact build environment

https://source.android.com/setup/start

https://source.android.com/setup/build/initializing

Ubunto 14.04

Your Hardware Enablement Stack (HWE) is supported until April 2019.


https://source.android.com/setup/build/downloading

Ubuntu 16.4

python 3.5.2

sorta works with repo

## Repo

Setup and install repo:

``source /vagrant/setup.sh``

Configure git identity:

``git config --global user.email <email>``, etc

Initialize the repo:

``repo init --depth 1 -u https://android.googlesource.com/platform/manifest``

Sync the repo:

``repo sync -c --no-tags --no-clone-bundle -j2``

This takes about an hour

> Warning: Python 2 is no longer supported: please upgrade to Python 3.6+

## Vagrant

``vagrant plugin install vagrant-disksize``

``vagrant up``

`` vagrant ssh``

Couldn't get the VM file size sorted out.

## Try OVA

https://nathanpfry.com/builduntu-virtual-machine-android-rom-compiling/

Need bitorrent client to get the download.

RPI 3 and RPI 4 in ./external/arm-trsuted-firmware.

## AOSP for Nexus
https://www.intellectsoft.net/blog/build-and-run-android-from-aosp-source-code-to-a-nexus-7/

repo init -u https://android.googlesource.com/platform/manifest -b android-6.0.1_r55

Your version is: openjdk version "1.8.0_242" OpenJDK Runtime Environment
requierd version "1.7.x"

sudo apt-get update
sudo apt-get install openjdk-7-jdk

Here's a group that "unlegacifies" old android kernels: https://www.unlegacy-android.org/projects/unlegacy-android/wiki/Main_Page

unset NDK_ROOT?

## Bugs
no space left on device
target /home/vagrant/aosp
/ filesystem had only 64 GB
edit Vagrantfile
vagrant plugin install vagrant-disksize
but then ipv6 netowrk error
https://tweaks.com/windows/40099/how-to-properly-disable-ipv6/
HKEY_LOCAL_MACHINE\SYSTEM\CurrentControlSet\services\TCPIP6\Parameters\DisabledComponents = 0xFF

make -j2
including ./external/zlib/Android.mk
buld/core/base_rules.mk:157: *** external/zlib: MODULE.TARGET.SHARED_LIBRARIES.libz already defined by external/arm-trusted-firmware/lib/zlib/zlib

### failed to build some targets
Probable OOM. Was using 2048 MB, 2 CPUs.
Upped to 4096

### ninja: build stopped: subcommand failed
Try ``export LC_ALL=C``

## Links and references

[An OVA for building AOSP ROMs](https://nathanpfry.com/builduntu-virtual-machine-android-rom-compiling/)



