
ifneq ("$(wildcard data.py)", "")
	PACKAGE ?= $(shell python3 -c "g={};exec(open('data.py').read(), g);print(g['name'])")
	VERSION ?= $(shell python3 -c "g={};exec(open('data.py').read(), g);print(g['version'])")

	# forces getdata to convert symlinks to normal files
	GETDATA_EXTRA_TARARGS = -h
else
	PACKAGE ?= $(shell grep Package: control | cut -c 10-)
	VERSION ?= $(shell grep Version: control | cut -c 10-)
	ARCH ?= $(shell grep Architecture: control | cut -c 15-)
	SOURCE ?= $(shell grep Source: control | cut -c 9-)
endif

# Sets IPK_DEST, IPK_NAME
mkfile_path := $(abspath $(lastword $(MAKEFILE_LIST)))
BUILD_ROOT = $(abspath ${mkfile_path}/../..)
include ${BUILD_ROOT}/Mk/globals.mk
