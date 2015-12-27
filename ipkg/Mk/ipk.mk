.PHONY: ipk clean package
ipk: ${IPK_NAME}

package:
	$(MAKE) clean
	$(MAKE) getdata
	$(MAKE) ipk

clean:
	rm -f control.tar.gz
	rm -f data.tar.gz
	rm -f ${IPK_NAME} ${EXTRA_CLEAN}
	
${IPK_NAME}: data control ${EXTRA_CONTROL}
	tar -czvf control.tar.gz --owner=0 --group=0 control ${EXTRA_CONTROL}
	cd data && tar -czvf ../data.tar.gz --owner=0 --group=0 . && cd ..
	echo 2.0 > debian-binary
	ar r ${IPK_NAME} control.tar.gz data.tar.gz debian-binary
