Return-Path: <linux-iio-owner@vger.kernel.org>
Received: from smtp-out-150.synserver.de ([212.40.185.150]:1131 "EHLO
	smtp-out-150.synserver.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S932221Ab3JNQrr (ORCPT
	<rfc822;linux-iio@vger.kernel.org>); Mon, 14 Oct 2013 12:47:47 -0400
From: Lars-Peter Clausen <lars@metafoo.de>
To: Jonathan Cameron <jic23@kernel.org>
Cc: linux-iio@vger.kernel.org, Lars-Peter Clausen <lars@metafoo.de>
Subject: [PATCH 17/17] iio: Remove unused iio_sw_buffer_preenable()
Date: Mon, 14 Oct 2013 18:49:30 +0200
Message-Id: <1381769370-17100-17-git-send-email-lars@metafoo.de>
In-Reply-To: <1381769370-17100-1-git-send-email-lars@metafoo.de>
References: <1381769370-17100-1-git-send-email-lars@metafoo.de>
Sender: linux-iio-owner@vger.kernel.org
List-Id: linux-iio@vger.kernel.org

The functionality implemented by iio_sw_buffer_preenable() is now done directly
in the IIO core and previous users of iio_sw_buffer_preenable() have all been
updated to not use it anymore. It is unused now and can be remove.

Signed-off-by: Lars-Peter Clausen <lars@metafoo.de>
---
 drivers/iio/industrialio-buffer.c | 18 ------------------
 include/linux/iio/buffer.h        |  2 --
 2 files changed, 20 deletions(-)

diff --git a/drivers/iio/industrialio-buffer.c b/drivers/iio/industrialio-buffer.c
index 186f501..d7ab258 100644
--- a/drivers/iio/industrialio-buffer.c
+++ b/drivers/iio/industrialio-buffer.c
@@ -749,24 +749,6 @@ done:
 }
 EXPORT_SYMBOL(iio_buffer_store_enable);
 
-int iio_sw_buffer_preenable(struct iio_dev *indio_dev)
-{
-	struct iio_buffer *buffer;
-	unsigned bytes;
-	dev_dbg(&indio_dev->dev, "%s\n", __func__);
-
-	list_for_each_entry(buffer, &indio_dev->buffer_list, buffer_list)
-		if (buffer->access->set_bytes_per_datum) {
-			bytes = iio_compute_scan_bytes(indio_dev,
-						       buffer->scan_mask,
-						       buffer->scan_timestamp);
-
-			buffer->access->set_bytes_per_datum(buffer, bytes);
-		}
-	return 0;
-}
-EXPORT_SYMBOL(iio_sw_buffer_preenable);
-
 /**
  * iio_validate_scan_mask_onehot() - Validates that exactly one channel is selected
  * @indio_dev: the iio device
diff --git a/include/linux/iio/buffer.h b/include/linux/iio/buffer.h
index 6e428d9..15607b4 100644
--- a/include/linux/iio/buffer.h
+++ b/include/linux/iio/buffer.h
@@ -206,8 +206,6 @@ ssize_t iio_buffer_show_enable(struct device *dev,
 					   iio_buffer_show_enable,	\
 					   iio_buffer_store_enable)
 
-int iio_sw_buffer_preenable(struct iio_dev *indio_dev);
-
 bool iio_validate_scan_mask_onehot(struct iio_dev *indio_dev,
 	const unsigned long *mask);
 
-- 
1.8.0

