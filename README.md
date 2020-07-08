# AOSP Starter VM
Goal is to build Android Open Source in a VirtualBox VM.

## VM

Why use a VM? 
- to avoid bogging down the host OS with all the AOSP tools
- to be able to reproduce an exact build environment

### ubuntu/trusty64
The nice thing about this is that it's got one root partition which uses all the available RAM.

The downside is it's got no swap, so an OOM Java Heap was encountered even with 8192 MB VM.

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

This takes about an hour the first time.

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

Didn't work.

### java.lang.OutOfMemoryError: Java heap space
In ``//frameworks/base:api-stubs-docs metalava``

Increase memory from 4096 to 8192. Not successful.

Add 16 GB swap. Not successful, but the problem may be the JVM configuration.

[Troubleshooting the Jack server](http://www.2net.co.uk/blog/jack-server.html). Might have a good hint about 
configuring Java heap space, but the Jack server wasn't used in this build.

``./prebuilts/jdk/jdk8/linux-x86/bin/java -version`` OK 1.8 openJDK

``./prebuilts/jdk/jdk8/linux-x86/bin/java -XshowSettings 2>&1  | grep Heap`` estimated 1.73G

But there is no ``~/.jack-seetings`` nor any jack on the filesystem.
I'mm seeing the heap space error in ``com.intellij.psi``

[Jack server is no longer used](https://stackoverflow.com/questions/60468693/java-outofmemoryerror-when-building-aosp-10)

Try ``export _JAVA_OPTIONS="-Xmx4g"``

> This does affect -XshowSettings: 3.5G

The build step that seems to be failing is in ``.frameworks/base/StubLibraries.bp``.

Try blanking out that file. Nix

Try removing StubLibraries.bp from Android.bp. Nix, breaks dependencies.

Display the make verbose log file with ``gzip -cd out/verbose.log.gz | less -R``

These were all with ``aosp_arm-eng``

Let's lunch something else, ``qemu_trusty_arm64-userdebug``

## Links and references

[An OVA for building AOSP ROMs](https://nathanpfry.com/builduntu-virtual-machine-android-rom-compiling/)

[Add swap space on Ubuntu](https://wohldani.com/how-to-add-swap-on-ubuntu-14-04/)

## Host memeory upgrdae 32 GB
Try ``build/soong/soong_ui.bash --make-mode --skip-make``

OOM

try ``export _JAVA_OPTIONS="-Xmx4g"`` and then ``8g``

Nope, still OOM

VM shows 8192 MB, 4 CPU

Lets' increase to 16,384

## Fresh start
With trusty64, 400 GB, 16384 MB, 4 cpus
``vagrant up``
16/21 (some were up to date)
``vagrant ssh``
``source /vagrant/setup.sh``
``git config --global user.email <email>``
``git config --global user.name <name>``
``repo init --depth 1 -u https://android.googlesource.com/platform/manifest``
repo init --depth 1 -u https://android.googlesource.com/platform/manifest
``repo sync -c --no-tags --no-clone-bundle -j2``
``source build/envsetup.sh``
``lunch aosp_flo-userdebug``
Can not locate config makefile for product "aosp_flo"
menu choose pixel3-mainline-userdebug
``make -j2``
you are building with 15,xxx MB ram, need 16 or more

20200707T2140
``#### build completed successfully (09:20:53 (hh:mm:ss)) ####``




