include ../Mk/pkgdata.mk

BINRELEASE = https://github.com/robotpy/roborio-atlas/releases/download/3.10.3-r2018.0/libgfortran-5.3.0-r0_cortexa9-vfpv3.tar.gz
LIBGZIP = $(abspath $(notdir ${BINRELEASE}))

.PHONY: all clean getdata

${LIBGZIP}:
	wget ${BINRELEASE}

getdata: ${LIBGZIP}
	rm -rf data
	mkdir -p data/usr/lib
	tar -xf ${LIBGZIP} -C data/usr/lib \
		'*'

include ${BUILD_ROOT}/Mk/ipk.mk

all:
	$(MAKE) package

