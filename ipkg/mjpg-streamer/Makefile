
.PHONY: all clean
.DEFAULT: all

clean:
	$(MAKE) -C main clean
	$(MAKE) -C cv-plugin clean
	$(MAKE) -C py-plugin clean

all:
	$(MAKE) -C main all
	$(MAKE) -C cv-plugin getdata ipk
	$(MAKE) -C py-plugin getdata ipk
