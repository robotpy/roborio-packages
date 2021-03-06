PACKAGE ?= $(shell grep Package: control | cut -c 10-)
VERSION ?= $(shell grep Version: control | cut -c 10-)
ARCH ?= $(shell grep Architecture: control | cut -c 15-)
SOURCE ?= $(shell grep Source: control | cut -c 9-)

# Sets IPK_DEST, IPK_NAME
mkfile_path := $(abspath $(lastword $(MAKEFILE_LIST)))
BUILD_ROOT = $(abspath ${mkfile_path}/../..)
include ${BUILD_ROOT}/Mk/globals.mk
