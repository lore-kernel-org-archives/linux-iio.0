Return-Path: <linux-iio-owner@vger.kernel.org>
Received: from smtp-out-137.synserver.de ([212.40.185.137]:1100 "EHLO
	smtp-out-134.synserver.de" rhost-flags-OK-OK-OK-FAIL)
	by vger.kernel.org with ESMTP id S1751710Ab2GBMkz (ORCPT
	<rfc822;linux-iio@vger.kernel.org>); Mon, 2 Jul 2012 08:40:55 -0400
From: Lars-Peter Clausen <lars@metafoo.de>
To: Jonathan Cameron <jic23@cam.ac.uk>
Cc: linux-iio@vger.kernel.org, Lars-Peter Clausen <lars@metafoo.de>
Subject: [PATCH 2/5] iio: Introduce iio_validate_scan_mask_onehot
Date: Mon,  2 Jul 2012 14:44:40 +0200
Message-Id: <1341233083-8765-2-git-send-email-lars@metafoo.de>
In-Reply-To: <1341233083-8765-1-git-send-email-lars@metafoo.de>
References: <1341233083-8765-1-git-send-email-lars@metafoo.de>
Sender: linux-iio-owner@vger.kernel.org
List-Id: linux-iio@vger.kernel.org

Add a helper function for validating a scan mask for devices where at most one
channel may be selected at a time. This is a common case among devices which
have scan mask restrictions so it makes sense to provide this function in the
core.

Signed-off-by: Lars-Peter Clausen <lars@metafoo.de>
---
 drivers/iio/industrialio-buffer.c |   15 +++++++++++++++
 include/linux/iio/buffer.h        |    3 +++
 2 files changed, 18 insertions(+)

diff --git a/drivers/iio/industrialio-buffer.c b/drivers/iio/industrialio-buffer.c
index cc5db36..bb88377 100644
--- a/drivers/iio/industrialio-buffer.c
+++ b/drivers/iio/industrialio-buffer.c
@@ -570,6 +570,21 @@ int iio_sw_buffer_preenable(struct iio_dev *indio_dev)
 }
 EXPORT_SYMBOL(iio_sw_buffer_preenable);
 
+/**
+ * iio_validate_scan_mask_onehot() - checks whether one or less bits are set
+ * @indio_dev: the iio device
+ * @mask: scan mask to be checked
+ *
+ * Return true if zero or one bits are set in the scan mask, false otherwise.
+ * It can be used for devices where only one channel can be active at a time.
+ */
+bool iio_validate_scan_mask_onehot(struct iio_dev *indio_dev,
+	const unsigned long *mask)
+{
+	return bitmap_weight(mask, indio_dev->masklength) <= 1;
+}
+EXPORT_SYMBOL_GPL(iio_validate_scan_mask_onehot);
+
 static bool iio_validate_scan_mask(struct iio_dev *indio_dev,
 	const unsigned long *mask)
 {
diff --git a/include/linux/iio/buffer.h b/include/linux/iio/buffer.h
index ad4fb1a..cc92713 100644
--- a/include/linux/iio/buffer.h
+++ b/include/linux/iio/buffer.h
@@ -174,6 +174,9 @@ ssize_t iio_buffer_show_enable(struct device *dev,
 
 int iio_sw_buffer_preenable(struct iio_dev *indio_dev);
 
+bool iio_validate_scan_mask_onehot(struct iio_dev *indio_dev,
+	const unsigned long *mask);
+
 #else /* CONFIG_IIO_BUFFER */
 
 static inline int iio_buffer_register(struct iio_dev *indio_dev,
-- 
1.7.10

