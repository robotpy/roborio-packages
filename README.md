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

Go into a directory and do this:

    make ROBORIO=roborio-XXXX.local all


Notes
-----

Some packages require a lot of hard drive space, or more memory.

* Some packages have deeply recursive build functionality, you can change
  the stack size on the RoboRIO

