#
# Builds a python wheel out of a non-python package
#
# Limitation: wheels don't support symlinks
#

PYPY_PACKAGE_NAME ?= $(subst -,_,${PACKAGE})
WHL_PLATFORM ?= linux_armv7l

PKG_DEST ?= ${BUILD_ROOT}/${YEAR}-whl
PKG_NAME ?= ${PKG_DEST}/${PYPY_PACKAGE_NAME}-${VERSION}-py3-none-${WHL_PLATFORM}.whl

ifdef GETDATA_DEV_TARARGS
PKG_NAME_DEV ?= ${PKG_DEST}/${PYPY_PACKAGE_NAME}_dev-${VERSION}-py3-none-${WHL_PLATFORM}.whl
endif

ifdef GETDATA_DBG_TARARGS
PKG_NAME_DBG ?= ${PKG_DEST}/${PYPY_PACKAGE_NAME}_dbg-${VERSION}-py3-none-${WHL_PLATFORM}.whl
endif

ipkwhl: ${PKG_NAME} ${PKG_NAME_DEV} ${PKG_NAME_DBG}

package:
	$(MAKE) clean
	$(MAKE) getdata
	$(MAKE) ipkwhl

clean:
	rm -f ${PKG_NAME} ${EXTRA_CLEAN}

${PKG_NAME}: data.py ${BUILD_ROOT}/tools/gen_setup_py.py
	cd data && ${BUILD_ROOT}/tools/gen_setup_py.py ../data.py setup.py
	cd data && python3 setup.py bdist_wheel -p ${WHL_PLATFORM} -d ${PKG_DEST}

ifdef GETDATA_DEV_TARARGS
${PKG_NAME_DEV}: data.py ${BUILD_ROOT}/tools/gen_setup_py.py
	cd devdata && ${BUILD_ROOT}/tools/gen_setup_py.py ../data.py setup.py --dev
	cd devdata && python3 setup.py bdist_wheel -p ${WHL_PLATFORM} -d ${PKG_DEST}
endif

ifdef GETDATA_DBG_TARARGS
${PKG_NAME_DBG}: data.py ${BUILD_ROOT}/tools/gen_setup_py.py
	cd dbgdata && ${BUILD_ROOT}/tools/gen_setup_py.py ../data.py setup.py --dbg
	cd dbgdata && python3 setup.py bdist_wheel -p ${WHL_PLATFORM} -d ${PKG_DEST}
endif
