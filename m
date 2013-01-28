Return-Path: <linux-iio-owner@vger.kernel.org>
Received: from smtp-out-080.synserver.de ([212.40.185.80]:1147 "EHLO
	smtp-out-080.synserver.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1754442Ab3A1KL3 (ORCPT
	<rfc822;linux-iio@vger.kernel.org>); Mon, 28 Jan 2013 05:11:29 -0500
From: Lars-Peter Clausen <lars@metafoo.de>
To: Jonathan Cameron <jic23@cam.ac.uk>
Cc: linux-iio@vger.kernel.org, Lars-Peter Clausen <lars@metafoo.de>
Subject: [PATCH] staging:iio: Remove noop call to __iio_update_buffer
Date: Mon, 28 Jan 2013 11:12:18 +0100
Message-Id: <1359367938-26398-1-git-send-email-lars@metafoo.de>
Sender: linux-iio-owner@vger.kernel.org
List-Id: linux-iio@vger.kernel.org

__iio_update_buffer updates the buffer's bytes_per_datum and length fields.
But the only user of this function just passes in these exact fields, so the
call basically looks like this:

	buffer->bytes_per_datum = buffer->bytes_per_datum;
	buffer->length = buffer->length;

Which means it is a noop and can be removed. Also remove the function itself,
since it is now unused.

Signed-off-by: Lars-Peter Clausen <lars@metafoo.de>
---
 drivers/iio/kfifo_buf.c    |  1 -
 include/linux/iio/buffer.h | 13 -------------
 2 files changed, 14 deletions(-)

diff --git a/drivers/iio/kfifo_buf.c b/drivers/iio/kfifo_buf.c
index 5bc5c86..a923c78 100644
--- a/drivers/iio/kfifo_buf.c
+++ b/drivers/iio/kfifo_buf.c
@@ -22,7 +22,6 @@ static inline int __iio_allocate_kfifo(struct iio_kfifo *buf,
 	if ((length == 0) || (bytes_per_datum == 0))
 		return -EINVAL;
 
-	__iio_update_buffer(&buf->buffer, bytes_per_datum, length);
 	return __kfifo_alloc((struct __kfifo *)&buf->kf, length,
 			     bytes_per_datum, GFP_KERNEL);
 }
diff --git a/include/linux/iio/buffer.h b/include/linux/iio/buffer.h
index f3eea18..2bac0eb 100644
--- a/include/linux/iio/buffer.h
+++ b/include/linux/iio/buffer.h
@@ -103,19 +103,6 @@ int iio_update_buffers(struct iio_dev *indio_dev,
  **/
 void iio_buffer_init(struct iio_buffer *buffer);
 
-/**
- * __iio_update_buffer() - update common elements of buffers
- * @buffer:		buffer that is the event source
- * @bytes_per_datum:	size of individual datum including timestamp
- * @length:		number of datums in buffer
- **/
-static inline void __iio_update_buffer(struct iio_buffer *buffer,
-				       int bytes_per_datum, int length)
-{
-	buffer->bytes_per_datum = bytes_per_datum;
-	buffer->length = length;
-}
-
 int iio_scan_mask_query(struct iio_dev *indio_dev,
 			struct iio_buffer *buffer, int bit);
 
-- 
1.8.0

