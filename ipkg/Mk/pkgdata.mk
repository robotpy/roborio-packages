PACKAGE ?= $(shell grep Package: control | cut -c 10-)
VERSION ?= $(shell grep Version: control | cut -c 10-)
ARCH ?= $(shell grep Architecture: control | cut -c 15-)
SOURCE ?= $(shell grep Source: control | cut -c 9-)

# Keep synced with remote_whl.mk
mkfile_path := $(abspath $(lastword $(MAKEFILE_LIST)))
BUILD_ROOT = $(abspath ${mkfile_path}/../..)
RELEASE = 2018-dev

IPK_DEST ?= ${BUILD_ROOT}/${RELEASE}
IPK_NAME = ${IPK_DEST}/${PACKAGE}_${VERSION}_${ARCH}.ipk
