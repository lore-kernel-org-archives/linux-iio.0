Return-Path: <linux-iio-owner@vger.kernel.org>
Received: from ns.pmeerw.net ([87.118.82.44]:55572 "EHLO pmeerw.net"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1755306Ab3HRNAc (ORCPT <rfc822;linux-iio@vger.kernel.org>);
	Sun, 18 Aug 2013 09:00:32 -0400
From: Peter Meerwald <pmeerw@pmeerw.net>
To: linux-iio@vger.kernel.org
Cc: Peter Meerwald <pmeerw@pmeerw.net>,
	Jon Brenner <jon.brenner@ams.com>
Subject: [PATCH 1/2] iio: add INT_TIME (integration time) channel info attribute
Date: Sun, 18 Aug 2013 15:00:27 +0200
Message-Id: <1376830828-2496-1-git-send-email-pmeerw@pmeerw.net>
Sender: linux-iio-owner@vger.kernel.org
List-Id: linux-iio@vger.kernel.org

integration time is in seconds; it controls the measurement
time and influences the gain of a sensor

used by adjd_s311, tsl4531
the following drivers have similar controls:
* tsl2563 (integration time is controlled via CALIBSCALE among other things)
* tsl2583 (has integration_time device_attr, but driver doesn't use channels yet)
* tsl2x7x (has integration_time attr)

Signed-off-by: Peter Meerwald <pmeerw@pmeerw.net>
Cc: Jon Brenner <jon.brenner@ams.com>
---
 Documentation/ABI/testing/sysfs-bus-iio | 12 ++++++++++++
 drivers/iio/industrialio-core.c         |  1 +
 include/linux/iio/iio.h                 |  1 +
 include/linux/iio/sysfs.h               | 15 +++++++++++++++
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
index 09ebe0a..45a99ef 100644
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
1.8.3.4

