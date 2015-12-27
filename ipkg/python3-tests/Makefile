include ../Mk/pkgdata.mk

DEPS =

BUILD_CMD = /bin/false

INSTALL_CMD = /bin/false

GETDATA_TARARGS = --exclude=\*.py[co] \
		  --exclude=__pycache__ \
		  usr/local/lib/python3.5/test

EXTRA_CONTROL = postinst prerm

include ../Mk/remote_build.mk
include ../Mk/ipk.mk
