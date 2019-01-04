# Variables:
#
# ROBORIO - the RoboRIO DNS name / IP address (expected to be set by user)
# BUILD_USER - the RoboRIO login to use (defaults to admin)
# BUILD_HOME - where build packages should be extracted (defaults to home)
# OPKG_SITE - where the RoboRIO should retrieve robotpy dependencies from
#
# TGZ - the tar.gz source code file; defaults to last part of SOURCE
# EXTRA_CLEAN - extra files to be cleaned in clean
# BUILD_DEPS - a space-delimited list of opkg dependencies (for install-deps)
# BUILD_DIR - the directory where the TGZ gets extracted to.
#             defaults to TGZ with .tgz and .tar.gz stripped
# BUILD_DIR_EXTRA - the directory inside the TGZ that builds should happen in
# BUILD_WARNING - warning to print before build
# BUILD_CMD - the build command
# INSTALL_CMD - the install command
# GETDATA_TARARGS - the args to use for tar when getting data
# EXTRA_CONTROL - extra files to include in control.tar.gz
#
TGZ ?= $(lastword $(subst /, ,${SOURCE}))
BUILD_DIR ?= $(subst .tgz,,$(subst .tar.gz,,${TGZ}))
BUILD_USER ?= admin
OPKG_SITE ?= https://www.tortall.net/~robotpy/feeds/${RELEASE}
STACK_SIZE ?= 4096


ifndef ROBORIO
$(error ROBORIO is not set, see vars.template)
endif

.PHONY: all init-ssh init-robotpy-opkg sync-date install-deps fetch extract build install fetch-src getdata

ALLTARGETS ?= clean init-robotpy-opkg sync-date install-deps fetch extract build install getdata ipk
all: ${ALLTARGETS}

init-ssh:
	ssh ${BUILD_USER}@${ROBORIO} 'mkdir -p .ssh && cat >> ~/.ssh/authorized_keys' < ~/.ssh/id_rsa.pub

init-robotpy-opkg:
	ssh ${BUILD_USER}@${ROBORIO} 'echo "src/gz robotpy ${OPKG_SITE}" > /etc/opkg/robotpy.conf'

sync-date:
ifneq (${NOSETDATE}, 1)
	ssh ${BUILD_USER}@${ROBORIO} "date -s '`date -u +'%Y-%m-%d %H:%m:%S'`'"
endif

install-deps:
ifneq ($(strip ${DEPS}),)
	ssh ${BUILD_USER}@${ROBORIO} 'opkg update && opkg install ${DEPS} && opkg clean'
endif

fetch: ${TGZ}
${TGZ}:
	wget ${SOURCE}

extract: ${TGZ}
	ssh ${BUILD_USER}@${ROBORIO} 'cd ${BUILD_HOME} && rm -rf ${BUILD_DIR}'
	cat ${TGZ} | ssh ${BUILD_USER}@${ROBORIO} 'cd ${BUILD_HOME} && mkdir ${BUILD_DIR} && cd ${BUILD_DIR} && tar xzf - --strip-components=1'
ifdef PATCHES
	$(foreach patch, $(PATCHES), ssh ${BUILD_USER}@${ROBORIO} 'cd ${BUILD_HOME} && cd ${BUILD_DIR} && patch -p1' < $(patch))
endif	

build:
ifdef BUILD_WARNING
	@echo "--------------------------------------------------------------"
	@echo "${BUILD_WARNING}"
	@echo "--------------------------------------------------------------"
	@echo "Press ENTER to continue"
	@bash -c read
endif
	ssh ${BUILD_USER}@${ROBORIO} 'ulimit -s ${STACK_SIZE} && cd ${BUILD_HOME} && cd ${BUILD_DIR}/${BUILD_DIR_EXTRA} && ${BUILD_CMD}'

install:
	ssh ${BUILD_USER}@${ROBORIO} 'ulimit -s ${STACK_SIZE} && cd ${BUILD_HOME} && cd ${BUILD_DIR}/${BUILD_DIR_EXTRA} && ${INSTALL_CMD}'
ifneq ($(strip ${EXES}),)
	ssh ${BUILD_USER}@${ROBORIO} 'for exes in ${EXES}; do for exe in /$$exes; do \
		fdir=$$(dirname $$exe) && fbase=$$(basename "$$exe") && \
		fdebug="$${fbase%.*}.debug" && \
		mkdir -p "$$fdir"/.debug && \
		chmod u+w $$exe && \
		objcopy --only-keep-debug $$exe "$$fdir/.debug/$$fdebug" && \
		chmod 755 "$$fdir/.debug/$$fdebug" && \
		objcopy --strip-debug "$$exe" && \
		objcopy --add-gnu-debuglink="$$fdir/.debug/$$fdebug" "$$exe"; \
		done; done'
endif

getdata:
	mkdir -p data
	rm -rf data.new
	mkdir data.new
	cd data.new && ssh ${BUILD_USER}@${ROBORIO} 'cd / && tar -cf - ${GETDATA_TARARGS}' | tar xf -
	rm -rf data.old && mv data data.old && mv data.new data
	[ ! -d extra ] || cp -r extra/* data/
