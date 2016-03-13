IPK_DEST = ../..
include ../../Mk/pkgdata.mk

DEPS = binutils-symlinks gcc-symlinks libgcc-s-dev g++-symlinks libstdc++-dev make libjpeg-dev coreutils \
		cmake opencv3-dev python35-numpy python3-dev

BUILD_DIR = mjpg-streamer-$(VERSION)/mjpg-streamer-experimental
BUILD_CMD = make

INSTALL_CMD = make install

GETDATA_TARARGS = \
		  --exclude=usr/local/lib/mjpg-streamer/input_opencv.so \
		  --exclude=usr/local/lib/mjpg-streamer/cvfilter\*.so \
		  usr/local/bin/mjpg_streamer* \
		  usr/local/lib/mjpg-streamer \
		  usr/local/share/mjpg-streamer
		  
GETDATA_EXTRA = mkdir -p data.new/etc/init.d && \
				mkdir -p data.new/etc/default && \
				cp extra/default data.new/etc/default/mjpg-streamer && \
				cp extra/init.sh data.new/etc/init.d/mjpg-streamer && \
				cp extra/run.sh data.new/usr/local/mjpg_streamer_cfg1 && \
				cp extra/run.sh data.new/usr/local/mjpg_streamer_cfg2 && \
				cp extra/run.sh data.new/usr/local/mjpg_streamer_cfg3 && \
				cp extra/run.sh data.new/usr/local/mjpg_streamer_cfg4 \

EXTRA_CONTROL = conffiles postinst prerm postrm

EXES = usr/local/bin/mjpg_streamer
       

include ../../Mk/remote_build.mk
include ../../Mk/ipk.mk
