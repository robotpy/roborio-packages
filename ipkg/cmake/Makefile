include ../Mk/ipkg.pre.mk

DEPS = binutils-symlinks gcc-symlinks g++-symlinks libgcc-s-dev make libstdc++-dev

BUILD_CMD = CXX=/usr/bin/g++ ./bootstrap && make

INSTALL_CMD = make install

GETDATA_TARARGS = \
		usr/local/bin/cmake \
		usr/local/bin/cpack \
		usr/local/bin/ctest \
		usr/local/share/aclocal/cmake.m4 \
		usr/local/share/cmake-3.1/Modules/ \
		usr/local/share/cmake-3.1/Templates/ \
		usr/local/doc/cmake-3.1/ 

EXTRA_CONTROL = postinst

include ../Mk/ipkg.post.mk
