Return-Path: <jic23@cam.ac.uk>
From: Jonathan Cameron <jic23@cam.ac.uk>
To: linux-iio@vger.kernel.org
Cc: arnd@arndb.de,
	Michael.Hennerich@analog.com,
	Jonathan Cameron <jic23@cam.ac.uk>
Subject: [PATCH 12/99] staging:iio:buffering remove unused parameter dead_offset from read_last_n in all buffer implementations.
Date: Wed,  4 May 2011 12:57:44 +0100
Message-Id: <1304510351-10922-13-git-send-email-jic23@cam.ac.uk>
In-Reply-To: <1304510351-10922-1-git-send-email-jic23@cam.ac.uk>
References: <1304510351-10922-1-git-send-email-jic23@cam.ac.uk>
List-ID: <linux-iio@vger.kernel.org>

This element has been usused by the core for quite some time.  sca3000 set it none the less
until the rewrite in the previous patch (and hence didn't work).

Signed-off-by: Jonathan Cameron <jic23@cam.ac.uk>
---
 drivers/staging/iio/accel/sca3000_ring.c |    5 +----
 drivers/staging/iio/industrialio-ring.c  |    4 ++--
 drivers/staging/iio/kfifo_buf.c          |    3 +--
 drivers/staging/iio/kfifo_buf.h          |    3 +--
 drivers/staging/iio/ring_generic.h       |    3 +--
 drivers/staging/iio/ring_sw.c            |   15 +++++++--------
 drivers/staging/iio/ring_sw.h            |    4 +---
 7 files changed, 14 insertions(+), 23 deletions(-)

diff --git a/drivers/staging/iio/accel/sca3000_ring.c b/drivers/staging/iio/accel/sca3000_ring.c
index 8efd4f0..d3c3789 100644
--- a/drivers/staging/iio/accel/sca3000_ring.c
+++ b/drivers/staging/iio/accel/sca3000_ring.c
@@ -79,16 +79,13 @@ error_ret:
  * @r:			the ring
  * @count:		number of samples to try and pull
  * @data:		output the actual samples pulled from the hw ring
- * @dead_offset:	cheating a bit here: Set to 1 so as to allow for the
- *			leading byte used in bus comms.
  *
  * Currently does not provide timestamps.  As the hardware doesn't add them they
  * can only be inferred approximately from ring buffer events such as 50% full
  * and knowledge of when buffer was last emptied.  This is left to userspace.
  **/
 static int sca3000_read_first_n_hw_rb(struct iio_ring_buffer *r,
-				      size_t count, char __user *buf,
-				      int *dead_offset)
+				      size_t count, char __user *buf)
 {
 	struct iio_hw_ring_buffer *hw_ring = iio_to_hw_ring_buf(r);
 	struct iio_dev *indio_dev = hw_ring->private;
diff --git a/drivers/staging/iio/industrialio-ring.c b/drivers/staging/iio/industrialio-ring.c
index 625263e..4497a50 100644
--- a/drivers/staging/iio/industrialio-ring.c
+++ b/drivers/staging/iio/industrialio-ring.c
@@ -71,12 +71,12 @@ static ssize_t iio_ring_read_first_n_outer(struct file *filp, char __user *buf,
 				  size_t n, loff_t *f_ps)
 {
 	struct iio_ring_buffer *rb = filp->private_data;
-	int ret, dead_offset;
+	int ret;
 
 	/* rip lots must exist. */
 	if (!rb->access.read_first_n)
 		return -EINVAL;
-	ret = rb->access.read_first_n(rb, n, buf, &dead_offset);
+	ret = rb->access.read_first_n(rb, n, buf);
 
 	return ret;
 }
diff --git a/drivers/staging/iio/kfifo_buf.c b/drivers/staging/iio/kfifo_buf.c
index 74c93f7..fdd5d9e 100644
--- a/drivers/staging/iio/kfifo_buf.c
+++ b/drivers/staging/iio/kfifo_buf.c
@@ -182,12 +182,11 @@ int iio_store_to_kfifo(struct iio_ring_buffer *r, u8 *data, s64 timestamp)
 EXPORT_SYMBOL(iio_store_to_kfifo);
 
 int iio_read_first_n_kfifo(struct iio_ring_buffer *r,
-			   size_t n, char __user *buf, int *deadoffset)
+			   size_t n, char __user *buf)
 {
 	int ret, copied;
 	struct iio_kfifo *kf = iio_to_kfifo(r);
 
-	*deadoffset = 0;
 	ret = kfifo_to_user(&kf->kf, buf, r->bytes_per_datum*n, &copied);
 
 	return copied;
diff --git a/drivers/staging/iio/kfifo_buf.h b/drivers/staging/iio/kfifo_buf.h
index 457010d..eb337a4 100644
--- a/drivers/staging/iio/kfifo_buf.h
+++ b/drivers/staging/iio/kfifo_buf.h
@@ -23,8 +23,7 @@ void iio_unmark_kfifo_in_use(struct iio_ring_buffer *r);
 int iio_store_to_kfifo(struct iio_ring_buffer *r, u8 *data, s64 timestamp);
 int iio_read_first_n_kfifo(struct iio_ring_buffer *r,
 			   size_t n,
-			   char __user *buf,
-			   int *dead_offset);
+			   char __user *buf);
 
 int iio_request_update_kfifo(struct iio_ring_buffer *r);
 int iio_mark_update_needed_kfifo(struct iio_ring_buffer *r);
diff --git a/drivers/staging/iio/ring_generic.h b/drivers/staging/iio/ring_generic.h
index 91f1037..671e9fd 100644
--- a/drivers/staging/iio/ring_generic.h
+++ b/drivers/staging/iio/ring_generic.h
@@ -50,8 +50,7 @@ struct iio_ring_access_funcs {
 	int (*read_last)(struct iio_ring_buffer *ring, u8 *data);
 	int (*read_first_n)(struct iio_ring_buffer *ring,
 			    size_t n,
-			    char __user *buf,
-			    int *dead_offset);
+			    char __user *buf);
 
 	int (*mark_param_change)(struct iio_ring_buffer *ring);
 	int (*request_update)(struct iio_ring_buffer *ring);
diff --git a/drivers/staging/iio/ring_sw.c b/drivers/staging/iio/ring_sw.c
index 5fbf5ff..40beadd 100644
--- a/drivers/staging/iio/ring_sw.c
+++ b/drivers/staging/iio/ring_sw.c
@@ -139,14 +139,13 @@ static int iio_store_to_sw_ring(struct iio_sw_ring_buffer *ring,
 }
 
 int iio_read_first_n_sw_rb(struct iio_ring_buffer *r,
-			   size_t n, char __user *buf, int *dead_offset)
+			   size_t n, char __user *buf)
 {
 	struct iio_sw_ring_buffer *ring = iio_to_sw_ring(r);
 
 	u8 *initial_read_p, *initial_write_p, *current_read_p, *end_read_p;
 	u8 *data;
-	int ret, max_copied;
-	int bytes_to_rip;
+	int ret, max_copied, bytes_to_rip, dead_offset;
 
 	/* A userspace program has probably made an error if it tries to
 	 *  read something that is not a whole number of bpds.
@@ -227,9 +226,9 @@ int iio_read_first_n_sw_rb(struct iio_ring_buffer *r,
 	current_read_p = ring->read_p;
 
 	if (initial_read_p <= current_read_p)
-		*dead_offset = current_read_p - initial_read_p;
+		dead_offset = current_read_p - initial_read_p;
 	else
-		*dead_offset = ring->buf.length*ring->buf.bytes_per_datum
+		dead_offset = ring->buf.length*ring->buf.bytes_per_datum
 			- (initial_read_p - current_read_p);
 
 	/* possible issue if the initial write has been lapped or indeed
@@ -237,7 +236,7 @@ int iio_read_first_n_sw_rb(struct iio_ring_buffer *r,
 	/* No valid data read.
 	 * In this case the read pointer is already correct having been
 	 * pushed further than we would look. */
-	if (max_copied - *dead_offset < 0) {
+	if (max_copied - dead_offset < 0) {
 		ret = 0;
 		goto error_free_data_cpy;
 	}
@@ -253,9 +252,9 @@ int iio_read_first_n_sw_rb(struct iio_ring_buffer *r,
 	while (ring->read_p != end_read_p)
 		ring->read_p = end_read_p;
 
-	ret = max_copied - *dead_offset;
+	ret = max_copied - dead_offset;
 
-	if (copy_to_user(buf, data + *dead_offset, ret))  {
+	if (copy_to_user(buf, data + dead_offset, ret))  {
 		ret =  -EFAULT;
 		goto error_free_data_cpy;
 	}
diff --git a/drivers/staging/iio/ring_sw.h b/drivers/staging/iio/ring_sw.h
index ee86020..7d56524 100644
--- a/drivers/staging/iio/ring_sw.h
+++ b/drivers/staging/iio/ring_sw.h
@@ -97,13 +97,11 @@ int iio_store_to_sw_rb(struct iio_ring_buffer *r, u8 *data, s64 timestamp);
  * @r:			ring buffer instance
  * @n:			number of datum's to try and read
  * @buf:		userspace buffer into which data is copied
- * @dead_offset:	how much of the stored data was possibly invalidated by
  *			the end of the copy.
  **/
 int iio_read_first_n_sw_rb(struct iio_ring_buffer *r,
 			   size_t n,
-			   char __user *buf,
-			   int *dead_offset);
+			   char __user *buf);
 
 /**
  * iio_request_update_sw_rb() - update params if update needed
-- 
1.7.3.4
