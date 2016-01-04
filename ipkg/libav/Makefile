include ../Mk/pkgdata.mk

DEPS = binutils-symlinks coreutils gcc-symlinks g++-symlinks libgcc-s-dev make

BUILD_CMD = CXX=/usr/bin/g++ ./configure --enable-pic --disable-shared --disable-zlib && make

INSTALL_CMD = make install

GETDATA_TARARGS = \
	usr/local/bin/avconv \
	usr/local/bin/avprobe \
	usr/local/lib/libavcodec.so* \
	usr/local/lib/libavdevice.so* \
	usr/local/lib/libavfilter.so* \
	usr/local/lib/libavformat.so* \
	usr/local/lib/libavresample.so* \
	usr/local/lib/libavutil.so* \
	usr/local/lib/libswscale.so* \
	usr/local/share/avconv/*.avpreset

EXES = \
	usr/local/bin/avconv \
	usr/local/bin/avprobe \
	usr/local/lib/libavcodec.so.56.1.0 \
	usr/local/lib/libavdevice.so.55.0.0 \
	usr/local/lib/libavfilter.so.5.0.0 \
	usr/local/lib/libavformat.so.56.1.0 \
	usr/local/lib/libavresample.so.2.1.0 \
	usr/local/lib/libavutil.so.54.3.0 \
	usr/local/lib/libswscale.so.3.0.0

EXTRA_CONTROL = postinst

include ../Mk/remote_build.mk
include ../Mk/ipk.mk


