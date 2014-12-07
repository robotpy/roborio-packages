include ../Mk/ipkg.pre.mk

DEPS = binutils-symlinks gcc-symlinks g++-symlinks libgcc-s-dev make libreadline-dev openssl-dev libz-dev libsqlite3-dev libexpat-dev libxml2-dev libbz2-dev liblzma-dev libgdbm-dev

BUILD_CMD = CXX=/usr/bin/g++ ./configure --enable-shared --with-system-expat --with-system-ffi && make

INSTALL_CMD = make install

GETDATA_TARARGS = --exclude=usr/local/lib/python2.7/site-packages/numpy\* \
		  --exclude=usr/local/lib/python2.7/test \
		  usr/local/lib/libpython2* \
		  usr/local/lib/pkgconfig/python*2* \
		  usr/local/lib/pkgconfig/python.pc \
		  usr/local/lib/python2.7 \
		  usr/local/bin/idle \
		  usr/local/bin/pydoc \
		  usr/local/bin/python \
		  usr/local/bin/python2 \
		  usr/local/bin/python2-config \
		  usr/local/bin/smtpd.py \
		  usr/local/include/python2.7

EXTRA_CONTROL = postinst

include ../Mk/ipkg.post.mk
