include ../Mk/pkgdata.mk

DEPS = binutils-symlinks gcc-symlinks g++-symlinks libgcc-s-dev make python3-dev ATLAS-dev

BUILD_WARNING = CAUTION: this almost certainly needs a swap device to complete
BUILD_CMD = /usr/local/bin/python3 setup.py build
INSTALL_CMD = /usr/local/bin/python3 setup.py install

GETDATA_TARARGS = usr/local/lib/python3.5/site-packages/numpy* \
		  usr/local/bin/f2py3

EXTRA_CONTROL = postinst prerm

include ../Mk/remote_build.mk
include ../Mk/ipk.mk