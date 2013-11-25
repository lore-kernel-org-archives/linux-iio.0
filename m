Return-Path: <linux-iio-owner@vger.kernel.org>
Received: from smtp-out-048.synserver.de ([212.40.185.48]:1250 "EHLO
	smtp-out-025.synserver.de" rhost-flags-OK-OK-OK-FAIL)
	by vger.kernel.org with ESMTP id S1756891Ab3KYO4c (ORCPT
	<rfc822;linux-iio@vger.kernel.org>); Mon, 25 Nov 2013 09:56:32 -0500
From: Lars-Peter Clausen <lars@metafoo.de>
To: Jonathan Cameron <jic23@kernel.org>
Cc: linux-iio@vger.kernel.org, Lars-Peter Clausen <lars@metafoo.de>
Subject: [PATCH 2/3] iio: kfifo_buf: Implement data_available() callback
Date: Mon, 25 Nov 2013 15:56:43 +0100
Message-Id: <1385391404-3112-2-git-send-email-lars@metafoo.de>
In-Reply-To: <1385391404-3112-1-git-send-email-lars@metafoo.de>
References: <1385391404-3112-1-git-send-email-lars@metafoo.de>
Sender: linux-iio-owner@vger.kernel.org
List-Id: linux-iio@vger.kernel.org

This patch implements the data_available() callback for the kfifo buffer instead
of using the stufftoread flag. The kfifo used by the buffer already knows
whether it is empty or not based on the position of its read and write pointer.
Using this makes it a lot easier to tell whether data is available or not and it
is not necessary to take special measures to ensure that no race conditions
between reading and writing from the buffer occur.

Note, that we still have to take the buffers lock to protect against concurrent
resizeing of the kfifo.

Signed-off-by: Lars-Peter Clausen <lars@metafoo.de>
---
 drivers/iio/kfifo_buf.c | 23 ++++++++++++++---------
 1 file changed, 14 insertions(+), 9 deletions(-)

diff --git a/drivers/iio/kfifo_buf.c b/drivers/iio/kfifo_buf.c
index 95c6fc8..7134e8a 100644
--- a/drivers/iio/kfifo_buf.c
+++ b/drivers/iio/kfifo_buf.c
@@ -42,7 +42,6 @@ static int iio_request_update_kfifo(struct iio_buffer *r)
 	} else {
 		kfifo_reset_out(&buf->kf);
 	}
-	r->stufftoread = false;
 	mutex_unlock(&buf->user_lock);
 
 	return ret;
@@ -108,7 +107,7 @@ static int iio_store_to_kfifo(struct iio_buffer *r,
 	ret = kfifo_in(&kf->kf, data, 1);
 	if (ret != 1)
 		return -EBUSY;
-	r->stufftoread = true;
+
 	wake_up_interruptible_poll(&r->pollq, POLLIN | POLLRDNORM);
 
 	return 0;
@@ -127,13 +126,6 @@ static int iio_read_first_n_kfifo(struct iio_buffer *r,
 		ret = -EINVAL;
 	else
 		ret = kfifo_to_user(&kf->kf, buf, n, &copied);
-
-	if (kfifo_is_empty(&kf->kf))
-		r->stufftoread = false;
-	/* verify it is still empty to avoid race */
-	if (!kfifo_is_empty(&kf->kf))
-		r->stufftoread = true;
-
 	mutex_unlock(&kf->user_lock);
 	if (ret < 0)
 		return ret;
@@ -141,6 +133,18 @@ static int iio_read_first_n_kfifo(struct iio_buffer *r,
 	return copied;
 }
 
+static bool iio_kfifo_buf_data_available(struct iio_buffer *r)
+{
+	struct iio_kfifo *kf = iio_to_kfifo(r);
+	bool empty;
+
+	mutex_lock(&kf->user_lock);
+	empty = kfifo_is_empty(&kf->kf);
+	mutex_unlock(&kf->user_lock);
+
+	return !empty;
+}
+
 static void iio_kfifo_buffer_release(struct iio_buffer *buffer)
 {
 	struct iio_kfifo *kf = iio_to_kfifo(buffer);
@@ -153,6 +157,7 @@ static void iio_kfifo_buffer_release(struct iio_buffer *buffer)
 static const struct iio_buffer_access_funcs kfifo_access_funcs = {
 	.store_to = &iio_store_to_kfifo,
 	.read_first_n = &iio_read_first_n_kfifo,
+	.data_available = iio_kfifo_buf_data_available,
 	.request_update = &iio_request_update_kfifo,
 	.get_bytes_per_datum = &iio_get_bytes_per_datum_kfifo,
 	.set_bytes_per_datum = &iio_set_bytes_per_datum_kfifo,
-- 
1.8.0

