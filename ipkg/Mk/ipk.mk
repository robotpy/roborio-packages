.PHONY: ipk clean package

ifdef GETDATA_DEV_TARARGS
IPK_NAME_DEV = ${IPK_DEST}/${PACKAGE}-dev_${VERSION}_${ARCH}.ipk
endif

ifdef GETDATA_DBG_TARARGS
IPK_NAME_DBG = ${IPK_DEST}/${PACKAGE}-dbg_${VERSION}_${ARCH}.ipk
endif

ipk: ${IPK_NAME} ${IPK_NAME_DEV} ${IPK_NAME_DBG}

package:
	$(MAKE) clean
	$(MAKE) getdata
	$(MAKE) ipk

clean:
	rm -f control.tar.gz
	rm -f data.tar.gz
	rm -rf devtmp dbgtmp
	rm -f ${IPK_NAME} ${IPK_NAME_DEV} ${IPK_NAME_DBG} ${EXTRA_CLEAN}
	
${IPK_NAME}: data control ${EXTRA_CONTROL}
	tar -czvf control.tar.gz --owner=0 --group=0 control ${EXTRA_CONTROL}
	cd data && tar -czvf ../data.tar.gz --owner=0 --group=0 . && cd ..
	echo 2.0 > debian-binary
	ar r ${IPK_NAME} control.tar.gz data.tar.gz debian-binary
	rm debian-binary

ifdef GETDATA_DEV_TARARGS
${IPK_NAME_DEV}: devdata control
	rm -rf devtmp
	mkdir devtmp
	sed \
		-e "s/^Package: .*/Package: ${PACKAGE}-dev/" \
		-e "s/\(^Description: .*\)/\1 development files/" \
		-e "s/^Section: .*/Section: devel/" \
		-e "s/^Depends: .*/Depends: ${PACKAGE} (= ${VERSION})/" \
		control > devtmp/control
	cd devtmp && tar -czvf control.tar.gz --owner=0 --group=0 control
	cd devdata && tar -czvf ../devtmp/data.tar.gz --owner=0 --group=0 .
	echo 2.0 > devtmp/debian-binary
	cd devtmp && ar r ${IPK_NAME_DEV} control.tar.gz data.tar.gz debian-binary
endif

ifdef GETDATA_DBG_TARARGS
${IPK_NAME_DBG}: dbgdata control
	rm -rf dbgtmp
	mkdir dbgtmp
	sed \
		-e "s/^Package: .*/Package: ${PACKAGE}-dbg/" \
		-e "s/\(^Description: .*\)/\1 debug symbols/" \
		-e "s/^Section: .*/Section: devel/" \
		-e "s/^Depends: .*/Depends: ${PACKAGE} (= ${VERSION})/" \
		control > dbgtmp/control
	cd dbgtmp && tar -czvf control.tar.gz --owner=0 --group=0 control
	cd dbgdata && tar -czvf ../dbgtmp/data.tar.gz --owner=0 --group=0 .
	echo 2.0 > dbgtmp/debian-binary
	cd dbgtmp && ar r ${IPK_NAME_DBG} control.tar.gz data.tar.gz debian-binary
endif