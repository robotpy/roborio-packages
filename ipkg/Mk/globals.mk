#
# Defines globals used in all the make types
#

ifneq ("$(wildcard $(BUILD_ROOT)/vars)","")
include ${BUILD_ROOT}/vars
endif

YEAR = 2021
RELEASE = ${YEAR}-dev
ARCH ?= cortexa9-vfpv3

ifndef PACKAGE
$(error PACKAGE is not set, error in makefile)
endif

ifndef VERSION
$(error VERSION is not set, error in makefile)
endif

