RobotPy RoboRIO Packages
========================

This repository contains the build files used to build the RobotPy .ipk
packages hosted at http://www.tortall.net/~robotpy/feeds/2014/.


Setting up the opkg feed on the RoboRIO
=======================================

Create a `.conf` file in `/etc/opkg` (e.g. `/etc/opkg/robotpy.conf`)
containing the following line:

`src/gz robotpy http://www.tortall.net/~robotpy/feeds/2014`

Then run `opkg update`.

Building these packages yourself
================================

Go into a directory and do this:

    make ROBORIO=roborio-1418.local all

