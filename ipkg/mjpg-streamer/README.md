mjpg-streamer for FRC
=====================

By default, this package will install mjpg-streamer so that it starts on bootup and streams a single camera on port 5800.

This package supports multiple cameras. To change the settings, you should
modify /etc/default/mjpg-streamer

Access the camera
-----------------

With the default settings, you can go to http://roborio-XXXX-frc.local:5800

For SmartDashboard users, there is a [plugin](https://github.com/Beachbot330/MJPGStream_SDExtension) exists that displays the stream.

Pesistent control settings
--------------------------

Any settings that you change in the web interface will not be persisted, and will
disappear after the camera is unplugged or a reboot.

To view the available input settings, you can execute the following:

	mjpg_streamer -i '/usr/local/lib/mjpg-streamer/input_uvc.so --help'
	
The available settings can be added to /etc/default/mjpg-streamer, by adding
them to the `INPUT[]` setting. For example, to set exposure manually to '30',
you would add the following to the config file:

	INPUT[1]="input_uvc.so --device /dev/video0 -ex 30"
	
Some settings do not work on all cameras, or may not support all ranges. The 
best way to find out what settings will work is to try them in the web interface.

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
