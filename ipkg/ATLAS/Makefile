include ../Mk/pkgdata.mk

.PHONY: all getdata

all:
	$(MAKE) package

getdata:
	mkdir -p data/usr/local/lib
	cp -p ../../atlas_libs/lib/*.so data/usr/local/lib/

include ../Mk/ipk.mk
