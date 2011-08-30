Return-Path: <jic23@cam.ac.uk>
From: Jonathan Cameron <jic23@cam.ac.uk>
To: greg@kroah.com
Cc: linux-iio@vger.kernel.org,
	Jonathan Cameron <jic23@cam.ac.uk>
Subject: [PATCH 7/7] staging:iio:Documentation sysfs-bus-iio update for chrdev merge.
Date: Tue, 30 Aug 2011 12:32:49 +0100
Message-Id: <1314703969-15275-8-git-send-email-jic23@cam.ac.uk>
In-Reply-To: <1314703969-15275-1-git-send-email-jic23@cam.ac.uk>
References: <1314703969-15275-1-git-send-email-jic23@cam.ac.uk>
List-ID: <linux-iio@vger.kernel.org>

A few element in here have been wrong for some time so cleaned them
up whilst here.

Signed-off-by: Jonathan Cameron <jic23@cam.ac.uk>
---
 drivers/staging/iio/Documentation/sysfs-bus-iio |  573 +++++++++++------------
 1 files changed, 276 insertions(+), 297 deletions(-)

diff --git a/drivers/staging/iio/Documentation/sysfs-bus-iio b/drivers/staging/iio/Documentation/sysfs-bus-iio
index c19dbf4..bed3bcb 100644
--- a/drivers/staging/iio/Documentation/sysfs-bus-iio
+++ b/drivers/staging/iio/Documentation/sysfs-bus-iio
@@ -1,4 +1,4 @@
-What:		/sys/bus/iio/devices/deviceX
+What:		/sys/bus/iio/devices/iio:deviceX
 KernelVersion:	2.6.35
 Contact:	linux-iio@vger.kernel.org
 Description:
@@ -6,7 +6,7 @@ Description:
 		Corresponds to a grouping of sensor channels. X is the IIO
 		index of the device.
 
-What:		/sys/bus/iio/devices/device[n]/power_state
+What:		/sys/bus/iio/devices/iio:deviceX/power_state
 KernelVersion:	2.6.37
 Contact:	linux-iio@vger.kernel.org
 Description:
@@ -25,21 +25,20 @@ Description:
 		generalize well and hence are not documented in this file.
 		X is the IIO index of the trigger.
 
-What:		/sys/bus/iio/devices/deviceX:buffer
+What:		/sys/bus/iio/devices/iio:deviceX/buffer
 KernelVersion:	2.6.35
 Contact:	linux-iio@vger.kernel.org
 Description:
-		Link to /sys/class/iio/deviceX/deviceX:buffer. X indicates
-		the device with which this buffer buffer is associated.
+		Directory of attributes relating to the buffer for the device.
 
-What:		/sys/bus/iio/devices/deviceX/name
+What:		/sys/bus/iio/devices/iio:deviceX/name
 KernelVersion:	2.6.35
 Contact:	linux-iio@vger.kernel.org
 Description:
 		Description of the physical chip / device for device X.
 		Typically a part number.
 
-What:		/sys/bus/iio/devices/deviceX/sampling_frequency
+What:		/sys/bus/iio/devices/iio:deviceX/sampling_frequency
 KernelVersion:	2.6.35
 Contact:	linux-iio@vger.kernel.org
 Description:
@@ -52,40 +51,40 @@ Description:
 		relevant directories.  If it effects all of the above
 		then it is to be found in the base device directory as here.
 
-What:		/sys/bus/iio/devices/deviceX/sampling_frequency_available
+What:		/sys/bus/iio/devices/iio:deviceX/sampling_frequency_available
 KernelVersion:	2.6.35
 Contact:	linux-iio@vger.kernel.org
 Description:
 		When the internal sampling clock can only take a small
 		discrete set of values, this file lists those available.
 
-What:		/sys/bus/iio/devices/deviceX/range
+What:		/sys/bus/iio/devices/iio:deviceX/range
 KernelVersion:	2.6.38
 Contact:	linux-iio@vger.kernel.org
 Description:
 		Hardware dependent ADC Full Scale Range in mVolt.
 
-What:		/sys/bus/iio/devices/deviceX/range_available
+What:		/sys/bus/iio/devices/iio:deviceX/range_available
 KernelVersion:	2.6.38
 Contact:	linux-iio@vger.kernel.org
 Description:
 		Hardware dependent supported vales for ADC Full Scale Range.
 
-What:		/sys/bus/iio/devices/deviceX/oversampling_ratio
+What:		/sys/bus/iio/devices/iio:deviceX/oversampling_ratio
 KernelVersion:	2.6.38
 Contact:	linux-iio@vger.kernel.org
 Description:
 		Hardware dependent ADC oversampling. Controls the sampling ratio
 		of the digital filter if available.
 
-What:		/sys/bus/iio/devices/deviceX/oversampling_ratio_available
+What:		/sys/bus/iio/devices/iio:deviceX/oversampling_ratio_available
 KernelVersion:	2.6.38
 Contact:	linux-iio@vger.kernel.org
 Description:
 		Hardware dependent values supported by the oversampling filter.
 
-What:		/sys/bus/iio/devices/deviceX/inY_raw
-What:		/sys/bus/iio/devices/deviceX/inY_supply_raw
+What:		/sys/bus/iio/devices/iio:deviceX/inY_raw
+What:		/sys/bus/iio/devices/iio:deviceX/inY_supply_raw
 KernelVersion:	2.6.35
 Contact:	linux-iio@vger.kernel.org
 Description:
@@ -95,7 +94,7 @@ Description:
 		versions may be used. The number must always be specified and
 		unique to allow association with event codes.
 
-What:		/sys/bus/iio/devices/deviceX/inY-inZ_raw
+What:		/sys/bus/iio/devices/iio:deviceX/inY-inZ_raw
 KernelVersion:	2.6.35
 Contact:	linux-iio@vger.kernel.org
 Description:
@@ -105,10 +104,10 @@ Description:
 		separately available. In differential only parts, then all that
 		is required is a consistent labeling.
 
-What:		/sys/bus/iio/devices/deviceX/temp_raw
-What:		/sys/bus/iio/devices/deviceX/temp_x_raw
-What:		/sys/bus/iio/devices/deviceX/temp_y_raw
-What:		/sys/bus/iio/devices/deviceX/temp_z_raw
+What:		/sys/bus/iio/devices/iio:deviceX/temp_raw
+What:		/sys/bus/iio/devices/iio:deviceX/temp_x_raw
+What:		/sys/bus/iio/devices/iio:deviceX/temp_y_raw
+What:		/sys/bus/iio/devices/iio:deviceX/temp_z_raw
 KernelVersion:	2.6.35
 Contact:	linux-iio@vger.kernel.org
 Description:
@@ -117,15 +116,15 @@ Description:
 		sensor is associated with one part of a compound device (e.g.
 		a gyroscope axis).
 
-What:		/sys/bus/iio/devices/deviceX/tempX_input
+What:		/sys/bus/iio/devices/iio:deviceX/tempX_input
 KernelVersion:	2.6.38
 Contact:	linux-iio@vger.kernel.org
 Description:
 		Scaled temperature measurement in milli degrees Celsius.
 
-What:		/sys/bus/iio/devices/deviceX/accel_x_raw
-What:		/sys/bus/iio/devices/deviceX/accel_y_raw
-What:		/sys/bus/iio/devices/deviceX/accel_z_raw
+What:		/sys/bus/iio/devices/iio:deviceX/accel_x_raw
+What:		/sys/bus/iio/devices/iio:deviceX/accel_y_raw
+What:		/sys/bus/iio/devices/iio:deviceX/accel_z_raw
 KernelVersion:	2.6.35
 Contact:	linux-iio@vger.kernel.org
 Description:
@@ -135,9 +134,9 @@ Description:
 		this orientation). Has all of the equivalent parameters as per
 		inY. Units after application of scale and offset are m/s^2.
 
-What:		/sys/bus/iio/devices/deviceX/gyro_x_raw
-What:		/sys/bus/iio/devices/deviceX/gyro_y_raw
-What:		/sys/bus/iio/devices/deviceX/gyro_z_raw
+What:		/sys/bus/iio/devices/iio:deviceX/gyro_x_raw
+What:		/sys/bus/iio/devices/iio:deviceX/gyro_y_raw
+What:		/sys/bus/iio/devices/iio:deviceX/gyro_z_raw
 KernelVersion:	2.6.35
 Contact:	linux-iio@vger.kernel.org
 Description:
@@ -146,9 +145,9 @@ Description:
 		radians per second. Has all the equivalent parameters as
 		per inY.
 
-What:		/sys/bus/iio/devices/deviceX/incli_x_raw
-What:		/sys/bus/iio/devices/deviceX/incli_y_raw
-What:		/sys/bus/iio/devices/deviceX/incli_z_raw
+What:		/sys/bus/iio/devices/iio:deviceX/incli_x_raw
+What:		/sys/bus/iio/devices/iio:deviceX/incli_y_raw
+What:		/sys/bus/iio/devices/iio:deviceX/incli_z_raw
 KernelVersion:	2.6.35
 Contact:	linux-iio@vger.kernel.org
 Description:
@@ -156,9 +155,9 @@ Description:
 		arbitrarily assigned). Data converted by application of offset
 		and scale to Degrees.
 
-What:		/sys/bus/iio/devices/deviceX/magn_x_raw
-What:		/sys/bus/iio/devices/deviceX/magn_y_raw
-What:		/sys/bus/iio/devices/deviceX/magn_z_raw
+What:		/sys/bus/iio/devices/iio:deviceX/magn_x_raw
+What:		/sys/bus/iio/devices/iio:deviceX/magn_y_raw
+What:		/sys/bus/iio/devices/iio:deviceX/magn_z_raw
 KernelVersion:	2.6.35
 Contact:	linux-iio@vger.kernel.org
 Description:
@@ -168,9 +167,9 @@ Description:
 		offset then scale to Gauss. Has all the equivalent modifiers
 		as per inY.
 
-What:		/sys/bus/iio/devices/deviceX/accel_x_peak_raw
-What:		/sys/bus/iio/devices/deviceX/accel_y_peak_raw
-What:		/sys/bus/iio/devices/deviceX/accel_z_peak_raw
+What:		/sys/bus/iio/devices/iio:deviceX/accel_x_peak_raw
+What:		/sys/bus/iio/devices/iio:deviceX/accel_y_peak_raw
+What:		/sys/bus/iio/devices/iio:deviceX/accel_z_peak_raw
 KernelVersion:	2.6.36
 Contact:	linux-iio@vger.kernel.org
 Description:
@@ -179,15 +178,15 @@ Description:
 		and are otherwise the direct equivalent of the
 		<type>Y[_name]_raw attributes.
 
-What:		/sys/bus/iio/devices/deviceX/accel_xyz_squared_peak_raw
+What:		/sys/bus/iio/devices/iio:deviceX/accel_xyz_squared_peak_raw
 KernelVersion:	2.6.36
 Contact:	linux-iio@vger.kernel.org
 Description:
 		A computed peak value based on the sum squared magnitude of
 		the underlying value in the specified directions.
 
-What:		/sys/bus/iio/devices/deviceX/accel_offset
-What:		/sys/bus/iio/devices/deviceX/temp_offset
+What:		/sys/bus/iio/devices/iio:deviceX/accel_offset
+What:		/sys/bus/iio/devices/iio:deviceX/temp_offset
 KernelVersion:	2.6.35
 Contact:	linux-iio@vger.kernel.org
 Description:
@@ -202,17 +201,17 @@ Description:
 		for variation between different instances of the part, typically
 		adjusted by using some hardware supported calibration procedure.
 
-What:		/sys/bus/iio/devices/deviceX/inY_scale
-What:		/sys/bus/iio/devices/deviceX/inY_supply_scale
-What:		/sys/bus/iio/devices/deviceX/in_scale
-What:		/sys/bus/iio/devices/deviceX/outY_scale
-What:		/sys/bus/iio/devices/deviceX/accel_scale
-What:		/sys/bus/iio/devices/deviceX/accel_peak_scale
-What:		/sys/bus/iio/devices/deviceX/gyro_scale
-What:		/sys/bus/iio/devices/deviceX/magn_scale
-What:		/sys/bus/iio/devices/deviceX/magn_x_scale
-What:		/sys/bus/iio/devices/deviceX/magn_y_scale
-What:		/sys/bus/iio/devices/deviceX/magn_z_scale
+What:		/sys/bus/iio/devices/iio:deviceX/inY_scale
+What:		/sys/bus/iio/devices/iio:deviceX/inY_supply_scale
+What:		/sys/bus/iio/devices/iio:deviceX/in_scale
+What:		/sys/bus/iio/devices/iio:deviceX/outY_scale
+What:		/sys/bus/iio/devices/iio:deviceX/accel_scale
+What:		/sys/bus/iio/devices/iio:deviceX/accel_peak_scale
+What:		/sys/bus/iio/devices/iio:deviceX/gyro_scale
+What:		/sys/bus/iio/devices/iio:deviceX/magn_scale
+What:		/sys/bus/iio/devices/iio:deviceX/magn_x_scale
+What:		/sys/bus/iio/devices/iio:deviceX/magn_y_scale
+What:		/sys/bus/iio/devices/iio:deviceX/magn_z_scale
 KernelVersion:	2.6.35
 Contact:	linux-iio@vger.kernel.org
 Description:
@@ -224,12 +223,12 @@ Description:
 		<type>[Y][_name]_scale. The peak modifier means this value
 		is applied to <type>Y[_name]_peak_raw values.
 
-What:		/sys/bus/iio/devices/deviceX/accel_x_calibbias
-What:		/sys/bus/iio/devices/deviceX/accel_y_calibbias
-What:		/sys/bus/iio/devices/deviceX/accel_z_calibbias
-What:		/sys/bus/iio/devices/deviceX/gyro_x_calibbias
-What:		/sys/bus/iio/devices/deviceX/gyro_y_calibbias
-What:		/sys/bus/iio/devices/deviceX/gyro_z_calibbias
+What:		/sys/bus/iio/devices/iio:deviceX/accel_x_calibbias
+What:		/sys/bus/iio/devices/iio:deviceX/accel_y_calibbias
+What:		/sys/bus/iio/devices/iio:deviceX/accel_z_calibbias
+What:		/sys/bus/iio/devices/iio:deviceX/gyro_x_calibbias
+What:		/sys/bus/iio/devices/iio:deviceX/gyro_y_calibbias
+What:		/sys/bus/iio/devices/iio:deviceX/gyro_z_calibbias
 KernelVersion:	2.6.35
 Contact:	linux-iio@vger.kernel.org
 Description:
@@ -237,15 +236,15 @@ Description:
 		inaccuracies). If shared across all channels, <type>_calibbias
 		is used.
 
-What		/sys/bus/iio/devices/deviceX/inY_calibscale
-What		/sys/bus/iio/devices/deviceX/inY_supply_calibscale
-What		/sys/bus/iio/devices/deviceX/in_calibscale
-What		/sys/bus/iio/devices/deviceX/accel_x_calibscale
-What		/sys/bus/iio/devices/deviceX/accel_y_calibscale
-What		/sys/bus/iio/devices/deviceX/accel_z_calibscale
-What		/sys/bus/iio/devices/deviceX/gyro_x_calibscale
-What		/sys/bus/iio/devices/deviceX/gyro_y_calibscale
-What		/sys/bus/iio/devices/deviceX/gyro_z_calibscale
+What		/sys/bus/iio/devices/iio:deviceX/inY_calibscale
+What		/sys/bus/iio/devices/iio:deviceX/inY_supply_calibscale
+What		/sys/bus/iio/devices/iio:deviceX/in_calibscale
+What		/sys/bus/iio/devices/iio:deviceX/accel_x_calibscale
+What		/sys/bus/iio/devices/iio:deviceX/accel_y_calibscale
+What		/sys/bus/iio/devices/iio:deviceX/accel_z_calibscale
+What		/sys/bus/iio/devices/iio:deviceX/gyro_x_calibscale
+What		/sys/bus/iio/devices/iio:deviceX/gyro_y_calibscale
+What		/sys/bus/iio/devices/iio:deviceX/gyro_z_calibscale
 KernelVersion:	2.6.35
 Contact:	linux-iio@vger.kernel.org
 Description:
@@ -253,14 +252,14 @@ Description:
 		production inaccuracies).  If shared across all channels,
 		<type>_calibscale is used.
 
-What:		/sys/bus/iio/devices/deviceX/accel_scale_available
+What:		/sys/bus/iio/devices/iio:deviceX/accel_scale_available
 KernelVersion:	2.635
 Contact:	linux-iio@vger.kernel.org
 Description:
 		If a discrete set of scale values are available, they
 		are listed in this attribute.
 
-What:		/sys/bus/iio/devices/deviceX/outY_raw
+What:		/sys/bus/iio/devices/iio:deviceX/outY_raw
 KernelVersion:	2.6.37
 Contact:	linux-iio@vger.kernel.org
 Description:
@@ -268,7 +267,7 @@ Description:
 		channel Y.  The number must always be specified and
 		unique if the output corresponds to a single channel.
 
-What:		/sys/bus/iio/devices/deviceX/outY&Z_raw
+What:		/sys/bus/iio/devices/iio:deviceX/outY&Z_raw
 KernelVersion:	2.6.37
 Contact:	linux-iio@vger.kernel.org
 Description:
@@ -277,8 +276,8 @@ Description:
 		where a single output sets the value for multiple channels
 		simultaneously.
 
-What:		/sys/bus/iio/devices/deviceX/outY_powerdown_mode
-What:		/sys/bus/iio/devices/deviceX/out_powerdown_mode
+What:		/sys/bus/iio/devices/iio:deviceX/outY_powerdown_mode
+What:		/sys/bus/iio/devices/iio:deviceX/out_powerdown_mode
 KernelVersion:	2.6.38
 Contact:	linux-iio@vger.kernel.org
 Description:
@@ -291,16 +290,16 @@ Description:
 		outX_powerdown_mode_available. If Y is not present the
 		mode is shared across all outputs.
 
-What:		/sys/bus/iio/devices/deviceX/outY_powerdown_mode_available
-What:		/sys/bus/iio/devices/deviceX/out_powerdown_mode_available
+What:		/sys/bus/iio/devices/iio:deviceX/outY_powerdown_mode_available
+What:		/sys/bus/iio/devices/iio:deviceX/out_powerdown_mode_available
 KernelVersion:	2.6.38
 Contact:	linux-iio@vger.kernel.org
 Description:
 		Lists all available output power down modes.
 		If Y is not present the mode is shared across all outputs.
 
-What:		/sys/bus/iio/devices/deviceX/outY_powerdown
-What:		/sys/bus/iio/devices/deviceX/out_powerdown
+What:		/sys/bus/iio/devices/iio:deviceX/outY_powerdown
+What:		/sys/bus/iio/devices/iio:deviceX/out_powerdown
 KernelVersion:	2.6.38
 Contact:	linux-iio@vger.kernel.org
 Description:
@@ -309,45 +308,37 @@ Description:
 		normal operation. Y may be suppressed if all outputs are
 		controlled together.
 
-What:		/sys/bus/iio/devices/deviceX/deviceX:eventY
+What:		/sys/bus/iio/devices/iio:deviceX/events
 KernelVersion:	2.6.35
 Contact:	linux-iio@vger.kernel.org
 Description:
 		Configuration of which hardware generated events are passed up
 		to user-space.
 
-What:		/sys/bus/iio/devices/deviceX:event/dev
-What:		/sys/bus/iio/devices/deviceX:eventY/dev
-KernelVersion:	2.6.35
-Contact:	linux-iio@vger.kernel.org
-Description:
-		major:minor character device numbers for the event line Y of
-		device X.
-
-What:		/sys/.../deviceX:eventY/accel_x_thresh_rising_en
-What:		/sys/.../deviceX:eventY/accel_x_thresh_falling_en
-What:		/sys/.../deviceX:eventY/accel_y_thresh_rising_en
-What:		/sys/.../deviceX:eventY/accel_y_thresh_falling_en
-What:		/sys/.../deviceX:eventY/accel_z_thresh_rising_en
-What:		/sys/.../deviceX:eventY/accel_z_thresh_falling_en
-What:		/sys/.../deviceX:eventY/gyro_x_thresh_rising_en
-What:		/sys/.../deviceX:eventY/gyro_x_thresh_falling_en
-What:		/sys/.../deviceX:eventY/gyro_y_thresh_rising_en
-What:		/sys/.../deviceX:eventY/gyro_y_thresh_falling_en
-What:		/sys/.../deviceX:eventY/gyro_z_thresh_rising_en
-What:		/sys/.../deviceX:eventY/gyro_z_thresh_falling_en
-What:		/sys/.../deviceX:eventY/magn_x_thresh_rising_en
-What:		/sys/.../deviceX:eventY/magn_x_thresh_falling_en
-What:		/sys/.../deviceX:eventY/magn_y_thresh_rising_en
-What:		/sys/.../deviceX:eventY/magn_y_thresh_falling_en
-What:		/sys/.../deviceX:eventY/magn_z_thresh_rising_en
-What:		/sys/.../deviceX:eventY/magn_z_thresh_falling_en
-What:		/sys/.../deviceX:eventY/inZ_supply_thresh_rising_en
-What:		/sys/.../deviceX:eventY/inZ_supply_thresh_falling_en
-What:		/sys/.../deviceX:eventY/inZ_thresh_rising_en
-What:		/sys/.../deviceX:eventY/inZ_thresh_falling_en
-What:		/sys/.../deviceX:eventY/temp_thresh_rising_en
-What:		/sys/.../deviceX:eventY/temp_thresh_falling_en
+What:		/sys/.../iio:deviceX/events/accel_x_thresh_rising_en
+What:		/sys/.../iio:deviceX/events/accel_x_thresh_falling_en
+What:		/sys/.../iio:deviceX/events/accel_y_thresh_rising_en
+What:		/sys/.../iio:deviceX/events/accel_y_thresh_falling_en
+What:		/sys/.../iio:deviceX/events/accel_z_thresh_rising_en
+What:		/sys/.../iio:deviceX/events/accel_z_thresh_falling_en
+What:		/sys/.../iio:deviceX/events/gyro_x_thresh_rising_en
+What:		/sys/.../iio:deviceX/events/gyro_x_thresh_falling_en
+What:		/sys/.../iio:deviceX/events/gyro_y_thresh_rising_en
+What:		/sys/.../iio:deviceX/events/gyro_y_thresh_falling_en
+What:		/sys/.../iio:deviceX/events/gyro_z_thresh_rising_en
+What:		/sys/.../iio:deviceX/events/gyro_z_thresh_falling_en
+What:		/sys/.../iio:deviceX/events/magn_x_thresh_rising_en
+What:		/sys/.../iio:deviceX/events/magn_x_thresh_falling_en
+What:		/sys/.../iio:deviceX/events/magn_y_thresh_rising_en
+What:		/sys/.../iio:deviceX/events/magn_y_thresh_falling_en
+What:		/sys/.../iio:deviceX/events/magn_z_thresh_rising_en
+What:		/sys/.../iio:deviceX/events/magn_z_thresh_falling_en
+What:		/sys/.../iio:deviceX/events/inZ_supply_thresh_rising_en
+What:		/sys/.../iio:deviceX/events/inZ_supply_thresh_falling_en
+What:		/sys/.../iio:deviceX/events/inZ_thresh_rising_en
+What:		/sys/.../iio:deviceX/events/inZ_thresh_falling_en
+What:		/sys/.../iio:deviceX/events/temp_thresh_rising_en
+What:		/sys/.../iio:deviceX/events/temp_thresh_falling_en
 KernelVersion:	2.6.37
 Contact:	linux-iio@vger.kernel.org
 Description:
@@ -369,30 +360,30 @@ Description:
 		a given event type is enabled a future point (and not those for
 		whatever event was previously enabled).
 
-What:		/sys/.../deviceX:eventY/accel_x_roc_rising_en
-What:		/sys/.../deviceX:eventY/accel_x_roc_falling_en
-What:		/sys/.../deviceX:eventY/accel_y_roc_rising_en
-What:		/sys/.../deviceX:eventY/accel_y_roc_falling_en
-What:		/sys/.../deviceX:eventY/accel_z_roc_rising_en
-What:		/sys/.../deviceX:eventY/accel_z_roc_falling_en
-What:		/sys/.../deviceX:eventY/gyro_x_roc_rising_en
-What:		/sys/.../deviceX:eventY/gyro_x_roc_falling_en
-What:		/sys/.../deviceX:eventY/gyro_y_roc_rising_en
-What:		/sys/.../deviceX:eventY/gyro_y_roc_falling_en
-What:		/sys/.../deviceX:eventY/gyro_z_roc_rising_en
-What:		/sys/.../deviceX:eventY/gyro_z_roc_falling_en
-What:		/sys/.../deviceX:eventY/magn_x_roc_rising_en
-What:		/sys/.../deviceX:eventY/magn_x_roc_falling_en
-What:		/sys/.../deviceX:eventY/magn_y_roc_rising_en
-What:		/sys/.../deviceX:eventY/magn_y_roc_falling_en
-What:		/sys/.../deviceX:eventY/magn_z_roc_rising_en
-What:		/sys/.../deviceX:eventY/magn_z_roc_falling_en
-What:		/sys/.../deviceX:eventY/inZ_supply_roc_rising_en
-What:		/sys/.../deviceX:eventY/inZ_supply_roc_falling_en
-What:		/sys/.../deviceX:eventY/inZ_roc_rising_en
-What:		/sys/.../deviceX:eventY/inZ_roc_falling_en
-What:		/sys/.../deviceX:eventY/temp_roc_rising_en
-What:		/sys/.../deviceX:eventY/temp_roc_falling_en
+What:		/sys/.../iio:deviceX/events/accel_x_roc_rising_en
+What:		/sys/.../iio:deviceX/events/accel_x_roc_falling_en
+What:		/sys/.../iio:deviceX/events/accel_y_roc_rising_en
+What:		/sys/.../iio:deviceX/events/accel_y_roc_falling_en
+What:		/sys/.../iio:deviceX/events/accel_z_roc_rising_en
+What:		/sys/.../iio:deviceX/events/accel_z_roc_falling_en
+What:		/sys/.../iio:deviceX/events/gyro_x_roc_rising_en
+What:		/sys/.../iio:deviceX/events/gyro_x_roc_falling_en
+What:		/sys/.../iio:deviceX/events/gyro_y_roc_rising_en
+What:		/sys/.../iio:deviceX/events/gyro_y_roc_falling_en
+What:		/sys/.../iio:deviceX/events/gyro_z_roc_rising_en
+What:		/sys/.../iio:deviceX/events/gyro_z_roc_falling_en
+What:		/sys/.../iio:deviceX/events/magn_x_roc_rising_en
+What:		/sys/.../iio:deviceX/events/magn_x_roc_falling_en
+What:		/sys/.../iio:deviceX/events/magn_y_roc_rising_en
+What:		/sys/.../iio:deviceX/events/magn_y_roc_falling_en
+What:		/sys/.../iio:deviceX/events/magn_z_roc_rising_en
+What:		/sys/.../iio:deviceX/events/magn_z_roc_falling_en
+What:		/sys/.../iio:deviceX/events/inZ_supply_roc_rising_en
+What:		/sys/.../iio:deviceX/events/inZ_supply_roc_falling_en
+What:		/sys/.../iio:deviceX/events/inZ_roc_rising_en
+What:		/sys/.../iio:deviceX/events/inZ_roc_falling_en
+What:		/sys/.../iio:deviceX/events/temp_roc_rising_en
+What:		/sys/.../iio:deviceX/events/temp_roc_falling_en
 KernelVersion:	2.6.37
 Contact:	linux-iio@vger.kernel.org
 Description:
@@ -415,30 +406,30 @@ Description:
 		a given event type is enabled a future point (and not those for
 		whatever event was previously enabled).
 
-What:		/sys/.../deviceX:eventY/accel_x_raw_thresh_rising_value
-What:		/sys/.../deviceX:eventY/accel_x_raw_thresh_falling_value
-What:		/sys/.../deviceX:eventY/accel_y_raw_thresh_rising_value
-What:		/sys/.../deviceX:eventY/accel_y_raw_thresh_falling_value
-What:		/sys/.../deviceX:eventY/accel_z_raw_thresh_rising_value
-What:		/sys/.../deviceX:eventY/accel_z_raw_thresh_falling_value
-What:		/sys/.../deviceX:eventY/gyro_x_raw_thresh_rising_value
-What:		/sys/.../deviceX:eventY/gyro_x_raw_thresh_falling_value
-What:		/sys/.../deviceX:eventY/gyro_y_raw_thresh_rising_value
-What:		/sys/.../deviceX:eventY/gyro_y_raw_thresh_falling_value
-What:		/sys/.../deviceX:eventY/gyro_z_raw_thresh_rising_value
-What:		/sys/.../deviceX:eventY/gyro_z_raw_thresh_falling_value
-What:		/sys/.../deviceX:eventY/magn_x_raw_thresh_rising_value
-What:		/sys/.../deviceX:eventY/magn_x_raw_thresh_falling_value
-What:		/sys/.../deviceX:eventY/magn_y_raw_thresh_rising_value
-What:		/sys/.../deviceX:eventY/magn_y_raw_thresh_falling_value
-What:		/sys/.../deviceX:eventY/magn_z_raw_thresh_rising_value
-What:		/sys/.../deviceX:eventY/magn_z_raw_thresh_falling_value
-What:		/sys/.../deviceX:eventY/inZ_supply_raw_thresh_rising_value
-What:		/sys/.../deviceX:eventY/inZ_supply_raw_thresh_falling_value
-What:		/sys/.../deviceX:eventY/inZ_raw_thresh_falling_value
-What:		/sys/.../deviceX:eventY/inZ_raw_thresh_falling_value
-What:		/sys/.../deviceX:eventY/temp_raw_thresh_falling_value
-What:		/sys/.../deviceX:eventY/temp_raw_thresh_falling_value
+What:		/sys/.../iio:deviceX/events/accel_x_raw_thresh_rising_value
+What:		/sys/.../iio:deviceX/events/accel_x_raw_thresh_falling_value
+What:		/sys/.../iio:deviceX/events/accel_y_raw_thresh_rising_value
+What:		/sys/.../iio:deviceX/events/accel_y_raw_thresh_falling_value
+What:		/sys/.../iio:deviceX/events/accel_z_raw_thresh_rising_value
+What:		/sys/.../iio:deviceX/events/accel_z_raw_thresh_falling_value
+What:		/sys/.../iio:deviceX/events/gyro_x_raw_thresh_rising_value
+What:		/sys/.../iio:deviceX/events/gyro_x_raw_thresh_falling_value
+What:		/sys/.../iio:deviceX/events/gyro_y_raw_thresh_rising_value
+What:		/sys/.../iio:deviceX/events/gyro_y_raw_thresh_falling_value
+What:		/sys/.../iio:deviceX/events/gyro_z_raw_thresh_rising_value
+What:		/sys/.../iio:deviceX/events/gyro_z_raw_thresh_falling_value
+What:		/sys/.../iio:deviceX/events/magn_x_raw_thresh_rising_value
+What:		/sys/.../iio:deviceX/events/magn_x_raw_thresh_falling_value
+What:		/sys/.../iio:deviceX/events/magn_y_raw_thresh_rising_value
+What:		/sys/.../iio:deviceX/events/magn_y_raw_thresh_falling_value
+What:		/sys/.../iio:deviceX/events/magn_z_raw_thresh_rising_value
+What:		/sys/.../iio:deviceX/events/magn_z_raw_thresh_falling_value
+What:		/sys/.../iio:deviceX/events/inZ_supply_raw_thresh_rising_value
+What:		/sys/.../iio:deviceX/events/inZ_supply_raw_thresh_falling_value
+What:		/sys/.../iio:deviceX/events/inZ_raw_thresh_falling_value
+What:		/sys/.../iio:deviceX/events/inZ_raw_thresh_falling_value
+What:		/sys/.../iio:deviceX/events/temp_raw_thresh_falling_value
+What:		/sys/.../iio:deviceX/events/temp_raw_thresh_falling_value
 KernelVersion:	2.6.37
 Contact:	linux-iio@vger.kernel.org
 Description:
@@ -452,30 +443,30 @@ Description:
 		value is in raw device units or in processed units (as _raw
 		and _input do on sysfs direct channel read attributes).
 
-What:		/sys/.../deviceX:eventY/accel_x_raw_roc_rising_value
-What:		/sys/.../deviceX:eventY/accel_x_raw_roc_falling_value
-What:		/sys/.../deviceX:eventY/accel_y_raw_roc_rising_value
-What:		/sys/.../deviceX:eventY/accel_y_raw_roc_falling_value
-What:		/sys/.../deviceX:eventY/accel_z_raw_roc_rising_value
-What:		/sys/.../deviceX:eventY/accel_z_raw_roc_falling_value
-What:		/sys/.../deviceX:eventY/gyro_x_raw_roc_rising_value
-What:		/sys/.../deviceX:eventY/gyro_x_raw_roc_falling_value
-What:		/sys/.../deviceX:eventY/gyro_y_raw_roc_rising_value
-What:		/sys/.../deviceX:eventY/gyro_y_raw_roc_falling_value
-What:		/sys/.../deviceX:eventY/gyro_z_raw_roc_rising_value
-What:		/sys/.../deviceX:eventY/gyro_z_raw_roc_falling_value
-What:		/sys/.../deviceX:eventY/magn_x_raw_roc_rising_value
-What:		/sys/.../deviceX:eventY/magn_x_raw_roc_falling_value
-What:		/sys/.../deviceX:eventY/magn_y_raw_roc_rising_value
-What:		/sys/.../deviceX:eventY/magn_y_raw_roc_falling_value
-What:		/sys/.../deviceX:eventY/magn_z_raw_roc_rising_value
-What:		/sys/.../deviceX:eventY/magn_z_raw_roc_falling_value
-What:		/sys/.../deviceX:eventY/inZ_supply_raw_roc_rising_value
-What:		/sys/.../deviceX:eventY/inZ_supply_raw_roc_falling_value
-What:		/sys/.../deviceX:eventY/inZ_raw_roc_falling_value
-What:		/sys/.../deviceX:eventY/inZ_raw_roc_falling_value
-What:		/sys/.../deviceX:eventY/temp_raw_roc_falling_value
-What:		/sys/.../deviceX:eventY/temp_raw_roc_falling_value
+What:		/sys/.../iio:deviceX/events/accel_x_raw_roc_rising_value
+What:		/sys/.../iio:deviceX/events/accel_x_raw_roc_falling_value
+What:		/sys/.../iio:deviceX/events/accel_y_raw_roc_rising_value
+What:		/sys/.../iio:deviceX/events/accel_y_raw_roc_falling_value
+What:		/sys/.../iio:deviceX/events/accel_z_raw_roc_rising_value
+What:		/sys/.../iio:deviceX/events/accel_z_raw_roc_falling_value
+What:		/sys/.../iio:deviceX/events/gyro_x_raw_roc_rising_value
+What:		/sys/.../iio:deviceX/events/gyro_x_raw_roc_falling_value
+What:		/sys/.../iio:deviceX/events/gyro_y_raw_roc_rising_value
+What:		/sys/.../iio:deviceX/events/gyro_y_raw_roc_falling_value
+What:		/sys/.../iio:deviceX/events/gyro_z_raw_roc_rising_value
+What:		/sys/.../iio:deviceX/events/gyro_z_raw_roc_falling_value
+What:		/sys/.../iio:deviceX/events/magn_x_raw_roc_rising_value
+What:		/sys/.../iio:deviceX/events/magn_x_raw_roc_falling_value
+What:		/sys/.../iio:deviceX/events/magn_y_raw_roc_rising_value
+What:		/sys/.../iio:deviceX/events/magn_y_raw_roc_falling_value
+What:		/sys/.../iio:deviceX/events/magn_z_raw_roc_rising_value
+What:		/sys/.../iio:deviceX/events/magn_z_raw_roc_falling_value
+What:		/sys/.../iio:deviceX/events/inZ_supply_raw_roc_rising_value
+What:		/sys/.../iio:deviceX/events/inZ_supply_raw_roc_falling_value
+What:		/sys/.../iio:deviceX/events/inZ_raw_roc_falling_value
+What:		/sys/.../iio:deviceX/events/inZ_raw_roc_falling_value
+What:		/sys/.../iio:deviceX/events/temp_raw_roc_falling_value
+What:		/sys/.../iio:deviceX/events/temp_raw_roc_falling_value
 KernelVersion:	2.6.37
 Contact:	linux-iio@vger.kernel.org
 Description:
@@ -489,55 +480,55 @@ Description:
 		value is in raw device units or in processed units (as _raw
 		and _input do on sysfs direct channel read attributes).
 
-What:		/sys/.../deviceX:eventY/accel_x_thresh_rising_period
-What:		/sys/.../deviceX:eventY/accel_x_thresh_falling_period
-hat:		/sys/.../deviceX:eventY/accel_x_roc_rising_period
-What:		/sys/.../deviceX:eventY/accel_x_roc_falling_period
-What:		/sys/.../deviceX:eventY/accel_y_thresh_rising_period
-What:		/sys/.../deviceX:eventY/accel_y_thresh_falling_period
-What:		/sys/.../deviceX:eventY/accel_y_roc_rising_period
-What:		/sys/.../deviceX:eventY/accel_y_roc_falling_period
-What:		/sys/.../deviceX:eventY/accel_z_thresh_rising_period
-What:		/sys/.../deviceX:eventY/accel_z_thresh_falling_period
-What:		/sys/.../deviceX:eventY/accel_z_roc_rising_period
-What:		/sys/.../deviceX:eventY/accel_z_roc_falling_period
-What:		/sys/.../deviceX:eventY/gyro_x_thresh_rising_period
-What:		/sys/.../deviceX:eventY/gyro_x_thresh_falling_period
-What:		/sys/.../deviceX:eventY/gyro_x_roc_rising_period
-What:		/sys/.../deviceX:eventY/gyro_x_roc_falling_period
-What:		/sys/.../deviceX:eventY/gyro_y_thresh_rising_period
-What:		/sys/.../deviceX:eventY/gyro_y_thresh_falling_period
-What:		/sys/.../deviceX:eventY/gyro_y_roc_rising_period
-What:		/sys/.../deviceX:eventY/gyro_y_roc_falling_period
-What:		/sys/.../deviceX:eventY/gyro_z_thresh_rising_period
-What:		/sys/.../deviceX:eventY/gyro_z_thresh_falling_period
-What:		/sys/.../deviceX:eventY/gyro_z_roc_rising_period
-What:		/sys/.../deviceX:eventY/gyro_z_roc_falling_period
-What:		/sys/.../deviceX:eventY/magn_x_thresh_rising_period
-What:		/sys/.../deviceX:eventY/magn_x_thresh_falling_period
-What:		/sys/.../deviceX:eventY/magn_x_roc_rising_period
-What:		/sys/.../deviceX:eventY/magn_x_roc_falling_period
-What:		/sys/.../deviceX:eventY/magn_y_thresh_rising_period
-What:		/sys/.../deviceX:eventY/magn_y_thresh_falling_period
-What:		/sys/.../deviceX:eventY/magn_y_roc_rising_period
-What:		/sys/.../deviceX:eventY/magn_y_roc_falling_period
-What:		/sys/.../deviceX:eventY/magn_z_thresh_rising_period
-What:		/sys/.../deviceX:eventY/magn_z_thresh_falling_period
-What:		/sys/.../deviceX:eventY/magn_z_roc_rising_period
-What:		/sys/.../deviceX:eventY/magn_z_roc_falling_period
-What:		/sys/.../deviceX:eventY/inZ_supply_thresh_rising_period
-What:		/sys/.../deviceX:eventY/inZ_supply_thresh_falling_period
-What:		/sys/.../deviceX:eventY/inz_supply_roc_rising_period
-What:		/sys/.../deviceX:eventY/inZ_supply_roc_falling_period
-What:		/sys/.../deviceX:eventY/inZ_thresh_rising_period
-What:		/sys/.../deviceX:eventY/inZ_thresh_falling_period
-What:		/sys/.../deviceX:eventY/inZ_roc_rising_period
-What:		/sys/.../deviceX:eventY/inZ_roc_falling_period
-What:		/sys/.../deviceX:eventY/temp_thresh_rising_period
-What:		/sys/.../deviceX:eventY/temp_thresh_falling_period
-What:		/sys/.../deviceX:eventY/temp_roc_rising_period
-What:		/sys/.../deviceX:eventY/temp_roc_falling_period
-What:		/sys/.../deviceX:eventY/accel_x&y&z_mag_falling_period
+What:		/sys/.../iio:deviceX/events/accel_x_thresh_rising_period
+What:		/sys/.../iio:deviceX/events/accel_x_thresh_falling_period
+hat:		/sys/.../iio:deviceX/events/accel_x_roc_rising_period
+What:		/sys/.../iio:deviceX/events/accel_x_roc_falling_period
+What:		/sys/.../iio:deviceX/events/accel_y_thresh_rising_period
+What:		/sys/.../iio:deviceX/events/accel_y_thresh_falling_period
+What:		/sys/.../iio:deviceX/events/accel_y_roc_rising_period
+What:		/sys/.../iio:deviceX/events/accel_y_roc_falling_period
+What:		/sys/.../iio:deviceX/events/accel_z_thresh_rising_period
+What:		/sys/.../iio:deviceX/events/accel_z_thresh_falling_period
+What:		/sys/.../iio:deviceX/events/accel_z_roc_rising_period
+What:		/sys/.../iio:deviceX/events/accel_z_roc_falling_period
+What:		/sys/.../iio:deviceX/events/gyro_x_thresh_rising_period
+What:		/sys/.../iio:deviceX/events/gyro_x_thresh_falling_period
+What:		/sys/.../iio:deviceX/events/gyro_x_roc_rising_period
+What:		/sys/.../iio:deviceX/events/gyro_x_roc_falling_period
+What:		/sys/.../iio:deviceX/events/gyro_y_thresh_rising_period
+What:		/sys/.../iio:deviceX/events/gyro_y_thresh_falling_period
+What:		/sys/.../iio:deviceX/events/gyro_y_roc_rising_period
+What:		/sys/.../iio:deviceX/events/gyro_y_roc_falling_period
+What:		/sys/.../iio:deviceX/events/gyro_z_thresh_rising_period
+What:		/sys/.../iio:deviceX/events/gyro_z_thresh_falling_period
+What:		/sys/.../iio:deviceX/events/gyro_z_roc_rising_period
+What:		/sys/.../iio:deviceX/events/gyro_z_roc_falling_period
+What:		/sys/.../iio:deviceX/events/magn_x_thresh_rising_period
+What:		/sys/.../iio:deviceX/events/magn_x_thresh_falling_period
+What:		/sys/.../iio:deviceX/events/magn_x_roc_rising_period
+What:		/sys/.../iio:deviceX/events/magn_x_roc_falling_period
+What:		/sys/.../iio:deviceX/events/magn_y_thresh_rising_period
+What:		/sys/.../iio:deviceX/events/magn_y_thresh_falling_period
+What:		/sys/.../iio:deviceX/events/magn_y_roc_rising_period
+What:		/sys/.../iio:deviceX/events/magn_y_roc_falling_period
+What:		/sys/.../iio:deviceX/events/magn_z_thresh_rising_period
+What:		/sys/.../iio:deviceX/events/magn_z_thresh_falling_period
+What:		/sys/.../iio:deviceX/events/magn_z_roc_rising_period
+What:		/sys/.../iio:deviceX/events/magn_z_roc_falling_period
+What:		/sys/.../iio:deviceX/events/inZ_supply_thresh_rising_period
+What:		/sys/.../iio:deviceX/events/inZ_supply_thresh_falling_period
+What:		/sys/.../iio:deviceX/events/inz_supply_roc_rising_period
+What:		/sys/.../iio:deviceX/events/inZ_supply_roc_falling_period
+What:		/sys/.../iio:deviceX/events/inZ_thresh_rising_period
+What:		/sys/.../iio:deviceX/events/inZ_thresh_falling_period
+What:		/sys/.../iio:deviceX/events/inZ_roc_rising_period
+What:		/sys/.../iio:deviceX/events/inZ_roc_falling_period
+What:		/sys/.../iio:deviceX/events/temp_thresh_rising_period
+What:		/sys/.../iio:deviceX/events/temp_thresh_falling_period
+What:		/sys/.../iio:deviceX/events/temp_roc_rising_period
+What:		/sys/.../iio:deviceX/events/temp_roc_falling_period
+What:		/sys/.../iio:deviceX/events/accel_x&y&z_mag_falling_period
 KernelVersion:	2.6.37
 Contact:	linux-iio@vger.kernel.org
 Description:
@@ -545,20 +536,20 @@ Description:
 		met before an event is generated. If direction is not
 		specified then this period applies to both directions.
 
-What:		/sys/.../deviceX:eventY/accel_mag_en
-What:		/sys/.../deviceX:eventY/accel_mag_rising_en
-What:		/sys/.../deviceX:eventY/accel_mag_falling_en
-What:		/sys/.../deviceX:eventY/accel_x_mag_en
-What:		/sys/.../deviceX:eventY/accel_x_mag_rising_en
-What:		/sys/.../deviceX:eventY/accel_x_mag_falling_en
-What:		/sys/.../deviceX:eventY/accel_y_mag_en
-What:		/sys/.../deviceX:eventY/accel_y_mag_rising_en
-What:		/sys/.../deviceX:eventY/accel_y_mag_falling_en
-What:		/sys/.../deviceX:eventY/accel_z_mag_en
-What:		/sys/.../deviceX:eventY/accel_z_mag_rising_en
-What:		/sys/.../deviceX:eventY/accel_z_mag_falling_en
-What:		/sys/.../deviceX:eventY/accel_x&y&z_mag_rising_en
-What:		/sys/.../deviceX:eventY/accel_x&y&z_mag_falling_en
+What:		/sys/.../iio:deviceX/events/accel_mag_en
+What:		/sys/.../iio:deviceX/events/accel_mag_rising_en
+What:		/sys/.../iio:deviceX/events/accel_mag_falling_en
+What:		/sys/.../iio:deviceX/events/accel_x_mag_en
+What:		/sys/.../iio:deviceX/events/accel_x_mag_rising_en
+What:		/sys/.../iio:deviceX/events/accel_x_mag_falling_en
+What:		/sys/.../iio:deviceX/events/accel_y_mag_en
+What:		/sys/.../iio:deviceX/events/accel_y_mag_rising_en
+What:		/sys/.../iio:deviceX/events/accel_y_mag_falling_en
+What:		/sys/.../iio:deviceX/events/accel_z_mag_en
+What:		/sys/.../iio:deviceX/events/accel_z_mag_rising_en
+What:		/sys/.../iio:deviceX/events/accel_z_mag_falling_en
+What:		/sys/.../iio:deviceX/events/accel_x&y&z_mag_rising_en
+What:		/sys/.../iio:deviceX/events/accel_x&y&z_mag_falling_en
 KernelVersion:	2.6.37
 Contact:	linux-iio@vger.kernel.org
 Description:
@@ -577,80 +568,68 @@ Description:
 		number or direction is not specified, applies to all channels of
 		this type.
 
-What:		/sys/bus/iio/devices/deviceX:buffer:event/dev
-KernelVersion:	2.6.35
-Contact:	linux-iio@vger.kernel.org
-Description:
-		Buffer for device X event character device major:minor numbers.
-
-What:		/sys/bus/iio/devices/deviceX:buffer:access/dev
-KernelVersion:	2.6.35
-Contact:	linux-iio@vger.kernel.org
-Description:
-		Buffer for device X access character device major:minor numbers.
-
-What:		/sys/bus/iio/devices/deviceX:buffer/trigger
+What:		/sys/bus/iio/devices/iio:deviceX/trigger/current_trigger
 KernelVersion:	2.6.35
 Contact:	linux-iio@vger.kernel.org
 Description:
 		The name of the trigger source being used, as per string given
 		in /sys/class/iio/triggerY/name.
 
-What:		/sys/bus/iio/devices/deviceX:buffer/length
+What:		/sys/bus/iio/devices/iio:deviceX/buffer/length
 KernelVersion:	2.6.35
 Contact:	linux-iio@vger.kernel.org
 Description:
 		Number of scans contained by the buffer.
 
-What:		/sys/bus/iio/devices/deviceX:buffer/bytes_per_datum
+What:		/sys/bus/iio/devices/iio:deviceX/buffer/bytes_per_datum
 KernelVersion:	2.6.37
 Contact:	linux-iio@vger.kernel.org
 Description:
 		Bytes per scan.  Due to alignment fun, the scan may be larger
 		than implied directly by the scan_element parameters.
 
-What:		/sys/bus/iio/devices/deviceX:buffer/enable
+What:		/sys/bus/iio/devices/iio:deviceX/buffer/enable
 KernelVersion:	2.6.35
 Contact:	linux-iio@vger.kernel.org
 Description:
 		Actually start the buffer capture up.  Will start trigger
 		if first device and appropriate.
 
-What:		/sys/bus/iio/devices/deviceX:buffer/scan_elements
+What:		/sys/bus/iio/devices/iio:deviceX/buffer/scan_elements
 KernelVersion:	2.6.37
 Contact:	linux-iio@vger.kernel.org
 Description:
 		Directory containing interfaces for elements that will be
 		captured for a single triggered sample set in the buffer.
 
-What:		/sys/bus/iio/devices/deviceX:buffer/scan_elements/accel_x_en
-What:		/sys/bus/iio/devices/deviceX:buffer/scan_elements/accel_y_en
-What:		/sys/bus/iio/devices/deviceX:buffer/scan_elements/accel_z_en
-What:		/sys/bus/iio/devices/deviceX:buffer/scan_elements/gyro_x_en
-What:		/sys/bus/iio/devices/deviceX:buffer/scan_elements/gyro_y_en
-What:		/sys/bus/iio/devices/deviceX:buffer/scan_elements/gyro_z_en
-What:		/sys/bus/iio/devices/deviceX:buffer/scan_elements/magn_x_en
-What:		/sys/bus/iio/devices/deviceX:buffer/scan_elements/magn_y_en
-What:		/sys/bus/iio/devices/deviceX:buffer/scan_elements/magn_z_en
-What:		/sys/bus/iio/devices/deviceX:buffer/scan_elements/timestamp_en
-What:		/sys/bus/iio/devices/deviceX:buffer/scan_elements/inY_supply_en
-What:		/sys/bus/iio/devices/deviceX:buffer/scan_elements/inY_en
-What:		/sys/bus/iio/devices/deviceX:buffer/scan_elements/inY-inZ_en
-What:		/sys/bus/iio/devices/deviceX:buffer/scan_elements/incli_x_en
-What:		/sys/bus/iio/devices/deviceX:buffer/scan_elements/incli_y_en
+What:		/sys/.../iio:deviceX/buffer/scan_elements/accel_x_en
+What:		/sys/.../iio:deviceX/buffer/scan_elements/accel_y_en
+What:		/sys/.../iio:deviceX/buffer/scan_elements/accel_z_en
+What:		/sys/.../iio:deviceX/buffer/scan_elements/gyro_x_en
+What:		/sys/.../iio:deviceX/buffer/scan_elements/gyro_y_en
+What:		/sys/.../iio:deviceX/buffer/scan_elements/gyro_z_en
+What:		/sys/.../iio:deviceX/buffer/scan_elements/magn_x_en
+What:		/sys/.../iio:deviceX/buffer/scan_elements/magn_y_en
+What:		/sys/.../iio:deviceX/buffer/scan_elements/magn_z_en
+What:		/sys/.../iio:deviceX/buffer/scan_elements/timestamp_en
+What:		/sys/.../iio:deviceX/buffer/scan_elements/inY_supply_en
+What:		/sys/.../iio:deviceX/buffer/scan_elements/inY_en
+What:		/sys/.../iio:deviceX/buffer/scan_elements/inY-inZ_en
+What:		/sys/.../iio:deviceX/buffer/scan_elements/incli_x_en
+What:		/sys/.../iio:deviceX/buffer/scan_elements/incli_y_en
 KernelVersion:	2.6.37
 Contact:	linux-iio@vger.kernel.org
 Description:
 		Scan element control for triggered data capture.
 
-What:		/sys/bus/iio/devices/deviceX:buffer/scan_elements/accel_type
-What:		/sys/bus/iio/devices/deviceX:buffer/scan_elements/gyro_type
-What:		/sys/bus/iio/devices/deviceX:buffer/scan_elements/magn_type
-What:		/sys/bus/iio/devices/deviceX:buffer/scan_elements/incli_type
-What:		/sys/bus/iio/devices/deviceX:buffer/scan_elements/inY_type
-What:		/sys/bus/iio/devices/deviceX:buffer/scan_elements/in-in_type
-What:		/sys/.../deviceX:buffer/scan_elements/inY_supply_type
-What:		/sys/.../deviceX:buffer/scan_elements/timestamp_type
+What:		/sys/.../iio:deviceX/buffer/scan_elements/accel_type
+What:		/sys/.../iio:deviceX/buffer/scan_elements/gyro_type
+What:		/sys/.../iio:deviceX/buffer/scan_elements/magn_type
+What:		/sys/.../iio:deviceX/buffer/scan_elements/incli_type
+What:		/sys/.../iio:deviceX/buffer/scan_elements/inY_type
+What:		/sys/.../iio:deviceX/buffer/scan_elements/in-in_type
+What:		/sys/.../iio:deviceX/buffer/scan_elements/inY_supply_type
+What:		/sys/.../iio:deviceX/buffer/scan_elements/timestamp_type
 KernelVersion:	2.6.37
 Contact:	linux-iio@vger.kernel.org
 Description:
@@ -673,27 +652,27 @@ Description:
 		For other storage combinations this attribute will be extended
 		appropriately.
 
-What:		/sys/.../deviceX:buffer/scan_elements/accel_type_available
+What:		/sys/.../iio:deviceX/buffer/scan_elements/accel_type_available
 KernelVersion:	2.6.37
 Contact:	linux-iio@vger.kernel.org
 Description:
 		If the type parameter can take one of a small set of values,
 		this attribute lists them.
 
-What:		/sys/bus/iio/devices/deviceX:buffer/scan_elements/inY_index
-What:		/sys/.../deviceX:buffer/scan_elements/inY_supply_index
-What:		/sys/bus/iio/devices/deviceX:buffer/scan_elements/accel_x_index
-What:		/sys/bus/iio/devices/deviceX:buffer/scan_elements/accel_y_index
-What:		/sys/bus/iio/devices/deviceX:buffer/scan_elements/accel_z_index
-What:		/sys/bus/iio/devices/deviceX:buffer/scan_elements/gyro_x_index
-What:		/sys/bus/iio/devices/deviceX:buffer/scan_elements/gyro_y_index
-What:		/sys/bus/iio/devices/deviceX:buffer/scan_elements/gyro_z_index
-What:		/sys/bus/iio/devices/deviceX:buffer/scan_elements/magn_x_index
-What:		/sys/bus/iio/devices/deviceX:buffer/scan_elements/magn_y_index
-What:		/sys/bus/iio/devices/deviceX:buffer/scan_elements/magn_z_index
-What:		/sys/bus/iio/devices/deviceX:buffer/scan_elements/incli_x_index
-What:		/sys/bus/iio/devices/deviceX:buffer/scan_elements/incli_y_index
-What:		/sys/.../deviceX:buffer/scan_elements/timestamp_index
+What:		/sys/.../iio:deviceX/buffer/scan_elements/inY_index
+What:		/sys/.../iio:deviceX/buffer/scan_elements/inY_supply_index
+What:		/sys/.../iio:deviceX/buffer/scan_elements/accel_x_index
+What:		/sys/.../iio:deviceX/buffer/scan_elements/accel_y_index
+What:		/sys/.../iio:deviceX/buffer/scan_elements/accel_z_index
+What:		/sys/.../iio:deviceX/buffer/scan_elements/gyro_x_index
+What:		/sys/.../iio:deviceX/buffer/scan_elements/gyro_y_index
+What:		/sys/.../iio:deviceX/buffer/scan_elements/gyro_z_index
+What:		/sys/.../iio:deviceX/buffer/scan_elements/magn_x_index
+What:		/sys/.../iio:deviceX/buffer/scan_elements/magn_y_index
+What:		/sys/.../iio:deviceX/buffer/scan_elements/magn_z_index
+What:		/sys/.../iio:deviceX/buffer/scan_elements/incli_x_index
+What:		/sys/.../iio:deviceX/buffer/scan_elements/incli_y_index
+What:		/sys/.../iio:deviceX/buffer/scan_elements/in_timestamp_index
 KernelVersion:	2.6.37
 Contact:	linux-iio@vger.kernel.org
 Description:
@@ -705,7 +684,7 @@ Description:
 		and the relevant _type attributes to establish the data storage
 		format.
 
-What:		/sys/bus/iio/devices/deviceX/gyro_z_quadrature_correction_raw
+What:		/sys/.../iio:deviceX/gyro_z_quadrature_correction_raw
 KernelVersion:	2.6.38
 Contact:	linux-iio@xxxxxxxxxxxxxxx
 Description:
-- 
1.7.3.4
