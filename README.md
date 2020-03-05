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

sorta work with repo

speed up repo sync

``repo sync -c --no-tags --no-clone-bundle -j2``

better

``repo init --depth 1``

