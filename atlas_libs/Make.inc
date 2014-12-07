#  ----------------------------
#  Make.inc for ATLAS3.8.4
#  ----------------------------

#  ----------------------------------
#  Make sure we get the correct shell
#  ----------------------------------
   SHELL = /bin/sh

#  -------------------------------------------------
#  Name indicating the platform to configure BLAS to
#  -------------------------------------------------
   ARCH = ARMv7VFPNEON32NEON

#  ----------------------------
#  Paths to various directories
#  ----------------------------
   BLDdir = /home/admin/atlas384/ATLAS-3.8.4-arm/build
   SRCdir = /home/admin/atlas384/ATLAS-3.8.4-arm/build/../
   INCAdir = $(BLDdir)/include
   INCSdir = $(SRCdir)/include
   BINdir = $(BLDdir)/bin
   LIBdir = $(BLDdir)/lib

   SYSdir = $(BLDdir)/tune/sysinfo
   GMMdir = $(BLDdir)/src/blas/gemm
   GMVdir = $(BLDdir)/src/blas/gemv
   GR1dir = $(BLDdir)/src/blas/ger
   L1Bdir = $(BLDdir)/src/blas/level1
   L2Bdir = $(BLDdir)/src/blas/level2
   L3Bdir = $(BLDdir)/src/blas/level3
   TSTdir = $(BLDdir)/src/testing
   AUXdir = $(BLDdir)/src/auxil
   CBLdir = $(BLDdir)/interfaces/blas/C/src
   FBLdir = $(BLDdir)/interfaces/blas/F77/src
   PTSdir = $(BLDdir)/src/pthreads
   MMTdir = $(BLDdir)/tune/blas/gemm
   MVTdir = $(BLDdir)/tune/blas/gemv
   R1Tdir = $(BLDdir)/tune/blas/ger
   L1Tdir = $(BLDdir)/tune/blas/level1
   L3Tdir = $(BLDdir)/tune/blas/level3

#  ---------------------------------------------------------------------
#  Name and location of scripts for running executables during tuning
#  ---------------------------------------------------------------------
   ATLRUN = $(BLDdir)/bin/ATLrun.sh
   ATLFWAIT = $(BLDdir)/bin/xatlas_waitfile

#  ---------------------
#  Libraries to be built
#  ---------------------
   ATLASlib = $(LIBdir)/libatlas.a
   CBLASlib = $(LIBdir)/libcblas.a
   F77BLASlib = $(LIBdir)/libf77blas.a
   PTCBLASlib = $(LIBdir)/libptcblas.a
   PTF77BLASlib = $(LIBdir)/libptf77blas.a
   LAPACKlib = $(LIBdir)/liblapack.a
   TESTlib = $(LIBdir)/libtstatlas.a

#  -------------------------------------------
#  Upper bound on largest cache size, in bytes
#  -------------------------------------------
   L2SIZE = -DL2SIZE=4194304

#  ---------------------------------------
#  Command setting up correct include path
#  ---------------------------------------
   INCLUDES = -I$(INCAdir) -I$(INCSdir) -I$(INCSdir)/contrib

#  -------------------------------------------
#  Defines for setting up F77/C interoperation
#  -------------------------------------------
   F2CDEFS = -DAdd_ -DF77_INTEGER=int -DStringSunStyle

#  ------------------------------
#  Architecture identifying flags
#  ------------------------------
   ARCHDEFS = -DATL_OS_Linux -DATL_ARCH_ARMv7VFPNEON -DATL_NEON -DATL_GAS_ARM

#  -------------------------------------------------------------------
#  NM is the flag required to name a compiled object/executable
#  OJ is the flag required to compile to object rather than executable
#  These flags are used by all compilers.
#  -------------------------------------------------------------------
   NM = -o
   OJ = -c

#  ---------------------------------------------------------------------------
#  Various compilers and linkers.  The compilers recognized by ATLAS are:
#    F77 :  Compiler to compile f77 interface code with -- Should match what
#           user compile's his own code with; has no affect on ATLAS
#           performance
#    ICC :  Compiler to used to compile all non-kernels in ATLAS, including
#           C interface codes.  Should match whatever compiler user compiles
#           with.  Impact on performance should be minimal.
#    SMC :  Compiler to use to compile single precision matmul kernels
#    DMC :  Compiler to use to compile double precision matmul kernels
#    SKC :  Compiler to use to compile single precision non-matmul kernels
#    DKC :  Compiler to use to compile double precision non-matmul kernels
#    XCC :  Compiler to be used on the compile engine of a cross-compiler
#  These C compiler are mostly the same, but flags are often different.
#  Note that if you specify no F77 compiler, F77 will be set to a C compiler
#  to aid in linking.
#  ---------------------------------------------------------------------------
   CDEFS = $(L2SIZE) $(INCLUDES) $(F2CDEFS) $(ARCHDEFS) -DWALL -DATL_NCPU=2

   ICC = gcc
   ICCFLAGS = $(CDEFS) -march=armv7-a -O1 -fPIC 
   SMC = gcc
   SMCFLAGS = -march=armv7-a -mfpu=neon -ffast-math -O3 -fschedule-insns -fschedule-insns2 -fprefetch-loop-arrays -fPIC 
   DMC = gcc
   DMCFLAGS = -march=armv7-a -mfpu=vfpv3 -O1 -fno-schedule-insns2 -fPIC 
   SKC = gcc
   SKCFLAGS = -march=armv7-a -mfpu=neon -ffast-math -O3 -fschedule-insns -fschedule-insns2 -fprefetch-loop-arrays -fPIC 
   DKC = gcc
   DKCFLAGS = -march=armv7-a -mfpu=vfpv3 -O1 -fno-schedule-insns2 -fPIC 
   XCC = gcc
   XCCFLAGS = $(CDEFS) -march=armv7-a -O1 -fPIC 
   F77 = gfortran
   F77FLAGS = -march=armv7-a -O1 -fPIC 
   SMAFLAGS = -fno-tree-loop-optimize
   DMAFLAGS = -fno-tree-loop-optimize
   CKC = $(SKC)
   ZKC = $(DKC)
   sKCFLAGS = $(CDEFS) $(SKCFLAGS)
   dKCFLAGS = $(CDEFS) $(DKCFLAGS)
   cKCFLAGS = $(CDEFS) $(SKCFLAGS)
   zKCFLAGS = $(CDEFS) $(DKCFLAGS)
   GOODGCC = gcc -fPIC
   LDFLAGS =
   F77SYSLIB = -L/usr/lib/gcc/arm-angstrom-linux-gnueabi/4.5.3 -l gfortran
   BC = $(ICC)
   NCFLAGS = $(ICCFLAGS)

   CLINKER = $(ICC)
   CLINKFLAGS = $(ICCFLAGS)
   FLINKER = $(F77)
   FLINKFLAGS = $(F77FLAGS)
   FCLINKFLAGS = $(FLINKFLAGS)
   ARCHIVER = ar
   ARFLAGS  = r
   RANLIB   = echo

#  -------------------------------------
#  tar, gzip, gunzip, and parallel make
#  -------------------------------------
   TAR    = tar
   GZIP   = gzip
   GUNZIP = gunzip
   PMAKE  = $(MAKE) -j 2

#  ------------------------------------
#  Reference and system libraries
#  ------------------------------------
   BLASlib = /home/admin/BLAS/blas_LINUX.a
   FBLASlib = 
   FLAPACKlib = /home/admin/lapack-3.5.0/liblapack.a
   SLAPACKlib = 
   LIBS = -lpthread -lm

#  --------------------------------------------------------------------
#  Compiler names for architectural defaults and flags to atlas_build
#  --------------------------------------------------------------------
   iccD = gcc
   smcD = gcc
   dmcD = gcc
   skcD = gcc
   dkcD = gcc
   xccD = gcc
   f77D = gfortran
   INSTFLAGS = -1 0 -a 0

#  ---------------------------------------
#  Generic targets needed by all makefiles
#  ---------------------------------------
do_it: all
waitfile:
