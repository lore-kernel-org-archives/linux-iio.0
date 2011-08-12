Return-Path: <linux-iio-owner@vger.kernel.org>
Received: from ppsw-51.csi.cam.ac.uk ([131.111.8.151]:57285 "EHLO
	ppsw-51.csi.cam.ac.uk" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1754079Ab1HLQBB (ORCPT
	<rfc822;linux-iio@vger.kernel.org>); Fri, 12 Aug 2011 12:01:01 -0400
From: Jonathan Cameron <jic23@cam.ac.uk>
To: greg@kroah.com
Cc: linux-iio@vger.kernel.org, Jonathan Cameron <jic23@cam.ac.uk>
Subject: [PATCH 17/19] staging:iio:sysfs cleanout header for unused definitions.
Date: Fri, 12 Aug 2011 17:08:51 +0100
Message-Id: <1313165333-3951-18-git-send-email-jic23@cam.ac.uk>
In-Reply-To: <1313165333-3951-1-git-send-email-jic23@cam.ac.uk>
References: <1313165333-3951-1-git-send-email-jic23@cam.ac.uk>
Sender: linux-iio-owner@vger.kernel.org
List-Id: linux-iio@vger.kernel.org

Also push one down into the only driver that actually uses it.

Signed-off-by: Jonathan Cameron <jic23@cam.ac.uk>
---
 drivers/staging/iio/accel/sca3000_core.c |    2 +-
 drivers/staging/iio/sysfs.h              |   45 +----------------------------
 2 files changed, 3 insertions(+), 44 deletions(-)

diff --git a/drivers/staging/iio/accel/sca3000_core.c b/drivers/staging/iio/accel/sca3000_core.c
index 3c637b9..22c38c3 100644
--- a/drivers/staging/iio/accel/sca3000_core.c
+++ b/drivers/staging/iio/accel/sca3000_core.c
@@ -421,7 +421,7 @@ static IIO_DEVICE_ATTR(measurement_mode, S_IRUGO | S_IWUSR,
 
 /* More standard attributes */
 
-static IIO_DEV_ATTR_REV(sca3000_show_rev);
+static IIO_DEVICE_ATTR(revision, S_IRUGO, sca3000_show_rev, NULL, 0);
 
 #define SCA3000_INFO_MASK			\
 	(1 << IIO_CHAN_INFO_SCALE_SHARED)
diff --git a/drivers/staging/iio/sysfs.h b/drivers/staging/iio/sysfs.h
index 203ee83..56f4efb 100644
--- a/drivers/staging/iio/sysfs.h
+++ b/drivers/staging/iio/sysfs.h
@@ -71,17 +71,8 @@ struct iio_const_attr {
 	struct iio_const_attr iio_const_attr_##_vname			\
 	= { .string = _string,						\
 	    .dev_attr = __ATTR(_name, S_IRUGO, iio_read_const_attr, NULL)}
-/* Generic attributes of onetype or another */
-
-/**
- * IIO_DEV_ATTR_REV - revision number for the device
- * @_show: output method for the attribute
- *
- * Very much device dependent.
- **/
-#define IIO_DEV_ATTR_REV(_show)			\
-	IIO_DEVICE_ATTR(revision, S_IRUGO, _show, NULL, 0)
 
+/* Generic attributes of onetype or another */
 /**
  * IIO_DEV_ATTR_RESET: resets the device
  **/
@@ -89,13 +80,6 @@ struct iio_const_attr {
 	IIO_DEVICE_ATTR(reset, S_IWUSR, NULL, _store, 0)
 
 /**
- * IIO_CONST_ATTR_NAME - constant identifier
- * @_string: the name
- **/
-#define IIO_CONST_ATTR_NAME(_string)				\
-	IIO_CONST_ATTR(name, _string)
-
-/**
  * IIO_DEV_ATTR_SAMP_FREQ - sets any internal clock frequency
  * @_mode: sysfs file mode/permissions
  * @_show: output method for the attribute
@@ -105,15 +89,11 @@ struct iio_const_attr {
 	IIO_DEVICE_ATTR(sampling_frequency, _mode, _show, _store, 0)
 
 /**
- * IIO_DEV_ATTR_AVAIL_SAMP_FREQ - list available sampling frequencies
+ * IIO_DEV_ATTR_SAMP_FREQ_AVAIL - list available sampling frequencies
  * @_show: output method for the attribute
  *
  * May be mode dependent on some devices
  **/
-/* Deprecated */
-#define IIO_DEV_ATTR_AVAIL_SAMP_FREQ(_show)				\
-	IIO_DEVICE_ATTR(available_sampling_frequency, S_IRUGO, _show, NULL, 0)
-
 #define IIO_DEV_ATTR_SAMP_FREQ_AVAIL(_show)				\
 	IIO_DEVICE_ATTR(sampling_frequency_available, S_IRUGO, _show, NULL, 0)
 /**
@@ -125,27 +105,6 @@ struct iio_const_attr {
 #define IIO_CONST_ATTR_SAMP_FREQ_AVAIL(_string)			\
 	IIO_CONST_ATTR(sampling_frequency_available, _string)
 
-/**
- * IIO_DEV_ATTR_SW_RING_ENABLE - enable software ring buffer
- * @_show: output method for the attribute
- * @_store: input method for the attribute
- *
- * Success may be dependent on attachment of trigger previously.
- **/
-#define IIO_DEV_ATTR_SW_RING_ENABLE(_show, _store)			\
-	IIO_DEVICE_ATTR(sw_ring_enable, S_IRUGO | S_IWUSR, _show, _store, 0)
-
-/**
- * IIO_DEV_ATTR_HW_RING_ENABLE - enable hardware ring buffer
- * @_show: output method for the attribute
- * @_store: input method for the attribute
- *
- * This is a different attribute from the software one as one can envision
- * schemes where a combination of the two may be used.
- **/
-#define IIO_DEV_ATTR_HW_RING_ENABLE(_show, _store)			\
-	IIO_DEVICE_ATTR(hw_ring_enable, S_IRUGO | S_IWUSR, _show, _store, 0)
-
 #define IIO_DEV_ATTR_TEMP_RAW(_show)			\
 	IIO_DEVICE_ATTR(temp_raw, S_IRUGO, _show, NULL, 0)
 
-- 
1.7.3.4

