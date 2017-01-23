
# Keep synced with pkgdata.mk
mkfile_path := $(abspath $(lastword $(MAKEFILE_LIST)))
BUILD_ROOT = $(abspath ${mkfile_path}/../..)

WHL_DEST ?= ${BUILD_ROOT}
WHL_FNAME ?= ${PYPI_PACKAGE_NAME}-${PYPI_PACKAGE_VERSION}-cp36-cp36m-linux_armv7l.whl
WHL_NAME ?= ${WHL_DEST}/${WHL_FNAME}

ALLTARGETS ?= clean init-robotpy-opkg sync-date install-deps mkwheelhouse build whl

BUILD_DIR ?= wheelhouse
BUILD_CMD ?= /usr/local/bin/pip3 --disable-pip-version-check install wheel && /usr/local/bin/pip3 -v --disable-pip-version-check wheel --no-deps -b . ${PYPI_PACKAGE_NAME}==${PYPI_PACKAGE_VERSION}

DEPS ?= binutils-symlinks gcc-symlinks g++-symlinks libgcc-s-dev make python36-dev ${IPK_DEPS}

include ${BUILD_ROOT}/Mk/remote_build.mk

.PHONY: mkwheelhouse

mkwheelhouse:
	ssh ${BUILD_USER}@${ROBORIO} 'cd ${BUILD_HOME} && mkdir -p ${BUILD_DIR}'

${WHL_NAME}:
	scp ${BUILD_USER}@${ROBORIO}:${BUILD_HOME}${BUILD_DIR}/${WHL_FNAME} "${WHL_NAME}"

whl: ${WHL_NAME}

clean:
	rm -f ${WHL_NAME}
