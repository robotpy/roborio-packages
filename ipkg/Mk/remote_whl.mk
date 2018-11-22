#
# Remotely builds a python wheel, retrieves it, and turns it into an IPK file
#
# PYPI_PACKAGE_NAME - name of package on pypi
# PYPI_PACKAGE_VERSION - package version on pypi
#
# BUILD_DEPS - IPKs that must be installed to build this
# RUNTIME_DEPS - IPKs that must be installed for this to work
# PYDEPS - Python build dependencies (download from pypi)
#

# Keep synced with pkgdata.mk
mkfile_path := $(abspath $(lastword $(MAKEFILE_LIST)))
BUILD_ROOT = $(abspath ${mkfile_path}/../..)

ARCH=cortexa9-vfpv3
PYVERSION=3.6
PYNAME=python36
RELEASE=2018-dev

PURE_PYTHON ?= false

ifeq ($(PURE_PYTHON), true)
	WHL_PLATFORM ?= py2.py3-none-any
else
	WHL_PLATFORM ?= cp36-cp36m-linux_armv7l
endif

IPK_DEST ?= ${BUILD_ROOT}/${RELEASE}
WHL_DEST ?= ${BUILD_ROOT}/${RELEASE}
WHL_NAME ?= $(subst -,_,${PYPI_PACKAGE_NAME})-${PYPI_PACKAGE_VERSION}-${WHL_PLATFORM}.whl
IPK_PKGNAME ?= ${PYNAME}-${PYPI_PACKAGE_NAME}
IPK_NAME ?= ${IPK_DEST}/${IPK_PKGNAME}_${PYPI_PACKAGE_VERSION}_${ARCH}.ipk

ALLTARGETS ?= clean init-robotpy-opkg sync-date install-deps mkwheelhouse build whl whl2ipk

BUILD_DIR ?= wheelhouse
BUILD_CMD ?= /usr/local/bin/pip3 --disable-pip-version-check install wheel ${PYDEPS} && /usr/local/bin/pip3 -v --disable-pip-version-check wheel --no-deps -b . ${PYPI_PACKAGE_NAME}==${PYPI_PACKAGE_VERSION}

DEPS ?= binutils-symlinks gcc-symlinks g++-symlinks libgcc-s-dev libstdc++-dev make python36-dev ${BUILD_DEPS}

include ${BUILD_ROOT}/Mk/remote_build.mk

.PHONY: mkwheelhouse clean
	
clean:
	rm -f ${WHL_NAME} ${IPK_NAME} ${EXTRA_CLEAN}

mkwheelhouse:
	ssh ${BUILD_USER}@${ROBORIO} 'cd ${BUILD_HOME} && mkdir -p ${BUILD_DIR}'

${WHL_NAME}:
	scp ${BUILD_USER}@${ROBORIO}:${BUILD_HOME}${BUILD_DIR}/${WHL_NAME} "${WHL_NAME}"

ifdef RUNTIME_DEPS
deps = --depends "${RUNTIME_DEPS}"
endif

${IPK_NAME}: ${WHL_NAME}
	${BUILD_ROOT}/tools/whl2ipk.py ${WHL_NAME} ${IPK_NAME} \
		--py 3.6 --depends python36 ${deps} \
		--maintainer 'RobotPy Developers <robotpy@googlegroups.com>' \
		--arch ${ARCH} --pkgname=${IPK_PKGNAME}

whl: ${WHL_NAME}
	
whl2ipk: ${IPK_NAME}
