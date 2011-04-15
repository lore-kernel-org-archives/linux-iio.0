Return-Path: <linux-iio-owner@vger.kernel.org>
Received: from ppsw-52.csi.cam.ac.uk ([131.111.8.152]:55778 "EHLO
	ppsw-52.csi.cam.ac.uk" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1755607Ab1DORyL (ORCPT
	<rfc822;linux-iio@vger.kernel.org>); Fri, 15 Apr 2011 13:54:11 -0400
From: Jonathan Cameron <jic23@cam.ac.uk>
To: greg@kroah.com
Cc: jbrenner@taosinc.com, linux-iio@vger.kernel.org,
	Jonathan Cameron <jic23@cam.ac.uk>
Subject: [PATCH 3/8] staging:iio: replace rip_lots naming with read_first_n
Date: Fri, 15 Apr 2011 18:55:55 +0100
Message-Id: <1302890160-8823-4-git-send-email-jic23@cam.ac.uk>
In-Reply-To: <1302890160-8823-1-git-send-email-jic23@cam.ac.uk>
References: <1302890160-8823-1-git-send-email-jic23@cam.ac.uk>
Sender: linux-iio-owner@vger.kernel.org
List-Id: linux-iio@vger.kernel.org

Change suggested by Arnd Bergmann, Related patch to remove
pointless (now) dead_offset parameter will have await
proper fix for the sca3000 driver.  That depends on
some intermediate patches so may be a little while.

Signed-off-by: Jonathan Cameron <jic23@cam.ac.uk>
---
 drivers/staging/iio/accel/sca3000_ring.c |    8 ++++----
 drivers/staging/iio/industrialio-ring.c  |   12 ++++++------
 drivers/staging/iio/kfifo_buf.c          |    8 ++++----
 drivers/staging/iio/kfifo_buf.h          |   10 +++++-----
 drivers/staging/iio/ring_generic.h       |   10 +++++-----
 drivers/staging/iio/ring_sw.c            |   13 +++++++------
 drivers/staging/iio/ring_sw.h            |   14 +++++++-------
 7 files changed, 38 insertions(+), 37 deletions(-)

diff --git a/drivers/staging/iio/accel/sca3000_ring.c b/drivers/staging/iio/accel/sca3000_ring.c
index a730a76..b505e70 100644
--- a/drivers/staging/iio/accel/sca3000_ring.c
+++ b/drivers/staging/iio/accel/sca3000_ring.c
@@ -35,7 +35,7 @@
  */
 
 /**
- * sca3000_rip_hw_rb() - main ring access function, pulls data from ring
+ * sca3000_read_first_n_hw_rb() - main ring access, pulls data from ring
  * @r:			the ring
  * @count:		number of samples to try and pull
  * @data:		output the actual samples pulled from the hw ring
@@ -46,8 +46,8 @@
  * can only be inferred approximately from ring buffer events such as 50% full
  * and knowledge of when buffer was last emptied.  This is left to userspace.
  **/
-static int sca3000_rip_hw_rb(struct iio_ring_buffer *r,
-			     size_t count, u8 **data, int *dead_offset)
+static int sca3000_read_first_n_hw_rb(struct iio_ring_buffer *r,
+				      size_t count, u8 **data, int *dead_offset)
 {
 	struct iio_hw_ring_buffer *hw_ring = iio_to_hw_ring_buf(r);
 	struct iio_dev *indio_dev = hw_ring->private;
@@ -283,7 +283,7 @@ int sca3000_configure_ring(struct iio_dev *indio_dev)
 	indio_dev->modes |= INDIO_RING_HARDWARE_BUFFER;
 
 	indio_dev->ring->scan_el_attrs = &sca3000_scan_el_group;
-	indio_dev->ring->access.rip_lots = &sca3000_rip_hw_rb;
+	indio_dev->ring->access.read_first_n = &sca3000_read_first_n_hw_rb;
 	indio_dev->ring->access.get_length = &sca3000_ring_get_length;
 	indio_dev->ring->access.get_bytes_per_datum = &sca3000_ring_get_bytes_per_datum;
 
diff --git a/drivers/staging/iio/industrialio-ring.c b/drivers/staging/iio/industrialio-ring.c
index bd4373a..3f6bee0 100644
--- a/drivers/staging/iio/industrialio-ring.c
+++ b/drivers/staging/iio/industrialio-ring.c
@@ -88,27 +88,27 @@ static int iio_ring_release(struct inode *inode, struct file *filp)
 }
 
 /**
- * iio_ring_rip_outer() - chrdev read for ring buffer access
+ * iio_ring_read_first_n_outer() - chrdev read for ring buffer access
  *
  * This function relies on all ring buffer implementations having an
  * iio_ring _bufer as their first element.
  **/
-static ssize_t iio_ring_rip_outer(struct file *filp, char __user *buf,
-				  size_t count, loff_t *f_ps)
+static ssize_t iio_ring_read_first_n_outer(struct file *filp, char __user *buf,
+				  size_t n, loff_t *f_ps)
 {
 	struct iio_ring_buffer *rb = filp->private_data;
 	int ret, dead_offset;
 
 	/* rip lots must exist. */
-	if (!rb->access.rip_lots)
+	if (!rb->access.read_first_n)
 		return -EINVAL;
-	ret = rb->access.rip_lots(rb, count, buf, &dead_offset);
+	ret = rb->access.read_first_n(rb, n, buf, &dead_offset);
 
 	return ret;
 }
 
 static const struct file_operations iio_ring_fileops = {
-	.read = iio_ring_rip_outer,
+	.read = iio_ring_read_first_n_outer,
 	.release = iio_ring_release,
 	.open = iio_ring_open,
 	.owner = THIS_MODULE,
diff --git a/drivers/staging/iio/kfifo_buf.c b/drivers/staging/iio/kfifo_buf.c
index a56c0cb..74c93f7 100644
--- a/drivers/staging/iio/kfifo_buf.c
+++ b/drivers/staging/iio/kfifo_buf.c
@@ -181,16 +181,16 @@ int iio_store_to_kfifo(struct iio_ring_buffer *r, u8 *data, s64 timestamp)
 }
 EXPORT_SYMBOL(iio_store_to_kfifo);
 
-int iio_rip_kfifo(struct iio_ring_buffer *r,
-		size_t count, char __user *buf, int *deadoffset)
+int iio_read_first_n_kfifo(struct iio_ring_buffer *r,
+			   size_t n, char __user *buf, int *deadoffset)
 {
 	int ret, copied;
 	struct iio_kfifo *kf = iio_to_kfifo(r);
 
 	*deadoffset = 0;
-	ret = kfifo_to_user(&kf->kf, buf, r->bytes_per_datum*count, &copied);
+	ret = kfifo_to_user(&kf->kf, buf, r->bytes_per_datum*n, &copied);
 
 	return copied;
 }
-EXPORT_SYMBOL(iio_rip_kfifo);
+EXPORT_SYMBOL(iio_read_first_n_kfifo);
 MODULE_LICENSE("GPL");
diff --git a/drivers/staging/iio/kfifo_buf.h b/drivers/staging/iio/kfifo_buf.h
index 8064383..457010d 100644
--- a/drivers/staging/iio/kfifo_buf.h
+++ b/drivers/staging/iio/kfifo_buf.h
@@ -21,10 +21,10 @@ void iio_mark_kfifo_in_use(struct iio_ring_buffer *r);
 void iio_unmark_kfifo_in_use(struct iio_ring_buffer *r);
 
 int iio_store_to_kfifo(struct iio_ring_buffer *r, u8 *data, s64 timestamp);
-int iio_rip_kfifo(struct iio_ring_buffer *r,
-		size_t count,
-		char __user *buf,
-		int *dead_offset);
+int iio_read_first_n_kfifo(struct iio_ring_buffer *r,
+			   size_t n,
+			   char __user *buf,
+			   int *dead_offset);
 
 int iio_request_update_kfifo(struct iio_ring_buffer *r);
 int iio_mark_update_needed_kfifo(struct iio_ring_buffer *r);
@@ -40,7 +40,7 @@ static inline void iio_kfifo_register_funcs(struct iio_ring_access_funcs *ra)
 	ra->unmark_in_use = &iio_unmark_kfifo_in_use;
 
 	ra->store_to = &iio_store_to_kfifo;
-	ra->rip_lots = &iio_rip_kfifo;
+	ra->read_first_n = &iio_read_first_n_kfifo;
 
 	ra->mark_param_change = &iio_mark_update_needed_kfifo;
 	ra->request_update = &iio_request_update_kfifo;
diff --git a/drivers/staging/iio/ring_generic.h b/drivers/staging/iio/ring_generic.h
index 32948e5..780c6aa 100644
--- a/drivers/staging/iio/ring_generic.h
+++ b/drivers/staging/iio/ring_generic.h
@@ -44,7 +44,7 @@ int iio_push_or_escallate_ring_event(struct iio_ring_buffer *ring_buf,
  * @unmark_in_use:	reduce reference count when no longer using ring buffer
  * @store_to:		actually store stuff to the ring buffer
  * @read_last:		get the last element stored
- * @rip_lots:		try to get a specified number of elements (must exist)
+ * @read_first_n:	try to get a specified number of elements (must exist)
  * @mark_param_change:	notify ring that some relevant parameter has changed
  *			Often this means the underlying storage may need to
  *			change.
@@ -71,10 +71,10 @@ struct iio_ring_access_funcs {
 
 	int (*store_to)(struct iio_ring_buffer *ring, u8 *data, s64 timestamp);
 	int (*read_last)(struct iio_ring_buffer *ring, u8 *data);
-	int (*rip_lots)(struct iio_ring_buffer *ring,
-			size_t count,
-			char __user *buf,
-			int *dead_offset);
+	int (*read_first_n)(struct iio_ring_buffer *ring,
+			    size_t n,
+			    char __user *buf,
+			    int *dead_offset);
 
 	int (*mark_param_change)(struct iio_ring_buffer *ring);
 	int (*request_update)(struct iio_ring_buffer *ring);
diff --git a/drivers/staging/iio/ring_sw.c b/drivers/staging/iio/ring_sw.c
index b71ce39..ea0015e 100644
--- a/drivers/staging/iio/ring_sw.c
+++ b/drivers/staging/iio/ring_sw.c
@@ -152,8 +152,8 @@ error_ret:
 	return ret;
 }
 
-int iio_rip_sw_rb(struct iio_ring_buffer *r,
-		  size_t count, char __user *buf, int *dead_offset)
+int iio_read_first_n_sw_rb(struct iio_ring_buffer *r,
+			   size_t n, char __user *buf, int *dead_offset)
 {
 	struct iio_sw_ring_buffer *ring = iio_to_sw_ring(r);
 
@@ -166,15 +166,16 @@ int iio_rip_sw_rb(struct iio_ring_buffer *r,
 	 *  read something that is not a whole number of bpds.
 	 * Return an error.
 	 */
-	if (count % ring->buf.bytes_per_datum) {
+	if (n % ring->buf.bytes_per_datum) {
 		ret = -EINVAL;
 		printk(KERN_INFO "Ring buffer read request not whole number of"
 		       "samples: Request bytes %zd, Current bytes per datum %d\n",
-		       count, ring->buf.bytes_per_datum);
+		       n, ring->buf.bytes_per_datum);
 		goto error_ret;
 	}
 	/* Limit size to whole of ring buffer */
-	bytes_to_rip = min((size_t)(ring->buf.bytes_per_datum*ring->buf.length), count);
+	bytes_to_rip = min((size_t)(ring->buf.bytes_per_datum*ring->buf.length),
+			   n);
 
 	data = kmalloc(bytes_to_rip, GFP_KERNEL);
 	if (data == NULL) {
@@ -278,7 +279,7 @@ error_ret:
 
 	return ret;
 }
-EXPORT_SYMBOL(iio_rip_sw_rb);
+EXPORT_SYMBOL(iio_read_first_n_sw_rb);
 
 int iio_store_to_sw_rb(struct iio_ring_buffer *r, u8 *data, s64 timestamp)
 {
diff --git a/drivers/staging/iio/ring_sw.h b/drivers/staging/iio/ring_sw.h
index 13341c1e..ee86020 100644
--- a/drivers/staging/iio/ring_sw.h
+++ b/drivers/staging/iio/ring_sw.h
@@ -93,17 +93,17 @@ int iio_read_last_from_sw_rb(struct iio_ring_buffer *r, u8 *data);
 int iio_store_to_sw_rb(struct iio_ring_buffer *r, u8 *data, s64 timestamp);
 
 /**
- * iio_rip_sw_rb() - attempt to read data from the ring buffer
+ * iio_read_first_n_sw_rb() - attempt to read data from the ring buffer
  * @r:			ring buffer instance
- * @count:		number of datum's to try and read
+ * @n:			number of datum's to try and read
  * @buf:		userspace buffer into which data is copied
  * @dead_offset:	how much of the stored data was possibly invalidated by
  *			the end of the copy.
  **/
-int iio_rip_sw_rb(struct iio_ring_buffer *r,
-		  size_t count,
-		  char __user *buf,
-		  int *dead_offset);
+int iio_read_first_n_sw_rb(struct iio_ring_buffer *r,
+			   size_t n,
+			   char __user *buf,
+			   int *dead_offset);
 
 /**
  * iio_request_update_sw_rb() - update params if update needed
@@ -161,7 +161,7 @@ static inline void iio_ring_sw_register_funcs(struct iio_ring_access_funcs *ra)
 
 	ra->store_to = &iio_store_to_sw_rb;
 	ra->read_last = &iio_read_last_from_sw_rb;
-	ra->rip_lots = &iio_rip_sw_rb;
+	ra->read_first_n = &iio_read_first_n_sw_rb;
 
 	ra->mark_param_change = &iio_mark_update_needed_sw_rb;
 	ra->request_update = &iio_request_update_sw_rb;
-- 
1.7.3.4

