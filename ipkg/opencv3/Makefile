
BINRELEASE = https://github.com/robotpy/roborio-opencv/releases/download/2016.1/OpenCV-3.1.0-cortexa9-vfpv3.tar.gz
CVZIP = $(abspath $(notdir ${BINRELEASE}))

export CVZIP

.PHONY: all clean fetch

${CVZIP}:
	wget ${BINRELEASE}

fetch: ${CVZIP} ;	

clean:
	$(MAKE) -C opencv3 clean
	$(MAKE) -C opencv3-dev clean
	$(MAKE) -C opencv3-java clean
	$(MAKE) -C python27-opencv3 clean
	$(MAKE) -C python35-opencv3 clean

all:
	$(MAKE) fetch
	$(MAKE) -C opencv3 all
	$(MAKE) -C opencv3-dev all
	$(MAKE) -C opencv3-java all
	$(MAKE) -C python27-opencv3 all
	$(MAKE) -C python35-opencv3 all

