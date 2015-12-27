RobotPy RoboRIO Packages
========================

This repository contains the build files used to build the RobotPy .ipk
packages hosted at http://www.tortall.net/~robotpy/feeds/2016/.


Setting up the opkg feed on the RoboRIO
=======================================

Create a `.conf` file in `/etc/opkg` (e.g. `/etc/opkg/robotpy.conf`)
containing the following line:

`src/gz robotpy http://www.tortall.net/~robotpy/feeds/2016`

Then run `opkg update`.

Building these packages yourself
================================

Many of these packages are built directly on a roboRIO. Compiling them can
eat up most of your RoboRIO's disk space, so you'll probably want to reimage it
before using the RoboRIO in a competition.

Go into a directory and do this:

    make ROBORIO=roborio-XXXX-frc.local all

Notes
-----

* You will almost certainly want to setup passwordless login using an SSH key,
  as the compile process uses SSH to login to the roborio multiple times.

* Most of these packages can be compiled on a virtual machine, and
  the virtual machine won't run out of disk space or RAM quite so easily. See
  the [roborio-vm](https://github.com/robotpy/roborio-vm) repository for more
  details.

* Some packages use a lot of RAM, and your best bet is to use a swap device to
  allow it to complete. A USB memory stick works great for this.
  * On a linux host use `cfdisk` to partition your stick
  * Use `mkswap` to initialize the space.
  * Mount it on the roborio by using `swapon`

When adding new packages:

* Some packages have deeply recursive build functionality, if you have a weird
  segfault that occurs it might be because the process ran out of stack space 
  (the default on the RoboRIO is 256k, whereas modern linux default to a few MB).
  In your build steps, you can set the stack size by executing `ulimit -s 2048`
