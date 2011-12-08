Return-Path: <linux-iio-owner@vger.kernel.org>
Received: from ch1ehsobe004.messaging.microsoft.com ([216.32.181.184]:38011
	"EHLO ch1outboundpool.messaging.microsoft.com" rhost-flags-OK-OK-OK-OK)
	by vger.kernel.org with ESMTP id S1751545Ab1LHRfh (ORCPT
	<rfc822;linux-iio@vger.kernel.org>); Thu, 8 Dec 2011 12:35:37 -0500
From: Lars-Peter Clausen <lars@metafoo.de>
To: Greg Kroah-Hartman <gregkh@suse.de>
CC: Jonathan Cameron <jic23@kernel.org>, <devel@driverdev.osuosl.org>,
	<linux-iio@vger.kernel.org>, Lars-Peter Clausen <lars@metafoo.de>
Subject: [PATCH 1/3] staging:iio: Fix sw_ring memory corruption
Date: Thu, 8 Dec 2011 18:35:51 +0100
Message-ID: <1323365753-7645-1-git-send-email-lars@metafoo.de>
MIME-Version: 1.0
Content-Type: text/plain
Sender: linux-iio-owner@vger.kernel.org
List-Id: linux-iio@vger.kernel.org

The sw_ring does not properly handle the case where the write pointer already
has wrapped around, the read pointer has not and the remaining buffer space at
the end is enough to fill the read buffer:

  +-----------------------------------+
  |     |              |##data##|     |
  +-----------------------------------+
     write_p        read_p

In this case the current code will copy all available data to the buffer and
as a result will write beyond the bounds of the buffer and cause a memory
corruption.

To address this issue this patch adds code to calculate the available buffer
space and makes sure that the number of bytes to copy does not exceed this
number. This allows the code which copies the data around to be simplified as
it only has to consider two cases: Read wraps around and read does not wrap
around.

Signed-off-by: Lars-Peter Clausen <lars@metafoo.de>
Acked-by: Jonathan Cameron <jic23@kernel.org>
---
 drivers/staging/iio/ring_sw.c |   58 ++++++++++++++++------------------------
 1 files changed, 23 insertions(+), 35 deletions(-)

diff --git a/drivers/staging/iio/ring_sw.c b/drivers/staging/iio/ring_sw.c
index a541a73..4c15cc8 100644
--- a/drivers/staging/iio/ring_sw.c
+++ b/drivers/staging/iio/ring_sw.c
@@ -170,6 +170,7 @@ static int iio_read_first_n_sw_rb(struct iio_buffer *r,
 	u8 *initial_read_p, *initial_write_p, *current_read_p, *end_read_p;
 	u8 *data;
 	int ret, max_copied, bytes_to_rip, dead_offset;
+	size_t data_available, buffer_size;
 
 	/* A userspace program has probably made an error if it tries to
 	 *  read something that is not a whole number of bpds.
@@ -182,9 +183,11 @@ static int iio_read_first_n_sw_rb(struct iio_buffer *r,
 		       n, ring->buf.bytes_per_datum);
 		goto error_ret;
 	}
+
+	buffer_size = ring->buf.bytes_per_datum*ring->buf.length;
+
 	/* Limit size to whole of ring buffer */
-	bytes_to_rip = min((size_t)(ring->buf.bytes_per_datum*ring->buf.length),
-			   n);
+	bytes_to_rip = min_t(size_t, buffer_size, n);
 
 	data = kmalloc(bytes_to_rip, GFP_KERNEL);
 	if (data == NULL) {
@@ -213,38 +216,24 @@ static int iio_read_first_n_sw_rb(struct iio_buffer *r,
 		goto error_free_data_cpy;
 	}
 
-	if (initial_write_p >= initial_read_p + bytes_to_rip) {
-		/* write_p is greater than necessary, all is easy */
-		max_copied = bytes_to_rip;
-		memcpy(data, initial_read_p, max_copied);
-		end_read_p = initial_read_p + max_copied;
-	} else if (initial_write_p > initial_read_p) {
-		/*not enough data to cpy */
-		max_copied = initial_write_p - initial_read_p;
+	if (initial_write_p >= initial_read_p)
+		data_available = initial_write_p - initial_read_p;
+	else
+		data_available = buffer_size - (initial_read_p - initial_write_p);
+
+	if (data_available < bytes_to_rip)
+		bytes_to_rip = data_available;
+
+	if (initial_read_p + bytes_to_rip >= ring->data + buffer_size) {
+		max_copied = ring->data + buffer_size - initial_read_p;
 		memcpy(data, initial_read_p, max_copied);
-		end_read_p = initial_write_p;
+		memcpy(data + max_copied, ring->data, bytes_to_rip - max_copied);
+		end_read_p = ring->data + bytes_to_rip - max_copied;
 	} else {
-		/* going through 'end' of ring buffer */
-		max_copied = ring->data
-			+ ring->buf.length*ring->buf.bytes_per_datum - initial_read_p;
-		memcpy(data, initial_read_p, max_copied);
-		/* possible we are done if we align precisely with end */
-		if (max_copied == bytes_to_rip)
-			end_read_p = ring->data;
-		else if (initial_write_p
-			 > ring->data + bytes_to_rip - max_copied) {
-			/* enough data to finish */
-			memcpy(data + max_copied, ring->data,
-			       bytes_to_rip - max_copied);
-			max_copied = bytes_to_rip;
-			end_read_p = ring->data + (bytes_to_rip - max_copied);
-		} else {  /* not enough data */
-			memcpy(data + max_copied, ring->data,
-			       initial_write_p - ring->data);
-			max_copied += initial_write_p - ring->data;
-			end_read_p = initial_write_p;
-		}
+		memcpy(data, initial_read_p, bytes_to_rip);
+		end_read_p = initial_read_p + bytes_to_rip;
 	}
+
 	/* Now to verify which section was cleanly copied - i.e. how far
 	 * read pointer has been pushed */
 	current_read_p = ring->read_p;
@@ -252,15 +241,14 @@ static int iio_read_first_n_sw_rb(struct iio_buffer *r,
 	if (initial_read_p <= current_read_p)
 		dead_offset = current_read_p - initial_read_p;
 	else
-		dead_offset = ring->buf.length*ring->buf.bytes_per_datum
-			- (initial_read_p - current_read_p);
+		dead_offset = buffer_size - (initial_read_p - current_read_p);
 
 	/* possible issue if the initial write has been lapped or indeed
 	 * the point we were reading to has been passed */
 	/* No valid data read.
 	 * In this case the read pointer is already correct having been
 	 * pushed further than we would look. */
-	if (max_copied - dead_offset < 0) {
+	if (bytes_to_rip - dead_offset < 0) {
 		ret = 0;
 		goto error_free_data_cpy;
 	}
@@ -276,7 +264,7 @@ static int iio_read_first_n_sw_rb(struct iio_buffer *r,
 	while (ring->read_p != end_read_p)
 		ring->read_p = end_read_p;
 
-	ret = max_copied - dead_offset;
+	ret = bytes_to_rip - dead_offset;
 
 	if (copy_to_user(buf, data + dead_offset, ret))  {
 		ret =  -EFAULT;
-- 
1.7.7.3


