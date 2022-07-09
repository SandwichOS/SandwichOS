#!/bin/bash

# config

export ORIGINAL_PATH=`pwd`
export SANDWICH=`pwd`
export GLIBC_VERSION=2.35
export BUSYBOX_VERSION=1.35.0

export SANDWICH_OUTPUT=`pwd`/iso

# create directories

if [ -d $SANDWICH_OUTPUT ]
then
	rm -r $SANDWICH_OUTPUT
fi

cp -r chroot $SANDWICH_OUTPUT

mkdir -p $SANDWICH_OUTPUT/boot/grub

SLICE_DESTDIR=$SANDWICH_OUTPUT $SANDWICH/source/slice install $SANDWICH/source/packages/linux.slicepkg

cp $SANDWICH/grub.cfg $SANDWICH_OUTPUT/boot/grub

grub-mkrescue $SANDWICH_OUTPUT -o SandwichOS.iso