mjpg-streamer for FRC
=====================

This package supports multiple cameras. To change the settings, you should
modify /etc/default/mjpg-streamer

Access the camera
-----------------

With the default settings, you can go to http://roborio-XXXX-frc.local:5800

Known issues
------------

mjpg-streamer will crash if no camera is detected, or if the camera is
unplugged. You will need to execute:

	/etc/init.d/mjpg-streamer start 

to start the camera again.
