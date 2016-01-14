mjpg-streamer for FRC
=====================

This package supports multiple cameras. To change the settings, you should
modify /etc/default/mjpg-streamer

Known issues
------------

mjpg-streamer will crash if no camera is detected, or if the camera is
unplugged. You will need to execute:

	/etc/init.d/mjpg-streamer start 

to start the camera again.
