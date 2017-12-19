include ../../Mk/pkgdata.mk

.PHONY: all getdata

all:
	$(MAKE) package

getdata:
	rm -rf data
	mkdir -p data/usr/local/lib
	tar -xf ${ATLASZIP} -C data/usr/local \
		'./lib/lib*.so'

include ${BUILD_ROOT}/Mk/ipk.mk
