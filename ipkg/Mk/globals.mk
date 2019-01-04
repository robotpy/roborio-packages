#
# Defines globals used in all the make types
#

ifneq ("$(wildcard $(BUILD_ROOT)/vars)","")
include ${BUILD_ROOT}/vars
endif

RELEASE = 2019-dev
ARCH ?= cortexa9-vfpv3

ifndef PACKAGE
$(error PACKAGE is not set, error in makefile)
endif

ifndef VERSION
$(error VERSION is not set, error in makefile)
endif


IPK_DEST ?= ${BUILD_ROOT}/${RELEASE}
IPK_NAME = ${IPK_DEST}/${PACKAGE}_${VERSION}_${ARCH}.ipk
