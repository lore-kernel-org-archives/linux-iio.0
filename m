Return-Path: <linux-iio-owner@vger.kernel.org>
Received: from tarvos.retrosnub.co.uk ([217.168.153.95]:60340 "EHLO
        tarvos.retrosnub.co.uk" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S933923AbdABT25 (ORCPT
        <rfc822;linux-iio@vger.kernel.org>); Mon, 2 Jan 2017 14:28:57 -0500
From: Jonathan Cameron <jic23@kernel.org>
To: linux-iio@vger.kernel.org
Cc: Daniel Baluta <daniel.baluta@gmail.com>,
        Hartmut Knaack <knaack.h@gmx.de>,
        Lars-Peter Clausen <lars@metafoo.de>,
        Peter Meerwald-Stadler <pmeerw@pmeerw.net>,
        Jonathan Cameron <jic23@kernel.org>
Subject: [PATCH 04/11] iio:buffer: Stop exporting iio_scan_mask_query
Date: Mon,  2 Jan 2017 19:28:27 +0000
Message-Id: <20170102192834.26546-5-jic23@kernel.org>
In-Reply-To: <20170102192834.26546-1-jic23@kernel.org>
References: <20170102192834.26546-1-jic23@kernel.org>
Sender: linux-iio-owner@vger.kernel.org
List-Id: linux-iio@vger.kernel.org

Nothing uses it outside of core code.

Signed-off-by: Jonathan Cameron <jic23@kernel.org>
---
 drivers/iio/industrialio-buffer.c | 27 +++++++++++++--------------
 include/linux/iio/buffer.h        |  3 ---
 2 files changed, 13 insertions(+), 17 deletions(-)

diff --git a/drivers/iio/industrialio-buffer.c b/drivers/iio/industrialio-buffer.c
index 831537cc9500..5eb991b24dff 100644
--- a/drivers/iio/industrialio-buffer.c
+++ b/drivers/iio/industrialio-buffer.c
@@ -358,6 +358,19 @@ static int iio_scan_mask_clear(struct iio_buffer *buffer, int bit)
 	return 0;
 }
 
+static int iio_scan_mask_query(struct iio_dev *indio_dev,
+			       struct iio_buffer *buffer, int bit)
+{
+	if (bit > indio_dev->masklength)
+		return -EINVAL;
+
+	if (!buffer->scan_mask)
+		return 0;
+
+	/* Ensure return value is 0 or 1. */
+	return !!test_bit(bit, buffer->scan_mask);
+};
+
 static ssize_t iio_scan_el_store(struct device *dev,
 				 struct device_attribute *attr,
 				 const char *buf,
@@ -1340,20 +1353,6 @@ bool iio_validate_scan_mask_onehot(struct iio_dev *indio_dev,
 }
 EXPORT_SYMBOL_GPL(iio_validate_scan_mask_onehot);
 
-int iio_scan_mask_query(struct iio_dev *indio_dev,
-			struct iio_buffer *buffer, int bit)
-{
-	if (bit > indio_dev->masklength)
-		return -EINVAL;
-
-	if (!buffer->scan_mask)
-		return 0;
-
-	/* Ensure return value is 0 or 1. */
-	return !!test_bit(bit, buffer->scan_mask);
-};
-EXPORT_SYMBOL_GPL(iio_scan_mask_query);
-
 static const void *iio_demux(struct iio_buffer *buffer,
 				 const void *datain)
 {
diff --git a/include/linux/iio/buffer.h b/include/linux/iio/buffer.h
index 30ea9806db67..635aa87eb5e9 100644
--- a/include/linux/iio/buffer.h
+++ b/include/linux/iio/buffer.h
@@ -161,9 +161,6 @@ int iio_update_buffers(struct iio_dev *indio_dev,
  **/
 void iio_buffer_init(struct iio_buffer *buffer);
 
-int iio_scan_mask_query(struct iio_dev *indio_dev,
-			struct iio_buffer *buffer, int bit);
-
 /**
  * iio_push_to_buffers() - push to a registered buffer.
  * @indio_dev:		iio_dev structure for device.
-- 
2.11.0

