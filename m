Return-Path: <pmeerw@pmeerw.net>
From: Peter Meerwald <pmeerw@pmeerw.net>
To: Jonathan Cameron <jic23@kernel.org>
Cc: linux-iio@vger.kernel.org,
	Peter Meerwald <pmeerw@pmeerw.net>
Subject: [PATCH v2] iio: nitpicking on sysfs-bus-iio
Date: Tue, 12 Jun 2012 14:41:00 +0200
Message-Id: <1339504860-2089-1-git-send-email-pmeerw@pmeerw.net>
List-ID: <linux-iio@vger.kernel.org>

From: Peter Meerwald <p.meerwald@bct-electronic.com>

v2: address comments by Jonathan Cameron
* add more output power down modes
* spelling of etc.

Signed-off-by: Peter Meerwald <pmeerw@pmeerw.net>

---
 Documentation/ABI/testing/sysfs-bus-iio |   50 ++++++++++++++++---------------
 1 files changed, 26 insertions(+), 24 deletions(-)

diff --git a/Documentation/ABI/testing/sysfs-bus-iio b/Documentation/ABI/testing/sysfs-bus-iio
index 5bc8a47..e0f68f6 100644
--- a/Documentation/ABI/testing/sysfs-bus-iio
+++ b/Documentation/ABI/testing/sysfs-bus-iio
@@ -40,9 +40,9 @@ Contact:	linux-iio@vger.kernel.org
 Description:
 		Some devices have internal clocks.  This parameter sets the
 		resulting sampling frequency.  In many devices this
-		parameter has an effect on input filters etc rather than
+		parameter has an effect on input filters etc. rather than
 		simply controlling when the input is sampled.  As this
-		effects datardy triggers, hardware buffers and the sysfs
+		effects data ready triggers, hardware buffers and the sysfs
 		direct access interfaces, it may be found in any of the
 		relevant directories.  If it effects all of the above
 		then it is to be found in the base device directory.
@@ -74,7 +74,7 @@ What:		/sys/bus/iio/devices/iio:deviceX/in_voltageY_supply_raw
 KernelVersion:	2.6.35
 Contact:	linux-iio@vger.kernel.org
 Description:
-		Raw (unscaled no bias removal etc) voltage measurement from
+		Raw (unscaled no bias removal etc.) voltage measurement from
 		channel Y. In special cases where the channel does not
 		correspond to externally available input one of the named
 		versions may be used. The number must always be specified and
@@ -118,7 +118,7 @@ What:		/sys/bus/iio/devices/iio:deviceX/in_temp_z_raw
 KernelVersion:	2.6.35
 Contact:	linux-iio@vger.kernel.org
 Description:
-		Raw (unscaled no bias removal etc) temperature measurement.
+		Raw (unscaled no bias removal etc.) temperature measurement.
 		If an axis is specified it generally means that the temperature
 		sensor is associated with one part of a compound device (e.g.
 		a gyroscope axis). Units after application of scale and offset
@@ -148,10 +148,9 @@ KernelVersion:	2.6.35
 Contact:	linux-iio@vger.kernel.org
 Description:
 		Angular velocity about axis x, y or z (may be arbitrarily
-		assigned) Data converted by application of offset then scale to
-		radians per second. Has all the equivalent parameters as
-		per voltageY. Units after application of scale and offset are
-		radians per second.
+		assigned). Has all the equivalent parameters as	per voltageY.
+		Units after application of scale and offset are	radians per
+		second.
 
 What:		/sys/bus/iio/devices/iio:deviceX/in_incli_x_raw
 What:		/sys/bus/iio/devices/iio:deviceX/in_incli_y_raw
@@ -161,7 +160,7 @@ Contact:	linux-iio@vger.kernel.org
 Description:
 		Inclination raw reading about axis x, y or z (may be
 		arbitrarily assigned). Data converted by application of offset
-		and scale to Degrees.
+		and scale to degrees.
 
 What:		/sys/bus/iio/devices/iio:deviceX/in_magn_x_raw
 What:		/sys/bus/iio/devices/iio:deviceX/in_magn_y_raw
@@ -203,7 +202,7 @@ Contact:	linux-iio@vger.kernel.org
 Description:
 		If known for a device, offset to be added to <type>[Y]_raw prior
 		to scaling by <type>[Y]_scale in order to obtain value in the
-		<type> units as specified in <type>[y]_raw documentation.
+		<type> units as specified in <type>[Y]_raw documentation.
 		Not present if the offset is always 0 or unknown. If Y or
 		axis <x|y|z> is not present, then the offset applies to all
 		in channels of <type>.
@@ -248,7 +247,7 @@ What:		/sys/bus/iio/devices/iio:deviceX/in_proximity0_calibbias
 KernelVersion:	2.6.35
 Contact:	linux-iio@vger.kernel.org
 Description:
-		Hardware applied calibration offset. (assumed to fix production
+		Hardware applied calibration offset (assumed to fix production
 		inaccuracies).
 
 What		/sys/bus/iio/devices/iio:deviceX/in_voltageY_calibscale
@@ -265,7 +264,7 @@ what		/sys/bus/iio/devices/iio:deviceX/in_proximity0_calibscale
 KernelVersion:	2.6.35
 Contact:	linux-iio@vger.kernel.org
 Description:
-		Hardware applied calibration scale factor. (assumed to fix
+		Hardware applied calibration scale factor (assumed to fix
 		production inaccuracies).  If shared across all channels,
 		<type>_calibscale is used.
 
@@ -277,7 +276,7 @@ What:		/sys/.../iio:deviceX/in_capacitance_scale_available
 KernelVersion:	2.635
 Contact:	linux-iio@vger.kernel.org
 Description:
-		If a discrete set of scale values are available, they
+		If a discrete set of scale values is available, they
 		are listed in this attribute.
 
 What		/sys/bus/iio/devices/iio:deviceX/out_voltageY_hardwaregain
@@ -321,9 +320,11 @@ Contact:	linux-iio@vger.kernel.org
 Description:
 		Specifies the output powerdown mode.
 		DAC output stage is disconnected from the amplifier and
-		1kohm_to_gnd: connected to ground via an 1kOhm resistor
-		100kohm_to_gnd: connected to ground via an 100kOhm resistor
-		three_state: left floating
+		1kohm_to_gnd: connected	to ground via an 1kOhm resistor,
+		6kohm_to_gnd: connected to ground via a 6kOhm resistor,
+		20kohm_to_gnd: connected to ground via a 20kOhm resistor,
+		100kohm_to_gnd: connected to ground via an 100kOhm resistor,
+		three_state: left floating.
 		For a list of available output power down options read
 		outX_powerdown_mode_available. If Y is not present the
 		mode is shared across all outputs.
@@ -342,9 +343,10 @@ KernelVersion:	2.6.38
 Contact:	linux-iio@vger.kernel.org
 Description:
 		Writing 1 causes output Y to enter the power down mode specified
-		by the corresponding outY_powerdown_mode. Clearing returns to
-		normal operation. Y may be suppressed if all outputs are
-		controlled together.
+		by the corresponding outY_powerdown_mode. DAC output stage is
+		disconnected from the amplifier. Clearing returns to normal
+		operation. Y may be suppressed if all outputs are controlled
+		together.
 
 What:		/sys/bus/iio/devices/iio:deviceX/events
 KernelVersion:	2.6.35
@@ -390,12 +392,12 @@ Description:
 		different values, but the device can only enable both thresholds
 		or neither.
 		Note the driver will assume the last p events requested are
-		to be enabled where p is however many it supports (which may
-		vary depending on the exact set requested. So if you want to be
+		to be enabled where p is how many it supports (which may vary
+		depending on the exact set requested. So if you want to be
 		sure you have set what you think you have, check the contents of
 		these attributes after everything is configured. Drivers may
 		have to buffer any parameters so that they are consistent when
-		a given event type is enabled a future point (and not those for
+		a given event type is enabled at a future point (and not those for
 		whatever event was previously enabled).
 
 What:		/sys/.../iio:deviceX/events/in_accel_x_roc_rising_en
@@ -671,7 +673,7 @@ What:		/sys/.../buffer/scan_elements/in_anglvel_type
 What:		/sys/.../buffer/scan_elements/in_magn_type
 What:		/sys/.../buffer/scan_elements/in_incli_type
 What:		/sys/.../buffer/scan_elements/in_voltageY_type
-What:		/sys/.../buffer/scan_elements/in_voltage-in_type
+What:		/sys/.../buffer/scan_elements/in_voltage_type
 What:		/sys/.../buffer/scan_elements/in_voltageY_supply_type
 What:		/sys/.../buffer/scan_elements/in_timestamp_type
 KernelVersion:	2.6.37
@@ -692,7 +694,7 @@ Description:
 		the buffer output value appropriately.  The storagebits value
 		also specifies the data alignment.  So s48/64>>2 will be a
 		signed 48 bit integer stored in a 64 bit location aligned to
-		a a64 bit boundary. To obtain the clean value, shift right 2
+		a 64 bit boundary. To obtain the clean value, shift right 2
 		and apply a mask to zero the top 16 bits of the result.
 		For other storage combinations this attribute will be extended
 		appropriately.
-- 
1.7.5.4
