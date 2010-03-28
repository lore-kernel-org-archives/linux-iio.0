Return-Path: <jic23@cam.ac.uk>
From: Jonathan Cameron <jic23@cam.ac.uk>
To: linux-iio@vger.kernel.org
Cc: Jonathan Cameron <jic23@cam.ac.uk>
Subject: [PATCH 02/13] staging:iio: Add new attrs for sampling frequency available and temp_raw
Date: Sun, 28 Mar 2010 21:41:08 +0100
Message-Id: <1269808879-28838-3-git-send-email-jic23@cam.ac.uk>
In-Reply-To: <1269808879-28838-2-git-send-email-jic23@cam.ac.uk>
References: <1269808879-28838-1-git-send-email-jic23@cam.ac.uk>
 <1269808879-28838-2-git-send-email-jic23@cam.ac.uk>
List-ID: <linux-iio@vger.kernel.org>

Signed-off-by: Jonathan Cameron <jic23@cam.ac.uk>
---
 drivers/staging/iio/sysfs.h |   12 +++++++++++-
 1 files changed, 11 insertions(+), 1 deletions(-)

diff --git a/drivers/staging/iio/sysfs.h b/drivers/staging/iio/sysfs.h
index d8fe0e2..afcf5ab 100644
--- a/drivers/staging/iio/sysfs.h
+++ b/drivers/staging/iio/sysfs.h
@@ -144,18 +144,25 @@ struct iio_const_attr {
  *
  * May be mode dependent on some devices
  **/
+/* Deprecated */
 #define IIO_DEV_ATTR_AVAIL_SAMP_FREQ(_show)				\
 	IIO_DEVICE_ATTR(available_sampling_frequency, S_IRUGO, _show, NULL, 0)
 
+#define IIO_DEV_ATTR_SAMP_FREQ_AVAIL(_show)				\
+	IIO_DEVICE_ATTR(sampling_frequency_available, S_IRUGO, _show, NULL, 0)
 /**
  * IIO_CONST_ATTR_AVAIL_SAMP_FREQ - list available sampling frequencies
  * @_string: frequency string for the attribute
  *
  * Constant version
  **/
-#define IIO_CONST_ATTR_AVAIL_SAMP_FREQ(_string)	\
+/* Deprecated */
+#define IIO_CONST_ATTR_AVAIL_SAMP_FREQ(_string)			\
 	IIO_CONST_ATTR(available_sampling_frequency, _string)
 
+#define IIO_CONST_ATTR_SAMP_FREQ_AVAIL(_string)			\
+	IIO_CONST_ATTR(sampling_frequency_available, _string)
+
 /**
  * IIO_DEV_ATTR_SCAN_MODE - select a scan mode
  * @_mode: sysfs file mode/permissions
@@ -234,6 +241,9 @@ struct iio_const_attr {
 #define IIO_DEV_ATTR_TEMP(_show)			\
 	IIO_DEVICE_ATTR(temp, S_IRUGO, _show, NULL, 0)
 
+#define IIO_DEV_ATTR_TEMP_RAW(_show)			\
+	IIO_DEVICE_ATTR(temp_raw, S_IRUGO, _show, NULL, 0)
+
 /**
  * IIO_EVENT_SH - generic shared event handler
  * @_name: event name
-- 
1.6.4.4
