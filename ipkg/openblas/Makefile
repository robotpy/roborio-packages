include ../Mk/pkgdata.mk

SOURCE = https://github.com/xianyi/OpenBLAS/archive/v${VERSION}.tar.gz

DEPS = binutils-symlinks gcc-symlinks make coreutils \
	gfortran gfortran-symlinks libgfortran-dev \
	perl perl-module-file-basename perl-module-file-temp

PATCHES = arm-buffersize.patch

BUILD_CMD = make MAX_STACK_ALLOC=256 TARGET=CORTEXA9 ARM_SOFTFP_ABI=1 NUM_CORES=2 USE_OPENMP=0 PREFIX=/usr/local

INSTALL_CMD = make PREFIX=/usr/local install

EXES = usr/local/lib/libopenblas.so.0

GETDATA_TARARGS = usr/local/lib/libopenblas.so.0

GETDATA_DEV_TARARGS = \
	usr/local/include/cblas.h \
	usr/local/include/f77blas.h \
	usr/local/include/lapack.h \
	usr/local/include/lapacke_config.h \
	usr/local/include/lapacke.h \
	usr/local/include/lapacke_mangling.h \
	usr/local/include/lapacke_utils.h \
	usr/local/include/openblas_config.h \
	usr/local/lib/libopenblas.a \
	usr/local/lib/libopenblas.so \
	usr/local/lib/pkgconfig/openblas.pc \
	usr/local/lib/cmake/openblas

GETDATA_DBG_TARARGS = \
	usr/local/lib/.debug/libopenblas.so.debug

include ../Mk/remote_build.mk
include ../Mk/ipkwhl.mk