.PHONY: clean upload

clean:
	rm Packages Packages.filelist Packages.gz

Packages: *.ipk
	tools/make_package_index.py

upload: Packages
	rsync --progress *.ipk Packages* narya.tortall.net:~robotpy/public_html/feeds/2016/
