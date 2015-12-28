PACKAGE ?= $(shell grep Package: control | cut -c 10-)
VERSION ?= $(shell grep Version: control | cut -c 10-)
ARCH ?= $(shell grep Architecture: control | cut -c 15-)
SOURCE ?= $(shell grep Source: control | cut -c 9-)

IPK_DEST ?= ..
IPK_NAME = ${IPK_DEST}/${PACKAGE}_${VERSION}_${ARCH}.ipk
