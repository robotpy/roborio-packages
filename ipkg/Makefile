.PHONY: clean upload
	
YEAR=2017

clean:
	rm -f Packages Packages.filelist Packages.gz

Packages index.html: *.ipk
	tools/make_package_index.py '${YEAR} RoboRIO packages'

upload-dev: Packages
	rsync --progress *.ipk Packages* narya.tortall.net:~robotpy/public_html/feeds/${YEAR}-dev/

upload: Packages index.html
	rsync --progress *.ipk Packages* index.html narya.tortall.net:~robotpy/public_html/feeds/${YEAR}/
