ALLTARGETS = clean getdata ipk

include ../../Mk/pkgdata.mk

DEPS =

BUILD_CMD = /bin/false

INSTALL_CMD = /bin/false

GETDATA_TARARGS = usr/local/bin/.debug/python3.7m \
		  usr/local/lib/.debug/libpython3* \
		  usr/local/lib/python3.7/lib-dynload/.debug

include ${BUILD_ROOT}/Mk/remote_build.mk
include ${BUILD_ROOT}/Mk/ipk.mk