include ../Mk/pkgdata.mk

BINRELEASE = https://www.tortall.net/~robotpy/fortran/libgfortran4-7.3.0-r0_cortexa9-vfpv3.tar.bz2
LIBGZIP = $(abspath $(notdir ${BINRELEASE}))

.PHONY: all getdata

all: package

${LIBGZIP}:
	wget ${BINRELEASE}

getdata: ${LIBGZIP}
	rm -rf data
	mkdir -p data/usr/local/lib
	${BUILD_ROOT}/tools/xtar -xf ${LIBGZIP} -C data/usr/local/lib \
		'libgfortran.so.4'

include ${BUILD_ROOT}/Mk/ipkwhl.mk


