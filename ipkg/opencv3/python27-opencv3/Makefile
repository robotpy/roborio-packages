IPK_DEST = ../..
include ../../Mk/pkgdata.mk

.PHONY: all getdata

all:
	$(MAKE) clean
	$(MAKE) getdata
	$(MAKE) ipk

getdata:
	rm -rf data
	mkdir -p data/usr/local/lib/python2.7/site-packages
	tar -xf ${CVZIP} -C data/usr/local/lib/python2.7/site-packages --strip=4 \
		'*/lib/python2.7/dist-packages/cv2.so'

include ../../Mk/ipk.mk
