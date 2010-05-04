Return-Path: <linux-iio-owner@vger.kernel.org>
Received: from ppsw-43.csi.cam.ac.uk ([131.111.8.143]:57891 "EHLO
	ppsw-43.csi.cam.ac.uk" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1754191Ab0EDNkT (ORCPT
	<rfc822;linux-iio@vger.kernel.org>); Tue, 4 May 2010 09:40:19 -0400
From: Jonathan Cameron <jic23@cam.ac.uk>
To: gregkh@suse.de
Cc: linux-iio@vger.kernel.org, Jonathan Cameron <jic23@cam.ac.uk>
Subject: [PATCH 02/20] staging:iio: Add new attrs for sampling frequency available and temp_raw
Date: Tue,  4 May 2010 14:42:57 +0100
Message-Id: <1272980595-11033-3-git-send-email-jic23@cam.ac.uk>
In-Reply-To: <1272980595-11033-2-git-send-email-jic23@cam.ac.uk>
References: <1272980595-11033-1-git-send-email-jic23@cam.ac.uk>
 <1272980595-11033-2-git-send-email-jic23@cam.ac.uk>
Sender: linux-iio-owner@vger.kernel.org
List-Id: linux-iio@vger.kernel.org

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

