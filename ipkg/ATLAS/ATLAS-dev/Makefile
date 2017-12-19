include ../../Mk/pkgdata.mk

.PHONY: all getdata

all:
	$(MAKE) package

getdata:
	rm -rf data
	mkdir -p data/usr/local/lib
	tar -xf ${ATLASZIP} -C data/usr/local \
		'./include/*' \
		'./lib/*.a'

include ${BUILD_ROOT}/Mk/ipk.mk
