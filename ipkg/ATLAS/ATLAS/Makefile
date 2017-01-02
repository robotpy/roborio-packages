include ../../Mk/pkgdata.mk

.PHONY: all getdata

all:
	$(MAKE) package

getdata:
	mkdir -p data/usr/local/lib
	cp -p ${BUILD_ROOT}/../atlas_libs/lib/*.so data/usr/local/lib/

include ${BUILD_ROOT}/Mk/ipk.mk
