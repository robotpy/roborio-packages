include ../../Mk/pkgdata.mk

.PHONY: all getdata

all:
	$(MAKE) clean
	$(MAKE) getdata
	$(MAKE) ipk

getdata:
	rm -rf data
	mkdir -p data/usr/local/lib/python3.8/site-packages
	tar -xf ${CVZIP} -C data/usr/local/lib/python3.8/site-packages --strip=4 \
		'*/lib/python3.8/site-packages/cv2.so'

include ../../Mk/ipk.mk
