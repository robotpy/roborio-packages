include ../Mk/pkgdata.mk

DEPS = binutils-symlinks gcc-symlinks libgcc-s-dev make libjpeg-dev coreutils

BUILD_DIR = mjpg-streamer-$(VERSION)/mjpg-streamer-experimental
BUILD_CMD = make

INSTALL_CMD = make install

GETDATA_TARARGS = \
		  usr/local/bin/mjpg_streamer \
		  usr/local/lib/mjpg-streamer \
		  usr/local/share/mjpg-streamer \
		  etc/init.d/mjpg-streamer \
		  etc/default/mjpg-streamer

EXTRA_CONTROL = postinst prerm postrm

EXES = usr/local/bin/mjpg_streamer
       

include ../Mk/remote_build.mk
include ../Mk/ipk.mk
