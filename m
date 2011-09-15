Return-Path: <jic23@cam.ac.uk>
From: Jonathan Cameron <jic23@cam.ac.uk>
To: linux-iio@vger.kernel.org
Cc: Jonathan Cameron <jic23@cam.ac.uk>
Subject: [PATCH 1/8] staging:iio:documentation general refresh of abi docs.
Date: Thu, 15 Sep 2011 14:45:30 +0100
Message-Id: <1316094337-12542-2-git-send-email-jic23@cam.ac.uk>
In-Reply-To: <1316094337-12542-1-git-send-email-jic23@cam.ac.uk>
References: <1316094337-12542-1-git-send-email-jic23@cam.ac.uk>
List-ID: <linux-iio@vger.kernel.org>

Numerous small fixes and additions of missing elements.

Signed-off-by: Jonathan Cameron <jic23@cam.ac.uk>
---
 drivers/staging/iio/Documentation/sysfs-bus-iio |  183 +++++++++++------------
 1 files changed, 91 insertions(+), 92 deletions(-)

diff --git a/drivers/staging/iio/Documentation/sysfs-bus-iio b/drivers/staging/iio/Documentation/sysfs-bus-iio
index 1d52c96..f7bc59a 100644
--- a/drivers/staging/iio/Documentation/sysfs-bus-iio
+++ b/drivers/staging/iio/Documentation/sysfs-bus-iio
@@ -6,12 +6,6 @@ Description:
 		Corresponds to a grouping of sensor channels. X is the IIO
 		index of the device.
 
-What:		/sys/bus/iio/devices/iio:deviceX/power_state
-KernelVersion:	2.6.37
-Contact:	linux-iio@vger.kernel.org
-Description:
-		This property gets/sets the device power state.
-
 What:		/sys/bus/iio/devices/triggerX
 KernelVersion:	2.6.35
 Contact:	linux-iio@vger.kernel.org
@@ -39,6 +33,8 @@ Description:
 		Typically a part number.
 
 What:		/sys/bus/iio/devices/iio:deviceX/sampling_frequency
+What:		/sys/bus/iio/devices/iio:deviceX/buffer/sampling_frequency
+What:		/sys/bus/iio/devices/triggerX/sampling_frequency
 KernelVersion:	2.6.35
 Contact:	linux-iio@vger.kernel.org
 Description:
@@ -49,27 +45,17 @@ Description:
 		effects datardy triggers, hardware buffers and the sysfs
 		direct access interfaces, it may be found in any of the
 		relevant directories.  If it effects all of the above
-		then it is to be found in the base device directory as here.
+		then it is to be found in the base device directory.
 
 What:		/sys/bus/iio/devices/iio:deviceX/sampling_frequency_available
+What:		/sys/.../iio:deviceX/buffer/sampling_frequency_available
+What:		/sys/bus/iio/devices/triggerX/sampling_frequency_available
 KernelVersion:	2.6.35
 Contact:	linux-iio@vger.kernel.org
 Description:
 		When the internal sampling clock can only take a small
 		discrete set of values, this file lists those available.
 
-What:		/sys/bus/iio/devices/iio:deviceX/range
-KernelVersion:	2.6.38
-Contact:	linux-iio@vger.kernel.org
-Description:
-		Hardware dependent ADC Full Scale Range in mVolt.
-
-What:		/sys/bus/iio/devices/iio:deviceX/range_available
-KernelVersion:	2.6.38
-Contact:	linux-iio@vger.kernel.org
-Description:
-		Hardware dependent supported vales for ADC Full Scale Range.
-
 What:		/sys/bus/iio/devices/iio:deviceX/oversampling_ratio
 KernelVersion:	2.6.38
 Contact:	linux-iio@vger.kernel.org
@@ -92,7 +78,8 @@ Description:
 		channel Y. In special cases where the channel does not
 		correspond to externally available input one of the named
 		versions may be used. The number must always be specified and
-		unique to allow association with event codes.
+		unique to allow association with event codes. Units after
+		application of scale and offset are microvolts.
 
 What:		/sys/bus/iio/devices/iio:deviceX/in_voltageY-voltageZ_raw
 KernelVersion:	2.6.35
@@ -102,9 +89,11 @@ Description:
 		channel Y - channel Z where these channel numbers apply to the
 		physically equivalent inputs when non differential readings are
 		separately available. In differential only parts, then all that
-		is required is a consistent labeling.
+		is required is a consistent labeling.  Units after application
+		of scale and offset are microvolts.
 
 What:		/sys/bus/iio/devices/iio:deviceX/in_temp_raw
+What:		/sys/bus/iio/devices/iio:deviceX/in_tempX_raw
 What:		/sys/bus/iio/devices/iio:deviceX/in_temp_x_raw
 What:		/sys/bus/iio/devices/iio:deviceX/in_temp_y_raw
 What:		/sys/bus/iio/devices/iio:deviceX/in_temp_z_raw
@@ -114,7 +103,8 @@ Description:
 		Raw (unscaled no bias removal etc) temperature measurement.
 		It an axis is specified it generally means that the temperature
 		sensor is associated with one part of a compound device (e.g.
-		a gyroscope axis).
+		a gyroscope axis). Units after application of scale and offset
+		are milli degrees Celsuis.
 
 What:		/sys/bus/iio/devices/iio:deviceX/in_tempX_input
 KernelVersion:	2.6.38
@@ -129,10 +119,9 @@ KernelVersion:	2.6.35
 Contact:	linux-iio@vger.kernel.org
 Description:
 		Acceleration in direction x, y or z (may be arbitrarily assigned
-		but should match other such assignments on device)
-		channel m (not present if only one accelerometer channel at
-		this orientation). Has all of the equivalent parameters as per
-		voltageY. Units after application of scale and offset are m/s^2.
+		but should match other such assignments on device).
+		Has all of the equivalent parameters as per voltageY. Units
+		after application of scale and offset are m/s^2.
 
 What:		/sys/bus/iio/devices/iio:deviceX/in_gyro_x_raw
 What:		/sys/bus/iio/devices/iio:deviceX/in_gyro_y_raw
@@ -143,7 +132,8 @@ Description:
 		Angular velocity about axis x, y or z (may be arbitrarily
 		assigned) Data converted by application of offset then scale to
 		radians per second. Has all the equivalent parameters as
-		per voltageY.
+		per voltageY. Units after application of scale and offset are
+		radians per second.
 
 What:		/sys/bus/iio/devices/iio:deviceX/in_incli_x_raw
 What:		/sys/bus/iio/devices/iio:deviceX/in_incli_y_raw
@@ -162,10 +152,8 @@ KernelVersion:	2.6.35
 Contact:	linux-iio@vger.kernel.org
 Description:
 		Magnetic field along axis x, y or z (may be arbitrarily
-		assigned) channel m (not present if only one magnetometer
-		at this orientation).  Data converted by application of
-		offset then scale to Gauss. Has all the equivalent modifiers
-		as per voltageY.
+		assigned).  Data converted by application of offset
+		then scale to Gauss.
 
 What:		/sys/bus/iio/devices/iio:deviceX/in_accel_x_peak_raw
 What:		/sys/bus/iio/devices/iio:deviceX/in_accel_y_peak_raw
@@ -173,10 +161,9 @@ What:		/sys/bus/iio/devices/iio:deviceX/in_accel_z_peak_raw
 KernelVersion:	2.6.36
 Contact:	linux-iio@vger.kernel.org
 Description:
-		Some devices provide a store of the highest value seen since
-		some reset condition.  These attributes allow access to this
-		and are otherwise the direct equivalent of the
-		<type>Y[_name]_raw attributes.
+		Highest value since some reset condition.  These
+		attributes allow access to this and are otherwise
+		the direct equivalent of the <type>Y[_name]_raw attributes.
 
 What:		/sys/bus/iio/devices/iio:deviceX/in_accel_xyz_squared_peak_raw
 KernelVersion:	2.6.36
@@ -186,6 +173,12 @@ Description:
 		the underlying value in the specified directions.
 
 What:		/sys/bus/iio/devices/iio:deviceX/in_accel_offset
+What:		/sys/bus/iio/devices/iio:deviceX/in_accel_x_offset
+What:		/sys/bus/iio/devices/iio:deviceX/in_accel_y_offset
+What:		/sys/bus/iio/devices/iio:deviceX/in_accel_z_offset
+What:		/sys/bus/iio/devices/iio:deviceX/in_voltageY_offset
+What:		/sys/bus/iio/devices/iio:deviceX/in_voltage_offset
+What:		/sys/bus/iio/devices/iio:deviceX/in_tempY_offset
 What:		/sys/bus/iio/devices/iio:deviceX/in_temp_offset
 KernelVersion:	2.6.35
 Contact:	linux-iio@vger.kernel.org
@@ -193,13 +186,16 @@ Description:
 		If known for a device, offset to be added to <type>[Y]_raw prior
 		to scaling by <type>[Y]_scale in order to obtain value in the
 		<type> units as specified in <type>[y]_raw documentation.
-		Not present if the offset is always 0 or unknown. If Y is not
-		present, then the offset applies to all in channels of <type>.
+		Not present if the offset is always 0 or unknown. If Y or
+		axis <x|y|z> is not present, then the offset applies to all
+		in channels of <type>.
 		May be writable if a variable offset can be applied on the
 		device. Note that this is different to calibbias which
 		is for devices (or drivers) that apply offsets to compensate
 		for variation between different instances of the part, typically
 		adjusted by using some hardware supported calibration procedure.
+		Calibbias is applied internally, offset is applied in userspace
+		to the _raw output.
 
 What:		/sys/bus/iio/devices/iio:deviceX/in_voltageY_scale
 What:		/sys/bus/iio/devices/iio:deviceX/in_voltageY_supply_scale
@@ -219,9 +215,9 @@ Description:
 		post addition of <type>[Y][_name]_offset in order to obtain the
 		measured value in <type> units as specified in
 		<type>[Y][_name]_raw documentation..  If shared across all in
-		channels then Y is not present and the value is called
-		<type>[Y][_name]_scale. The peak modifier means this value
-		is applied to <type>Y[_name]_peak_raw values.
+		channels then Y and <x|y|z> are not present and the value is
+		called <type>[Y][_name]_scale. The peak modifier means this
+		value is applied to <type>Y[_name]_peak_raw values.
 
 What:		/sys/bus/iio/devices/iio:deviceX/in_accel_x_calibbias
 What:		/sys/bus/iio/devices/iio:deviceX/in_accel_y_calibbias
@@ -233,8 +229,7 @@ KernelVersion:	2.6.35
 Contact:	linux-iio@vger.kernel.org
 Description:
 		Hardware applied calibration offset. (assumed to fix production
-		inaccuracies). If shared across all channels, <type>_calibbias
-		is used.
+		inaccuracies).
 
 What		/sys/bus/iio/devices/iio:deviceX/in_voltageY_calibscale
 What		/sys/bus/iio/devices/iio:deviceX/in_voltageY_supply_calibscale
@@ -253,13 +248,16 @@ Description:
 		<type>_calibscale is used.
 
 What:		/sys/bus/iio/devices/iio:deviceX/in_accel_scale_available
+What:		/sys/.../iio:deviceX/in_voltageX_scale_available
+What:		/sys/.../iio:deviceX/in_voltage-voltage_scale_available
+What:		/sys/.../iio:deviceX/out_voltageX_scale_available
 KernelVersion:	2.635
 Contact:	linux-iio@vger.kernel.org
 Description:
 		If a discrete set of scale values are available, they
 		are listed in this attribute.
 
-What:		/sys/bus/iio/devices/iio:deviceX/out_votlageY_raw
+What:		/sys/bus/iio/devices/iio:deviceX/out_voltageY_raw
 KernelVersion:	2.6.37
 Contact:	linux-iio@vger.kernel.org
 Description:
@@ -333,22 +331,22 @@ What:		/sys/.../iio:deviceX/events/in_magn_y_thresh_rising_en
 What:		/sys/.../iio:deviceX/events/in_magn_y_thresh_falling_en
 What:		/sys/.../iio:deviceX/events/in_magn_z_thresh_rising_en
 What:		/sys/.../iio:deviceX/events/in_magn_z_thresh_falling_en
-What:		/sys/.../iio:deviceX/events/in_voltageZ_supply_thresh_rising_en
-What:		/sys/.../iio:deviceX/events/in_voltageZ_supply_thresh_falling_en
-What:		/sys/.../iio:deviceX/events/in_voltageZ_thresh_rising_en
-What:		/sys/.../iio:deviceX/events/in_voltageZ_thresh_falling_en
-What:		/sys/.../iio:deviceX/events/in_temp_thresh_rising_en
-What:		/sys/.../iio:deviceX/events/in_temp_thresh_falling_en
+What:		/sys/.../iio:deviceX/events/in_voltageY_supply_thresh_rising_en
+What:		/sys/.../iio:deviceX/events/in_voltageY_supply_thresh_falling_en
+What:		/sys/.../iio:deviceX/events/in_voltageY_thresh_rising_en
+What:		/sys/.../iio:deviceX/events/in_voltageY_thresh_falling_en
+What:		/sys/.../iio:deviceX/events/in_tempY_thresh_rising_en
+What:		/sys/.../iio:deviceX/events/in_tempY_thresh_falling_en
 KernelVersion:	2.6.37
 Contact:	linux-iio@vger.kernel.org
 Description:
 		Event generated when channel passes a threshold in the specified
 		(_rising|_falling) direction. If the direction is not specified,
 		then either the device will report an event which ever direction
-		a single threshold value is called in (e.g.
-		<type>[Z][_name]_<raw|input>_thresh_value) or
-		<type>[Z][_name]_<raw|input>_thresh_rising_value and
-		<type>[Z][_name]_<raw|input>_thresh_falling_value may take
+		a single threshold value is passed in (e.g.
+		<type>[Y][_name]_<raw|input>_thresh_value) or
+		<type>[Y][_name]_<raw|input>_thresh_rising_value and
+		<type>[Y][_name]_<raw|input>_thresh_falling_value may take
 		different values, but the device can only enable both thresholds
 		or neither.
 		Note the driver will assume the last p events requested are
@@ -378,12 +376,12 @@ What:		/sys/.../iio:deviceX/events/in_magn_y_roc_rising_en
 What:		/sys/.../iio:deviceX/events/in_magn_y_roc_falling_en
 What:		/sys/.../iio:deviceX/events/in_magn_z_roc_rising_en
 What:		/sys/.../iio:deviceX/events/in_magn_z_roc_falling_en
-What:		/sys/.../iio:deviceX/events/in_voltageZ_supply_roc_rising_en
-What:		/sys/.../iio:deviceX/events/in_voltageZ_supply_roc_falling_en
-What:		/sys/.../iio:deviceX/events/in_voltageZ_roc_rising_en
-What:		/sys/.../iio:deviceX/events/in_voltageZ_roc_falling_en
-What:		/sys/.../iio:deviceX/events/in_temp_roc_rising_en
-What:		/sys/.../iio:deviceX/events/in_temp_roc_falling_en
+What:		/sys/.../iio:deviceX/events/in_voltageY_supply_roc_rising_en
+What:		/sys/.../iio:deviceX/events/in_voltageY_supply_roc_falling_en
+What:		/sys/.../iio:deviceX/events/in_voltageY_roc_rising_en
+What:		/sys/.../iio:deviceX/events/in_voltageY_roc_falling_en
+What:		/sys/.../iio:deviceX/events/in_tempY_roc_rising_en
+What:		/sys/.../iio:deviceX/events/in_tempY_roc_falling_en
 KernelVersion:	2.6.37
 Contact:	linux-iio@vger.kernel.org
 Description:
@@ -391,10 +389,10 @@ Description:
 		change (1st differential) in the specified (_rising|_falling)
 		direction. If the direction is not specified, then either the
 		device will report an event which ever direction a single
-		threshold value is called in (e.g.
-		<type>[Z][_name]_<raw|input>_roc_value) or
-		<type>[Z][_name]_<raw|input>_roc_rising_value and
-		<type>[Z][_name]_<raw|input>_roc_falling_value may take
+		threshold value is passed in (e.g.
+		<type>[Y][_name]_<raw|input>_roc_value) or
+		<type>[Y][_name]_<raw|input>_roc_rising_value and
+		<type>[Y][_name]_<raw|input>_roc_falling_value may take
 		different values, but the device can only enable both rate of
 		change thresholds or neither.
 		Note the driver will assume the last p events requested are
@@ -424,19 +422,19 @@ What:		/sys/.../events/in_magn_y_raw_thresh_rising_value
 What:		/sys/.../events/in_magn_y_raw_thresh_falling_value
 What:		/sys/.../events/in_magn_z_raw_thresh_rising_value
 What:		/sys/.../events/in_magn_z_raw_thresh_falling_value
-What:		/sys/.../events/in_voltageZ_supply_raw_thresh_rising_value
-What:		/sys/.../events/in_voltageZ_supply_raw_thresh_falling_value
-What:		/sys/.../events/in_voltageZ_raw_thresh_falling_value
-What:		/sys/.../events/in_voltageZ_raw_thresh_falling_value
-What:		/sys/.../events/in_temp_raw_thresh_falling_value
-What:		/sys/.../events/in_temp_raw_thresh_falling_value
+What:		/sys/.../events/in_voltageY_supply_raw_thresh_rising_value
+What:		/sys/.../events/in_voltageY_supply_raw_thresh_falling_value
+What:		/sys/.../events/in_voltageY_raw_thresh_falling_value
+What:		/sys/.../events/in_voltageY_raw_thresh_falling_value
+What:		/sys/.../events/in_tempY_raw_thresh_falling_value
+What:		/sys/.../events/in_tempY_raw_thresh_falling_value
 KernelVersion:	2.6.37
 Contact:	linux-iio@vger.kernel.org
 Description:
 		Specifies the value of threshold that the device is comparing
 		against for the events enabled by
-		<type>Z[_name]_thresh[_rising|falling]_en.
-		If separate attributes  exist for the two directions, but
+		<type>Y[_name]_thresh[_rising|falling]_en.
+		If separate attributes exist for the two directions, but
 		direction is not specified for this attribute, then a single
 		threshold value applies to both directions.
 		The raw or input element of the name indicates whether the
@@ -461,18 +459,18 @@ What:		/sys/.../events/in_magn_y_raw_roc_rising_value
 What:		/sys/.../events/in_magn_y_raw_roc_falling_value
 What:		/sys/.../events/in_magn_z_raw_roc_rising_value
 What:		/sys/.../events/in_magn_z_raw_roc_falling_value
-What:		/sys/.../events/in_voltageZ_supply_raw_roc_rising_value
-What:		/sys/.../events/in_voltageZ_supply_raw_roc_falling_value
-What:		/sys/.../events/in_voltageZ_raw_roc_falling_value
-What:		/sys/.../events/in_voltageZ_raw_roc_falling_value
-What:		/sys/.../events/in_temp_raw_roc_falling_value
-What:		/sys/.../events/in_temp_raw_roc_falling_value
+What:		/sys/.../events/in_voltageY_supply_raw_roc_rising_value
+What:		/sys/.../events/in_voltageY_supply_raw_roc_falling_value
+What:		/sys/.../events/in_voltageY_raw_roc_falling_value
+What:		/sys/.../events/in_voltageY_raw_roc_falling_value
+What:		/sys/.../events/in_tempY_raw_roc_falling_value
+What:		/sys/.../events/in_tempY_raw_roc_falling_value
 KernelVersion:	2.6.37
 Contact:	linux-iio@vger.kernel.org
 Description:
 		Specifies the value of rate of change threshold that the
 		device is comparing against for the events enabled by
-		<type>[Z][_name]_roc[_rising|falling]_en.
+		<type>[Y][_name]_roc[_rising|falling]_en.
 		If separate attributes exist for the two directions,
 		but direction is not specified for this attribute,
 		then a single threshold value applies to both directions.
@@ -516,18 +514,18 @@ What:		/sys/.../events/in_magn_z_thresh_rising_period
 What:		/sys/.../events/in_magn_z_thresh_falling_period
 What:		/sys/.../events/in_magn_z_roc_rising_period
 What:		/sys/.../events/in_magn_z_roc_falling_period
-What:		/sys/.../events/in_voltageZ_supply_thresh_rising_period
-What:		/sys/.../events/in_voltageZ_supply_thresh_falling_period
-What:		/sys/.../events/in_voltagez_supply_roc_rising_period
-What:		/sys/.../events/in_voltageZ_supply_roc_falling_period
-What:		/sys/.../events/in_voltageZ_thresh_rising_period
-What:		/sys/.../events/in_voltageZ_thresh_falling_period
-What:		/sys/.../events/in_voltageZ_roc_rising_period
-What:		/sys/.../events/in_voltageZ_roc_falling_period
-What:		/sys/.../events/in_temp_thresh_rising_period
-What:		/sys/.../events/in_temp_thresh_falling_period
-What:		/sys/.../events/in_temp_roc_rising_period
-What:		/sys/.../events/in_temp_roc_falling_period
+What:		/sys/.../events/in_voltageY_supply_thresh_rising_period
+What:		/sys/.../events/in_voltageY_supply_thresh_falling_period
+What:		/sys/.../events/in_voltageY_supply_roc_rising_period
+What:		/sys/.../events/in_voltageY_supply_roc_falling_period
+What:		/sys/.../events/in_voltageY_thresh_rising_period
+What:		/sys/.../events/in_voltageY_thresh_falling_period
+What:		/sys/.../events/in_voltageY_roc_rising_period
+What:		/sys/.../events/in_voltageY_roc_falling_period
+What:		/sys/.../events/in_tempY_thresh_rising_period
+What:		/sys/.../events/in_tempY_thresh_falling_period
+What:		/sys/.../events/in_tempY_roc_rising_period
+What:		/sys/.../events/in_tempY_roc_falling_period
 What:		/sys/.../events/in_accel_x&y&z_mag_falling_period
 KernelVersion:	2.6.37
 Contact:	linux-iio@vger.kernel.org
@@ -635,7 +633,8 @@ Contact:	linux-iio@vger.kernel.org
 Description:
 		Description of the scan element data storage within the buffer
 		and hence the form in which it is read from user-space.
-		Form is [s|u]bits/storagebits[>>shift].  s or u specifies if
+		Form is [be|le]:[s|u]bits/storagebits[>>shift].
+		be or le specifies big or little endian. s or u specifies if
 		signed (2's complement) or unsigned. bits is the number of bits
 		of data and storagebits is the space (after padding) that it
 		occupies in the buffer. shift if specified, is the shift that
@@ -672,7 +671,7 @@ What:		/sys/.../buffer/scan_elements/in_magn_y_index
 What:		/sys/.../buffer/scan_elements/in_magn_z_index
 What:		/sys/.../buffer/scan_elements/in_incli_x_index
 What:		/sys/.../buffer/scan_elements/in_incli_y_index
-What:		/sys/.../buffer/scan_elements/in_voltage_timestamp_index
+What:		/sys/.../buffer/scan_elements/in_timestamp_index
 KernelVersion:	2.6.37
 Contact:	linux-iio@vger.kernel.org
 Description:
-- 
1.7.3.4
