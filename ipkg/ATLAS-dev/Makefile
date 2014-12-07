VER=$(shell grep Version control | cut -c 10-)
IPK_NAME=../ATLAS-dev_${VER}_armv7a-vfp-neon.ipk

.PHONY: all clean getdata ipk

ipk: ${IPK_NAME}

all:
	$(MAKE) clean
	$(MAKE) getdata
	$(MAKE) ipk

clean:
	rm -f control.tar.gz
	rm -f data.tar.gz
	rm -f ${IPK_NAME}

getdata:
	mkdir -p data/usr/local/lib
	mkdir -p data/usr/local/include
	cp -p ../../atlas_libs/*.a data/usr/local/lib/
	cp -Rp ../../atlas_libs/include/* data/usr/local/include/

${IPK_NAME}: data control
	tar czvf control.tar.gz control
	cd data && tar czvf ../data.tar.gz . && cd ..
	echo 2.0 > debian-binary
	ar r ${IPK_NAME} control.tar.gz data.tar.gz debian-binary
