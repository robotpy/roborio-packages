IPK_DEST = ../..
include ../../Mk/pkgdata.mk

.PHONY: all getdata

all:
	$(MAKE) clean
	$(MAKE) getdata
	$(MAKE) ipk

# This is actually compiled against 3.5, but there's a bug in the output tar
# file from roborio-opencv
# -> see https://github.com/Itseez/opencv/issues/5887

getdata:
	rm -rf data
	mkdir -p data/usr/local/lib/python3.5/site-packages
	tar -xf ${CVZIP} -C data/usr/local/lib/python3.5/site-packages --strip=4 \
		--xform='s/cv2.*so/cv2.so/' \
		'*/lib/python3.4/*/cv2.*so'

include ../../Mk/ipk.mk
