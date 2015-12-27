include ../Mk/pkgdata.mk

DEPS =

BUILD_CMD = /bin/false

INSTALL_CMD = /bin/false

GETDATA_TARARGS = --exclude=usr/local/include/python2.7/pyconfig.h \
		  usr/local/include/python2.7 \
		  usr/local/lib/pkgconfig/python2.pc \
		  usr/local/lib/pkgconfig/python-2.7.pc \
		  usr/local/lib/python2.7/config/libpython2.7.a

include ../Mk/remote_build.mk
include ../Mk/ipk.mk
