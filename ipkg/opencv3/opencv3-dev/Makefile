include ../../Mk/pkgdata.mk

.PHONY: getdata

all:
	$(MAKE) clean
	$(MAKE) getdata
	$(MAKE) ipk

getdata:
	rm -rf data
	mkdir -p data/usr/local/lib
	tar -xf ${CVZIP} -C data/usr/local --strip=1 \
		'*/include/*' \
		'*/lib/pkgconfig/*.pc' \
		'*/share/OpenCV/*.cmake'

include ${BUILD_ROOT}/Mk/ipk.mk
