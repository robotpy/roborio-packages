
BINRELEASE = https://github.com/robotpy/roborio-opencv/releases/download/2019.0.0/OpenCV-3.4.5-cortexa9-vfpv3.tar.gz
CVZIP = $(abspath $(notdir ${BINRELEASE}))

export CVZIP

.PHONY: all clean fetch

${CVZIP}:
	wget ${BINRELEASE}

fetch: ${CVZIP} ;

clean:
	$(MAKE) -C opencv3 clean
	$(MAKE) -C opencv3-dev clean
	$(MAKE) -C python3-opencv3 clean

all:
	$(MAKE) fetch
	$(MAKE) -C opencv3 all
	$(MAKE) -C opencv3-dev all
	$(MAKE) -C python3-opencv3 all
