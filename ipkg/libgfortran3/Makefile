VER=$(shell grep Version control | cut -c 10-)
IPK_NAME=../libgfortran3_${VER}_armv7a-vfp-neon.ipk

.PHONY: all clean ipk

ipk: ${IPK_NAME}

all:
	$(MAKE) clean
	$(MAKE) ipk

clean:
	rm -f control.tar.gz
	rm -f data.tar.gz
	rm -f ${IPK_NAME}

${IPK_NAME}:
	tar czvf control.tar.gz control postinst
	cd data && tar czvf ../data.tar.gz . && cd ..
	echo 2.0 > debian-binary
	ar r ${IPK_NAME} control.tar.gz data.tar.gz debian-binary
