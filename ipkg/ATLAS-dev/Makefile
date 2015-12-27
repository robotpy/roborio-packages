include ../Mk/pkgdata.mk

.PHONY: all getdata

all:
	$(MAKE) package

getdata:
	mkdir -p data/usr/local/lib
	mkdir -p data/usr/local/include
	cp -p ../../atlas_libs/lib/*.a data/usr/local/lib/
	cp -Rp ../../atlas_libs/include/* data/usr/local/include/

include ../Mk/ipk.mk
