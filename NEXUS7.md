# Nexus 7

- Model: ME370T (2012) 32 GB
- Product: grouper
- Variant: grouper
- Bootloader: 4.23
- HW: ER3
- Lock state: locked

- Android version: 5.1.1
- Kernel version: 3.1.10-gf5d7b7b8b
- android-build@vpbs1,mtv.corp.google.com
- Thu Jan 8 04:50:16 YTC 2015

Build number
LMY47V

Available AOSP builds
- AOSP 6.0
- AOSP 7.1

## Unlocking
Unlocking the bootloader is necessary to install custom operating systems. 
It's pretty easy. Just note that it wipes out any user data on the device.

- download the android platform tools
- unzip and extract to a suitable directory
- open a command prompt in the directory
- add to the path, e.g. ``export PATH=`pwd`:$PATH``
- ensure the device has USB debugging enabled
- use adb to boot into the the bootloader ``adb boot bootloader``
- use fastboot to unlock the bootloader ``fastboot oem unlock``
- on the device, confirm the unlock
- start the device

> You may want to enable developer options and USB debugging, since these
> settings were also erased.




