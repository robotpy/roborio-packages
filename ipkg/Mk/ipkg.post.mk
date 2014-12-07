# Variables:
#
# ROBORIO - the RoboRIO DNS name / IP address (expected to be set by user)
# BUILD_USER - the RoboRIO login to use (defaults to admin)
# BUILD_HOME - where build packages should be extracted (defaults to home)
#
# TGZ - the tar.gz source code file; defaults to last part of SOURCE
# EXTRA_CLEAN - extra files to be cleaned in clean
# BUILD_DEPS - a space-delimited list of opkg dependencies (for install-deps)
# BUILD_DIR - the directory where the TGZ gets extracted to.
#             defaults to TGZ with .tgz and .tar.gz stripped
# BUILD_WARNING - warning to print before build
# BUILD_CMD - the build command
# INSTALL_CMD - the install command
# GETDATA_TARARGS - the args to use for tar when getting data
# EXTRA_CONTROL - extra files to include in control.tar.gz
#
TGZ ?= $(lastword $(subst /, ,${SOURCE}))
BUILD_DIR ?= $(subst .tgz,,$(subst .tar.gz,,${TGZ}))
BUILD_USER ?= admin

clean:
	rm -f control.tar.gz
	rm -f data.tar.gz
	rm -f ${IPK_NAME} ${EXTRA_CLEAN}

install-deps:
ifneq ($(strip ${DEPS}),)
	ssh admin@${ROBORIO} 'opkg update && opkg install ${DEPS}'
endif

fetch: ${TGZ}
${TGZ}:
	wget ${SOURCE}

extract: ${TGZ}
	ssh ${BUILD_USER}@${ROBORIO} 'cd ${BUILD_HOME} && rm -rf ${BUILD_DIR}'
	cat ${TGZ} | ssh ${BUILD_USER}@${ROBORIO} 'cd ${BUILD_HOME} && tar xzf -'

build:
ifdef BUILD_WARNING
	@echo "--------------------------------------------------------------"
	@echo "${BUILD_WARNING}"
	@echo "--------------------------------------------------------------"
	@echo "Press ENTER to continue"
	@bash -c read
endif
	ssh ${BUILD_USER}@${ROBORIO} 'cd ${BUILD_HOME} && cd ${BUILD_DIR} && ${BUILD_CMD}'

install:
	ssh ${BUILD_USER}@${ROBORIO} 'cd ${BUILD_HOME} && cd ${BUILD_DIR} && ${INSTALL_CMD}'

getdata:
	mkdir -p data
	rm -rf data.new
	mkdir data.new
	cd data.new && ssh ${BUILD_USER}@${ROBORIO} 'cd / && tar -cf - ${GETDATA_TARARGS}' | tar xf -
	rm -rf data.old && mv data data.old && mv data.new data

${IPK_NAME}: data control ${EXTRA_CONTROL}
	tar czvf control.tar.gz control ${EXTRA_CONTROL}
	cd data && tar czvf ../data.tar.gz . && cd ..
	echo 2.0 > debian-binary
	ar r ${IPK_NAME} control.tar.gz data.tar.gz debian-binary
