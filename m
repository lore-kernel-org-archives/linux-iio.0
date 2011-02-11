Return-Path: <jic23@cam.ac.uk>
From: Jonathan Cameron <jic23@cam.ac.uk>
To: greg@kroah.com
Cc: linux-iio@vger.kernel.org,
	Jonathan Cameron <jic23@cam.ac.uk>
Subject: [PATCH 1/5] staging:iio:buffering move the copy to user on rip down into implementations
Date: Fri, 11 Feb 2011 13:09:09 +0000
Message-Id: <1297429753-6606-2-git-send-email-jic23@cam.ac.uk>
In-Reply-To: <1297429753-6606-1-git-send-email-jic23@cam.ac.uk>
References: <1297429753-6606-1-git-send-email-jic23@cam.ac.uk>
List-ID: <linux-iio@vger.kernel.org>

The current interface is not as adaptable as it should be. Moving
this complexity into the implementations makes it easier to add
new implementations.

Signed-off-by: Jonathan Cameron <jic23@cam.ac.uk>
Tested-by: Michael Hennerich <michael.hennerich@analog.com>
---
 drivers/staging/iio/industrialio-ring.c |   25 +++----------------------
 drivers/staging/iio/ring_generic.h      |    2 +-
 drivers/staging/iio/ring_sw.c           |   27 +++++++++++++++++----------
 drivers/staging/iio/ring_sw.h           |    4 ++--
 4 files changed, 23 insertions(+), 35 deletions(-)

diff --git a/drivers/staging/iio/industrialio-ring.c b/drivers/staging/iio/industrialio-ring.c
index 9a98fcd..bd4373a 100644
--- a/drivers/staging/iio/industrialio-ring.c
+++ b/drivers/staging/iio/industrialio-ring.c
@@ -16,7 +16,6 @@
 #include <linux/kernel.h>
 #include <linux/device.h>
 #include <linux/fs.h>
-#include <linux/poll.h>
 #include <linux/cdev.h>
 #include <linux/slab.h>
 
@@ -98,31 +97,13 @@ static ssize_t iio_ring_rip_outer(struct file *filp, char __user *buf,
 				  size_t count, loff_t *f_ps)
 {
 	struct iio_ring_buffer *rb = filp->private_data;
-	int ret, dead_offset, copied;
-	u8 *data;
+	int ret, dead_offset;
+
 	/* rip lots must exist. */
 	if (!rb->access.rip_lots)
 		return -EINVAL;
-	copied = rb->access.rip_lots(rb, count, &data, &dead_offset);
+	ret = rb->access.rip_lots(rb, count, buf, &dead_offset);
 
-	if (copied <= 0) {
-		ret = copied;
-		goto error_ret;
-	}
-	if (copy_to_user(buf, data + dead_offset, copied))  {
-		ret =  -EFAULT;
-		goto error_free_data_cpy;
-	}
-	/* In clever ring buffer designs this may not need to be freed.
-	 * When such a design exists I'll add this to ring access funcs.
-	 */
-	kfree(data);
-
-	return copied;
-
-error_free_data_cpy:
-	kfree(data);
-error_ret:
 	return ret;
 }
 
diff --git a/drivers/staging/iio/ring_generic.h b/drivers/staging/iio/ring_generic.h
index 8ecb189..f21ac09 100644
--- a/drivers/staging/iio/ring_generic.h
+++ b/drivers/staging/iio/ring_generic.h
@@ -73,7 +73,7 @@ struct iio_ring_access_funcs {
 	int (*read_last)(struct iio_ring_buffer *ring, u8 *data);
 	int (*rip_lots)(struct iio_ring_buffer *ring,
 			size_t count,
-			u8 **data,
+			char __user *buf,
 			int *dead_offset);
 
 	int (*mark_param_change)(struct iio_ring_buffer *ring);
diff --git a/drivers/staging/iio/ring_sw.c b/drivers/staging/iio/ring_sw.c
index 52624ac..b71ce39 100644
--- a/drivers/staging/iio/ring_sw.c
+++ b/drivers/staging/iio/ring_sw.c
@@ -12,6 +12,7 @@
 #include <linux/module.h>
 #include <linux/device.h>
 #include <linux/workqueue.h>
+#include <linux/poll.h>
 #include "ring_sw.h"
 #include "trigger.h"
 
@@ -152,11 +153,12 @@ error_ret:
 }
 
 int iio_rip_sw_rb(struct iio_ring_buffer *r,
-		  size_t count, u8 **data, int *dead_offset)
+		  size_t count, char __user *buf, int *dead_offset)
 {
 	struct iio_sw_ring_buffer *ring = iio_to_sw_ring(r);
 
 	u8 *initial_read_p, *initial_write_p, *current_read_p, *end_read_p;
+	u8 *data;
 	int ret, max_copied;
 	int bytes_to_rip;
 
@@ -174,8 +176,8 @@ int iio_rip_sw_rb(struct iio_ring_buffer *r,
 	/* Limit size to whole of ring buffer */
 	bytes_to_rip = min((size_t)(ring->buf.bytes_per_datum*ring->buf.length), count);
 
-	*data = kmalloc(bytes_to_rip, GFP_KERNEL);
-	if (*data == NULL) {
+	data = kmalloc(bytes_to_rip, GFP_KERNEL);
+	if (data == NULL) {
 		ret = -ENOMEM;
 		goto error_ret;
 	}
@@ -204,30 +206,30 @@ int iio_rip_sw_rb(struct iio_ring_buffer *r,
 	if (initial_write_p >= initial_read_p + bytes_to_rip) {
 		/* write_p is greater than necessary, all is easy */
 		max_copied = bytes_to_rip;
-		memcpy(*data, initial_read_p, max_copied);
+		memcpy(data, initial_read_p, max_copied);
 		end_read_p = initial_read_p + max_copied;
 	} else if (initial_write_p > initial_read_p) {
 		/*not enough data to cpy */
 		max_copied = initial_write_p - initial_read_p;
-		memcpy(*data, initial_read_p, max_copied);
+		memcpy(data, initial_read_p, max_copied);
 		end_read_p = initial_write_p;
 	} else {
 		/* going through 'end' of ring buffer */
 		max_copied = ring->data
 			+ ring->buf.length*ring->buf.bytes_per_datum - initial_read_p;
-		memcpy(*data, initial_read_p, max_copied);
+		memcpy(data, initial_read_p, max_copied);
 		/* possible we are done if we align precisely with end */
 		if (max_copied == bytes_to_rip)
 			end_read_p = ring->data;
 		else if (initial_write_p
 			 > ring->data + bytes_to_rip - max_copied) {
 			/* enough data to finish */
-			memcpy(*data + max_copied, ring->data,
+			memcpy(data + max_copied, ring->data,
 			       bytes_to_rip - max_copied);
 			max_copied = bytes_to_rip;
 			end_read_p = ring->data + (bytes_to_rip - max_copied);
 		} else {  /* not enough data */
-			memcpy(*data + max_copied, ring->data,
+			memcpy(data + max_copied, ring->data,
 			       initial_write_p - ring->data);
 			max_copied += initial_write_p - ring->data;
 			end_read_p = initial_write_p;
@@ -264,11 +266,16 @@ int iio_rip_sw_rb(struct iio_ring_buffer *r,
 	while (ring->read_p != end_read_p)
 		ring->read_p = end_read_p;
 
-	return max_copied - *dead_offset;
+	ret = max_copied - *dead_offset;
 
+	if (copy_to_user(buf, data + *dead_offset, ret))  {
+		ret =  -EFAULT;
+		goto error_free_data_cpy;
+	}
 error_free_data_cpy:
-	kfree(*data);
+	kfree(data);
 error_ret:
+
 	return ret;
 }
 EXPORT_SYMBOL(iio_rip_sw_rb);
diff --git a/drivers/staging/iio/ring_sw.h b/drivers/staging/iio/ring_sw.h
index ad03d83..13341c1e 100644
--- a/drivers/staging/iio/ring_sw.h
+++ b/drivers/staging/iio/ring_sw.h
@@ -96,13 +96,13 @@ int iio_store_to_sw_rb(struct iio_ring_buffer *r, u8 *data, s64 timestamp);
  * iio_rip_sw_rb() - attempt to read data from the ring buffer
  * @r:			ring buffer instance
  * @count:		number of datum's to try and read
- * @data:		where the data will be stored.
+ * @buf:		userspace buffer into which data is copied
  * @dead_offset:	how much of the stored data was possibly invalidated by
  *			the end of the copy.
  **/
 int iio_rip_sw_rb(struct iio_ring_buffer *r,
 		  size_t count,
-		  u8 **data,
+		  char __user *buf,
 		  int *dead_offset);
 
 /**
-- 
1.7.3.4
