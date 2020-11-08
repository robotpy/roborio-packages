include ../../Mk/pkgdata.mk

.PHONY: getdata

all:
	$(MAKE) clean
	$(MAKE) getdata
	$(MAKE) ipkwhl

getdata:
	rm -rf data
	mkdir -p data/usr/local/lib
	${BUILD_ROOT}/tools/xtar -xf ${CVZIP} -C data/usr/local --strip=1 \
		'*/include/*' \
		'*/lib/cmake/opencv4/*.cmake' \
		'*/lib/pkgconfig/*'

include ${BUILD_ROOT}/Mk/ipkwhl.mk
