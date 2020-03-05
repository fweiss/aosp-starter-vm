#!/bin/sh

mkdir ~/bin
PATH=~/bin:$PATH

curl https://storage.googleapis.com/git-repo-downloads/repo > ~/bin/repo
chmod a+x ~/bin/repo

# gpg --recv-key 8BB9AD793E8E6153AF0F9A4416530D5E920F5C65
# curl https://storage.googleapis.com/git-repo-downloads/repo.asc | gpg --verify - ~/bin/repo

mkdir aosp
cd aosp

repo init -u https://android.googlesource.com/platform/manifest
