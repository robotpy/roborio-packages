ALLTARGETS = clean getdata ipk

include ../../Mk/pkgdata.mk

DEPS =

BUILD_CMD = /bin/false

INSTALL_CMD = /bin/false

GETDATA_TARARGS = --exclude=usr/local/include/python3.8/pyconfig.h \
		  usr/local/include/python3.8 \
		  usr/local/lib/pkgconfig/python3.pc \
		  usr/local/lib/pkgconfig/python3-embed.pc \
		  usr/local/lib/pkgconfig/python-3.8.pc \
		  usr/local/lib/pkgconfig/python-3.8-embed.pc \
		  usr/local/lib/python3.8/config-3.8-arm-linux-gnueabi/libpython3.8.a

include ${BUILD_ROOT}/Mk/remote_build.mk
include ${BUILD_ROOT}/Mk/ipk.mk
