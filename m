Return-Path: <linux-iio-owner@vger.kernel.org>
Received: from mail-pf0-f194.google.com ([209.85.192.194]:35969 "EHLO
	mail-pf0-f194.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752533AbcG2IhE (ORCPT
	<rfc822;linux-iio@vger.kernel.org>); Fri, 29 Jul 2016 04:37:04 -0400
Received: by mail-pf0-f194.google.com with SMTP id y134so5107602pfg.3
        for <linux-iio@vger.kernel.org>; Fri, 29 Jul 2016 01:37:02 -0700 (PDT)
From: Matt Ranostay <mranostay@gmail.com>
To: linux-iio@vger.kernel.org
Cc: jic23@kernel.org, Matt Ranostay <mranostay@gmail.com>
Subject: [RFC v3 1/3] iio: buffer-callback: allow getting underlying iio_dev
Date: Fri, 29 Jul 2016 01:36:50 -0700
Message-Id: <1469781412-29686-2-git-send-email-mranostay@gmail.com>
In-Reply-To: <1469781412-29686-1-git-send-email-mranostay@gmail.com>
References: <1469781412-29686-1-git-send-email-mranostay@gmail.com>
Sender: linux-iio-owner@vger.kernel.org
List-Id: linux-iio@vger.kernel.org

Add iio_channel_cb_get_iio_dev function to allow getting the
underlying iio_dev. This is useful for setting the trigger of the
consumer ADC device.

Signed-off-by: Matt Ranostay <mranostay@gmail.com>
---
 drivers/iio/buffer/industrialio-buffer-cb.c | 24 ++++++++++++++----------
 include/linux/iio/consumer.h                | 12 ++++++++++++
 2 files changed, 26 insertions(+), 10 deletions(-)

diff --git a/drivers/iio/buffer/industrialio-buffer-cb.c b/drivers/iio/buffer/industrialio-buffer-cb.c
index 323079c3ccce..b8f550e47d3d 100644
--- a/drivers/iio/buffer/industrialio-buffer-cb.c
+++ b/drivers/iio/buffer/industrialio-buffer-cb.c
@@ -18,6 +18,7 @@ struct iio_cb_buffer {
 	int (*cb)(const void *data, void *private);
 	void *private;
 	struct iio_channel *channels;
+	struct iio_dev *indio_dev;
 };
 
 static struct iio_cb_buffer *buffer_to_cb_buffer(struct iio_buffer *buffer)
@@ -52,7 +53,6 @@ struct iio_cb_buffer *iio_channel_get_all_cb(struct device *dev,
 {
 	int ret;
 	struct iio_cb_buffer *cb_buff;
-	struct iio_dev *indio_dev;
 	struct iio_channel *chan;
 
 	cb_buff = kzalloc(sizeof(*cb_buff), GFP_KERNEL);
@@ -72,17 +72,17 @@ struct iio_cb_buffer *iio_channel_get_all_cb(struct device *dev,
 		goto error_free_cb_buff;
 	}
 
-	indio_dev = cb_buff->channels[0].indio_dev;
+	cb_buff->indio_dev = cb_buff->channels[0].indio_dev;
 	cb_buff->buffer.scan_mask
-		= kcalloc(BITS_TO_LONGS(indio_dev->masklength), sizeof(long),
-			  GFP_KERNEL);
+		= kcalloc(BITS_TO_LONGS(cb_buff->indio_dev->masklength),
+			  sizeof(long), GFP_KERNEL);
 	if (cb_buff->buffer.scan_mask == NULL) {
 		ret = -ENOMEM;
 		goto error_release_channels;
 	}
 	chan = &cb_buff->channels[0];
 	while (chan->indio_dev) {
-		if (chan->indio_dev != indio_dev) {
+		if (chan->indio_dev != cb_buff->indio_dev) {
 			ret = -EINVAL;
 			goto error_free_scan_mask;
 		}
@@ -105,17 +105,14 @@ EXPORT_SYMBOL_GPL(iio_channel_get_all_cb);
 
 int iio_channel_start_all_cb(struct iio_cb_buffer *cb_buff)
 {
-	return iio_update_buffers(cb_buff->channels[0].indio_dev,
-				  &cb_buff->buffer,
+	return iio_update_buffers(cb_buff->indio_dev, &cb_buff->buffer,
 				  NULL);
 }
 EXPORT_SYMBOL_GPL(iio_channel_start_all_cb);
 
 void iio_channel_stop_all_cb(struct iio_cb_buffer *cb_buff)
 {
-	iio_update_buffers(cb_buff->channels[0].indio_dev,
-			   NULL,
-			   &cb_buff->buffer);
+	iio_update_buffers(cb_buff->indio_dev, NULL, &cb_buff->buffer);
 }
 EXPORT_SYMBOL_GPL(iio_channel_stop_all_cb);
 
@@ -133,6 +130,13 @@ struct iio_channel
 }
 EXPORT_SYMBOL_GPL(iio_channel_cb_get_channels);
 
+struct iio_dev
+*iio_channel_cb_get_iio_dev(const struct iio_cb_buffer *cb_buffer)
+{
+	return cb_buffer->indio_dev;
+}
+EXPORT_SYMBOL_GPL(iio_channel_cb_get_iio_dev);
+
 MODULE_AUTHOR("Jonathan Cameron <jic23@kernel.org>");
 MODULE_DESCRIPTION("Industrial I/O callback buffer");
 MODULE_LICENSE("GPL");
diff --git a/include/linux/iio/consumer.h b/include/linux/iio/consumer.h
index 3d672f72e7ec..9edccfba1ffb 100644
--- a/include/linux/iio/consumer.h
+++ b/include/linux/iio/consumer.h
@@ -165,6 +165,18 @@ struct iio_channel
 *iio_channel_cb_get_channels(const struct iio_cb_buffer *cb_buffer);
 
 /**
+ * iio_channel_cb_get_iio_dev() - get access to the underlying device.
+ * @cb_buffer:		The callback buffer from whom we want the device
+ *			information.
+ *
+ * This function allows one to obtain information about the device.
+ * The primary aim is to allow drivers that are consuming a device to query
+ * things like current trigger.
+ */
+struct iio_dev
+*iio_channel_cb_get_iio_dev(const struct iio_cb_buffer *cb_buffer);
+
+/**
  * iio_read_channel_raw() - read from a given channel
  * @chan:		The channel being queried.
  * @val:		Value read back.
-- 
2.7.4

