
ifneq ("$(wildcard vars)","")
include vars
endif

ifndef GPG_FINGERPRINT
$(error GPG_FINGERPRINT is not set, see vars.template)
endif

YEAR=2020
DEVYEAR=${YEAR}-dev

.PHONY: clean
clean:
	rm -f Packages Packages.filelist Packages.gz Packages.asc

${YEAR}/Packages.gz ${YEAR}/index.html: ${YEAR}/*.ipk
	cd ${YEAR}; ../tools/make_package_index.py '${YEAR} RoboRIO packages'

${YEAR}/Packages.asc: ${YEAR}/Packages.gz
	cd ${YEAR}; gpg --armor --detach-sign -u ${GPG_FINGERPRINT} Packages

${DEVYEAR}/Packages.gz: ${DEVYEAR}/*.ipk
	cd ${DEVYEAR}; ../tools/make_package_index.py '${YEAR} RoboRIO packages (preview)'

${DEVYEAR}/Packages.asc: ${DEVYEAR}/Packages.gz
	cd ${DEVYEAR}; gpg --armor --detach-sign -u ${GPG_FINGERPRINT} Packages

.PHONY: ${DEVYEAR}
${DEVYEAR}: ${DEVYEAR}/Packages.gz ${DEVYEAR}/Packages.asc

.PHONY: upload-dev
upload-dev: ${DEVYEAR}
	cd ${DEVYEAR}; rsync --progress *.ipk Packages* narya.tortall.net:~robotpy/public_html/feeds/${DEVYEAR}/

.PHONY: upload
upload: ${YEAR}/Packages.gz ${YEAR}/Packages.asc ${YEAR}/index.html
	cd ${YEAR}; rsync --progress *.ipk Packages* index.html narya.tortall.net:~robotpy/public_html/feeds/${YEAR}/
