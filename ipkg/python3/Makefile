VER=$(shell grep Version control | cut -c 10-)
IPK_NAME=../python3_${VER}_armv7a-vfp-neon.ipk
TGZ=Python-${VER}.tgz
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
	ssh admin@${ROBORIO} 'opkg update && opkg install binutils-symlinks gcc-symlinks g++-symlinks libgcc-s-dev make libreadline-dev openssl-dev libz-dev libsqlite3-dev libexpat-dev libxml2-dev libbz2-dev liblzma-dev libgdbm-dev'

fetch: ${TGZ}
${TGZ}:
	wget ${SOURCE}

extract: ${TGZ}
	scp ${TGZ} admin@${ROBORIO}:
	ssh admin@${ROBORIO} 'rm -rf Python-${VER} && tar xzf ${TGZ}'

build:
	ssh admin@${ROBORIO} 'cd Python-${VER} && CXX=/usr/bin/g++ ./configure --enable-shared --with-system-expat --with-system-ffi && make'

install:
	ssh admin@${ROBORIO} 'cd Python-${VER} && make install'

getdata:
	mkdir -p data
	rm -rf data.new
	mkdir data.new
	cd data.new && ssh admin@${ROBORIO} 'cd / && tar --exclude=usr/local/lib/python3.4/site-packages/numpy\* -cf - usr/local/lib/libpython3* usr/local/lib/pkgconfig/python*3* usr/local/lib/python3.4 usr/local/bin/*3.4 usr/local/bin/2to3 usr/local/bin/idle3 usr/local/bin/pip3 usr/local/bin/pydoc3 usr/local/bin/python3 usr/local/bin/python3-config usr/local/bin/python3.4m usr/local/bin/python3.4m-config usr/local/bin/pyvenv usr/local/include/python3.4m' | tar xf -
	rm -rf data.old && mv data data.old && mv data.new data

${IPK_NAME}: data control postinst
	tar czvf control.tar.gz control postinst
	cd data && tar czvf ../data.tar.gz . && cd ..
	echo 2.0 > debian-binary
	ar r ${IPK_NAME} control.tar.gz data.tar.gz debian-binary
