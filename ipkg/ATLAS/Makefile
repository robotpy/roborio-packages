
BINRELEASE = https://github.com/robotpy/roborio-atlas/releases/download/3.10.3-r2018.0/atlas-3.10.3_cortexa9-vfpv3.tar.bz2
ATLASZIP = $(abspath $(notdir ${BINRELEASE}))
	
export ATLASZIP

.PHONY: all clean fetch

${ATLASZIP}:
	wget ${BINRELEASE}

fetch: ${ATLASZIP} ;

clean:
	$(MAKE) -C ATLAS clean
	$(MAKE) -C ATLAS-dev clean

all:
	$(MAKE) fetch
	$(MAKE) -C ATLAS all
	$(MAKE) -C ATLAS-dev all
