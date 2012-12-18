Return-Path: <linux-iio-owner@vger.kernel.org>
Received: from mail-wg0-f42.google.com ([74.125.82.42]:61015 "EHLO
	mail-wg0-f42.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1754773Ab2LRXvl (ORCPT
	<rfc822;linux-iio@vger.kernel.org>); Tue, 18 Dec 2012 18:51:41 -0500
Received: by mail-wg0-f42.google.com with SMTP id dr1so8149wgb.5
        for <linux-iio@vger.kernel.org>; Tue, 18 Dec 2012 15:51:40 -0800 (PST)
From: Cong Ding <dinggnu@gmail.com>
To: Jonathan Cameron <jic23@cam.ac.uk>,
	Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
	linux-iio@vger.kernel.org, devel@driverdev.osuosl.org,
	linux-kernel@vger.kernel.org
Cc: Cong Ding <dinggnu@gmail.com>
Subject: [PATCH] staging: iio: cleanup ring_sw.c
Date: Wed, 19 Dec 2012 00:39:59 +0100
Message-Id: <1355873999-32098-1-git-send-email-dinggnu@gmail.com>
Sender: linux-iio-owner@vger.kernel.org
List-Id: linux-iio@vger.kernel.org

clean the checkpatch warnings in ring_sw.c. mostly are 80 characters per line
issue.

Signed-off-by: Cong Ding <dinggnu@gmail.com>
---
 drivers/staging/iio/ring_sw.c |   25 ++++++++++++++-----------
 1 file changed, 14 insertions(+), 11 deletions(-)

diff --git a/drivers/staging/iio/ring_sw.c b/drivers/staging/iio/ring_sw.c
index 3a45f9a..4db1cc3 100644
--- a/drivers/staging/iio/ring_sw.c
+++ b/drivers/staging/iio/ring_sw.c
@@ -77,7 +77,8 @@ static int iio_store_to_sw_ring(struct iio_sw_ring_buffer *ring,
 		 * as long as the read pointer is valid before this
 		 * passes it - guaranteed as set later in this function.
 		 */
-		ring->half_p = ring->data - ring->buf.length*ring->buf.bytes_per_datum/2;
+		ring->half_p = ring->data -
+			ring->buf.length*ring->buf.bytes_per_datum/2;
 	}
 	/* Copy data to where ever the current write pointer says */
 	memcpy(ring->write_p, data, ring->buf.bytes_per_datum);
@@ -112,8 +113,8 @@ static int iio_store_to_sw_ring(struct iio_sw_ring_buffer *ring,
 	else if (ring->write_p == ring->read_p) {
 		change_test_ptr = ring->read_p;
 		temp_ptr = change_test_ptr + ring->buf.bytes_per_datum;
-		if (temp_ptr
-		    == ring->data + ring->buf.length*ring->buf.bytes_per_datum) {
+		if (temp_ptr == ring->data +
+		    ring->buf.length*ring->buf.bytes_per_datum) {
 			temp_ptr = ring->data;
 		}
 		/* We are moving pointer on one because the ring is full.  Any
@@ -127,7 +128,8 @@ static int iio_store_to_sw_ring(struct iio_sw_ring_buffer *ring,
 	 * simultaneous read */
 	/* Also need to use loop count to ensure this only happens once */
 	ring->half_p += ring->buf.bytes_per_datum;
-	if (ring->half_p == ring->data + ring->buf.length*ring->buf.bytes_per_datum)
+	if (ring->half_p == ring->data +
+			ring->buf.length*ring->buf.bytes_per_datum)
 		ring->half_p = ring->data;
 	if (ring->half_p == ring->read_p) {
 		ring->buf.stufftoread = true;
@@ -153,7 +155,8 @@ static int iio_read_first_n_sw_rb(struct iio_buffer *r,
 	if (n % ring->buf.bytes_per_datum) {
 		ret = -EINVAL;
 		printk(KERN_INFO "Ring buffer read request not whole number of"
-		       "samples: Request bytes %zd, Current bytes per datum %d\n",
+		       "samples: Request bytes %zd, Current bytes per"
+		       "datum %d\n",
 		       n, ring->buf.bytes_per_datum);
 		goto error_ret;
 	}
@@ -193,7 +196,8 @@ static int iio_read_first_n_sw_rb(struct iio_buffer *r,
 	if (initial_write_p >= initial_read_p)
 		data_available = initial_write_p - initial_read_p;
 	else
-		data_available = buffer_size - (initial_read_p - initial_write_p);
+		data_available = buffer_size -
+			(initial_read_p - initial_write_p);
 
 	if (data_available < bytes_to_rip)
 		bytes_to_rip = data_available;
@@ -201,7 +205,8 @@ static int iio_read_first_n_sw_rb(struct iio_buffer *r,
 	if (initial_read_p + bytes_to_rip >= ring->data + buffer_size) {
 		max_copied = ring->data + buffer_size - initial_read_p;
 		memcpy(data, initial_read_p, max_copied);
-		memcpy(data + max_copied, ring->data, bytes_to_rip - max_copied);
+		memcpy(data + max_copied,
+				ring->data, bytes_to_rip - max_copied);
 		end_read_p = ring->data + bytes_to_rip - max_copied;
 	} else {
 		memcpy(data, initial_read_p, bytes_to_rip);
@@ -251,12 +256,10 @@ static int iio_read_first_n_sw_rb(struct iio_buffer *r,
 error_free_data_cpy:
 	kfree(data);
 error_ret:
-
 	return ret;
 }
 
-static int iio_store_to_sw_rb(struct iio_buffer *r,
-			      u8 *data)
+static int iio_store_to_sw_rb(struct iio_buffer *r, u8 *data)
 {
 	struct iio_sw_ring_buffer *ring = iio_to_sw_ring(r);
 	return iio_store_to_sw_ring(ring, data);
@@ -343,7 +346,7 @@ struct iio_buffer *iio_sw_rb_allocate(struct iio_dev *indio_dev)
 	struct iio_buffer *buf;
 	struct iio_sw_ring_buffer *ring;
 
-	ring = kzalloc(sizeof *ring, GFP_KERNEL);
+	ring = kzalloc(sizeof(*ring), GFP_KERNEL);
 	if (!ring)
 		return NULL;
 	ring->update_needed = true;
-- 
1.7.10.4

