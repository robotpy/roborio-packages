include ../../Mk/pkgdata.mk

.PHONY: all getdata

all:
	$(MAKE) clean
	$(MAKE) getdata
	$(MAKE) ipkwhl

getdata:
	rm -rf data
	mkdir -p data/usr/local/lib/python3.9/site-packages
	tar -xf ${CVZIP} -C data/usr/local/lib/python3.9/site-packages --strip=4 \
		'*/lib/python3.9/site-packages/cv2*.so'

include ${BUILD_ROOT}/Mk/ipkwhl.mk
