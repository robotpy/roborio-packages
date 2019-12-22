include ../Mk/pkgdata.mk

DEPS = binutils-symlinks gcc-symlinks make coreutils \
	gfortran gfortran-symlinks libgfortran-dev \
	perl perl-module-file-basename perl-module-file-temp

BUILD_CMD = make TARGET=CORTEXA9 NUM_CORES=2 PREFIX=/usr/local

INSTALL_CMD = make PREFIX=/usr/local install

EXES = usr/local/lib/libopenblas_cortexa9p-r0.3.7.so

GETDATA_TARARGS = usr/local/lib/libopenblas*.so

GETDATA_DEV_TARARGS = \
	usr/local/include/cblas.h \
	usr/local/include/f77blas.h \
	usr/local/include/lapacke_config.h \
	usr/local/include/lapacke.h \
	usr/local/include/lapacke_mangling.h \
	usr/local/include/lapacke_utils.h \
	usr/local/include/openblas_config.h \
	usr/local/lib/libopenblas*.a \
	usr/local/lib/pkgconfig/openblas.pc \
	usr/local/lib/cmake/openblas

GETDATA_DBG_TARARGS = \
	usr/local/lib/.debug/libopenblas*.debug

EXTRA_CONTROL = postinst

include ../Mk/remote_build.mk
include ../Mk/ipk.mk
