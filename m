Return-Path: <linux-iio-owner@vger.kernel.org>
Received: from ns.pmeerw.net ([87.118.82.44]:57130 "EHLO pmeerw.net"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1752890Ab3IQWmK (ORCPT <rfc822;linux-iio@vger.kernel.org>);
	Tue, 17 Sep 2013 18:42:10 -0400
From: Peter Meerwald <pmeerw@pmeerw.net>
To: linux-iio@vger.kernel.org
Cc: Peter Meerwald <pmeerw@pmeerw.net>
Subject: [PATCH] iio: Minor cleanups of industrialio-buffer
Date: Wed, 18 Sep 2013 00:42:07 +0200
Message-Id: <1379457727-15780-1-git-send-email-pmeerw@pmeerw.net>
Sender: linux-iio-owner@vger.kernel.org
List-Id: linux-iio@vger.kernel.org

adding one return value check
fix one kerneldoc

Signed-off-by: Peter Meerwald <pmeerw@pmeerw.net>
---
 drivers/iio/industrialio-buffer.c | 13 ++++++++-----
 1 file changed, 8 insertions(+), 5 deletions(-)

diff --git a/drivers/iio/industrialio-buffer.c b/drivers/iio/industrialio-buffer.c
index a7ac4b5..58180ec 100644
--- a/drivers/iio/industrialio-buffer.c
+++ b/drivers/iio/industrialio-buffer.c
@@ -243,6 +243,8 @@ static int iio_buffer_add_channel_sysfs(struct iio_dev *indio_dev,
 					     0,
 					     &indio_dev->dev,
 					     &buffer->scan_el_dev_attr_list);
+	if (ret)
+		goto error_ret;
 	attrcount++;
 	ret = attrcount;
 error_ret:
@@ -412,7 +414,7 @@ ssize_t iio_buffer_show_enable(struct device *dev,
 }
 EXPORT_SYMBOL(iio_buffer_show_enable);
 
-/* note NULL used as error indicator as it doesn't make sense. */
+/* Note NULL used as error indicator as it doesn't make sense. */
 static const unsigned long *iio_scan_mask_match(const unsigned long *av_masks,
 					  unsigned int masklength,
 					  const unsigned long *mask)
@@ -494,7 +496,7 @@ int iio_update_buffers(struct iio_dev *indio_dev,
 		return 0;
 	}
 
-	/* What scan mask do we actually have ?*/
+	/* What scan mask do we actually have? */
 	compound_mask = kcalloc(BITS_TO_LONGS(indio_dev->masklength),
 				sizeof(long), GFP_KERNEL);
 	if (compound_mask == NULL) {
@@ -560,7 +562,7 @@ int iio_update_buffers(struct iio_dev *indio_dev,
 			goto error_run_postdisable;
 		}
 	}
-	/* Definitely possible for devices to support both of these.*/
+	/* Definitely possible for devices to support both of these. */
 	if (indio_dev->modes & INDIO_BUFFER_TRIGGERED) {
 		if (!indio_dev->trig) {
 			printk(KERN_INFO "Buffer not started: no trigger\n");
@@ -571,7 +573,7 @@ int iio_update_buffers(struct iio_dev *indio_dev,
 		indio_dev->currentmode = INDIO_BUFFER_TRIGGERED;
 	} else if (indio_dev->modes & INDIO_BUFFER_HARDWARE) {
 		indio_dev->currentmode = INDIO_BUFFER_HARDWARE;
-	} else { /* should never be reached */
+	} else { /* Should never be reached */
 		ret = -EINVAL;
 		goto error_run_postdisable;
 	}
@@ -694,6 +696,7 @@ static bool iio_validate_scan_mask(struct iio_dev *indio_dev,
 
 /**
  * iio_scan_mask_set() - set particular bit in the scan mask
+ * @indio_dev: the iio device
  * @buffer: the buffer whose scan mask we are interested in
  * @bit: the bit to be set.
  *
@@ -714,7 +717,7 @@ int iio_scan_mask_set(struct iio_dev *indio_dev,
 	if (trialmask == NULL)
 		return -ENOMEM;
 	if (!indio_dev->masklength) {
-		WARN_ON("trying to set scanmask prior to registering buffer\n");
+		WARN_ON("Trying to set scanmask prior to registering buffer\n");
 		goto err_invalid_mask;
 	}
 	bitmap_copy(trialmask, buffer->scan_mask, indio_dev->masklength);
-- 
1.8.4

