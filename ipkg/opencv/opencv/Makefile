include ../../Mk/pkgdata.mk

EXTRA_CONTROL = postinst

.PHONY: all getdata

all:
	$(MAKE) clean
	$(MAKE) getdata
	$(MAKE) ipkwhl

getdata:
	rm -rf data
	mkdir -p data/usr/local/lib
	${BUILD_ROOT}/tools/xtar -xf ${CVZIP} -C data/usr/local --strip=1 \
		'*/lib/lib*so.4.5' \
		'*/share/opencv4/haarcascades/*.xml' \
		'*/share/opencv4/lbpcascades/*.xml'

include ${BUILD_ROOT}/Mk/ipkwhl.mk
