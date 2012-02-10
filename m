Return-Path: <lars@metafoo.de>
From: Lars-Peter Clausen <lars@metafoo.de>
To: Jonathan Cameron <jic23@kernel.org>
Cc: linux-iio@vger.kernel.org,
	Lars-Peter Clausen <lars@metafoo.de>
Subject: [PATCH 2/2] staging:iio: Remove noop calls to __iio_update_buffer
Date: Fri, 10 Feb 2012 19:24:29 +0100
Message-Id: <1328898269-26197-2-git-send-email-lars@metafoo.de>
In-Reply-To: <1328898269-26197-1-git-send-email-lars@metafoo.de>
References: <1328898269-26197-1-git-send-email-lars@metafoo.de>
List-ID: <linux-iio@vger.kernel.org>

__iio_update_buffer updates the buffer's bytes_per_datum and length attributes.
But in these two cases we indirectly just pass the existing values, so the call
becomes a noop and can be removed.

Signed-off-by: Lars-Peter Clausen <lars@metafoo.de>
---
We might as well also remove the function itself, since these are the only two
users. What do you think?
---
 drivers/staging/iio/kfifo_buf.c |    1 -
 drivers/staging/iio/ring_sw.c   |    1 -
 2 files changed, 0 insertions(+), 2 deletions(-)

diff --git a/drivers/staging/iio/kfifo_buf.c b/drivers/staging/iio/kfifo_buf.c
index 9f3bd59..468e202 100644
--- a/drivers/staging/iio/kfifo_buf.c
+++ b/drivers/staging/iio/kfifo_buf.c
@@ -22,7 +22,6 @@ static inline int __iio_allocate_kfifo(struct iio_kfifo *buf,
 	if ((length == 0) || (bytes_per_datum == 0))
 		return -EINVAL;
 
-	__iio_update_buffer(&buf->buffer, bytes_per_datum, length);
 	return kfifo_alloc(&buf->kf, bytes_per_datum*length, GFP_KERNEL);
 }
 
diff --git a/drivers/staging/iio/ring_sw.c b/drivers/staging/iio/ring_sw.c
index eeac0da..5664372 100644
--- a/drivers/staging/iio/ring_sw.c
+++ b/drivers/staging/iio/ring_sw.c
@@ -46,7 +46,6 @@ static inline int __iio_allocate_sw_ring_buffer(struct iio_sw_ring_buffer *ring,
 {
 	if ((length == 0) || (bytes_per_datum == 0))
 		return -EINVAL;
-	__iio_update_buffer(&ring->buf, bytes_per_datum, length);
 	ring->data = kmalloc(length*ring->buf.bytes_per_datum, GFP_ATOMIC);
 	ring->read_p = NULL;
 	ring->write_p = NULL;
-- 
1.7.9
