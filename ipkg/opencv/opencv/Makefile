include ../../Mk/pkgdata.mk

EXTRA_CONTROL = postinst

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
		'*/share/opencv4/haarcascades/*.xml' \
		'*/share/opencv4/lbpcascades/*.xml'

include ../../Mk/ipk.mk
