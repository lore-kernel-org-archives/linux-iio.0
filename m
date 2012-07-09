Return-Path: <lars@metafoo.de>
From: Lars-Peter Clausen <lars@metafoo.de>
To: Jonathan Cameron <jic23@cam.ac.uk>
Cc: linux-iio@vger.kernel.org,
	Lars-Peter Clausen <lars@metafoo.de>
Subject: [PATCH v2 2/6] iio: Introduce iio_validate_scan_mask_onehot
Date: Mon,  9 Jul 2012 11:00:48 +0200
Message-Id: <1341824452-28803-2-git-send-email-lars@metafoo.de>
In-Reply-To: <1341824452-28803-1-git-send-email-lars@metafoo.de>
References: <1341824452-28803-1-git-send-email-lars@metafoo.de>
List-ID: <linux-iio@vger.kernel.org>

Add a helper function for validating a scan mask for devices where exactly one
channel must be selected during sampling. This is a common case among devices
which have scan mask restrictions so it makes sense to provide this function in
the core.

Signed-off-by: Lars-Peter Clausen <lars@metafoo.de>
---
Make the check more strict and only accept scanmasks with exactly one bit set
instead of one or less bits set.
---
 drivers/iio/industrialio-buffer.c |   16 ++++++++++++++++
 include/linux/iio/buffer.h        |    3 +++
 2 files changed, 19 insertions(+)

diff --git a/drivers/iio/industrialio-buffer.c b/drivers/iio/industrialio-buffer.c
index cc5db36..6e00042 100644
--- a/drivers/iio/industrialio-buffer.c
+++ b/drivers/iio/industrialio-buffer.c
@@ -570,6 +570,22 @@ int iio_sw_buffer_preenable(struct iio_dev *indio_dev)
 }
 EXPORT_SYMBOL(iio_sw_buffer_preenable);
 
+/**
+ * iio_validate_scan_mask_onehot() - Validates that exactly one channel is selected
+ * @indio_dev: the iio device
+ * @mask: scan mask to be checked
+ *
+ * Return true if exactly one bit is set in the scan mask, false otherwise. It
+ * can be used for devices where only one channel can be active for sampling at
+ * a time.
+ */
+bool iio_validate_scan_mask_onehot(struct iio_dev *indio_dev,
+	const unsigned long *mask)
+{
+	return bitmap_weight(mask, indio_dev->masklength) == 1;
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
1.7.10.4
