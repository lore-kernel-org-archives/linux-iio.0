Return-Path: <linux-iio-owner@vger.kernel.org>
Received: from ns.pmeerw.net ([87.118.82.44]:33409 "EHLO pmeerw.net"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1756373Ab3ICBIP (ORCPT <rfc822;linux-iio@vger.kernel.org>);
	Mon, 2 Sep 2013 21:08:15 -0400
From: Peter Meerwald <pmeerw@pmeerw.net>
To: linux-iio@vger.kernel.org
Cc: Peter Meerwald <pmeerw@pmeerw.net>,
	Jon Brenner <jon.brenner@ams.com>
Subject: [PATCH v2 1/2] iio: Add INT_TIME (integration time) channel info attribute
Date: Tue,  3 Sep 2013 03:08:05 +0200
Message-Id: <1378170486-27702-1-git-send-email-pmeerw@pmeerw.net>
Sender: linux-iio-owner@vger.kernel.org
List-Id: linux-iio@vger.kernel.org

Integration time is in seconds; it controls the measurement
time and influences the gain of a sensor.

There are two typical ways that scaling is implemented in a device:
1) input amplifier,
2) reference to the ADC is changed.
These both result in the accuracy of the ADC varying (by applying its
sampling over a more relevant range).

Integration time is a way of dealing with noise inherent in the analog
sensor itself.  In the case of a light sensor, a mixture of photon noise
and device specific noise.  Photon noise is dealt with by either improving
the efficiency of the sensor, (more photons actually captured) which is not
easily varied dynamically, or by integrating the measurement over a longer
time period.  Note that this can also be thought of as an averaging of a
number of individual samples and is infact sometimes implemented this way.
Altering integration time implies that the duration of a measurement changes,
a fact the device's user may be interested in.

Hence it makes sense to distinguish between integration time and simple
scale. In some devices both types of control are present and whilst they
will have similar effects on the amplitude of the reading, their effect
on the noise of the measurements will differ considerably.

Used by adjd_s311, tsl4531, tcs3472
The following drivers have similar controls (and could be adapted):
* tsl2563 (integration time is controlled via CALIBSCALE among other things)
* tsl2583 (has integration_time device_attr, but driver doesn't use channels yet)
* tsl2x7x (has integration_time attr)

Signed-off-by: Peter Meerwald <pmeerw@pmeerw.net>
Cc: Jon Brenner <jon.brenner@ams.com>
---
 Documentation/ABI/testing/sysfs-bus-iio |   12 ++++++++++++
 drivers/iio/industrialio-core.c         |    1 +
 include/linux/iio/iio.h                 |    1 +
 include/linux/iio/sysfs.h               |   15 +++++++++++++++
 4 files changed, 29 insertions(+)

diff --git a/Documentation/ABI/testing/sysfs-bus-iio b/Documentation/ABI/testing/sysfs-bus-iio
index 5caaab9..d75147c 100644
--- a/Documentation/ABI/testing/sysfs-bus-iio
+++ b/Documentation/ABI/testing/sysfs-bus-iio
@@ -800,3 +800,15 @@ Description:
 		Writing '1' stores the current device configuration into
 		on-chip EEPROM. After power-up or chip reset the device will
 		automatically load the saved configuration.
+
+What:		/sys/.../iio:deviceX/in_intensity_red_integration_time
+What:		/sys/.../iio:deviceX/in_intensity_green_integration_time
+What:		/sys/.../iio:deviceX/in_intensity_blue_integration_time
+What:		/sys/.../iio:deviceX/in_intensity_clear_integration_time
+What:		/sys/.../iio:deviceX/in_illuminance_integration_time
+KernelVersion:	3.12
+Contact:	linux-iio@vger.kernel.org
+Description:
+		This attribute is used to get/set the integration time in
+		seconds.
+
diff --git a/drivers/iio/industrialio-core.c b/drivers/iio/industrialio-core.c
index 97f0297..2cb4841 100644
--- a/drivers/iio/industrialio-core.c
+++ b/drivers/iio/industrialio-core.c
@@ -101,6 +101,7 @@ static const char * const iio_chan_info_postfix[] = {
 	[IIO_CHAN_INFO_PHASE] = "phase",
 	[IIO_CHAN_INFO_HARDWAREGAIN] = "hardwaregain",
 	[IIO_CHAN_INFO_HYSTERESIS] = "hysteresis",
+	[IIO_CHAN_INFO_INT_TIME] = "integration_time",
 };
 
 const struct iio_chan_spec
diff --git a/include/linux/iio/iio.h b/include/linux/iio/iio.h
index 8e7a813..01edd67 100644
--- a/include/linux/iio/iio.h
+++ b/include/linux/iio/iio.h
@@ -36,6 +36,7 @@ enum iio_chan_info_enum {
 	IIO_CHAN_INFO_PHASE,
 	IIO_CHAN_INFO_HARDWAREGAIN,
 	IIO_CHAN_INFO_HYSTERESIS,
+	IIO_CHAN_INFO_INT_TIME,
 };
 
 enum iio_endian {
diff --git a/include/linux/iio/sysfs.h b/include/linux/iio/sysfs.h
index 2958c96..8a1d186 100644
--- a/include/linux/iio/sysfs.h
+++ b/include/linux/iio/sysfs.h
@@ -100,6 +100,21 @@ struct iio_const_attr {
 #define IIO_CONST_ATTR_SAMP_FREQ_AVAIL(_string)			\
 	IIO_CONST_ATTR(sampling_frequency_available, _string)
 
+/**
+ * IIO_DEV_ATTR_INT_TIME_AVAIL - list available integration times
+ * @_show: output method for the attribute
+ **/
+#define IIO_DEV_ATTR_INT_TIME_AVAIL(_show)		\
+	IIO_DEVICE_ATTR(integration_time_available, S_IRUGO, _show, NULL, 0)
+/**
+ * IIO_CONST_ATTR_INT_TIME_AVAIL - list available integration times
+ * @_string: frequency string for the attribute
+ *
+ * Constant version
+ **/
+#define IIO_CONST_ATTR_INT_TIME_AVAIL(_string)		\
+	IIO_CONST_ATTR(integration_time_available, _string)
+
 #define IIO_DEV_ATTR_TEMP_RAW(_show)			\
 	IIO_DEVICE_ATTR(in_temp_raw, S_IRUGO, _show, NULL, 0)
 
-- 
1.7.9.5

