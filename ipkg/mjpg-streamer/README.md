mjpg-streamer for FRC
=====================

By default, this package will install mjpg-streamer so that it starts on bootup and streams a single camera on port 5800.

This package supports multiple cameras (see below). To change the settings,
you should modify /etc/default/mjpg-streamer

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

Multiple cameras
----------------

### USB Bandwidth issues

If you use multiple cameras and get the following error:

	VIDIOC_STREAMON: No space left on device
	
Then you're probably trying to use too much USB bandwidth. Search the internet
for more information, but what has worked for me is significantly reducing the
framerate and resolution on all cameras. Play with it until they work. I was
able to get the following 3-camera setup working with 3 LifeCam HD-3000 devices:

* input_uvc: 160x120
* input_uvc: 160x120
* input_opencv: 320x240

One thing that may help is the following command which can be executed on the 
RoboRIO via SSH:

	cat /sys/kernel/debug/usb/devices  | grep B\:
	
It will show the currently allocated USB bandwidth, you can use this to figure
out the correct combination of devices and framerates/resolutions.

### Persistent device paths

If you use the `/dev/video0..n` device paths, you will notice that on occasion
they are not ordered deterministically. To ensure that your cameras don't 
accidentally switch on you during a competition, you can use the following
to help you select a deterministic path.

If you execute `find /dev/v4l` on the RoboRIO with a webcam plugged in, you'll
see something like this:

```
admin@roboRIO-XXXX-FRC:~# find /dev/v4l
/dev/v4l
/dev/v4l/by-path
/dev/v4l/by-path/platform-zynq-ehci.0-usb-0:1.2.1:1.0-video-index0
/dev/v4l/by-id
/dev/v4l/by-id/usb-Microsoft_Microsoft®_LifeCam_HD-3000-video-index0
```

If you're using a USB Webcam that has a serial number associated with it, the
`/dev/v4l/by-id/*` paths are exact device paths that should always be the same 
regardless of what USB port you plug the device into. 

However, if you're using a device that does not provide a serial number (such as
the LifeCam HD-3000), then you will need to use a `/dev/v4l/by-path/*` device 
path instead. This path should be deterministic based on which USB port you 
have the webcam plugged into, even if you have it plugged into a hub. Just make
sure you don't switch it to a different port! 

### OpenCV and device paths

If you're using the OpenCV input plugin, as of 3.1.0-r2, OpenCV will accept
device paths (prior versions only accepted device index options such as `-d 0`).
This change uses a patch that will be apart of OpenCV 3.2 (see 
https://github.com/Itseez/opencv/pull/6391 for more information).

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
