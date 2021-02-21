#
# Remotely builds a python wheel, retrieves it, and turns it into an IPK file
#
# PYPI_PACKAGE_NAME - name of package on pypi
# PYPI_PACKAGE_VERSION - package version on pypi
#
# BUILD_DEPS - IPKs that must be installed to build this
# RUNTIME_DEPS - IPKs that must be installed for this to work (comma separated)
# PYDEPS - Python build dependencies (download from pypi)
#

ifndef PYPI_PACKAGE_NAME
$(error error in makefile, PYPI_PACKAGE_NAME not set)
endif

ifndef PYPI_PACKAGE_VERSION
$(error error in makefile, PYPI_PACKAGE_VERSION not set)
endif


PYVERSION=3.9
PYNAME=python39

PURE_PYTHON ?= false
DOWNLOAD_WHL ?= false

ifeq ($(PURE_PYTHON), true)
	WHL_PLATFORM ?= py3-none-any
else
	WHL_PLATFORM ?= cp39-cp39-linux_armv7l
endif

PACKAGE ?= ${PYNAME}-${PYPI_PACKAGE_NAME}
VERSION ?= ${PYPI_PACKAGE_VERSION}

WHEEL_URL ?= https://www.tortall.net/~robotpy/wheels/2021/roborio

# Sets IPK_DEST, IPK_NAME
mkfile_path := $(abspath $(lastword $(MAKEFILE_LIST)))
BUILD_ROOT = $(abspath ${mkfile_path}/../..)
include ${BUILD_ROOT}/Mk/globals.mk

WHL_DEST ?= ${BUILD_ROOT}/${YEAR}-whl
WHL_NAME ?= $(subst -,_,${PYPI_PACKAGE_NAME})-${PYPI_PACKAGE_VERSION}-${WHL_PLATFORM}.whl


ALLTARGETS ?= clean init-robotpy-opkg sync-date install-deps mkwheelhouse build whl whl2ipk

BUILD_DIR ?= wheelhouse
BUILD_CMD ?= \
	/usr/local/bin/pip3 --disable-pip-version-check install --prefer-binary --find-links ${WHEEL_URL} wheel ${PYDEPS} && \
	ldconfig && \
	RPYBUILD_PARALLEL=1 PKG_CONFIG_PATH=/usr/local/lib/pkgconfig /usr/local/bin/pip3 -v --disable-pip-version-check wheel --no-build-isolation --no-deps --no-binary :all: -b . ${PYPI_PACKAGE_NAME}==${PYPI_PACKAGE_VERSION}

DEPS ?= binutils-symlinks gcc-symlinks g++-symlinks libgcc-s-dev libstdc++-dev make ${PYNAME}-dev ${BUILD_DEPS}

include ${BUILD_ROOT}/Mk/remote_build.mk

.PHONY: mkwheelhouse clean
	
clean:
	rm -f ${WHL_NAME} ${EXTRA_CLEAN}

mkwheelhouse:
	ssh ${BUILD_USER}@${ROBORIO} 'cd ${BUILD_HOME} && mkdir -p ${BUILD_DIR}'

ifeq ($(DOWNLOAD_WHL), true)
${WHL_NAME}:
	pip3 --disable-pip-version-check download --no-deps --only-binary :all: ${PYPI_PACKAGE_NAME}==${PYPI_PACKAGE_VERSION}
else
${WHL_NAME}:
	scp ${BUILD_USER}@${ROBORIO}:${BUILD_HOME}${BUILD_DIR}/${WHL_NAME} "${WHL_DEST}/${WHL_NAME}"
endif

ifdef RUNTIME_DEPS
deps = --depends "${RUNTIME_DEPS}"
endif

whl: ${WHL_NAME}
ipkwhl: