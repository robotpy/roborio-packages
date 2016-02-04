include ../Mk/pkgdata.mk

DEPS = binutils-symlinks gcc-symlinks g++-symlinks libgcc-s-dev libstdc++-dev make python3-dev python35-numpy ATLAS-dev libgfortran3 gfortran gfortran-symlinks libgfortran-dev

BUILD_WARNING = CAUTION: this almost certainly needs roborio-vm to complete
BUILD_CMD = /usr/local/bin/python3 setup.py build
INSTALL_CMD = /usr/local/bin/python3 setup.py install

GETDATA_TARARGS = usr/local/lib/python3.5/site-packages/scipy*

EXTRA_CONTROL = postinst prerm

include ../Mk/remote_build.mk
include ../Mk/ipk.mk
