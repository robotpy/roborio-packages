include ../../Mk/pkgdata.mk

.PHONY: all getdata

all:
	$(MAKE) clean
	$(MAKE) getdata
	$(MAKE) ipk

getdata:
	rm -rf data
	mkdir -p data/usr/local/lib/python3.6/site-packages
	tar -xf ${CVZIP} -C data/usr/local/lib/python3.6/site-packages --strip=2 \
		'*/python/cv2.so'

include ../../Mk/ipk.mk
