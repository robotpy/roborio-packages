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
		'*/share/OpenCV/java/*.jar' '*/share/OpenCV/java/*.so'

# TODO: Not sure where the best place to deploy the java stuff is

include ../../Mk/ipk.mk
