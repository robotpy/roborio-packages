ATLAS prebuilt binaries (NI LabVIEW 15.0)
=========================================

ATLAS is tricky to build, so the binaries are provided here instead of
providing makefiles to build them. However, if you need to build it,
here's how I did it.

Versions:

* libgfortran 4.8.2
* ATLAS 3.10.0
* LAPACK 3.6

Building libgfortran (cross compiler)
=====================================

	git clone https://github.com/ni/nilrt.git
	git checkout nilrt/15.0

	cd nilrt
	MACHINE=xilinx-zynq DISTRO=nilrt ./nibb.sh config

Modify `conf/local.conf', add the following to the end:

	FORTRAN_forcevariable = ",fortran"
	RUNTIMETARGET_append_pn-gcc-runtime = " libquadmath"
	
	PREFERRED_VERSION_libgfortran="4.8.2"
	PREFERRED_VERSION_nativesdk_libgfortran="4.8.2"

Need to cherry-pick the fixes for gfortran into openembedded-core:

	pushd sources/openembedded-core
	git cherry-pick de2aa7a56790581406f219339c9022638cd47494
	popd

Now, you can build fortran:

	. env-nilrt-xilinx-zynq
	bitbake gfortran
	bitbake libgfortran

There will be ipk files in `build/tmp_nilrt_3_0_xilinx-zynq-glibc/deploy/ipk/cortexa9-vfpv3/`.
Copy these to the roborio:

* libgfortran
* libgfortran-dev
* gfortran

SSH as admin, install the packages:

	opkg install *.ipk

Now you're ready to build ATLAS.

Building ATLAS (RoboRIO)
========================

Download ATLAS 3.10.2 and LAPACK 3.6.0. Copy to the RoboRIO, and unpack 
ATLAS. Execute:

	opkg install bzip2
	ulimit -s 2048
	tar -xf atlas3.10.2.tar.bz2

	cd ATLAS
	mkdir BUILD
	cd BUILD

	../configure --shared --with-netlib-lapack-tarfile=/home/admin/lapack-3.6.0.tgz -m 667
	make
	make check
	make install

The ATLAS files will be installed to /usr/local/atlas, tar those up and you're set!
