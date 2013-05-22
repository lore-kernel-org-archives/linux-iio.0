Return-Path: <linux-iio-owner@vger.kernel.org>
Received: from saturn.retrosnub.co.uk ([178.18.118.26]:39270 "EHLO
	saturn.retrosnub.co.uk" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1757250Ab3EVVl1 (ORCPT
	<rfc822;linux-iio@vger.kernel.org>); Wed, 22 May 2013 17:41:27 -0400
From: Jonathan Cameron <jic23@kernel.org>
To: linux-iio@vger.kernel.org
Cc: mirq-linux@rere.qmqm.pl, Jonathan Cameron <jic23@kernel.org>
Subject: [PATCH] iio:callback buffer: free the scan_mask
Date: Wed, 22 May 2013 22:41:17 +0100
Message-Id: <1369258877-7308-1-git-send-email-jic23@kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Sender: linux-iio-owner@vger.kernel.org
List-Id: linux-iio@vger.kernel.org

Reported-by: Michał Mirosław <mirq-linux@rere.qmqm.pl>
Signed-off-by: Jonathan Cameron <jic23@kernel.org>
---
As per original discussion I've now put together a minimal patch.
The rework suggested was reasonable but had no place in a fix patch.

 drivers/iio/buffer_cb.c | 5 ++++-
 1 file changed, 4 insertions(+), 1 deletion(-)

diff --git a/drivers/iio/buffer_cb.c b/drivers/iio/buffer_cb.c
index 9201022..9d19ba7 100644
--- a/drivers/iio/buffer_cb.c
+++ b/drivers/iio/buffer_cb.c
@@ -64,7 +64,7 @@ struct iio_cb_buffer *iio_channel_get_all_cb(struct device *dev,
 	while (chan->indio_dev) {
 		if (chan->indio_dev != indio_dev) {
 			ret = -EINVAL;
-			goto error_release_channels;
+			goto error_free_scan_mask;
 		}
 		set_bit(chan->channel->scan_index,
 			cb_buff->buffer.scan_mask);
@@ -73,6 +73,8 @@ struct iio_cb_buffer *iio_channel_get_all_cb(struct device *dev,
 
 	return cb_buff;
 
+error_free_scan_mask:
+	kfree(cb_buff->buffer.scan_mask);
 error_release_channels:
 	iio_channel_release_all(cb_buff->channels);
 error_free_cb_buff:
@@ -100,6 +102,7 @@ EXPORT_SYMBOL_GPL(iio_channel_stop_all_cb);
 
 void iio_channel_release_all_cb(struct iio_cb_buffer *cb_buff)
 {
+	kfree(cb_buff->buffer.scan_mask);
 	iio_channel_release_all(cb_buff->channels);
 	kfree(cb_buff);
 }
-- 
1.8.2.3

