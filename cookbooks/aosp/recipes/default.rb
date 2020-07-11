# GOAL: install the prerequisites for building AOSP

# https://source.android.com/setup/build/initializing

apt_update

# ubuntu 18.04 already has python 3.6.7
# repo: warning: Python 2 is no longer supported; Please upgrade to Python 3.6+.
apt_package 'python'
apt_package 'python3'
apt_package 'python3-pip'
apt_package 'python3-pexpect'

apt_package 'git-core'
apt_package 'gnupg'
apt_package 'flex'
apt_package 'bison'
apt_package 'gperf'
apt_package 'build-essential'
apt_package 'zip'
apt_package 'curl'
apt_package 'zlib1g-dev'
apt_package 'gcc-multilib'
apt_package 'g++-multilib'
apt_package 'libc6-dev-i386'
apt_package 'lib32ncurses5-dev'
apt_package 'x11proto-core-dev'
apt_package 'libx11-dev'
apt_package 'lib32z-dev'
apt_package 'libgl1-mesa-dev'
apt_package 'libxml2-utils'
apt_package 'xsltproc'
apt_package 'unzip'

# needed for lunch
apt_package 'openjdk-7-jdk'
