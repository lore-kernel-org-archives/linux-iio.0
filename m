Return-Path: <linux-iio-owner@vger.kernel.org>
Received: from saturn.retrosnub.co.uk ([178.18.118.26]:60138 "EHLO
	saturn.retrosnub.co.uk" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1754376Ab2ESPHF (ORCPT
	<rfc822;linux-iio@vger.kernel.org>); Sat, 19 May 2012 11:07:05 -0400
From: Jonathan Cameron <jic23@kernel.org>
To: linux-iio@vger.kernel.org
Cc: lars@metafoo.de, stefani@seibold.net, ggao@invensense.com,
	Jonathan Cameron <jic23@kernel.org>
Subject: [PATCH] iio:kfifo_buf  Take advantage of the fixed record size used in IIO
Date: Sat, 19 May 2012 12:14:05 +0100
Message-Id: <1337426045-6890-1-git-send-email-jic23@kernel.org>
Sender: linux-iio-owner@vger.kernel.org
List-Id: linux-iio@vger.kernel.org

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

This is an RFC as

a) I'm far from sure I got it right.
b) There is probably a better way of doing it!

Signed-off-by: Jonathan Cameron <jic23@kernel.org>
---
Note this is against current staging-next.


 drivers/iio/kfifo_buf.c |    7 ++++---
 1 file changed, 4 insertions(+), 3 deletions(-)

diff --git a/drivers/iio/kfifo_buf.c b/drivers/iio/kfifo_buf.c
index 6bf9d05..74b1cb8 100644
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
@@ -94,7 +95,7 @@ static int iio_store_to_kfifo(struct iio_buffer *r,
 {
 	int ret;
 	struct iio_kfifo *kf = iio_to_kfifo(r);
-	ret = kfifo_in(&kf->kf, data, r->bytes_per_datum);
+	ret = __kfifo_in((struct __kfifo *)&kf->kf, data, r->bytes_per_datum);
 	if (ret != r->bytes_per_datum)
 		return -EBUSY;
 	return 0;
@@ -110,7 +111,7 @@ static int iio_read_first_n_kfifo(struct iio_buffer *r,
 		return -EINVAL;
 
 	n = rounddown(n, r->bytes_per_datum);
-	ret = kfifo_to_user(&kf->kf, buf, n, &copied);
+	ret = __kfifo_to_user((struct __kfifo *)&kf->kf, buf, n, &copied);
 
 	return copied;
 }
-- 
1.7.10.2

