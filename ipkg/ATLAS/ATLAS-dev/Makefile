include ../../Mk/pkgdata.mk

.PHONY: all getdata

all:
	$(MAKE) package

getdata:
	mkdir -p data/usr/local/lib
	mkdir -p data/usr/local/include
	cp -p ${BUILD_ROOT}/../atlas_libs/lib/*.a data/usr/local/lib/
	cp -Rp ${BUILD_ROOT}/../atlas_libs/include/* data/usr/local/include/

include ${BUILD_ROOT}/Mk/ipk.mk
