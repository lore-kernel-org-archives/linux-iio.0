Return-Path: <jic23@hermes.cam.ac.uk>
From: Jonathan Cameron <jic23@kernel.org>
To: linux-iio@vger.kernel.org,
	greg@kroah.com
Cc: lars@metafoo.de,
	Jonathan Cameron <jic23@kernel.org>
Subject: [PATCH 15/19] staging:iio:ring_sw don't provide read last function.
Date: Mon,  5 Dec 2011 22:18:26 +0000
Message-Id: <1323123510-21388-16-git-send-email-jic23@kernel.org>
In-Reply-To: <1323123510-21388-1-git-send-email-jic23@kernel.org>
References: <1323123510-21388-1-git-send-email-jic23@kernel.org>
Sender: "J.I. Cameron" <jic23@hermes.cam.ac.uk>
List-ID: <linux-iio@vger.kernel.org>

No longer needed as we don't have drivers providing sysfs access
to buffered data.

Signed-off-by: Jonathan Cameron <jic23@kernel.org>
Acked-by: Lars-Peter Clausen <lars@metafoo.de>
---
 drivers/staging/iio/ring_sw.c |   33 ---------------------------------
 1 files changed, 0 insertions(+), 33 deletions(-)

diff --git a/drivers/staging/iio/ring_sw.c b/drivers/staging/iio/ring_sw.c
index 98fe819..37d26e6 100644
--- a/drivers/staging/iio/ring_sw.c
+++ b/drivers/staging/iio/ring_sw.c
@@ -23,7 +23,6 @@
  * @data:		the ring buffer memory
  * @read_p:		read pointer (oldest available)
  * @write_p:		write pointer
- * @last_written_p:	read pointer (newest available)
  * @half_p:		half buffer length behind write_p (event generation)
  * @use_count:		reference count to prevent resizing when in use
  * @update_needed:	flag to indicated change in size requested
@@ -37,7 +36,6 @@ struct iio_sw_ring_buffer {
 	unsigned char		*data;
 	unsigned char		*read_p;
 	unsigned char		*write_p;
-	unsigned char		*last_written_p;
 	/* used to act as a point at which to signal an event */
 	unsigned char		*half_p;
 	int			use_count;
@@ -56,7 +54,6 @@ static inline int __iio_allocate_sw_ring_buffer(struct iio_sw_ring_buffer *ring,
 	ring->data = kmalloc(length*ring->buf.bytes_per_datum, GFP_ATOMIC);
 	ring->read_p = NULL;
 	ring->write_p = NULL;
-	ring->last_written_p = NULL;
 	ring->half_p = NULL;
 	return ring->data ? 0 : -ENOMEM;
 }
@@ -115,7 +112,6 @@ static int iio_store_to_sw_ring(struct iio_sw_ring_buffer *ring,
 	 * Always valid as either points to latest or second latest value.
 	 * Before this runs it is null and read attempts fail with -EAGAIN.
 	 */
-	ring->last_written_p = ring->write_p;
 	barrier();
 	/* temp_ptr used to ensure we never have an invalid pointer
 	 * it may be slightly lagging, but never invalid
@@ -305,34 +301,6 @@ static int iio_store_to_sw_rb(struct iio_buffer *r,
 	return iio_store_to_sw_ring(ring, data, timestamp);
 }
 
-static int iio_read_last_from_sw_ring(struct iio_sw_ring_buffer *ring,
-				      unsigned char *data)
-{
-	unsigned char *last_written_p_copy;
-
-	iio_mark_sw_rb_in_use(&ring->buf);
-again:
-	barrier();
-	last_written_p_copy = ring->last_written_p;
-	barrier(); /*unnessecary? */
-	/* Check there is anything here */
-	if (last_written_p_copy == NULL)
-		return -EAGAIN;
-	memcpy(data, last_written_p_copy, ring->buf.bytes_per_datum);
-
-	if (unlikely(ring->last_written_p != last_written_p_copy))
-		goto again;
-
-	iio_unmark_sw_rb_in_use(&ring->buf);
-	return 0;
-}
-
-static int iio_read_last_from_sw_rb(struct iio_buffer *r,
-			     unsigned char *data)
-{
-	return iio_read_last_from_sw_ring(iio_to_sw_ring(r), data);
-}
-
 static int iio_request_update_sw_rb(struct iio_buffer *r)
 {
 	int ret = 0;
@@ -435,7 +403,6 @@ const struct iio_buffer_access_funcs ring_sw_access_funcs = {
 	.mark_in_use = &iio_mark_sw_rb_in_use,
 	.unmark_in_use = &iio_unmark_sw_rb_in_use,
 	.store_to = &iio_store_to_sw_rb,
-	.read_last = &iio_read_last_from_sw_rb,
 	.read_first_n = &iio_read_first_n_sw_rb,
 	.mark_param_change = &iio_mark_update_needed_sw_rb,
 	.request_update = &iio_request_update_sw_rb,
-- 
1.7.7.4
