
BINRELEASE = https://github.com/robotpy/roborio-opencv/releases/download/2021.0/OpenCV-4.5.0-cortexa9-vfpv3.tar.gz
CVZIP = $(abspath $(notdir ${BINRELEASE}))

export CVZIP

.PHONY: all clean fetch

${CVZIP}:
	wget ${BINRELEASE}

fetch: ${CVZIP} ;

clean:
	$(MAKE) -C opencv clean
	$(MAKE) -C opencv-dev clean
	$(MAKE) -C python3-opencv clean

all:
	$(MAKE) fetch
	$(MAKE) -C opencv all
	$(MAKE) -C opencv-dev all
	$(MAKE) -C python3-opencv all
