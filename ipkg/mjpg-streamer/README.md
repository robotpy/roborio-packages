mjpg-streamer for FRC
=====================

This package supports multiple cameras. To change the settings, you should
modify /etc/default/mjpg-streamer

Access the camera
-----------------

With the default settings, you can go to http://roborio-XXXX-frc.local:5800

Debugging problems
------------------

As of 2016.1.1, there exists a script called `mjpg_streamer_cfg1`, 2, 3.. that
will execute mjpg_streamer with the same arugments that would get executed by
the init script. You can run this to see the stderr/stdout of mjpg-streamer.

Known issues
------------

mjpg-streamer will crash if no camera is detected, or if the camera is
unplugged. You will need to execute:

	/etc/init.d/mjpg-streamer start 

to start the camera again.
