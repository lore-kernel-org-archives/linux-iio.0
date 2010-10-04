Return-Path: <jic23@cam.ac.uk>
From: Jonathan Cameron <jic23@cam.ac.uk>
To: linux-iio@vger.kernel.org
Cc: manuel.stahl@iis.fraunhofer.de,
	Jonathan Cameron <jic23@cam.ac.uk>
Subject: [PATCH 14/16] staging:iio:events update documentation to match new abi.
Date: Mon,  4 Oct 2010 16:58:03 +0100
Message-Id: <1286207885-26689-15-git-send-email-jic23@cam.ac.uk>
In-Reply-To: <1286207885-26689-1-git-send-email-jic23@cam.ac.uk>
References: <1286207885-26689-1-git-send-email-jic23@cam.ac.uk>
List-ID: <linux-iio@vger.kernel.org>

Signed-off-by: Jonathan Cameron <jic23@cam.ac.uk>
---
 drivers/staging/iio/Documentation/sysfs-bus-iio |  192 ++++++++++++++++-------
 1 files changed, 136 insertions(+), 56 deletions(-)

diff --git a/drivers/staging/iio/Documentation/sysfs-bus-iio b/drivers/staging/iio/Documentation/sysfs-bus-iio
index 62becc0..fdb017a 100644
--- a/drivers/staging/iio/Documentation/sysfs-bus-iio
+++ b/drivers/staging/iio/Documentation/sysfs-bus-iio
@@ -1,4 +1,3 @@
-
 What:		/sys/bus/iio/devices/device[n]
 KernelVersion:	2.6.35
 Contact:	linux-iio@vger.kernel.org
@@ -22,8 +21,8 @@ What:		/sys/bus/iio/devices/device[n]:buffer
 KernelVersion:	2.6.35
 Contact:	linux-iio@vger.kernel.org
 Description:
-	        Link to /sys/class/iio/device[n]/device[n]:buffer. n indicates the
-		device with which this buffer buffer is associated.
+		Link to /sys/class/iio/device[n]/device[n]:buffer. n indicates
+		the device with which this buffer buffer is associated.
 
 What:		/sys/.../device[n]/name
 KernelVersion:	2.6.35
@@ -52,7 +51,7 @@ Description:
 		When the internal sampling clock can only take a small
 		discrete set of values, this file lists those availale.
 
-What:		/sys/.../device[n]/in[_name][m]_raw
+What:		/sys/.../device[n]/in[m][_name]_raw
 KernelVersion:	2.6.35
 Contact:	linux-iio@vger.kernel.org
 Description:
@@ -60,8 +59,11 @@ Description:
 		channel m. name is used in special cases where this does
 		not correspond to externally available input (e.g. supply
 		voltage monitoring in which case the file is in_supply_raw).
+		If the device supports events on this channel then m must be
+		specified (even on named channels) so as to allow the source
+		of event codes to be identified.
 
-What:		/sys/.../device[n]/in[_name][m]_offset
+What:		/sys/.../device[n]/in[m][_name]_offset
 KernelVersion:	2.6.35
 Contact:	linux-iio@vger.kernel.org
 Description:
@@ -75,7 +77,7 @@ Description:
 		between different instances of the part, typically adjusted by
 		using some hardware supported calibration procedure.
 
-What:		/sys/.../device[n]/in[_name][m]_offset_available
+What:		/sys/.../device[n]/in[m][_name]_offset_available
 KernelVersion:	2.6.35
 Contact:	linux-iio@vger.kernel.org
 Description:
@@ -84,45 +86,46 @@ Description:
 		options the same) for individual offsets then m should not be
 		present.
 
-What:		/sys/.../device[n]/in[_name][m]_offset_[min|max]
+What:		/sys/.../device[n]/in[m][_name]_offset_[min|max]
 KernelVersion:	2.6.35
 Contact:	linux-iio@vger.kernel.org
 Description:
-		If a more or less continuous range of voltage offsets are supported
-		then these specify the minimum and maximum.  If shared by all
-		in channels then m is not present.
+		If a more or less continuous range of voltage offsets are
+		supported then these specify the minimum and maximum.  If shared
+		by all in channels then m is not present.
 
-What:		/sys/.../device[n]/in[_name][m]_calibbias
+What:		/sys/.../device[n]/in[m][_name]_calibbias
 KernelVersion:	2.6.35
 Contact:	linux-iio@vger.kernel.org
 Description:
 		Hardware applied calibration offset. (assumed to fix production
 		inaccuracies)
 
-What		/sys/.../device[n]/in[_name][m]_calibscale
+What		/sys/.../device[n]/in[m][_name]_calibscale
 KernelVersion:	2.6.35
 Contact:	linux-iio@vger.kernel.org
 Description:
-		Hardware applied calibration scale factor. (assumed to fix production
-		inaccuracies)
+		Hardware applied calibration scale factor. (assumed to fix
+		production inaccuracies)
 
-What:		/sys/.../device[n]/in[_name][m]_scale
+What:		/sys/.../device[n]/in[m][_name]_scale
 KernelVersion:	2.6.35
 Contact:	linux-iio@vger.kernel.org
 Description:
 		If known for a device, scale to be applied to volt[m]_raw post
 		addition of in[_name][m]_offset in order to obtain the measured
-		voltage	in millivolts.  If shared across all in channels then			m is not present.
+		voltage in millivolts.  If shared across all in channels then
+		m is not present.
 
 What:		/sys/.../device[n]/in[m]-in[o]_raw
 KernelVersion:	2.6.35
 Contact:	linux-iio@vger.kernel.org
 Description:
 		Raw (unscaled) differential voltage measurement equivalent to
-		channel m - channel o where these channel numbers apply to the physically
-		equivalent inputs when non differential readings are separately available.
-		In differential only parts, then all that is required is a consistent
-		labelling.
+		channel m - channel o where these channel numbers apply to the
+		physically equivalent inputs when non differential readings are
+		separately available. In differential only parts, then all that
+		is required is a consistent labelling.
 
 What:		/sys/.../device[n]/accel[_x|_y|_z][m]_raw
 KernelVersion:	2.6.35
@@ -131,17 +134,19 @@ Description:
 		Acceleration in direction x, y or z (may be arbitrarily assigned
 		but should match other such assignments on device)
 		channel m (not present if only one accelerometer channel at
-		this orientation). Has all of the equivalent parameters as per in[m].
-		Units after application of scale and offset are m/s^2.
+		this orientation). Has all of the equivalent parameters as per
+		in[m]. Units after application of scale and offset are m/s^2.
 
 What:		/sys/.../device[n]/gyro[_x|_y|_z][m]_raw
 KernelVersion:	2.6.35
 Contact:	linux-iio@vger.kernel.org
 Description:
-		Angular velocity about axis x, y or z (may be arbitrarily assigned)
-		channel m (not present if only one gyroscope at this orientation).
+		Angular velocity about axis x, y or z (may be arbitrarily
+		assigned) channel m (not present if only one gyroscope at
+		this orientation).
 		Data converted by application of offset then scale to
-		radians per second. Has all the equivalent parameters as per in[m].
+		radians per second. Has all the equivalent parameters as
+		per in[m].
 
 What:		/sys/.../device[n]/incli[_x|_y|_z][m]_raw
 KernelVersion:	2.6.35
@@ -156,10 +161,11 @@ What:		/sys/.../device[n]/magn[_x|_y|_z][m]_raw
 KernelVersion:	2.6.35
 Contact:	linux-iio@vger.kernel.org
 Description:
-		Magnetic field along axis x, y or z (may be arbitrarily assigned)
-		channel m (not present if only one magnetometer at this orientation).
-		Data converted by application of offset then scale to Gauss.
-		Has all the equivalent modifiers as per in[m].
+		Magnetic field along axis x, y or z (may be arbitrarily
+		assigned) channel m (not present if only one magnetometer
+		at this orientation).  Data converted by application of
+		offset then scale to Gauss. Has all the equivalent modifiers
+		as per in[m].
 
 What:		/sys/.../device[n]/device[n]:event[m]
 KernelVersion:	2.6.35
@@ -177,40 +183,114 @@ Description:
 
 Taking accel_x0 as an example
 
-What:		/sys/.../device[n]:event[m]/accel_x0_thresh[_high|_low]_en
-KernelVersion:	2.6.35
+What:		/sys/.../device[n]:event[m]/accel_x0_thresh[_rising|_falling]_en
+KernelVersion:	2.6.37
+Contact:	linux-iio@vger.kernel.org
+Description:
+		Event generated when accel_x0 passes a threshold in the specfied
+		(_rising|_falling) direction. If the direction is not specified,
+		then either the device will report an event which ever direction
+		a single threshold value is called in (e.g.
+		accel_x0_<raw|input>_thresh_value) or
+		accel_x0_<raw|input>_thresh_rising_value and
+		accel_x0_<raw|input>_thresh_falling_value may take different
+		values, but the device can only enable both thresholds or
+		neither.
+		Note the driver will assume the last p events requested are
+		to be enabled where p is however many it supports (which may
+		vary depending on the exact set requested. So if you want to be
+		sure you have set what you think you have, check the contents of
+		these attributes after everything is configured. Drivers may
+		have to buffer any parameters so that they are consistent when
+		a given event type is enabled a future point (and not those for
+		whatever event was previously enabled).
+
+What:		/sys/.../accel_x0_<raw|input>_thresh[_rising|_falling]_value
+KernelVersion:	2.6.37
 Contact:	linux-iio@vger.kernel.org
 Description:
-		Event generated when accel_x0 passes a threshold in correction direction
-		(or stays beyond one). If direction isn't specified, either triggers it.
-		Note driver will assume last p events requested are enabled where p is
-		however many it supports.  So if you want to be sure you have
-		set what you think you have, check the contents of these. Drivers
-		may have to buffer any parameters so that they are consistent when a
-		given event type is enabled a future point (and not those for whatever
-		alarm was previously enabled).
+		Specifies the value of threshold that the device is comparing
+		against for the events enabled by
+		accel_x0_<raw|input>_thresh[_rising|falling]_en.
+		If seperate exist for the two directions, but direction is
+		not specified for this attribute, then a single threshold value
+		applies to both directions.
+		The raw or input element of the name indicates whether the
+		value is in raw device units or in processed units (as _raw
+		and _input do on sysfs direct channel read attributes).
 
-What:		/sys/.../device[n]:event[m]/accel_x0_roc[_high|_low]_en
-KernelVersion:	2.6.35
+What:		/sys/.../accel_x0_thresh[_rising|_falling]_meanperiod
+KernelVersion:	2.6.37
+Contact:	linux-iio@vger.kernel.org
+Description:
+		Period of time (in seconds) over which the raw channel value
+		is averaged before being compared with the threshold set in
+		accel_x0_thresh[_rising|_falling]_meanperiod.  If direction is
+		not specified then this mean period applies to both directions.
+
+What:		/sys/.../accel_x0_thresh[_rising|_falling]_period
+KernelVersion:	2.6.37
 Contact:	linux-iio@vger.kernel.org
 Description:
-		Same as above but based on the first differential of the value.
+		Period of time (in seconds) for which the threshold must be
+		passed before an event is generated. If direction is not
+		specified then this period applies to both directions.
 
+What:		/sys/.../device[n]:event[m]/accel_x0_mag[_rising|_falling]_en
+KernelVersion:	2.6.37
+Contact:	linux-iio@vger.kernel.org
+Description:
+		Similar to accel_x0_thresh[_rising|_falling]_en, but here the
+		magnitude of the channel is compared to the threshold, not its
+		signed value.
 
-What:		/sys/.../device[n]:event[m]/accel_x0[_thresh|_roc][_high|_low]_period
-KernelVersion:	2.6.35
+What:		/sys/.../accel_x0_<raw|input>_mag[_rising|_falling]_value
+KernelVersion:	2.6.37
 Contact:	linux-iio@vger.kernel.org
 Description:
-		A period of time (microsecs) for which the condition must be broken
-		before an interrupt is triggered. Applies to all alarms if type is not
-		specified.
+		The value to which the magnitude of the channel is compared.
 
-What:		/sys/.../device[n]:event[m]/accel_x0[_thresh|_roc][_high|_low]_value
-KernelVersion:	2.6.35
+What:		/sys/.../accel_x0_mag[_rising|_falling]_meanperiod
+KernelVersion:	2.6.37
+Contact:	linux-iio@vger.kernel.org
+Description:
+		Period of time (in seconds) over which the value of the channel
+		is averaged before being compared to the threshold
+
+What:		/sys/.../accel_x0_mag[_rising|_falling]_period
+KernelVersion:	2.6.37
+Contact:	linux-iio@vger.kernel.org
+Description:
+		Period of time (in seconds) for which the condition must be true
+		before an event occurs.
+
+What:		/sys/.../device[n]:event[m]/accel_x0_roc[_rising|_falling]_en
+KernelVersion:	2.6.37
+Contact:	linux-iio@vger.kernel.org
+Description:
+		Similar to accel_x0_thresh[_rising|_falling]_en, but here the
+		first differential is compared with the threshold.
+
+What:		/sys/.../accel_x0_<raw|input>_roc[_rising|_falling]_value
+KernelVersion:	2.6.37
+Contact:	linux-iio@vger.kernel.org
+Description:
+		The value to which the first differential of the channel is
+		compared.
+
+What:		/sys/.../accel_x0_roc[_rising|_falling]_meanperiod
+KernelVersion:	2.6.37
+Contact:	linux-iio@vger.kernel.org
+Description:
+		Period of time (in seconds) over which the value of the channel
+		is averaged before being compared to the threshold
+
+What:		/sys/.../accel_x0_roc[_rising|_falling]_period
+KernelVersion:	2.6.37
 Contact:	linux-iio@vger.kernel.org
 Description:
-		The actual value of the threshold in raw device units obtained by
-		 reverse application of scale and offfset to the acceleration in m/s^2.
+		Period of time (in seconds) for which the condition must be true
+		before an event occurs.
 
 What:		/sys/.../device[n]/device[n]:buffer:event/dev
 KernelVersion:	2.6.35
@@ -255,16 +335,16 @@ What:		/sys/.../device[n]:buffer/alignment
 KernelVersion:	2.6.35
 Contact:	linux-iio@vger.kernel.org
 Description:
-		Minimum data alignment.  Scan elements larger than this are aligned
-		to the nearest power of 2 times this.  (may not be true in weird
-		hardware buffers that pack data well)
+		Minimum data alignment.  Scan elements larger than this are
+		aligned to the nearest power of 2 times this.  (may not be
+		true in weird hardware buffers that pack data well)
 
 What:		/sys/.../device[n]/buffer/scan_elements
 KernelVersion:	2.6.37
 Contact:	linux-iio@vger.kernel.org
 Description:
-		Directory containing interfaces for elements that will be captured
-		for a single triggered sample set in the buffer.
+		Directory containing interfaces for elements that will be
+		captured for a single triggered sample set in the buffer.
 
 What:		/sys/.../device[n]/buffer/scan_elements/accel_x0_en
 KernelVersion:	2.6.37
-- 
1.7.2.2
