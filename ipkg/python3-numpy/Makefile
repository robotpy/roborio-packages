VER=$(shell grep Version control | cut -c 10-)
IPK_NAME=../python34-numpy_${VER}_armv7a-vfp-neon.ipk
TGZ=numpy-${VER}.tar.gz
SOURCE=$(shell grep Source control | cut -c 9-)

.PHONY: all clean install-deps fetch extract build install fetch-src getdata ipk

ipk: ${IPK_NAME}

all:
	$(MAKE) clean
	$(MAKE) install-deps
	$(MAKE) fetch
	$(MAKE) extract
	$(MAKE) build
	$(MAKE) install
	$(MAKE) getdata
	$(MAKE) ipk

clean:
	rm -f control.tar.gz
	rm -f data.tar.gz
	rm -f ${IPK_NAME}

install-deps:
	ssh admin@${ROBORIO} 'opkg update && opkg install binutils-symlinks gcc-symlinks g++-symlinks libgcc-s-dev make ATLAS-dev'

fetch: ${TGZ}
${TGZ}:
	wget ${SOURCE}

extract: ${TGZ}
	scp ${TGZ} admin@${ROBORIO}:
	ssh admin@${ROBORIO} 'rm -rf numpy-${VER} && tar xzf ${TGZ}'

build:
	@echo "--------------------------------------------------------------"
	@echo "CAUTION: this almost certainly needs a swap device to complete"
	@echo "--------------------------------------------------------------"
	@echo "Press ENTER to continue"
	@bash -c read
	ssh admin@${ROBORIO} 'cd numpy-${VER} && python3 setup.py build'

install:
	ssh admin@${ROBORIO} 'cd numpy-${VER} && python3 setup.py install'

getdata:
	mkdir -p data
	rm -rf data.new
	mkdir data.new
	cd data.new && ssh admin@${ROBORIO} 'cd / && tar cf - usr/local/lib/python3.4/site-packages/numpy* usr/local/bin/f2py3' | tar xf -
	rm -rf data.old && mv data data.old && mv data.new data

${IPK_NAME}: data control postinst
	tar czvf control.tar.gz control postinst
	cd data && tar czvf ../data.tar.gz . && cd ..
	echo 2.0 > debian-binary
	ar r ${IPK_NAME} control.tar.gz data.tar.gz debian-binary
