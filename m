Return-Path: <lars@metafoo.de>
From: Lars-Peter Clausen <lars@metafoo.de>
To: Jonathan Cameron <jic23@kernel.org>
Cc: linux-iio@vger.kernel.org,
	Lars-Peter Clausen <lars@metafoo.de>
Subject: [PATCH 2/3] iio:kfifo: Empty buffer on update
Date: Mon, 14 Oct 2013 17:09:09 +0200
Message-Id: <1381763350-8930-2-git-send-email-lars@metafoo.de>
In-Reply-To: <1381763350-8930-1-git-send-email-lars@metafoo.de>
References: <1381763350-8930-1-git-send-email-lars@metafoo.de>
List-ID: <linux-iio@vger.kernel.org>

The kfifo's request_update callback will free the current buffer and allocate a
new one if the size has changed. This will remove any samples that might still
be left in the buffer. If the size has not changed the buffer content is
left untouched though. This is a bit inconsistent and might cause an application
to see data from a previous capture. This patch inserts a call to
kfifo_reset_out() when the size did not change. This makes sure that any pending
samples are removed from the buffer.

Note, due to a different bug the buffer is currently always re-allocated, even
if the size did not change. So this patch will not change the behavior. In the
next patch the bug will be fixed and this patch makes sure that the current
behavior is kept.

Signed-off-by: Lars-Peter Clausen <lars@metafoo.de>
---
 drivers/iio/kfifo_buf.c | 12 +++++++-----
 1 file changed, 7 insertions(+), 5 deletions(-)

diff --git a/drivers/iio/kfifo_buf.c b/drivers/iio/kfifo_buf.c
index b7f4617..a050b18 100644
--- a/drivers/iio/kfifo_buf.c
+++ b/drivers/iio/kfifo_buf.c
@@ -33,15 +33,17 @@ static int iio_request_update_kfifo(struct iio_buffer *r)
 	int ret = 0;
 	struct iio_kfifo *buf = iio_to_kfifo(r);
 
-	if (!buf->update_needed)
-		goto error_ret;
 	mutex_lock(&buf->user_lock);
-	kfifo_free(&buf->kf);
-	ret = __iio_allocate_kfifo(buf, buf->buffer.bytes_per_datum,
+	if (!buf->update_needed) {
+		kfifo_reset_out(&buf->kf);
+	} else {
+		kfifo_free(&buf->kf);
+		ret = __iio_allocate_kfifo(buf, buf->buffer.bytes_per_datum,
 				   buf->buffer.length);
+	}
 	r->stufftoread = false;
 	mutex_unlock(&buf->user_lock);
-error_ret:
+
 	return ret;
 }
 
-- 
1.8.0
