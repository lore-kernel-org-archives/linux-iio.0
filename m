Return-Path: <linux-iio-owner@vger.kernel.org>
Received: from rere.qmqm.pl ([89.167.52.164]:34128 "EHLO rere.qmqm.pl"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1758951Ab3EDN1n (ORCPT <rfc822;linux-iio@vger.kernel.org>);
	Sat, 4 May 2013 09:27:43 -0400
Message-Id: <69bda5c45bbe03d8e6164ec1a737d93e195c7004.1367671597.git.mirq-linux@rere.qmqm.pl>
From: =?UTF-8?q?Micha=C5=82=20Miros=C5=82aw?= <mirq-linux@rere.qmqm.pl>
Subject: [PATCH] iio: fix memleak in iio_cb_buffer handling
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
To: linux-iio@vger.kernel.org
Cc: Jonathan Cameron <jic23@cam.ac.uk>
Date: Sat,  4 May 2013 15:19:35 +0200 (CEST)
Sender: linux-iio-owner@vger.kernel.org
List-Id: linux-iio@vger.kernel.org

iio_channel_get_all_cb() was not releasing cb_buff->buffer.scan_mask on error
path. Neither was iio_channel_release_all_cb(). Fix this by using single
allocation for entire iio_cb_buffer data.

Signed-off-by: Michał Mirosław <mirq-linux@rere.qmqm.pl>
---

Compile tested only.

 drivers/iio/buffer_cb.c |   32 +++++++++++++++-----------------
 1 file changed, 15 insertions(+), 17 deletions(-)

diff --git a/drivers/iio/buffer_cb.c b/drivers/iio/buffer_cb.c
index 9201022..6fcac0a 100644
--- a/drivers/iio/buffer_cb.c
+++ b/drivers/iio/buffer_cb.c
@@ -10,6 +10,7 @@ struct iio_cb_buffer {
 	int (*cb)(u8 *data, void *private);
 	void *private;
 	struct iio_channel *channels;
+	unsigned long scan_mask[0];
 };
 
 static int iio_buffer_cb_store_to(struct iio_buffer *buffer, u8 *data)
@@ -35,32 +36,30 @@ struct iio_cb_buffer *iio_channel_get_all_cb(struct device *dev,
 	struct iio_dev *indio_dev;
 	struct iio_channel *chan;
 
-	cb_buff = kzalloc(sizeof(*cb_buff), GFP_KERNEL);
+	chan = iio_channel_get_all(dev);
+	if (IS_ERR(chan)) {
+		ret = PTR_ERR(chan);
+		goto error_ret;
+	}
+
+	indio_dev = chan->indio_dev;
+
+	cb_buff = kzalloc(sizeof(*cb_buff) +
+		BITS_TO_LONGS(indio_dev->masklength) * sizeof(long),
+		GFP_KERNEL);
 	if (cb_buff == NULL) {
+		iio_channel_release_all(chan);
 		ret = -ENOMEM;
 		goto error_ret;
 	}
 
+	cb_buff->channels = chan;
 	cb_buff->private = private;
 	cb_buff->cb = cb;
 	cb_buff->buffer.access = &iio_cb_access;
 	INIT_LIST_HEAD(&cb_buff->buffer.demux_list);
+	cb_buff->buffer.scan_mask = cb_buff->scan_mask;
 
-	cb_buff->channels = iio_channel_get_all(dev);
-	if (IS_ERR(cb_buff->channels)) {
-		ret = PTR_ERR(cb_buff->channels);
-		goto error_free_cb_buff;
-	}
-
-	indio_dev = cb_buff->channels[0].indio_dev;
-	cb_buff->buffer.scan_mask
-		= kcalloc(BITS_TO_LONGS(indio_dev->masklength), sizeof(long),
-			  GFP_KERNEL);
-	if (cb_buff->buffer.scan_mask == NULL) {
-		ret = -ENOMEM;
-		goto error_release_channels;
-	}
-	chan = &cb_buff->channels[0];
 	while (chan->indio_dev) {
 		if (chan->indio_dev != indio_dev) {
 			ret = -EINVAL;
@@ -75,7 +74,6 @@ struct iio_cb_buffer *iio_channel_get_all_cb(struct device *dev,
 
 error_release_channels:
 	iio_channel_release_all(cb_buff->channels);
-error_free_cb_buff:
 	kfree(cb_buff);
 error_ret:
 	return ERR_PTR(ret);

