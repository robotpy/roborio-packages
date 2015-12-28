IPK_DEST = ../..
include ../../Mk/pkgdata.mk

.PHONY: all getdata

all:
	$(MAKE) clean
	$(MAKE) getdata
	$(MAKE) ipk

getdata:
	rm -rf data
	mkdir -p data/usr/local/lib
	tar -xf ${CVZIP} -C data/usr/local --strip=1 \
		'*/include/*' \
		'*/share/OpenCV/*.cmake'

include ../../Mk/ipk.mk
