Return-Path: <jic23@cam.ac.uk>
From: Jonathan Cameron <jic23@cam.ac.uk>
To: linux-iio@vger.kernel.org
Cc: Jonathan Cameron <jic23@cam.ac.uk>
Subject: [PATCH 02/12] staging:iio:Documentation sysfs-bus-iio add in and out prefixes
Date: Fri, 26 Aug 2011 11:16:25 +0100
Message-Id: <1314353795-7437-3-git-send-email-jic23@cam.ac.uk>
In-Reply-To: <1314353795-7437-1-git-send-email-jic23@cam.ac.uk>
References: <1314353795-7437-1-git-send-email-jic23@cam.ac.uk>
List-ID: <linux-iio@vger.kernel.org>

Also includes the inX -> in_voltageX and outX -> out_voltageX conversions.
To keep lines short quite a lot of supressing of directories was needed.

Signed-off-by: Jonathan Cameron <jic23@cam.ac.uk>
---
 drivers/staging/iio/Documentation/sysfs-bus-iio |  536 +++++++++++-----------
 1 files changed, 268 insertions(+), 268 deletions(-)

diff --git a/drivers/staging/iio/Documentation/sysfs-bus-iio b/drivers/staging/iio/Documentation/sysfs-bus-iio
index bed3bcb..1d52c96 100644
--- a/drivers/staging/iio/Documentation/sysfs-bus-iio
+++ b/drivers/staging/iio/Documentation/sysfs-bus-iio
@@ -83,8 +83,8 @@ Contact:	linux-iio@vger.kernel.org
 Description:
 		Hardware dependent values supported by the oversampling filter.
 
-What:		/sys/bus/iio/devices/iio:deviceX/inY_raw
-What:		/sys/bus/iio/devices/iio:deviceX/inY_supply_raw
+What:		/sys/bus/iio/devices/iio:deviceX/in_voltageY_raw
+What:		/sys/bus/iio/devices/iio:deviceX/in_voltageY_supply_raw
 KernelVersion:	2.6.35
 Contact:	linux-iio@vger.kernel.org
 Description:
@@ -94,7 +94,7 @@ Description:
 		versions may be used. The number must always be specified and
 		unique to allow association with event codes.
 
-What:		/sys/bus/iio/devices/iio:deviceX/inY-inZ_raw
+What:		/sys/bus/iio/devices/iio:deviceX/in_voltageY-voltageZ_raw
 KernelVersion:	2.6.35
 Contact:	linux-iio@vger.kernel.org
 Description:
@@ -104,10 +104,10 @@ Description:
 		separately available. In differential only parts, then all that
 		is required is a consistent labeling.
 
-What:		/sys/bus/iio/devices/iio:deviceX/temp_raw
-What:		/sys/bus/iio/devices/iio:deviceX/temp_x_raw
-What:		/sys/bus/iio/devices/iio:deviceX/temp_y_raw
-What:		/sys/bus/iio/devices/iio:deviceX/temp_z_raw
+What:		/sys/bus/iio/devices/iio:deviceX/in_temp_raw
+What:		/sys/bus/iio/devices/iio:deviceX/in_temp_x_raw
+What:		/sys/bus/iio/devices/iio:deviceX/in_temp_y_raw
+What:		/sys/bus/iio/devices/iio:deviceX/in_temp_z_raw
 KernelVersion:	2.6.35
 Contact:	linux-iio@vger.kernel.org
 Description:
@@ -116,15 +116,15 @@ Description:
 		sensor is associated with one part of a compound device (e.g.
 		a gyroscope axis).
 
-What:		/sys/bus/iio/devices/iio:deviceX/tempX_input
+What:		/sys/bus/iio/devices/iio:deviceX/in_tempX_input
 KernelVersion:	2.6.38
 Contact:	linux-iio@vger.kernel.org
 Description:
 		Scaled temperature measurement in milli degrees Celsius.
 
-What:		/sys/bus/iio/devices/iio:deviceX/accel_x_raw
-What:		/sys/bus/iio/devices/iio:deviceX/accel_y_raw
-What:		/sys/bus/iio/devices/iio:deviceX/accel_z_raw
+What:		/sys/bus/iio/devices/iio:deviceX/in_accel_x_raw
+What:		/sys/bus/iio/devices/iio:deviceX/in_accel_y_raw
+What:		/sys/bus/iio/devices/iio:deviceX/in_accel_z_raw
 KernelVersion:	2.6.35
 Contact:	linux-iio@vger.kernel.org
 Description:
@@ -132,22 +132,22 @@ Description:
 		but should match other such assignments on device)
 		channel m (not present if only one accelerometer channel at
 		this orientation). Has all of the equivalent parameters as per
-		inY. Units after application of scale and offset are m/s^2.
+		voltageY. Units after application of scale and offset are m/s^2.
 
-What:		/sys/bus/iio/devices/iio:deviceX/gyro_x_raw
-What:		/sys/bus/iio/devices/iio:deviceX/gyro_y_raw
-What:		/sys/bus/iio/devices/iio:deviceX/gyro_z_raw
+What:		/sys/bus/iio/devices/iio:deviceX/in_gyro_x_raw
+What:		/sys/bus/iio/devices/iio:deviceX/in_gyro_y_raw
+What:		/sys/bus/iio/devices/iio:deviceX/in_gyro_z_raw
 KernelVersion:	2.6.35
 Contact:	linux-iio@vger.kernel.org
 Description:
 		Angular velocity about axis x, y or z (may be arbitrarily
 		assigned) Data converted by application of offset then scale to
 		radians per second. Has all the equivalent parameters as
-		per inY.
+		per voltageY.
 
-What:		/sys/bus/iio/devices/iio:deviceX/incli_x_raw
-What:		/sys/bus/iio/devices/iio:deviceX/incli_y_raw
-What:		/sys/bus/iio/devices/iio:deviceX/incli_z_raw
+What:		/sys/bus/iio/devices/iio:deviceX/in_incli_x_raw
+What:		/sys/bus/iio/devices/iio:deviceX/in_incli_y_raw
+What:		/sys/bus/iio/devices/iio:deviceX/in_incli_z_raw
 KernelVersion:	2.6.35
 Contact:	linux-iio@vger.kernel.org
 Description:
@@ -155,9 +155,9 @@ Description:
 		arbitrarily assigned). Data converted by application of offset
 		and scale to Degrees.
 
-What:		/sys/bus/iio/devices/iio:deviceX/magn_x_raw
-What:		/sys/bus/iio/devices/iio:deviceX/magn_y_raw
-What:		/sys/bus/iio/devices/iio:deviceX/magn_z_raw
+What:		/sys/bus/iio/devices/iio:deviceX/in_magn_x_raw
+What:		/sys/bus/iio/devices/iio:deviceX/in_magn_y_raw
+What:		/sys/bus/iio/devices/iio:deviceX/in_magn_z_raw
 KernelVersion:	2.6.35
 Contact:	linux-iio@vger.kernel.org
 Description:
@@ -165,11 +165,11 @@ Description:
 		assigned) channel m (not present if only one magnetometer
 		at this orientation).  Data converted by application of
 		offset then scale to Gauss. Has all the equivalent modifiers
-		as per inY.
+		as per voltageY.
 
-What:		/sys/bus/iio/devices/iio:deviceX/accel_x_peak_raw
-What:		/sys/bus/iio/devices/iio:deviceX/accel_y_peak_raw
-What:		/sys/bus/iio/devices/iio:deviceX/accel_z_peak_raw
+What:		/sys/bus/iio/devices/iio:deviceX/in_accel_x_peak_raw
+What:		/sys/bus/iio/devices/iio:deviceX/in_accel_y_peak_raw
+What:		/sys/bus/iio/devices/iio:deviceX/in_accel_z_peak_raw
 KernelVersion:	2.6.36
 Contact:	linux-iio@vger.kernel.org
 Description:
@@ -178,15 +178,15 @@ Description:
 		and are otherwise the direct equivalent of the
 		<type>Y[_name]_raw attributes.
 
-What:		/sys/bus/iio/devices/iio:deviceX/accel_xyz_squared_peak_raw
+What:		/sys/bus/iio/devices/iio:deviceX/in_accel_xyz_squared_peak_raw
 KernelVersion:	2.6.36
 Contact:	linux-iio@vger.kernel.org
 Description:
 		A computed peak value based on the sum squared magnitude of
 		the underlying value in the specified directions.
 
-What:		/sys/bus/iio/devices/iio:deviceX/accel_offset
-What:		/sys/bus/iio/devices/iio:deviceX/temp_offset
+What:		/sys/bus/iio/devices/iio:deviceX/in_accel_offset
+What:		/sys/bus/iio/devices/iio:deviceX/in_temp_offset
 KernelVersion:	2.6.35
 Contact:	linux-iio@vger.kernel.org
 Description:
@@ -201,17 +201,17 @@ Description:
 		for variation between different instances of the part, typically
 		adjusted by using some hardware supported calibration procedure.
 
-What:		/sys/bus/iio/devices/iio:deviceX/inY_scale
-What:		/sys/bus/iio/devices/iio:deviceX/inY_supply_scale
-What:		/sys/bus/iio/devices/iio:deviceX/in_scale
-What:		/sys/bus/iio/devices/iio:deviceX/outY_scale
-What:		/sys/bus/iio/devices/iio:deviceX/accel_scale
-What:		/sys/bus/iio/devices/iio:deviceX/accel_peak_scale
-What:		/sys/bus/iio/devices/iio:deviceX/gyro_scale
-What:		/sys/bus/iio/devices/iio:deviceX/magn_scale
-What:		/sys/bus/iio/devices/iio:deviceX/magn_x_scale
-What:		/sys/bus/iio/devices/iio:deviceX/magn_y_scale
-What:		/sys/bus/iio/devices/iio:deviceX/magn_z_scale
+What:		/sys/bus/iio/devices/iio:deviceX/in_voltageY_scale
+What:		/sys/bus/iio/devices/iio:deviceX/in_voltageY_supply_scale
+What:		/sys/bus/iio/devices/iio:deviceX/in_voltage_scale
+What:		/sys/bus/iio/devices/iio:deviceX/out_voltageY_scale
+What:		/sys/bus/iio/devices/iio:deviceX/in_accel_scale
+What:		/sys/bus/iio/devices/iio:deviceX/in_accel_peak_scale
+What:		/sys/bus/iio/devices/iio:deviceX/in_gyro_scale
+What:		/sys/bus/iio/devices/iio:deviceX/in_magn_scale
+What:		/sys/bus/iio/devices/iio:deviceX/in_magn_x_scale
+What:		/sys/bus/iio/devices/iio:deviceX/in_magn_y_scale
+What:		/sys/bus/iio/devices/iio:deviceX/in_magn_z_scale
 KernelVersion:	2.6.35
 Contact:	linux-iio@vger.kernel.org
 Description:
@@ -223,12 +223,12 @@ Description:
 		<type>[Y][_name]_scale. The peak modifier means this value
 		is applied to <type>Y[_name]_peak_raw values.
 
-What:		/sys/bus/iio/devices/iio:deviceX/accel_x_calibbias
-What:		/sys/bus/iio/devices/iio:deviceX/accel_y_calibbias
-What:		/sys/bus/iio/devices/iio:deviceX/accel_z_calibbias
-What:		/sys/bus/iio/devices/iio:deviceX/gyro_x_calibbias
-What:		/sys/bus/iio/devices/iio:deviceX/gyro_y_calibbias
-What:		/sys/bus/iio/devices/iio:deviceX/gyro_z_calibbias
+What:		/sys/bus/iio/devices/iio:deviceX/in_accel_x_calibbias
+What:		/sys/bus/iio/devices/iio:deviceX/in_accel_y_calibbias
+What:		/sys/bus/iio/devices/iio:deviceX/in_accel_z_calibbias
+What:		/sys/bus/iio/devices/iio:deviceX/in_gyro_x_calibbias
+What:		/sys/bus/iio/devices/iio:deviceX/in_gyro_y_calibbias
+What:		/sys/bus/iio/devices/iio:deviceX/in_gyro_z_calibbias
 KernelVersion:	2.6.35
 Contact:	linux-iio@vger.kernel.org
 Description:
@@ -236,15 +236,15 @@ Description:
 		inaccuracies). If shared across all channels, <type>_calibbias
 		is used.
 
-What		/sys/bus/iio/devices/iio:deviceX/inY_calibscale
-What		/sys/bus/iio/devices/iio:deviceX/inY_supply_calibscale
-What		/sys/bus/iio/devices/iio:deviceX/in_calibscale
-What		/sys/bus/iio/devices/iio:deviceX/accel_x_calibscale
-What		/sys/bus/iio/devices/iio:deviceX/accel_y_calibscale
-What		/sys/bus/iio/devices/iio:deviceX/accel_z_calibscale
-What		/sys/bus/iio/devices/iio:deviceX/gyro_x_calibscale
-What		/sys/bus/iio/devices/iio:deviceX/gyro_y_calibscale
-What		/sys/bus/iio/devices/iio:deviceX/gyro_z_calibscale
+What		/sys/bus/iio/devices/iio:deviceX/in_voltageY_calibscale
+What		/sys/bus/iio/devices/iio:deviceX/in_voltageY_supply_calibscale
+What		/sys/bus/iio/devices/iio:deviceX/in_voltage_calibscale
+What		/sys/bus/iio/devices/iio:deviceX/in_accel_x_calibscale
+What		/sys/bus/iio/devices/iio:deviceX/in_accel_y_calibscale
+What		/sys/bus/iio/devices/iio:deviceX/in_accel_z_calibscale
+What		/sys/bus/iio/devices/iio:deviceX/in_gyro_x_calibscale
+What		/sys/bus/iio/devices/iio:deviceX/in_gyro_y_calibscale
+What		/sys/bus/iio/devices/iio:deviceX/in_gyro_z_calibscale
 KernelVersion:	2.6.35
 Contact:	linux-iio@vger.kernel.org
 Description:
@@ -252,14 +252,14 @@ Description:
 		production inaccuracies).  If shared across all channels,
 		<type>_calibscale is used.
 
-What:		/sys/bus/iio/devices/iio:deviceX/accel_scale_available
+What:		/sys/bus/iio/devices/iio:deviceX/in_accel_scale_available
 KernelVersion:	2.635
 Contact:	linux-iio@vger.kernel.org
 Description:
 		If a discrete set of scale values are available, they
 		are listed in this attribute.
 
-What:		/sys/bus/iio/devices/iio:deviceX/outY_raw
+What:		/sys/bus/iio/devices/iio:deviceX/out_votlageY_raw
 KernelVersion:	2.6.37
 Contact:	linux-iio@vger.kernel.org
 Description:
@@ -267,7 +267,7 @@ Description:
 		channel Y.  The number must always be specified and
 		unique if the output corresponds to a single channel.
 
-What:		/sys/bus/iio/devices/iio:deviceX/outY&Z_raw
+What:		/sys/bus/iio/devices/iio:deviceX/out_voltageY&Z_raw
 KernelVersion:	2.6.37
 Contact:	linux-iio@vger.kernel.org
 Description:
@@ -276,8 +276,8 @@ Description:
 		where a single output sets the value for multiple channels
 		simultaneously.
 
-What:		/sys/bus/iio/devices/iio:deviceX/outY_powerdown_mode
-What:		/sys/bus/iio/devices/iio:deviceX/out_powerdown_mode
+What:		/sys/bus/iio/devices/iio:deviceX/out_voltageY_powerdown_mode
+What:		/sys/bus/iio/devices/iio:deviceX/out_voltage_powerdown_mode
 KernelVersion:	2.6.38
 Contact:	linux-iio@vger.kernel.org
 Description:
@@ -290,16 +290,16 @@ Description:
 		outX_powerdown_mode_available. If Y is not present the
 		mode is shared across all outputs.
 
-What:		/sys/bus/iio/devices/iio:deviceX/outY_powerdown_mode_available
-What:		/sys/bus/iio/devices/iio:deviceX/out_powerdown_mode_available
+What:		/sys/.../iio:deviceX/out_votlageY_powerdown_mode_available
+What:		/sys/.../iio:deviceX/out_voltage_powerdown_mode_available
 KernelVersion:	2.6.38
 Contact:	linux-iio@vger.kernel.org
 Description:
 		Lists all available output power down modes.
 		If Y is not present the mode is shared across all outputs.
 
-What:		/sys/bus/iio/devices/iio:deviceX/outY_powerdown
-What:		/sys/bus/iio/devices/iio:deviceX/out_powerdown
+What:		/sys/bus/iio/devices/iio:deviceX/out_voltageY_powerdown
+What:		/sys/bus/iio/devices/iio:deviceX/out_voltage_powerdown
 KernelVersion:	2.6.38
 Contact:	linux-iio@vger.kernel.org
 Description:
@@ -315,30 +315,30 @@ Description:
 		Configuration of which hardware generated events are passed up
 		to user-space.
 
-What:		/sys/.../iio:deviceX/events/accel_x_thresh_rising_en
-What:		/sys/.../iio:deviceX/events/accel_x_thresh_falling_en
-What:		/sys/.../iio:deviceX/events/accel_y_thresh_rising_en
-What:		/sys/.../iio:deviceX/events/accel_y_thresh_falling_en
-What:		/sys/.../iio:deviceX/events/accel_z_thresh_rising_en
-What:		/sys/.../iio:deviceX/events/accel_z_thresh_falling_en
-What:		/sys/.../iio:deviceX/events/gyro_x_thresh_rising_en
-What:		/sys/.../iio:deviceX/events/gyro_x_thresh_falling_en
-What:		/sys/.../iio:deviceX/events/gyro_y_thresh_rising_en
-What:		/sys/.../iio:deviceX/events/gyro_y_thresh_falling_en
-What:		/sys/.../iio:deviceX/events/gyro_z_thresh_rising_en
-What:		/sys/.../iio:deviceX/events/gyro_z_thresh_falling_en
-What:		/sys/.../iio:deviceX/events/magn_x_thresh_rising_en
-What:		/sys/.../iio:deviceX/events/magn_x_thresh_falling_en
-What:		/sys/.../iio:deviceX/events/magn_y_thresh_rising_en
-What:		/sys/.../iio:deviceX/events/magn_y_thresh_falling_en
-What:		/sys/.../iio:deviceX/events/magn_z_thresh_rising_en
-What:		/sys/.../iio:deviceX/events/magn_z_thresh_falling_en
-What:		/sys/.../iio:deviceX/events/inZ_supply_thresh_rising_en
-What:		/sys/.../iio:deviceX/events/inZ_supply_thresh_falling_en
-What:		/sys/.../iio:deviceX/events/inZ_thresh_rising_en
-What:		/sys/.../iio:deviceX/events/inZ_thresh_falling_en
-What:		/sys/.../iio:deviceX/events/temp_thresh_rising_en
-What:		/sys/.../iio:deviceX/events/temp_thresh_falling_en
+What:		/sys/.../iio:deviceX/events/in_accel_x_thresh_rising_en
+What:		/sys/.../iio:deviceX/events/in_accel_x_thresh_falling_en
+What:		/sys/.../iio:deviceX/events/in_accel_y_thresh_rising_en
+What:		/sys/.../iio:deviceX/events/in_accel_y_thresh_falling_en
+What:		/sys/.../iio:deviceX/events/in_accel_z_thresh_rising_en
+What:		/sys/.../iio:deviceX/events/in_accel_z_thresh_falling_en
+What:		/sys/.../iio:deviceX/events/in_gyro_x_thresh_rising_en
+What:		/sys/.../iio:deviceX/events/in_gyro_x_thresh_falling_en
+What:		/sys/.../iio:deviceX/events/in_gyro_y_thresh_rising_en
+What:		/sys/.../iio:deviceX/events/in_gyro_y_thresh_falling_en
+What:		/sys/.../iio:deviceX/events/in_gyro_z_thresh_rising_en
+What:		/sys/.../iio:deviceX/events/in_gyro_z_thresh_falling_en
+What:		/sys/.../iio:deviceX/events/in_magn_x_thresh_rising_en
+What:		/sys/.../iio:deviceX/events/in_magn_x_thresh_falling_en
+What:		/sys/.../iio:deviceX/events/in_magn_y_thresh_rising_en
+What:		/sys/.../iio:deviceX/events/in_magn_y_thresh_falling_en
+What:		/sys/.../iio:deviceX/events/in_magn_z_thresh_rising_en
+What:		/sys/.../iio:deviceX/events/in_magn_z_thresh_falling_en
+What:		/sys/.../iio:deviceX/events/in_voltageZ_supply_thresh_rising_en
+What:		/sys/.../iio:deviceX/events/in_voltageZ_supply_thresh_falling_en
+What:		/sys/.../iio:deviceX/events/in_voltageZ_thresh_rising_en
+What:		/sys/.../iio:deviceX/events/in_voltageZ_thresh_falling_en
+What:		/sys/.../iio:deviceX/events/in_temp_thresh_rising_en
+What:		/sys/.../iio:deviceX/events/in_temp_thresh_falling_en
 KernelVersion:	2.6.37
 Contact:	linux-iio@vger.kernel.org
 Description:
@@ -360,30 +360,30 @@ Description:
 		a given event type is enabled a future point (and not those for
 		whatever event was previously enabled).
 
-What:		/sys/.../iio:deviceX/events/accel_x_roc_rising_en
-What:		/sys/.../iio:deviceX/events/accel_x_roc_falling_en
-What:		/sys/.../iio:deviceX/events/accel_y_roc_rising_en
-What:		/sys/.../iio:deviceX/events/accel_y_roc_falling_en
-What:		/sys/.../iio:deviceX/events/accel_z_roc_rising_en
-What:		/sys/.../iio:deviceX/events/accel_z_roc_falling_en
-What:		/sys/.../iio:deviceX/events/gyro_x_roc_rising_en
-What:		/sys/.../iio:deviceX/events/gyro_x_roc_falling_en
-What:		/sys/.../iio:deviceX/events/gyro_y_roc_rising_en
-What:		/sys/.../iio:deviceX/events/gyro_y_roc_falling_en
-What:		/sys/.../iio:deviceX/events/gyro_z_roc_rising_en
-What:		/sys/.../iio:deviceX/events/gyro_z_roc_falling_en
-What:		/sys/.../iio:deviceX/events/magn_x_roc_rising_en
-What:		/sys/.../iio:deviceX/events/magn_x_roc_falling_en
-What:		/sys/.../iio:deviceX/events/magn_y_roc_rising_en
-What:		/sys/.../iio:deviceX/events/magn_y_roc_falling_en
-What:		/sys/.../iio:deviceX/events/magn_z_roc_rising_en
-What:		/sys/.../iio:deviceX/events/magn_z_roc_falling_en
-What:		/sys/.../iio:deviceX/events/inZ_supply_roc_rising_en
-What:		/sys/.../iio:deviceX/events/inZ_supply_roc_falling_en
-What:		/sys/.../iio:deviceX/events/inZ_roc_rising_en
-What:		/sys/.../iio:deviceX/events/inZ_roc_falling_en
-What:		/sys/.../iio:deviceX/events/temp_roc_rising_en
-What:		/sys/.../iio:deviceX/events/temp_roc_falling_en
+What:		/sys/.../iio:deviceX/events/in_accel_x_roc_rising_en
+What:		/sys/.../iio:deviceX/events/in_accel_x_roc_falling_en
+What:		/sys/.../iio:deviceX/events/in_accel_y_roc_rising_en
+What:		/sys/.../iio:deviceX/events/in_accel_y_roc_falling_en
+What:		/sys/.../iio:deviceX/events/in_accel_z_roc_rising_en
+What:		/sys/.../iio:deviceX/events/in_accel_z_roc_falling_en
+What:		/sys/.../iio:deviceX/events/in_gyro_x_roc_rising_en
+What:		/sys/.../iio:deviceX/events/in_gyro_x_roc_falling_en
+What:		/sys/.../iio:deviceX/events/in_gyro_y_roc_rising_en
+What:		/sys/.../iio:deviceX/events/in_gyro_y_roc_falling_en
+What:		/sys/.../iio:deviceX/events/in_gyro_z_roc_rising_en
+What:		/sys/.../iio:deviceX/events/in_gyro_z_roc_falling_en
+What:		/sys/.../iio:deviceX/events/in_magn_x_roc_rising_en
+What:		/sys/.../iio:deviceX/events/in_magn_x_roc_falling_en
+What:		/sys/.../iio:deviceX/events/in_magn_y_roc_rising_en
+What:		/sys/.../iio:deviceX/events/in_magn_y_roc_falling_en
+What:		/sys/.../iio:deviceX/events/in_magn_z_roc_rising_en
+What:		/sys/.../iio:deviceX/events/in_magn_z_roc_falling_en
+What:		/sys/.../iio:deviceX/events/in_voltageZ_supply_roc_rising_en
+What:		/sys/.../iio:deviceX/events/in_voltageZ_supply_roc_falling_en
+What:		/sys/.../iio:deviceX/events/in_voltageZ_roc_rising_en
+What:		/sys/.../iio:deviceX/events/in_voltageZ_roc_falling_en
+What:		/sys/.../iio:deviceX/events/in_temp_roc_rising_en
+What:		/sys/.../iio:deviceX/events/in_temp_roc_falling_en
 KernelVersion:	2.6.37
 Contact:	linux-iio@vger.kernel.org
 Description:
@@ -406,30 +406,30 @@ Description:
 		a given event type is enabled a future point (and not those for
 		whatever event was previously enabled).
 
-What:		/sys/.../iio:deviceX/events/accel_x_raw_thresh_rising_value
-What:		/sys/.../iio:deviceX/events/accel_x_raw_thresh_falling_value
-What:		/sys/.../iio:deviceX/events/accel_y_raw_thresh_rising_value
-What:		/sys/.../iio:deviceX/events/accel_y_raw_thresh_falling_value
-What:		/sys/.../iio:deviceX/events/accel_z_raw_thresh_rising_value
-What:		/sys/.../iio:deviceX/events/accel_z_raw_thresh_falling_value
-What:		/sys/.../iio:deviceX/events/gyro_x_raw_thresh_rising_value
-What:		/sys/.../iio:deviceX/events/gyro_x_raw_thresh_falling_value
-What:		/sys/.../iio:deviceX/events/gyro_y_raw_thresh_rising_value
-What:		/sys/.../iio:deviceX/events/gyro_y_raw_thresh_falling_value
-What:		/sys/.../iio:deviceX/events/gyro_z_raw_thresh_rising_value
-What:		/sys/.../iio:deviceX/events/gyro_z_raw_thresh_falling_value
-What:		/sys/.../iio:deviceX/events/magn_x_raw_thresh_rising_value
-What:		/sys/.../iio:deviceX/events/magn_x_raw_thresh_falling_value
-What:		/sys/.../iio:deviceX/events/magn_y_raw_thresh_rising_value
-What:		/sys/.../iio:deviceX/events/magn_y_raw_thresh_falling_value
-What:		/sys/.../iio:deviceX/events/magn_z_raw_thresh_rising_value
-What:		/sys/.../iio:deviceX/events/magn_z_raw_thresh_falling_value
-What:		/sys/.../iio:deviceX/events/inZ_supply_raw_thresh_rising_value
-What:		/sys/.../iio:deviceX/events/inZ_supply_raw_thresh_falling_value
-What:		/sys/.../iio:deviceX/events/inZ_raw_thresh_falling_value
-What:		/sys/.../iio:deviceX/events/inZ_raw_thresh_falling_value
-What:		/sys/.../iio:deviceX/events/temp_raw_thresh_falling_value
-What:		/sys/.../iio:deviceX/events/temp_raw_thresh_falling_value
+What:		/sys/.../events/in_accel_x_raw_thresh_rising_value
+What:		/sys/.../events/in_accel_x_raw_thresh_falling_value
+What:		/sys/.../events/in_accel_y_raw_thresh_rising_value
+What:		/sys/.../events/in_accel_y_raw_thresh_falling_value
+What:		/sys/.../events/in_accel_z_raw_thresh_rising_value
+What:		/sys/.../events/in_accel_z_raw_thresh_falling_value
+What:		/sys/.../events/in_gyro_x_raw_thresh_rising_value
+What:		/sys/.../events/in_gyro_x_raw_thresh_falling_value
+What:		/sys/.../events/in_gyro_y_raw_thresh_rising_value
+What:		/sys/.../events/in_gyro_y_raw_thresh_falling_value
+What:		/sys/.../events/in_gyro_z_raw_thresh_rising_value
+What:		/sys/.../events/in_gyro_z_raw_thresh_falling_value
+What:		/sys/.../events/in_magn_x_raw_thresh_rising_value
+What:		/sys/.../events/in_magn_x_raw_thresh_falling_value
+What:		/sys/.../events/in_magn_y_raw_thresh_rising_value
+What:		/sys/.../events/in_magn_y_raw_thresh_falling_value
+What:		/sys/.../events/in_magn_z_raw_thresh_rising_value
+What:		/sys/.../events/in_magn_z_raw_thresh_falling_value
+What:		/sys/.../events/in_voltageZ_supply_raw_thresh_rising_value
+What:		/sys/.../events/in_voltageZ_supply_raw_thresh_falling_value
+What:		/sys/.../events/in_voltageZ_raw_thresh_falling_value
+What:		/sys/.../events/in_voltageZ_raw_thresh_falling_value
+What:		/sys/.../events/in_temp_raw_thresh_falling_value
+What:		/sys/.../events/in_temp_raw_thresh_falling_value
 KernelVersion:	2.6.37
 Contact:	linux-iio@vger.kernel.org
 Description:
@@ -443,30 +443,30 @@ Description:
 		value is in raw device units or in processed units (as _raw
 		and _input do on sysfs direct channel read attributes).
 
-What:		/sys/.../iio:deviceX/events/accel_x_raw_roc_rising_value
-What:		/sys/.../iio:deviceX/events/accel_x_raw_roc_falling_value
-What:		/sys/.../iio:deviceX/events/accel_y_raw_roc_rising_value
-What:		/sys/.../iio:deviceX/events/accel_y_raw_roc_falling_value
-What:		/sys/.../iio:deviceX/events/accel_z_raw_roc_rising_value
-What:		/sys/.../iio:deviceX/events/accel_z_raw_roc_falling_value
-What:		/sys/.../iio:deviceX/events/gyro_x_raw_roc_rising_value
-What:		/sys/.../iio:deviceX/events/gyro_x_raw_roc_falling_value
-What:		/sys/.../iio:deviceX/events/gyro_y_raw_roc_rising_value
-What:		/sys/.../iio:deviceX/events/gyro_y_raw_roc_falling_value
-What:		/sys/.../iio:deviceX/events/gyro_z_raw_roc_rising_value
-What:		/sys/.../iio:deviceX/events/gyro_z_raw_roc_falling_value
-What:		/sys/.../iio:deviceX/events/magn_x_raw_roc_rising_value
-What:		/sys/.../iio:deviceX/events/magn_x_raw_roc_falling_value
-What:		/sys/.../iio:deviceX/events/magn_y_raw_roc_rising_value
-What:		/sys/.../iio:deviceX/events/magn_y_raw_roc_falling_value
-What:		/sys/.../iio:deviceX/events/magn_z_raw_roc_rising_value
-What:		/sys/.../iio:deviceX/events/magn_z_raw_roc_falling_value
-What:		/sys/.../iio:deviceX/events/inZ_supply_raw_roc_rising_value
-What:		/sys/.../iio:deviceX/events/inZ_supply_raw_roc_falling_value
-What:		/sys/.../iio:deviceX/events/inZ_raw_roc_falling_value
-What:		/sys/.../iio:deviceX/events/inZ_raw_roc_falling_value
-What:		/sys/.../iio:deviceX/events/temp_raw_roc_falling_value
-What:		/sys/.../iio:deviceX/events/temp_raw_roc_falling_value
+What:		/sys/.../events/in_accel_x_raw_roc_rising_value
+What:		/sys/.../events/in_accel_x_raw_roc_falling_value
+What:		/sys/.../events/in_accel_y_raw_roc_rising_value
+What:		/sys/.../events/in_accel_y_raw_roc_falling_value
+What:		/sys/.../events/in_accel_z_raw_roc_rising_value
+What:		/sys/.../events/in_accel_z_raw_roc_falling_value
+What:		/sys/.../events/in_gyro_x_raw_roc_rising_value
+What:		/sys/.../events/in_gyro_x_raw_roc_falling_value
+What:		/sys/.../events/in_gyro_y_raw_roc_rising_value
+What:		/sys/.../events/in_gyro_y_raw_roc_falling_value
+What:		/sys/.../events/in_gyro_z_raw_roc_rising_value
+What:		/sys/.../events/in_gyro_z_raw_roc_falling_value
+What:		/sys/.../events/in_magn_x_raw_roc_rising_value
+What:		/sys/.../events/in_magn_x_raw_roc_falling_value
+What:		/sys/.../events/in_magn_y_raw_roc_rising_value
+What:		/sys/.../events/in_magn_y_raw_roc_falling_value
+What:		/sys/.../events/in_magn_z_raw_roc_rising_value
+What:		/sys/.../events/in_magn_z_raw_roc_falling_value
+What:		/sys/.../events/in_voltageZ_supply_raw_roc_rising_value
+What:		/sys/.../events/in_voltageZ_supply_raw_roc_falling_value
+What:		/sys/.../events/in_voltageZ_raw_roc_falling_value
+What:		/sys/.../events/in_voltageZ_raw_roc_falling_value
+What:		/sys/.../events/in_temp_raw_roc_falling_value
+What:		/sys/.../events/in_temp_raw_roc_falling_value
 KernelVersion:	2.6.37
 Contact:	linux-iio@vger.kernel.org
 Description:
@@ -480,55 +480,55 @@ Description:
 		value is in raw device units or in processed units (as _raw
 		and _input do on sysfs direct channel read attributes).
 
-What:		/sys/.../iio:deviceX/events/accel_x_thresh_rising_period
-What:		/sys/.../iio:deviceX/events/accel_x_thresh_falling_period
-hat:		/sys/.../iio:deviceX/events/accel_x_roc_rising_period
-What:		/sys/.../iio:deviceX/events/accel_x_roc_falling_period
-What:		/sys/.../iio:deviceX/events/accel_y_thresh_rising_period
-What:		/sys/.../iio:deviceX/events/accel_y_thresh_falling_period
-What:		/sys/.../iio:deviceX/events/accel_y_roc_rising_period
-What:		/sys/.../iio:deviceX/events/accel_y_roc_falling_period
-What:		/sys/.../iio:deviceX/events/accel_z_thresh_rising_period
-What:		/sys/.../iio:deviceX/events/accel_z_thresh_falling_period
-What:		/sys/.../iio:deviceX/events/accel_z_roc_rising_period
-What:		/sys/.../iio:deviceX/events/accel_z_roc_falling_period
-What:		/sys/.../iio:deviceX/events/gyro_x_thresh_rising_period
-What:		/sys/.../iio:deviceX/events/gyro_x_thresh_falling_period
-What:		/sys/.../iio:deviceX/events/gyro_x_roc_rising_period
-What:		/sys/.../iio:deviceX/events/gyro_x_roc_falling_period
-What:		/sys/.../iio:deviceX/events/gyro_y_thresh_rising_period
-What:		/sys/.../iio:deviceX/events/gyro_y_thresh_falling_period
-What:		/sys/.../iio:deviceX/events/gyro_y_roc_rising_period
-What:		/sys/.../iio:deviceX/events/gyro_y_roc_falling_period
-What:		/sys/.../iio:deviceX/events/gyro_z_thresh_rising_period
-What:		/sys/.../iio:deviceX/events/gyro_z_thresh_falling_period
-What:		/sys/.../iio:deviceX/events/gyro_z_roc_rising_period
-What:		/sys/.../iio:deviceX/events/gyro_z_roc_falling_period
-What:		/sys/.../iio:deviceX/events/magn_x_thresh_rising_period
-What:		/sys/.../iio:deviceX/events/magn_x_thresh_falling_period
-What:		/sys/.../iio:deviceX/events/magn_x_roc_rising_period
-What:		/sys/.../iio:deviceX/events/magn_x_roc_falling_period
-What:		/sys/.../iio:deviceX/events/magn_y_thresh_rising_period
-What:		/sys/.../iio:deviceX/events/magn_y_thresh_falling_period
-What:		/sys/.../iio:deviceX/events/magn_y_roc_rising_period
-What:		/sys/.../iio:deviceX/events/magn_y_roc_falling_period
-What:		/sys/.../iio:deviceX/events/magn_z_thresh_rising_period
-What:		/sys/.../iio:deviceX/events/magn_z_thresh_falling_period
-What:		/sys/.../iio:deviceX/events/magn_z_roc_rising_period
-What:		/sys/.../iio:deviceX/events/magn_z_roc_falling_period
-What:		/sys/.../iio:deviceX/events/inZ_supply_thresh_rising_period
-What:		/sys/.../iio:deviceX/events/inZ_supply_thresh_falling_period
-What:		/sys/.../iio:deviceX/events/inz_supply_roc_rising_period
-What:		/sys/.../iio:deviceX/events/inZ_supply_roc_falling_period
-What:		/sys/.../iio:deviceX/events/inZ_thresh_rising_period
-What:		/sys/.../iio:deviceX/events/inZ_thresh_falling_period
-What:		/sys/.../iio:deviceX/events/inZ_roc_rising_period
-What:		/sys/.../iio:deviceX/events/inZ_roc_falling_period
-What:		/sys/.../iio:deviceX/events/temp_thresh_rising_period
-What:		/sys/.../iio:deviceX/events/temp_thresh_falling_period
-What:		/sys/.../iio:deviceX/events/temp_roc_rising_period
-What:		/sys/.../iio:deviceX/events/temp_roc_falling_period
-What:		/sys/.../iio:deviceX/events/accel_x&y&z_mag_falling_period
+What:		/sys/.../events/in_accel_x_thresh_rising_period
+What:		/sys/.../events/in_accel_x_thresh_falling_period
+hat:		/sys/.../events/in_accel_x_roc_rising_period
+What:		/sys/.../events/in_accel_x_roc_falling_period
+What:		/sys/.../events/in_accel_y_thresh_rising_period
+What:		/sys/.../events/in_accel_y_thresh_falling_period
+What:		/sys/.../events/in_accel_y_roc_rising_period
+What:		/sys/.../events/in_accel_y_roc_falling_period
+What:		/sys/.../events/in_accel_z_thresh_rising_period
+What:		/sys/.../events/in_accel_z_thresh_falling_period
+What:		/sys/.../events/in_accel_z_roc_rising_period
+What:		/sys/.../events/in_accel_z_roc_falling_period
+What:		/sys/.../events/in_gyro_x_thresh_rising_period
+What:		/sys/.../events/in_gyro_x_thresh_falling_period
+What:		/sys/.../events/in_gyro_x_roc_rising_period
+What:		/sys/.../events/in_gyro_x_roc_falling_period
+What:		/sys/.../events/in_gyro_y_thresh_rising_period
+What:		/sys/.../events/in_gyro_y_thresh_falling_period
+What:		/sys/.../events/in_gyro_y_roc_rising_period
+What:		/sys/.../events/in_gyro_y_roc_falling_period
+What:		/sys/.../events/in_gyro_z_thresh_rising_period
+What:		/sys/.../events/in_gyro_z_thresh_falling_period
+What:		/sys/.../events/in_gyro_z_roc_rising_period
+What:		/sys/.../events/in_gyro_z_roc_falling_period
+What:		/sys/.../events/in_magn_x_thresh_rising_period
+What:		/sys/.../events/in_magn_x_thresh_falling_period
+What:		/sys/.../events/in_magn_x_roc_rising_period
+What:		/sys/.../events/in_magn_x_roc_falling_period
+What:		/sys/.../events/in_magn_y_thresh_rising_period
+What:		/sys/.../events/in_magn_y_thresh_falling_period
+What:		/sys/.../events/in_magn_y_roc_rising_period
+What:		/sys/.../events/in_magn_y_roc_falling_period
+What:		/sys/.../events/in_magn_z_thresh_rising_period
+What:		/sys/.../events/in_magn_z_thresh_falling_period
+What:		/sys/.../events/in_magn_z_roc_rising_period
+What:		/sys/.../events/in_magn_z_roc_falling_period
+What:		/sys/.../events/in_voltageZ_supply_thresh_rising_period
+What:		/sys/.../events/in_voltageZ_supply_thresh_falling_period
+What:		/sys/.../events/in_voltagez_supply_roc_rising_period
+What:		/sys/.../events/in_voltageZ_supply_roc_falling_period
+What:		/sys/.../events/in_voltageZ_thresh_rising_period
+What:		/sys/.../events/in_voltageZ_thresh_falling_period
+What:		/sys/.../events/in_voltageZ_roc_rising_period
+What:		/sys/.../events/in_voltageZ_roc_falling_period
+What:		/sys/.../events/in_temp_thresh_rising_period
+What:		/sys/.../events/in_temp_thresh_falling_period
+What:		/sys/.../events/in_temp_roc_rising_period
+What:		/sys/.../events/in_temp_roc_falling_period
+What:		/sys/.../events/in_accel_x&y&z_mag_falling_period
 KernelVersion:	2.6.37
 Contact:	linux-iio@vger.kernel.org
 Description:
@@ -536,31 +536,31 @@ Description:
 		met before an event is generated. If direction is not
 		specified then this period applies to both directions.
 
-What:		/sys/.../iio:deviceX/events/accel_mag_en
-What:		/sys/.../iio:deviceX/events/accel_mag_rising_en
-What:		/sys/.../iio:deviceX/events/accel_mag_falling_en
-What:		/sys/.../iio:deviceX/events/accel_x_mag_en
-What:		/sys/.../iio:deviceX/events/accel_x_mag_rising_en
-What:		/sys/.../iio:deviceX/events/accel_x_mag_falling_en
-What:		/sys/.../iio:deviceX/events/accel_y_mag_en
-What:		/sys/.../iio:deviceX/events/accel_y_mag_rising_en
-What:		/sys/.../iio:deviceX/events/accel_y_mag_falling_en
-What:		/sys/.../iio:deviceX/events/accel_z_mag_en
-What:		/sys/.../iio:deviceX/events/accel_z_mag_rising_en
-What:		/sys/.../iio:deviceX/events/accel_z_mag_falling_en
-What:		/sys/.../iio:deviceX/events/accel_x&y&z_mag_rising_en
-What:		/sys/.../iio:deviceX/events/accel_x&y&z_mag_falling_en
+What:		/sys/.../iio:deviceX/events/in_accel_mag_en
+What:		/sys/.../iio:deviceX/events/in_accel_mag_rising_en
+What:		/sys/.../iio:deviceX/events/in_accel_mag_falling_en
+What:		/sys/.../iio:deviceX/events/in_accel_x_mag_en
+What:		/sys/.../iio:deviceX/events/in_accel_x_mag_rising_en
+What:		/sys/.../iio:deviceX/events/in_accel_x_mag_falling_en
+What:		/sys/.../iio:deviceX/events/in_accel_y_mag_en
+What:		/sys/.../iio:deviceX/events/in_accel_y_mag_rising_en
+What:		/sys/.../iio:deviceX/events/in_accel_y_mag_falling_en
+What:		/sys/.../iio:deviceX/events/in_accel_z_mag_en
+What:		/sys/.../iio:deviceX/events/in_accel_z_mag_rising_en
+What:		/sys/.../iio:deviceX/events/in_accel_z_mag_falling_en
+What:		/sys/.../iio:deviceX/events/in_accel_x&y&z_mag_rising_en
+What:		/sys/.../iio:deviceX/events/in_accel_x&y&z_mag_falling_en
 KernelVersion:	2.6.37
 Contact:	linux-iio@vger.kernel.org
 Description:
-		Similar to accel_x_thresh[_rising|_falling]_en, but here the
+		Similar to in_accel_x_thresh[_rising|_falling]_en, but here the
 		magnitude of the channel is compared to the threshold, not its
 		signed value.
 
-What:		/sys/.../accel_raw_mag_value
-What:		/sys/.../accel_x_raw_mag_rising_value
-What:		/sys/.../accel_y_raw_mag_rising_value
-What:		/sys/.../accel_z_raw_mag_rising_value
+What:		/sys/.../events/in_accel_raw_mag_value
+What:		/sys/.../events/in_accel_x_raw_mag_rising_value
+What:		/sys/.../events/in_accel_y_raw_mag_rising_value
+What:		/sys/.../events/in_accel_z_raw_mag_rising_value
 KernelVersion:	2.6.37
 Contact:	linux-iio@vger.kernel.org
 Description:
@@ -602,34 +602,34 @@ Description:
 		Directory containing interfaces for elements that will be
 		captured for a single triggered sample set in the buffer.
 
-What:		/sys/.../iio:deviceX/buffer/scan_elements/accel_x_en
-What:		/sys/.../iio:deviceX/buffer/scan_elements/accel_y_en
-What:		/sys/.../iio:deviceX/buffer/scan_elements/accel_z_en
-What:		/sys/.../iio:deviceX/buffer/scan_elements/gyro_x_en
-What:		/sys/.../iio:deviceX/buffer/scan_elements/gyro_y_en
-What:		/sys/.../iio:deviceX/buffer/scan_elements/gyro_z_en
-What:		/sys/.../iio:deviceX/buffer/scan_elements/magn_x_en
-What:		/sys/.../iio:deviceX/buffer/scan_elements/magn_y_en
-What:		/sys/.../iio:deviceX/buffer/scan_elements/magn_z_en
-What:		/sys/.../iio:deviceX/buffer/scan_elements/timestamp_en
-What:		/sys/.../iio:deviceX/buffer/scan_elements/inY_supply_en
-What:		/sys/.../iio:deviceX/buffer/scan_elements/inY_en
-What:		/sys/.../iio:deviceX/buffer/scan_elements/inY-inZ_en
-What:		/sys/.../iio:deviceX/buffer/scan_elements/incli_x_en
-What:		/sys/.../iio:deviceX/buffer/scan_elements/incli_y_en
+What:		/sys/.../buffer/scan_elements/in_accel_x_en
+What:		/sys/.../buffer/scan_elements/in_accel_y_en
+What:		/sys/.../buffer/scan_elements/in_accel_z_en
+What:		/sys/.../buffer/scan_elements/in_gyro_x_en
+What:		/sys/.../buffer/scan_elements/in_gyro_y_en
+What:		/sys/.../buffer/scan_elements/in_gyro_z_en
+What:		/sys/.../buffer/scan_elements/in_magn_x_en
+What:		/sys/.../buffer/scan_elements/in_magn_y_en
+What:		/sys/.../buffer/scan_elements/in_magn_z_en
+What:		/sys/.../buffer/scan_elements/in_timestamp_en
+What:		/sys/.../buffer/scan_elements/in_voltageY_supply_en
+What:		/sys/.../buffer/scan_elements/in_voltageY_en
+What:		/sys/.../buffer/scan_elements/in_voltageY-voltageZ_en
+What:		/sys/.../buffer/scan_elements/in_incli_x_en
+What:		/sys/.../buffer/scan_elements/in_incli_y_en
 KernelVersion:	2.6.37
 Contact:	linux-iio@vger.kernel.org
 Description:
 		Scan element control for triggered data capture.
 
-What:		/sys/.../iio:deviceX/buffer/scan_elements/accel_type
-What:		/sys/.../iio:deviceX/buffer/scan_elements/gyro_type
-What:		/sys/.../iio:deviceX/buffer/scan_elements/magn_type
-What:		/sys/.../iio:deviceX/buffer/scan_elements/incli_type
-What:		/sys/.../iio:deviceX/buffer/scan_elements/inY_type
-What:		/sys/.../iio:deviceX/buffer/scan_elements/in-in_type
-What:		/sys/.../iio:deviceX/buffer/scan_elements/inY_supply_type
-What:		/sys/.../iio:deviceX/buffer/scan_elements/timestamp_type
+What:		/sys/.../buffer/scan_elements/in_accel_type
+What:		/sys/.../buffer/scan_elements/in_gyro_type
+What:		/sys/.../buffer/scan_elements/in_magn_type
+What:		/sys/.../buffer/scan_elements/in_incli_type
+What:		/sys/.../buffer/scan_elements/in_voltageY_type
+What:		/sys/.../buffer/scan_elements/in_voltage-in_type
+What:		/sys/.../buffer/scan_elements/in_voltageY_supply_type
+What:		/sys/.../buffer/scan_elements/in_timestamp_type
 KernelVersion:	2.6.37
 Contact:	linux-iio@vger.kernel.org
 Description:
@@ -652,27 +652,27 @@ Description:
 		For other storage combinations this attribute will be extended
 		appropriately.
 
-What:		/sys/.../iio:deviceX/buffer/scan_elements/accel_type_available
+What:		/sys/.../buffer/scan_elements/in_accel_type_available
 KernelVersion:	2.6.37
 Contact:	linux-iio@vger.kernel.org
 Description:
 		If the type parameter can take one of a small set of values,
 		this attribute lists them.
 
-What:		/sys/.../iio:deviceX/buffer/scan_elements/inY_index
-What:		/sys/.../iio:deviceX/buffer/scan_elements/inY_supply_index
-What:		/sys/.../iio:deviceX/buffer/scan_elements/accel_x_index
-What:		/sys/.../iio:deviceX/buffer/scan_elements/accel_y_index
-What:		/sys/.../iio:deviceX/buffer/scan_elements/accel_z_index
-What:		/sys/.../iio:deviceX/buffer/scan_elements/gyro_x_index
-What:		/sys/.../iio:deviceX/buffer/scan_elements/gyro_y_index
-What:		/sys/.../iio:deviceX/buffer/scan_elements/gyro_z_index
-What:		/sys/.../iio:deviceX/buffer/scan_elements/magn_x_index
-What:		/sys/.../iio:deviceX/buffer/scan_elements/magn_y_index
-What:		/sys/.../iio:deviceX/buffer/scan_elements/magn_z_index
-What:		/sys/.../iio:deviceX/buffer/scan_elements/incli_x_index
-What:		/sys/.../iio:deviceX/buffer/scan_elements/incli_y_index
-What:		/sys/.../iio:deviceX/buffer/scan_elements/in_timestamp_index
+What:		/sys/.../buffer/scan_elements/in_voltageY_index
+What:		/sys/.../buffer/scan_elements/in_voltageY_supply_index
+What:		/sys/.../buffer/scan_elements/in_accel_x_index
+What:		/sys/.../buffer/scan_elements/in_accel_y_index
+What:		/sys/.../buffer/scan_elements/in_accel_z_index
+What:		/sys/.../buffer/scan_elements/in_gyro_x_index
+What:		/sys/.../buffer/scan_elements/in_gyro_y_index
+What:		/sys/.../buffer/scan_elements/in_gyro_z_index
+What:		/sys/.../buffer/scan_elements/in_magn_x_index
+What:		/sys/.../buffer/scan_elements/in_magn_y_index
+What:		/sys/.../buffer/scan_elements/in_magn_z_index
+What:		/sys/.../buffer/scan_elements/in_incli_x_index
+What:		/sys/.../buffer/scan_elements/in_incli_y_index
+What:		/sys/.../buffer/scan_elements/in_voltage_timestamp_index
 KernelVersion:	2.6.37
 Contact:	linux-iio@vger.kernel.org
 Description:
@@ -684,9 +684,9 @@ Description:
 		and the relevant _type attributes to establish the data storage
 		format.
 
-What:		/sys/.../iio:deviceX/gyro_z_quadrature_correction_raw
+What:		/sys/.../iio:deviceX/in_gyro_z_quadrature_correction_raw
 KernelVersion:	2.6.38
-Contact:	linux-iio@xxxxxxxxxxxxxxx
+Contact:	linux-iio@vger.kernel.org
 Description:
 		This attribute is used to read the amount of quadrature error
 		present in the device at a given time.
-- 
1.7.3.4
