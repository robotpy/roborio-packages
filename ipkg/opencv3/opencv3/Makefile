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
		'*/bin/opencv_*' \
		'*/lib/lib*so*' \
		'*/share/OpenCV/haarcascades/*.xml' \
		'*/share/OpenCV/lbpcascades/*.xml'

include ../../Mk/ipk.mk
