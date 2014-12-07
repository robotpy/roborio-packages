include ../Mk/ipkg.pre.mk

DEPS = binutils-symlinks gcc-symlinks g++-symlinks libgcc-s-dev make libreadline-dev openssl-dev libz-dev libsqlite3-dev libexpat-dev libxml2-dev libbz2-dev liblzma-dev libgdbm-dev

BUILD_CMD = CXX=/usr/bin/g++ ./configure --enable-shared --with-system-expat --with-system-ffi && make

INSTALL_CMD = make install

GETDATA_TARARGS = usr/local/lib/python2.7/test

include ../Mk/ipkg.post.mk
