
include ../Mk/pkgdata.mk
.PHONY: all getdata

BINRELEASE = https://github.com/wpilibsuite/EclipsePlugins/raw/master/edu.wpi.first.wpilib.plugins.java/src/main/resources/java-zip/ant/netconsole-host

all:
	$(MAKE) clean
	$(MAKE) getdata
	$(MAKE) ipk

getdata:
	rm -rf data
	mkdir -p data/usr/local/frc/bin
	wget ${BINRELEASE} -O data/usr/local/frc/bin/netconsole-host
	chmod +x data/usr/local/frc/bin/netconsole-host

include ${BUILD_ROOT}/Mk/ipk.mk