include ../Mk/ipkg.pre.mk

DEPS = binutils-symlinks gcc-symlinks g++-symlinks libgcc-s-dev make python2 ATLAS-dev

BUILD_WARNING = CAUTION: this almost certainly needs a swap device to complete
BUILD_CMD = /usr/local/bin/python setup.py build
INSTALL_CMD = /usr/local/bin/python setup.py install

GETDATA_TARARGS = usr/local/lib/python2.7/site-packages/numpy* \
		  usr/local/bin/f2py

EXTRA_CONTROL = postinst

include ../Mk/ipkg.post.mk
