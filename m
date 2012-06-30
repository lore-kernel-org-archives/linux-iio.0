Return-Path: <jic23@hermes.cam.ac.uk>
From: Jonathan Cameron <jic23@kernel.org>
To: linux-iio@vger.kernel.org
Cc: Jonathan Cameron <jic23@kernel.org>
Subject: [PATCH 2/2] iio: kfifo - add poll support.
Date: Sat, 30 Jun 2012 13:52:43 +0100
Message-Id: <1341060763-9602-3-git-send-email-jic23@kernel.org>
In-Reply-To: <1341060763-9602-1-git-send-email-jic23@kernel.org>
References: <1341060763-9602-1-git-send-email-jic23@kernel.org>
Sender: "J.I. Cameron" <jic23@hermes.cam.ac.uk>
List-ID: <linux-iio@vger.kernel.org>

This buffer implementation was missing poll support.

Signed-off-by: Jonathan Cameron <jic23@kernel.org>
---
 drivers/iio/kfifo_buf.c | 15 ++++++++++++++-
 1 file changed, 14 insertions(+), 1 deletion(-)

diff --git a/drivers/iio/kfifo_buf.c b/drivers/iio/kfifo_buf.c
index 6ec763f..63da424 100644
--- a/drivers/iio/kfifo_buf.c
+++ b/drivers/iio/kfifo_buf.c
@@ -6,6 +6,7 @@
 #include <linux/kfifo.h>
 #include <linux/mutex.h>
 #include <linux/iio/kfifo_buf.h>
+#include <linux/sched.h>
 
 struct iio_kfifo {
 	struct iio_buffer buffer;
@@ -36,6 +37,7 @@ static int iio_request_update_kfifo(struct iio_buffer *r)
 	kfifo_free(&buf->kf);
 	ret = __iio_allocate_kfifo(buf, buf->buffer.bytes_per_datum,
 				   buf->buffer.length);
+	r->stufftoread = false;
 error_ret:
 	return ret;
 }
@@ -82,6 +84,9 @@ static int iio_set_bytes_per_datum_kfifo(struct iio_buffer *r, size_t bpd)
 
 static int iio_set_length_kfifo(struct iio_buffer *r, int length)
 {
+	/* Avoid an invalid state */
+	if (length < 2)
+		length = 2;
 	if (r->length != length) {
 		r->length = length;
 		iio_mark_update_needed_kfifo(r);
@@ -98,6 +103,8 @@ static int iio_store_to_kfifo(struct iio_buffer *r,
 	ret = kfifo_in(&kf->kf, data, 1);
 	if (ret != 1)
 		return -EBUSY;
+	r->stufftoread = true;
+	wake_up_interruptible(&r->pollq);
 
 	return 0;
 }
@@ -115,6 +122,12 @@ static int iio_read_first_n_kfifo(struct iio_buffer *r,
 	if (ret < 0)
 		return ret;
 
+	if (kfifo_is_empty(&kf->kf))
+		r->stufftoread = false;
+	/* verify it is still empty to avoid race */
+	if (!kfifo_is_empty(&kf->kf))
+		r->stufftoread = true;
+
 	return copied;
 }
 
@@ -139,7 +152,7 @@ struct iio_buffer *iio_kfifo_allocate(struct iio_dev *indio_dev)
 	iio_buffer_init(&kf->buffer);
 	kf->buffer.attrs = &iio_kfifo_attribute_group;
 	kf->buffer.access = &kfifo_access_funcs;
-
+	kf->buffer.length = 2;
 	return &kf->buffer;
 }
 EXPORT_SYMBOL(iio_kfifo_allocate);
-- 
1.7.11.1
