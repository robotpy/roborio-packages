.PHONY: clean upload

clean:
	rm -f Packages Packages.filelist Packages.gz

Packages: *.ipk
	tools/make_package_index.py

upload-dev: Packages
	rsync --progress *.ipk Packages* narya.tortall.net:~robotpy/public_html/feeds/2017-dev/
	rsync --progress *.whl narya.tortall.net:~robotpy/public_html/wheels/2017-dev/

upload: Packages
	rsync --progress *.ipk Packages* narya.tortall.net:~robotpy/public_html/feeds/2017/
	rsync --progress *.whl narya.tortall.net:~robotpy/public_html/wheels/2017/
