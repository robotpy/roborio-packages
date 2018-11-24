include ../../Mk/pkgdata.mk

DEPS = binutils-symlinks gcc-symlinks g++-symlinks libgcc-s-dev gcov make libreadline-dev openssl-dev libz-dev libsqlite3-dev libexpat-dev libxml2-dev libbz2-dev liblzma-dev libgdbm-dev libffi-dev pkgconfig

BUILD_CMD = CXX=/usr/bin/g++ ./configure --enable-shared --with-system-expat --with-system-ffi --enable-optimizations && make

INSTALL_CMD = make install

GETDATA_TARARGS = --exclude=usr/local/lib/python3.7/site-packages/numpy\* \
		  --exclude=usr/local/lib/python3.7/test \
		  --exclude=usr/local/lib/python3.7/config-3.7m-arm-linux-gnueabi/libpython3.7m.a \
		  --exclude=usr/local/lib/python3.7/lib-dynload/.debug \
		  --exclude=\*.py[co] \
		  --exclude=__pycache__ \
		  usr/local/include/python3.7m/pyconfig.h \
		  usr/local/lib/libpython3* \
		  usr/local/bin/*3.7 \
		  usr/local/bin/2to3 \
		  usr/local/bin/idle3 \
		  usr/local/bin/pip3 \
		  usr/local/bin/pydoc3 \
		  usr/local/bin/python3 \
		  usr/local/bin/python3-config \
		  usr/local/lib/python3.7 \
		  usr/local/bin/python3.7-config \
		  usr/local/bin/python3.7m \
		  usr/local/bin/python3.7m-config \
		  usr/local/bin/pyvenv \
		  usr/local/bin/pyvenv-3.7

EXTRA_CONTROL = postinst prerm

EXES = usr/local/bin/python3.7m \
       usr/local/lib/libpython3.7m.so.1.0 \
       usr/local/lib/python3.7/lib-dynload/*.so

PATCHES = 4856.diff

include ../../Mk/remote_build.mk
include ../../Mk/ipk.mk
