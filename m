Return-Path: <linux-iio-owner@vger.kernel.org>
Received: from smtp-out-137.synserver.de ([212.40.185.137]:1094 "EHLO
	smtp-out-134.synserver.de" rhost-flags-OK-OK-OK-FAIL)
	by vger.kernel.org with ESMTP id S1752262Ab2GBMkz (ORCPT
	<rfc822;linux-iio@vger.kernel.org>); Mon, 2 Jul 2012 08:40:55 -0400
From: Lars-Peter Clausen <lars@metafoo.de>
To: Jonathan Cameron <jic23@cam.ac.uk>
Cc: linux-iio@vger.kernel.org, Lars-Peter Clausen <lars@metafoo.de>
Subject: [PATCH 1/5] iio: Add callback to check whether a scan mask is valid
Date: Mon,  2 Jul 2012 14:44:39 +0200
Message-Id: <1341233083-8765-1-git-send-email-lars@metafoo.de>
Sender: linux-iio-owner@vger.kernel.org
List-Id: linux-iio@vger.kernel.org

This is useful for cases where the number of valid scan masks grows
exponentially, but it is rather easy to check whether a mask is valid or not
programmatically.

An example of such a case is a device with multiple ADCs where each ADC has a
upstream MUX, which allows to select from a number of physical channels.

  +-------+   +-------+
  |       |   |       | --- Channel 1
  | ADC 1 |---| MUX 1 | ---   ...
  |       |   |       | --- Channel M
  +-------+   +-------+

     .            .            .
     .            .            .
     .            .            .

  +-------+   +-------+
  |       |   |       | --- Channel M * N + 1
  | ADC N |---| MUX N | ---       ...
  |       |   |       | --- Channel M * N + M
  +-------+   +-------+

The number of necessary scan masks for this case is (M+1)**N - 1, on the other
hand it is easy to check whether the subsets for each ADC of the scanmask have
only one bit set.

Signed-off-by: Lars-Peter Clausen <lars@metafoo.de>
---
 drivers/iio/industrialio-buffer.c |   27 ++++++++++++++++++++-------
 include/linux/iio/iio.h           |    4 ++++
 2 files changed, 24 insertions(+), 7 deletions(-)

diff --git a/drivers/iio/industrialio-buffer.c b/drivers/iio/industrialio-buffer.c
index 3d8d187..cc5db36 100644
--- a/drivers/iio/industrialio-buffer.c
+++ b/drivers/iio/industrialio-buffer.c
@@ -570,6 +570,15 @@ int iio_sw_buffer_preenable(struct iio_dev *indio_dev)
 }
 EXPORT_SYMBOL(iio_sw_buffer_preenable);
 
+static bool iio_validate_scan_mask(struct iio_dev *indio_dev,
+	const unsigned long *mask)
+{
+	if (!indio_dev->setup_ops->validate_scan_mask)
+		return true;
+
+	return indio_dev->setup_ops->validate_scan_mask(indio_dev, mask);
+}
+
 /**
  * iio_scan_mask_set() - set particular bit in the scan mask
  * @buffer: the buffer whose scan mask we are interested in
@@ -589,27 +598,31 @@ int iio_scan_mask_set(struct iio_dev *indio_dev,
 		return -ENOMEM;
 	if (!indio_dev->masklength) {
 		WARN_ON("trying to set scanmask prior to registering buffer\n");
-		kfree(trialmask);
-		return -EINVAL;
+		goto err_invalid_mask;
 	}
 	bitmap_copy(trialmask, buffer->scan_mask, indio_dev->masklength);
 	set_bit(bit, trialmask);
 
+	if (!iio_validate_scan_mask(indio_dev, trialmask))
+		goto err_invalid_mask;
+
 	if (indio_dev->available_scan_masks) {
 		mask = iio_scan_mask_match(indio_dev->available_scan_masks,
 					   indio_dev->masklength,
 					   trialmask);
-		if (!mask) {
-			kfree(trialmask);
-			return -EINVAL;
-		}
+		if (!mask)
+			goto err_invalid_mask;
 	}
 	bitmap_copy(buffer->scan_mask, trialmask, indio_dev->masklength);
 
 	kfree(trialmask);
 
 	return 0;
-};
+
+err_invalid_mask:
+	kfree(trialmask);
+	return -EINVAL;
+}
 EXPORT_SYMBOL_GPL(iio_scan_mask_set);
 
 int iio_scan_mask_query(struct iio_dev *indio_dev,
diff --git a/include/linux/iio/iio.h b/include/linux/iio/iio.h
index 2afbb6f..be82936 100644
--- a/include/linux/iio/iio.h
+++ b/include/linux/iio/iio.h
@@ -363,12 +363,16 @@ struct iio_info {
  * @predisable:		[DRIVER] function to run prior to marking buffer
  *			disabled
  * @postdisable:	[DRIVER] function to run after marking buffer disabled
+ * @validate_scan_mask: [DRIVER] function callback to check whether a given
+ *			scan mask is valid for the device.
  */
 struct iio_buffer_setup_ops {
 	int				(*preenable)(struct iio_dev *);
 	int				(*postenable)(struct iio_dev *);
 	int				(*predisable)(struct iio_dev *);
 	int				(*postdisable)(struct iio_dev *);
+	bool (*validate_scan_mask)(struct iio_dev *indio_dev,
+				   const unsigned long *scan_mask);
 };
 
 /**
-- 
1.7.10

