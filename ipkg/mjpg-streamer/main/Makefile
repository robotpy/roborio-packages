IPK_DEST = ../..
include ../../Mk/pkgdata.mk

DEPS = binutils-symlinks gcc-symlinks libgcc-s-dev g++-symlinks libstdc++-dev make libjpeg-dev coreutils \
		cmake opencv3-dev python35-numpy python3-dev

BUILD_DIR_EXTRA = /mjpg-streamer-experimental
BUILD_CMD = make

INSTALL_CMD = make install

GETDATA_TARARGS = \
		  --exclude=usr/local/lib/mjpg-streamer/input_opencv.so \
		  --exclude=usr/local/lib/mjpg-streamer/cvfilter\*.so \
		  usr/local/bin/mjpg_streamer* \
		  usr/local/lib/mjpg-streamer \
		  usr/local/share/mjpg-streamer

EXTRA_CONTROL = conffiles postinst prerm postrm

EXES = usr/local/bin/mjpg_streamer
       

include ../../Mk/remote_build.mk
include ../../Mk/ipk.mk
