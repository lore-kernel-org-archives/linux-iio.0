Return-Path: <lars@metafoo.de>
From: Lars-Peter Clausen <lars@metafoo.de>
To: Jonathan Cameron <jic23@cam.ac.uk>
CC: Michael Hennerich <michael.hennerich@analog.com>,
	<linux-iio@vger.kernel.org>, <device-drivers-devel@blackfin.uclinux.org>,
	<drivers@analog.com>, Lars-Peter Clausen <lars@metafoo.de>
Subject: [PATCH 8/8] iio:staging: Drop {mark,unmark}_in_use callbacks
Date: Fri, 16 Dec 2011 11:19:51 +0100
Message-ID: <1324030791-17983-8-git-send-email-lars@metafoo.de>
In-Reply-To: <1324030791-17983-1-git-send-email-lars@metafoo.de>
References: <1324030791-17983-1-git-send-email-lars@metafoo.de>
MIME-Version: 1.0
Content-Type: text/plain
List-ID: <linux-iio@vger.kernel.org>

These callbacks are currently used by the individual buffer implementations to
ensure that the request_update callback is not issued while the buffer is in use.
But the core already provides sufficient measures to prevent this from happening
in the first place. So it is safe to remove them.

There is one functional change due to this patch. Since the buffer is no longer
marked as in use when the chrdev is opened, it is now possible to enable the
buffer while it is opened. This did not work before, because mark_param_change
did fail if the buffer was marked as in use.

Signed-off-by: Lars-Peter Clausen <lars@metafoo.de>
---
 drivers/staging/iio/Documentation/ring.txt |    4 ---
 drivers/staging/iio/buffer.h               |    5 ----
 drivers/staging/iio/iio_core.h             |   11 --------
 drivers/staging/iio/industrialio-buffer.c  |   28 ----------------------
 drivers/staging/iio/industrialio-core.c    |    8 +-----
 drivers/staging/iio/kfifo_buf.c            |   32 -------------------------
 drivers/staging/iio/ring_sw.c              |   35 ----------------------------
 7 files changed, 1 insertions(+), 122 deletions(-)

diff --git a/drivers/staging/iio/Documentation/ring.txt b/drivers/staging/iio/Documentation/ring.txt
index 0f21479..e338077 100644
--- a/drivers/staging/iio/Documentation/ring.txt
+++ b/drivers/staging/iio/Documentation/ring.txt
@@ -23,10 +23,6 @@ The function pointers within here are used to allow the core to handle
 as much buffer functionality as possible. Note almost all of these
 are optional.
 
-mark_in_use, unmark_in_use
-  Basically indicate that not changes should be made to the buffer state that
-  will effect the form of the data being captures (e.g. scan elements or length)
-
 store_to
   If possible, push data to the buffer.
 
diff --git a/drivers/staging/iio/buffer.h b/drivers/staging/iio/buffer.h
index ea42b5d..6fb6e64 100644
--- a/drivers/staging/iio/buffer.h
+++ b/drivers/staging/iio/buffer.h
@@ -18,8 +18,6 @@ struct iio_buffer;
 
 /**
  * struct iio_buffer_access_funcs - access functions for buffers.
- * @mark_in_use:	reference counting, typically to prevent module removal
- * @unmark_in_use:	reduce reference count when no longer using buffer
  * @store_to:		actually store stuff to the buffer
  * @read_first_n:	try to get a specified number of bytes (must exist)
  * @request_update:	if a parameter change has been marked, update underlying
@@ -38,9 +36,6 @@ struct iio_buffer;
  * any of them not existing.
  **/
 struct iio_buffer_access_funcs {
-	void (*mark_in_use)(struct iio_buffer *buffer);
-	void (*unmark_in_use)(struct iio_buffer *buffer);
-
 	int (*store_to)(struct iio_buffer *buffer, u8 *data, s64 timestamp);
 	int (*read_first_n)(struct iio_buffer *buffer,
 			    size_t n,
diff --git a/drivers/staging/iio/iio_core.h b/drivers/staging/iio/iio_core.h
index ff27f13..107cfb1 100644
--- a/drivers/staging/iio/iio_core.h
+++ b/drivers/staging/iio/iio_core.h
@@ -33,9 +33,6 @@ int __iio_add_chan_devattr(const char *postfix,
 #ifdef CONFIG_IIO_BUFFER
 struct poll_table_struct;
 
-int iio_chrdev_buffer_open(struct iio_dev *indio_dev);
-void iio_chrdev_buffer_release(struct iio_dev *indio_dev);
-
 unsigned int iio_buffer_poll(struct file *filp,
 			     struct poll_table_struct *wait);
 ssize_t iio_buffer_read_first_n_outer(struct file *filp, char __user *buf,
@@ -47,14 +44,6 @@ ssize_t iio_buffer_read_first_n_outer(struct file *filp, char __user *buf,
 
 #else
 
-static inline int iio_chrdev_buffer_open(struct iio_dev *indio_dev)
-{
-	return 0;
-}
-
-static inline void iio_chrdev_buffer_release(struct iio_dev *indio_dev)
-{}
-
 #define iio_buffer_poll_addr NULL
 #define iio_buffer_read_first_n_outer_addr NULL
 
diff --git a/drivers/staging/iio/industrialio-buffer.c b/drivers/staging/iio/industrialio-buffer.c
index adf6d35..ed0a0ef 100644
--- a/drivers/staging/iio/industrialio-buffer.c
+++ b/drivers/staging/iio/industrialio-buffer.c
@@ -64,26 +64,6 @@ unsigned int iio_buffer_poll(struct file *filp,
 	return 0;
 }
 
-int iio_chrdev_buffer_open(struct iio_dev *indio_dev)
-{
-	struct iio_buffer *rb = indio_dev->buffer;
-	if (!rb)
-		return 0;
-	if (rb->access->mark_in_use)
-		rb->access->mark_in_use(rb);
-	return 0;
-}
-
-void iio_chrdev_buffer_release(struct iio_dev *indio_dev)
-{
-	struct iio_buffer *rb = indio_dev->buffer;
-
-	if (!rb)
-		return;
-	if (rb->access->unmark_in_use)
-		rb->access->unmark_in_use(rb);
-}
-
 void iio_buffer_init(struct iio_buffer *buffer)
 {
 	INIT_LIST_HEAD(&buffer->demux_list);
@@ -447,16 +427,12 @@ ssize_t iio_buffer_store_enable(struct device *dev,
 				goto error_ret;
 			}
 		}
-		if (buffer->access->mark_in_use)
-			buffer->access->mark_in_use(buffer);
 		/* Definitely possible for devices to support both of these.*/
 		if (indio_dev->modes & INDIO_BUFFER_TRIGGERED) {
 			if (!indio_dev->trig) {
 				printk(KERN_INFO
 				       "Buffer not started: no trigger\n");
 				ret = -EINVAL;
-				if (buffer->access->unmark_in_use)
-					buffer->access->unmark_in_use(buffer);
 				goto error_ret;
 			}
 			indio_dev->currentmode = INDIO_BUFFER_TRIGGERED;
@@ -473,8 +449,6 @@ ssize_t iio_buffer_store_enable(struct device *dev,
 				printk(KERN_INFO
 				       "Buffer not started:"
 				       "postenable failed\n");
-				if (buffer->access->unmark_in_use)
-					buffer->access->unmark_in_use(buffer);
 				indio_dev->currentmode = previous_mode;
 				if (indio_dev->setup_ops->postdisable)
 					indio_dev->setup_ops->
@@ -488,8 +462,6 @@ ssize_t iio_buffer_store_enable(struct device *dev,
 			if (ret)
 				goto error_ret;
 		}
-		if (buffer->access->unmark_in_use)
-			buffer->access->unmark_in_use(buffer);
 		indio_dev->currentmode = INDIO_DIRECT_MODE;
 		if (indio_dev->setup_ops->postdisable) {
 			ret = indio_dev->setup_ops->postdisable(indio_dev);
diff --git a/drivers/staging/iio/industrialio-core.c b/drivers/staging/iio/industrialio-core.c
index 12d1576..19f897f 100644
--- a/drivers/staging/iio/industrialio-core.c
+++ b/drivers/staging/iio/industrialio-core.c
@@ -1083,18 +1083,13 @@ static int iio_chrdev_open(struct inode *inode, struct file *filp)
 {
 	struct iio_dev *indio_dev = container_of(inode->i_cdev,
 						struct iio_dev, chrdev);
-	unsigned int ret;
 
 	if (test_and_set_bit(IIO_BUSY_BIT_POS, &indio_dev->flags))
 		return -EBUSY;
 
 	filp->private_data = indio_dev;
 
-	ret = iio_chrdev_buffer_open(indio_dev);
-	if (ret < 0)
-		clear_bit(IIO_BUSY_BIT_POS, &indio_dev->flags);
-
-	return ret;
+	return 0;
 }
 
 /**
@@ -1104,7 +1099,6 @@ static int iio_chrdev_release(struct inode *inode, struct file *filp)
 {
 	struct iio_dev *indio_dev = container_of(inode->i_cdev,
 						struct iio_dev, chrdev);
-	iio_chrdev_buffer_release(indio_dev);
 	clear_bit(IIO_BUSY_BIT_POS, &indio_dev->flags);
 	return 0;
 }
diff --git a/drivers/staging/iio/kfifo_buf.c b/drivers/staging/iio/kfifo_buf.c
index 33d9202..ff3e0c2 100644
--- a/drivers/staging/iio/kfifo_buf.c
+++ b/drivers/staging/iio/kfifo_buf.c
@@ -11,9 +11,7 @@
 struct iio_kfifo {
 	struct iio_buffer buffer;
 	struct kfifo kf;
-	int use_count;
 	int update_needed;
-	struct mutex use_lock;
 };
 
 #define iio_to_kfifo(r) container_of(r, struct iio_kfifo, buffer)
@@ -33,47 +31,20 @@ static int iio_request_update_kfifo(struct iio_buffer *r)
 	int ret = 0;
 	struct iio_kfifo *buf = iio_to_kfifo(r);
 
-	mutex_lock(&buf->use_lock);
 	if (!buf->update_needed)
 		goto error_ret;
-	if (buf->use_count) {
-		ret = -EAGAIN;
-		goto error_ret;
-	}
 	kfifo_free(&buf->kf);
 	ret = __iio_allocate_kfifo(buf, buf->buffer.bytes_per_datum,
 				   buf->buffer.length);
 error_ret:
-	mutex_unlock(&buf->use_lock);
 	return ret;
 }
 
-static void iio_mark_kfifo_in_use(struct iio_buffer *r)
-{
-	struct iio_kfifo *buf = iio_to_kfifo(r);
-	mutex_lock(&buf->use_lock);
-	buf->use_count++;
-	mutex_unlock(&buf->use_lock);
-}
-
-static void iio_unmark_kfifo_in_use(struct iio_buffer *r)
-{
-	struct iio_kfifo *buf = iio_to_kfifo(r);
-	mutex_lock(&buf->use_lock);
-	buf->use_count--;
-	mutex_unlock(&buf->use_lock);
-}
-
 static int iio_get_length_kfifo(struct iio_buffer *r)
 {
 	return r->length;
 }
 
-static inline void __iio_init_kfifo(struct iio_kfifo *kf)
-{
-	mutex_init(&kf->use_lock);
-}
-
 static IIO_BUFFER_ENABLE_ATTR;
 static IIO_BUFFER_LENGTH_ATTR;
 
@@ -98,7 +69,6 @@ struct iio_buffer *iio_kfifo_allocate(struct iio_dev *indio_dev)
 	kf->update_needed = true;
 	iio_buffer_init(&kf->buffer);
 	kf->buffer.attrs = &iio_kfifo_attribute_group;
-	__iio_init_kfifo(kf);
 
 	return &kf->buffer;
 }
@@ -170,8 +140,6 @@ static int iio_read_first_n_kfifo(struct iio_buffer *r,
 }
 
 const struct iio_buffer_access_funcs kfifo_access_funcs = {
-	.mark_in_use = &iio_mark_kfifo_in_use,
-	.unmark_in_use = &iio_unmark_kfifo_in_use,
 	.store_to = &iio_store_to_kfifo,
 	.read_first_n = &iio_read_first_n_kfifo,
 	.request_update = &iio_request_update_kfifo,
diff --git a/drivers/staging/iio/ring_sw.c b/drivers/staging/iio/ring_sw.c
index 03eae3a..16f7dd5 100644
--- a/drivers/staging/iio/ring_sw.c
+++ b/drivers/staging/iio/ring_sw.c
@@ -24,9 +24,7 @@
  * @read_p:		read pointer (oldest available)
  * @write_p:		write pointer
  * @half_p:		half buffer length behind write_p (event generation)
- * @use_count:		reference count to prevent resizing when in use
  * @update_needed:	flag to indicated change in size requested
- * @use_lock:		lock to prevent change in size when in use
  *
  * Note that the first element of all ring buffers must be a
  * struct iio_buffer.
@@ -38,9 +36,7 @@ struct iio_sw_ring_buffer {
 	unsigned char		*write_p;
 	/* used to act as a point at which to signal an event */
 	unsigned char		*half_p;
-	int			use_count;
 	int			update_needed;
-	spinlock_t		use_lock;
 };
 
 #define iio_to_sw_ring(r) container_of(r, struct iio_sw_ring_buffer, buf)
@@ -58,33 +54,11 @@ static inline int __iio_allocate_sw_ring_buffer(struct iio_sw_ring_buffer *ring,
 	return ring->data ? 0 : -ENOMEM;
 }
 
-static inline void __iio_init_sw_ring_buffer(struct iio_sw_ring_buffer *ring)
-{
-	spin_lock_init(&ring->use_lock);
-}
-
 static inline void __iio_free_sw_ring_buffer(struct iio_sw_ring_buffer *ring)
 {
 	kfree(ring->data);
 }
 
-static void iio_mark_sw_rb_in_use(struct iio_buffer *r)
-{
-	struct iio_sw_ring_buffer *ring = iio_to_sw_ring(r);
-	spin_lock(&ring->use_lock);
-	ring->use_count++;
-	spin_unlock(&ring->use_lock);
-}
-
-static void iio_unmark_sw_rb_in_use(struct iio_buffer *r)
-{
-	struct iio_sw_ring_buffer *ring = iio_to_sw_ring(r);
-	spin_lock(&ring->use_lock);
-	ring->use_count--;
-	spin_unlock(&ring->use_lock);
-}
-
-
 /* Ring buffer related functionality */
 /* Store to ring is typically called in the bh of a data ready interrupt handler
  * in the device driver */
@@ -295,18 +269,12 @@ static int iio_request_update_sw_rb(struct iio_buffer *r)
 	struct iio_sw_ring_buffer *ring = iio_to_sw_ring(r);
 
 	r->stufftoread = false;
-	spin_lock(&ring->use_lock);
 	if (!ring->update_needed)
 		goto error_ret;
-	if (ring->use_count) {
-		ret = -EAGAIN;
-		goto error_ret;
-	}
 	__iio_free_sw_ring_buffer(ring);
 	ret = __iio_allocate_sw_ring_buffer(ring, ring->buf.bytes_per_datum,
 					    ring->buf.length);
 error_ret:
-	spin_unlock(&ring->use_lock);
 	return ret;
 }
 
@@ -374,7 +342,6 @@ struct iio_buffer *iio_sw_rb_allocate(struct iio_dev *indio_dev)
 	ring->update_needed = true;
 	buf = &ring->buf;
 	iio_buffer_init(buf);
-	__iio_init_sw_ring_buffer(ring);
 	buf->attrs = &iio_ring_attribute_group;
 
 	return buf;
@@ -388,8 +355,6 @@ void iio_sw_rb_free(struct iio_buffer *r)
 EXPORT_SYMBOL(iio_sw_rb_free);
 
 const struct iio_buffer_access_funcs ring_sw_access_funcs = {
-	.mark_in_use = &iio_mark_sw_rb_in_use,
-	.unmark_in_use = &iio_unmark_sw_rb_in_use,
 	.store_to = &iio_store_to_sw_rb,
 	.read_first_n = &iio_read_first_n_sw_rb,
 	.request_update = &iio_request_update_sw_rb,
-- 
1.7.7.3
