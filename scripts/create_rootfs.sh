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
	mkdir -p $SANDWICH/source/tarball
	mkdir -p $SANDWICH/source/decompressed

	# download tarballs

	wget https://ftp.gnu.org/gnu/glibc/glibc-$GLIBC_VERSION.tar.gz -O $SANDWICH/source/tarball/glibc-$GLIBC_VERSION.tar.gz
	wget https://www.busybox.net/downloads/busybox-$BUSYBOX_VERSION.tar.bz2 -O $SANDWICH/source/tarball/busybox-$BUSYBOX_VERSION.tar.bz2
fi

# compile glibc

if [ ! -d $SANDWICH/source/decompressed/glibc-$GLIBC_VERSION ]
then
	tar -xvf $SANDWICH/source/tarball/glibc-$GLIBC_VERSION.tar.gz -C $SANDWICH/source/decompressed
fi

mkdir $SANDWICH/source/decompressed/glibc-$GLIBC_VERSION/build

cd $SANDWICH/source/decompressed/glibc-$GLIBC_VERSION/build

../configure --libdir=/lib/x86_64-linux-gnu --prefix=/ && make -j8 && make install DESTDIR=$SANDWICH_OUTPUT && ln -s lib $SANDWICH_OUTPUT/lib64

cd $ORIGINAL_PATH

# compile busybox

if [ ! -d $SANDWICH/source/decompressed/busybox-$BUSYBOX_VERSION ]
then
	tar -xvf $SANDWICH/source/tarball/busybox-$BUSYBOX_VERSION.tar.bz2 -C $SANDWICH/source/decompressed
fi

cd $SANDWICH/source/decompressed/busybox-$BUSYBOX_VERSION

make defconfig && make -j8 && make install && cp -r _install/* $SANDWICH_OUTPUT

cd $ORIGINAL_PATH