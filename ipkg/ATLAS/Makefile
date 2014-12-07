VER=$(shell grep Version control | cut -c 10-)
IPK_NAME=../ATLAS_${VER}_armv7a-vfp-neon.ipk

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
	cp -p ../../atlas_libs/*.so data/usr/local/lib/

${IPK_NAME}: data control postinst
	tar czvf control.tar.gz control postinst
	cd data && tar czvf ../data.tar.gz . && cd ..
	echo 2.0 > debian-binary
	ar r ${IPK_NAME} control.tar.gz data.tar.gz debian-binary
