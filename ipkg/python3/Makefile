include ../Mk/ipkg.pre.mk

DEPS = binutils-symlinks gcc-symlinks g++-symlinks libgcc-s-dev make libreadline-dev openssl-dev libz-dev libsqlite3-dev libexpat-dev libxml2-dev libbz2-dev liblzma-dev libgdbm-dev

BUILD_CMD = CXX=/usr/bin/g++ ./configure --enable-shared --with-system-expat --with-system-ffi && make

INSTALL_CMD = make install

GETDATA_TARARGS = --exclude=usr/local/lib/python3.4/site-packages/numpy\* \
		  --exclude=usr/local/lib/python3.4/test \
		  usr/local/lib/libpython3* \
		  usr/local/lib/pkgconfig/python*3* \
		  usr/local/lib/python3.4 \
		  usr/local/bin/*3.4 \
		  usr/local/bin/2to3 \
		  usr/local/bin/idle3 \
		  usr/local/bin/pip3 \
		  usr/local/bin/pydoc3 \
		  usr/local/bin/python3 \
		  usr/local/bin/python3-config \
		  usr/local/bin/python3.4m \
		  usr/local/bin/python3.4m-config \
		  usr/local/bin/pyvenv \
		  usr/local/include/python3.4m

EXTRA_CONTROL = postinst

include ../Mk/ipkg.post.mk
