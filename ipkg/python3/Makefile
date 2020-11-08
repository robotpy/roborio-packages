include ../Mk/pkgdata.mk

DEPS = binutils-symlinks gcc-symlinks g++-symlinks libgcc-s-dev gcov make libreadline-dev openssl-dev libz-dev libsqlite3-dev libexpat-dev libxml2-dev libbz2-dev liblzma-dev libgdbm-dev libffi-dev pkgconfig

BUILD_CMD = CXX=/usr/bin/g++ ./configure --enable-shared --with-system-expat --with-system-ffi --enable-optimizations && make

INSTALL_CMD = make install

GETDATA_TARARGS = --exclude=usr/local/lib/python3.9/site-packages/numpy\* \
		  --exclude=usr/local/lib/python3.9/test \
		  --exclude=usr/local/lib/python3.9/config-3.9-arm-linux-gnueabi/libpython3.9.a \
		  --exclude=usr/local/lib/python3.9/lib-dynload/.debug \
		  --exclude=\*.py[co] \
		  --exclude=__pycache__ \
		  usr/local/include/python3.9/pyconfig.h \
		  usr/local/lib/libpython3* \
		  usr/local/bin/*3.9 \
		  usr/local/bin/2to3 \
		  usr/local/bin/idle3 \
		  usr/local/bin/pip3 \
		  usr/local/bin/pydoc3 \
		  usr/local/bin/python3 \
		  usr/local/bin/python3-config \
		  usr/local/lib/python3.9 \
		  usr/local/bin/python3.9-config

GETDATA_DEV_TARARGS = --exclude=usr/local/include/python3.9/pyconfig.h \
		  usr/local/include/python3.9 \
		  usr/local/lib/pkgconfig/python3.pc \
		  usr/local/lib/pkgconfig/python3-embed.pc \
		  usr/local/lib/pkgconfig/python-3.9.pc \
		  usr/local/lib/pkgconfig/python-3.9-embed.pc \
		  usr/local/lib/python3.9/config-3.9-arm-linux-gnueabi/libpython3.9.a

GETDATA_DBG_TARARGS = usr/local/bin/.debug/python3.debug \
		  usr/local/lib/.debug/libpython3* \
		  usr/local/lib/python3.9/lib-dynload/.debug

EXTRA_CONTROL = postinst prerm

EXES = usr/local/bin/python3.9 \
       usr/local/lib/libpython3.9.so.1.0 \
       usr/local/lib/python3.9/lib-dynload/*.so

include ../Mk/remote_build.mk
include ../Mk/ipk.mk
