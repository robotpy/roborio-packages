include ../Mk/ipkg.pre.mk

DEPS = binutils-symlinks gcc-symlinks g++-symlinks libgcc-s-dev make python3 ATLAS-dev

BUILD_WARNING = CAUTION: this almost certainly needs a swap device to complete
BUILD_CMD = python3 setup.py build
INSTALL_CMD = python3 setup.py install

GETDATA_TARARGS = usr/local/lib/python3.4/site-packages/numpy* \
		  usr/local/bin/f2py3

EXTRA_CONTROL = postinst

include ../Mk/ipkg.post.mk
