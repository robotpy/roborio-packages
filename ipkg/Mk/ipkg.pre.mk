PACKAGE ?= $(shell grep Package: control | cut -c 10-)
VERSION ?= $(shell grep Version: control | cut -c 10-)
ARCH ?= $(shell grep Architecture: control | cut -c 15-)
SOURCE ?= $(shell grep Source: control | cut -c 9-)

IPK_NAME = ../${PACKAGE}_${VERSION}_${ARCH}.ipk

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
