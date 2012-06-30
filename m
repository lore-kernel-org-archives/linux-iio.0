Return-Path: <jic23@hermes.cam.ac.uk>
From: Jonathan Cameron <jic23@kernel.org>
To: linux-iio@vger.kernel.org
Cc: Jonathan Cameron <jic23@kernel.org>
Subject: [PATCH 1/2] iio:kfifo_buf  Take advantage of the fixed record size used in IIO
Date: Sat, 30 Jun 2012 13:52:42 +0100
Message-Id: <1341060763-9602-2-git-send-email-jic23@kernel.org>
In-Reply-To: <1341060763-9602-1-git-send-email-jic23@kernel.org>
References: <1341060763-9602-1-git-send-email-jic23@kernel.org>
Sender: "J.I. Cameron" <jic23@hermes.cam.ac.uk>
List-ID: <linux-iio@vger.kernel.org>

By bypassing the standard macros for setting up the kfifo we can
take advantage of the fixed record size implementation without
having to have a type to pass in (from which the size of an element
is normally established).

In IIO we have variable 'scans' as our records in which any element
can be present or not.  They do not however vary when we are
actually filling or reading from the buffer.  Thus we have a fixed
record size whenever we are actually running.  As setup and tear
down are not in the fast path we can take the overhead of reinitializing
the kfifo every time.

Signed-off-by: Jonathan Cameron <jic23@kernel.org>
---
 drivers/iio/kfifo_buf.c | 13 ++++++++-----
 1 file changed, 8 insertions(+), 5 deletions(-)

diff --git a/drivers/iio/kfifo_buf.c b/drivers/iio/kfifo_buf.c
index 6bf9d05..6ec763f 100644
--- a/drivers/iio/kfifo_buf.c
+++ b/drivers/iio/kfifo_buf.c
@@ -22,7 +22,8 @@ static inline int __iio_allocate_kfifo(struct iio_kfifo *buf,
 		return -EINVAL;
 
 	__iio_update_buffer(&buf->buffer, bytes_per_datum, length);
-	return kfifo_alloc(&buf->kf, bytes_per_datum*length, GFP_KERNEL);
+	return __kfifo_alloc((struct __kfifo *)&buf->kf, length,
+			     bytes_per_datum, GFP_KERNEL);
 }
 
 static int iio_request_update_kfifo(struct iio_buffer *r)
@@ -94,9 +95,10 @@ static int iio_store_to_kfifo(struct iio_buffer *r,
 {
 	int ret;
 	struct iio_kfifo *kf = iio_to_kfifo(r);
-	ret = kfifo_in(&kf->kf, data, r->bytes_per_datum);
-	if (ret != r->bytes_per_datum)
+	ret = kfifo_in(&kf->kf, data, 1);
+	if (ret != 1)
 		return -EBUSY;
+
 	return 0;
 }
 
@@ -106,11 +108,12 @@ static int iio_read_first_n_kfifo(struct iio_buffer *r,
 	int ret, copied;
 	struct iio_kfifo *kf = iio_to_kfifo(r);
 
-	if (n < r->bytes_per_datum)
+	if (n < r->bytes_per_datum || r->bytes_per_datum == 0)
 		return -EINVAL;
 
-	n = rounddown(n, r->bytes_per_datum);
 	ret = kfifo_to_user(&kf->kf, buf, n, &copied);
+	if (ret < 0)
+		return ret;
 
 	return copied;
 }
-- 
1.7.11.1
