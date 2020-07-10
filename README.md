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

## Links and references
A quick tuturial including an actual customization.

https://www.polidea.com/blog/How-to-Build-your-Own-Android-Based-on-AOSP/






