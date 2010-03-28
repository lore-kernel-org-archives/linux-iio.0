Return-Path: <linux-iio-owner@vger.kernel.org>
Received: from ppsw-0.csi.cam.ac.uk ([131.111.8.130]:48601 "EHLO
	ppsw-0.csi.cam.ac.uk" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1755235Ab0C1UjR (ORCPT
	<rfc822;linux-iio@vger.kernel.org>); Sun, 28 Mar 2010 16:39:17 -0400
From: Jonathan Cameron <jic23@cam.ac.uk>
To: linux-iio@vger.kernel.org
Cc: Jonathan Cameron <jic23@cam.ac.uk>
Subject: [PATCH 01/13] staging:iio: Add new in_raw definitions for adc channels.
Date: Sun, 28 Mar 2010 21:41:07 +0100
Message-Id: <1269808879-28838-2-git-send-email-jic23@cam.ac.uk>
In-Reply-To: <1269808879-28838-1-git-send-email-jic23@cam.ac.uk>
References: <1269808879-28838-1-git-send-email-jic23@cam.ac.uk>
Sender: linux-iio-owner@vger.kernel.org
List-Id: linux-iio@vger.kernel.org

Signed-off-by: Jonathan Cameron <jic23@cam.ac.uk>
---
 drivers/staging/iio/adc/adc.h |   12 ++++++++++++
 drivers/staging/iio/sysfs.h   |    3 +++
 2 files changed, 15 insertions(+), 0 deletions(-)

diff --git a/drivers/staging/iio/adc/adc.h b/drivers/staging/iio/adc/adc.h
index d925b2c..46f0d08 100644
--- a/drivers/staging/iio/adc/adc.h
+++ b/drivers/staging/iio/adc/adc.h
@@ -9,5 +9,17 @@
  *
  */
 
+/* Deprecated */
 #define IIO_DEV_ATTR_ADC(_num, _show, _addr)			\
   IIO_DEVICE_ATTR(adc_##_num, S_IRUGO, _show, NULL, _addr)
+
+#define IIO_DEV_ATTR_IN_RAW(_num, _show, _addr)				\
+	IIO_DEVICE_ATTR(in##_num##_raw, S_IRUGO, _show, NULL, _addr)
+
+#define IIO_DEV_ATTR_IN_DIFF_RAW(_nump, _numn, _show, _addr)		\
+	IIO_DEVICE_ATTR_NAMED(in##_nump##min##_numn##_raw,		\
+			      in##_nump-in##_numn##_raw,		\
+			      S_IRUGO,					\
+			      _show,					\
+			      NULL,					\
+			      _addr)
diff --git a/drivers/staging/iio/sysfs.h b/drivers/staging/iio/sysfs.h
index e501e13..d8fe0e2 100644
--- a/drivers/staging/iio/sysfs.h
+++ b/drivers/staging/iio/sysfs.h
@@ -98,6 +98,9 @@ struct iio_const_attr {
 	struct iio_dev_attr iio_dev_attr_##_name		\
 	= IIO_ATTR(_name, _mode, _show, _store, _addr)
 
+#define IIO_DEVICE_ATTR_NAMED(_vname, _name, _mode, _show, _store, _addr) \
+	struct iio_dev_attr iio_dev_attr_##_vname			\
+	= IIO_ATTR(_name, _mode, _show, _store, _addr)
 
 #define IIO_DEVICE_ATTR_2(_name, _mode, _show, _store, _addr, _val2)	\
 	struct iio_dev_attr iio_dev_attr_##_name			\
-- 
1.6.4.4

