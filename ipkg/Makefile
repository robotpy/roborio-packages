.PHONY: clean upload
	
YEAR=2020
DEVYEAR=${YEAR}-dev

clean:
	rm -f Packages Packages.filelist Packages.gz

${YEAR}/Packages ${YEAR}/index.html: ${YEAR}/*.ipk
	cd ${YEAR}; ../tools/make_package_index.py '${YEAR} RoboRIO packages'
	
${DEVYEAR}/Packages: ${DEVYEAR}/*.ipk
	cd ${DEVYEAR}; ../tools/make_package_index.py '${YEAR} RoboRIO packages (preview)'

upload-dev: ${DEVYEAR}/Packages
	cd ${DEVYEAR}; rsync --progress *.ipk Packages* narya.tortall.net:~robotpy/public_html/feeds/${DEVYEAR}/

upload: ${YEAR}/Packages ${YEAR}/index.html
	cd ${YEAR}; rsync --progress *.ipk Packages* index.html narya.tortall.net:~robotpy/public_html/feeds/${YEAR}/
