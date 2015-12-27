include ../Mk/pkgdata.mk

DEPS = binutils-symlinks gcc-symlinks g++-symlinks libgcc-s-dev make libreadline-dev openssl-dev libz-dev libsqlite3-dev libexpat-dev libxml2-dev libbz2-dev liblzma-dev libgdbm-dev

BUILD_CMD = CXX=/usr/bin/g++ ./configure --enable-shared --with-system-expat --with-system-ffi && make

INSTALL_CMD = make install

GETDATA_TARARGS = --exclude=usr/local/lib/python3.5/site-packages/numpy\* \
		  --exclude=usr/local/lib/python3.5/test \
		  --exclude=usr/local/lib/python3.5/config-3.5m/libpython3.5m.a \
		  --exclude=usr/local/lib/python3.5/lib-dynload/.debug \
		  --exclude=\*.py[co] \
		  --exclude=__pycache__ \
		  usr/local/include/python3.5m/pyconfig.h \
		  usr/local/lib/libpython3* \
		  usr/local/lib/python3.5 \
		  usr/local/bin/*3.5 \
		  usr/local/bin/2to3 \
		  usr/local/bin/idle3 \
		  usr/local/bin/pip3 \
		  usr/local/bin/pydoc3 \
		  usr/local/bin/python3 \
		  usr/local/bin/python3-config \
		  usr/local/bin/python3.5m \
		  usr/local/bin/python3.5m-config \
		  usr/local/bin/pyvenv

EXTRA_CONTROL = postinst prerm

EXES = usr/local/bin/python3.5m \
       usr/local/lib/libpython3.5m.so.1.0 \
       usr/local/lib/python3.5/lib-dynload/*.so

include ../Mk/remote_build.mk
include ../Mk/ipk.mk
