#!/bin/bash

# config

export ORIGINAL_PATH=`pwd`
export SANDWICH=`pwd`
export GLIBC_VERSION=2.35
export BUSYBOX_VERSION=1.35.0

export SANDWICH_OUTPUT=`pwd`/chroot

# create directories

mkdir -p $SANDWICH_OUTPUT

if [ ! -d $SANDWICH/source ]
then
	mkdir -p $SANDWICH/source/packages

	# download files

	wget https://github.com/SandwichOS/slice/releases/download/test1/slice -O $SANDWICH/source/slice

	chmod +x $SANDWICH/source/slice

	wget https://github.com/SandwichOS/slice/releases/download/test1/slice.slicepkg -O $SANDWICH/source/packages/slice.slicepkg
	wget https://github.com/SandwichOS/kernel/releases/download/test1/linux.slicepkg -O $SANDWICH/source/packages/linux.slicepkg
	wget https://github.com/SandwichOS/core-packages/releases/download/test1/glibc.slicepkg -O $SANDWICH/source/packages/glibc.slicepkg
	wget https://github.com/SandwichOS/core-packages/releases/download/test1/busybox.slicepkg -O $SANDWICH/source/packages/busybox.slicepkg
	#wget https://github.com/SandwichOS/core-packages/releases/download/test1/coreutils.slicepkg -O $SANDWICH/source/packages/coreutils.slicepkg
fi

SLICE_DESTDIR=$SANDWICH_OUTPUT $SANDWICH/source/slice install $SANDWICH/source/packages/slice.slicepkg
SLICE_DESTDIR=$SANDWICH_OUTPUT $SANDWICH/source/slice install $SANDWICH/source/packages/glibc.slicepkg
SLICE_DESTDIR=$SANDWICH_OUTPUT $SANDWICH/source/slice install $SANDWICH/source/packages/busybox.slicepkg
#SLICE_DESTDIR=$SANDWICH_OUTPUT $SANDWICH/source/slice install $SANDWICH/source/packages/coreutils.slicepkg