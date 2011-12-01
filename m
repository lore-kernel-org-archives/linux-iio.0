Return-Path: <lars@metafoo.de>
From: Lars-Peter Clausen <lars@metafoo.de>
To: Jonathan Cameron <jic23@cam.ac.uk>
CC: Michael Hennerich <michael.hennerich@analog.com>,
	<linux-iio@vger.kernel.org>, <device-drivers-devel@blackfin.uclinux.org>,
	<drivers@analog.com>, Lars-Peter Clausen <lars@metafoo.de>
Subject: [PATCH 01/10] staging:iio: Add wrapper functions around buffer access ops
Date: Thu, 1 Dec 2011 15:19:20 +0100
Message-ID: <1322749170-21407-1-git-send-email-lars@metafoo.de>
MIME-Version: 1.0
Content-Type: text/plain
List-ID: <linux-iio@vger.kernel.org>

Add some convenience wrapper functions around the buffer access operations. This
makes the resulting code both a bit easier to read and to write.

Signed-off-by: Lars-Peter Clausen <lars@metafoo.de>
---
The patches in this series depend on Jonathans buffer cleanup patches.
---
 drivers/staging/iio/buffer.h              |   68 +++++++++++++++++++++++++++++
 drivers/staging/iio/industrialio-buffer.c |   63 +++++++++++---------------
 2 files changed, 95 insertions(+), 36 deletions(-)

diff --git a/drivers/staging/iio/buffer.h b/drivers/staging/iio/buffer.h
index c697099..9383d2d 100644
--- a/drivers/staging/iio/buffer.h
+++ b/drivers/staging/iio/buffer.h
@@ -194,6 +194,74 @@ ssize_t iio_buffer_show_enable(struct device *dev,
 
 int iio_sw_buffer_preenable(struct iio_dev *indio_dev);
 
+static inline void buffer_mark_in_use(struct iio_buffer *buffer)
+{
+	if (buffer->access->mark_in_use)
+		buffer->access->mark_in_use(buffer);
+}
+
+static inline void buffer_unmark_in_use(struct iio_buffer *buffer)
+{
+	if (buffer->access->unmark_in_use)
+		buffer->access->unmark_in_use(buffer);
+}
+
+static inline int buffer_store_to(struct iio_buffer *buffer, u8 *data,
+	s64 timestamp)
+{
+	return buffer->access->store_to(buffer, data, timestamp);
+}
+
+static inline int buffer_read_first_n(struct iio_buffer *buffer, size_t n,
+	char __user *buf)
+{
+	return buffer->access->read_first_n(buffer, n, buf);
+}
+
+static inline int buffer_mark_param_change(struct iio_buffer *buffer)
+{
+	if (buffer->access->mark_param_change)
+		return buffer->access->mark_param_change(buffer);
+
+	return 0;
+}
+
+static inline int buffer_request_update(struct iio_buffer *buffer)
+{
+	if (buffer->access->request_update)
+		return buffer->access->request_update(buffer);
+
+	return 0;
+}
+
+static inline int buffer_get_bytes_per_datum(struct iio_buffer *buffer)
+{
+	return buffer->access->get_bytes_per_datum(buffer);
+}
+
+static inline int buffer_set_bytes_per_datum(struct iio_buffer *buffer,
+	size_t bpd)
+{
+	return buffer->access->set_bytes_per_datum(buffer, bpd);
+}
+
+static inline int buffer_get_length(struct iio_buffer *buffer)
+{
+	if (buffer->access->get_length)
+		return buffer->access->get_length(buffer);
+
+	return -ENOSYS;
+}
+
+static inline int buffer_set_length(struct iio_buffer *buffer,
+	int length)
+{
+	if (buffer->access->set_length)
+		return buffer->access->set_length(buffer, length);
+
+	return -ENOSYS;
+}
+
 #else /* CONFIG_IIO_BUFFER */
 
 static inline int iio_buffer_register(struct iio_dev *indio_dev,
diff --git a/drivers/staging/iio/industrialio-buffer.c b/drivers/staging/iio/industrialio-buffer.c
index f131088..165c88e 100644
--- a/drivers/staging/iio/industrialio-buffer.c
+++ b/drivers/staging/iio/industrialio-buffer.c
@@ -43,9 +43,9 @@ ssize_t iio_buffer_read_first_n_outer(struct file *filp, char __user *buf,
 	struct iio_dev *indio_dev = filp->private_data;
 	struct iio_buffer *rb = indio_dev->buffer;
 
-	if (!rb || !rb->access->read_first_n)
+	if (!rb)
 		return -EINVAL;
-	return rb->access->read_first_n(rb, n, buf);
+	return buffer_read_first_n(rb, n, buf);
 }
 
 /**
@@ -69,8 +69,7 @@ int iio_chrdev_buffer_open(struct iio_dev *indio_dev)
 	struct iio_buffer *rb = indio_dev->buffer;
 	if (!rb)
 		return 0;
-	if (rb->access->mark_in_use)
-		rb->access->mark_in_use(rb);
+	buffer_mark_in_use(rb);
 	return 0;
 }
 
@@ -81,8 +80,7 @@ void iio_chrdev_buffer_release(struct iio_dev *indio_dev)
 	if (!rb)
 		return;
 	clear_bit(IIO_BUSY_BIT_POS, &rb->flags);
-	if (rb->access->unmark_in_use)
-		rb->access->unmark_in_use(rb);
+	buffer_unmark_in_use(rb);
 }
 
 void iio_buffer_init(struct iio_buffer *buffer)
@@ -371,12 +369,13 @@ ssize_t iio_buffer_read_length(struct device *dev,
 {
 	struct iio_dev *indio_dev = dev_get_drvdata(dev);
 	struct iio_buffer *buffer = indio_dev->buffer;
+	int len;
 
-	if (buffer->access->get_length)
-		return sprintf(buf, "%d\n",
-			       buffer->access->get_length(buffer));
+	len = buffer_get_length(buffer);
+	if (len < 0)
+		return 0;
 
-	return 0;
+	return sprintf(buf, "%d\n", len);
 }
 EXPORT_SYMBOL(iio_buffer_read_length);
 
@@ -394,15 +393,13 @@ ssize_t iio_buffer_write_length(struct device *dev,
 	if (ret)
 		return ret;
 
-	if (buffer->access->get_length)
-		if (val == buffer->access->get_length(buffer))
-			return len;
+	ret = buffer_get_length(buffer);
+	if (ret >= 0 && ret == val)
+		return len;
 
-	if (buffer->access->set_length) {
-		buffer->access->set_length(buffer, val);
-		if (buffer->access->mark_param_change)
-			buffer->access->mark_param_change(buffer);
-	}
+	ret = buffer_set_length(buffer, val);
+	if (ret)
+		buffer_mark_param_change(buffer);
 
 	return len;
 }
@@ -437,25 +434,21 @@ ssize_t iio_buffer_store_enable(struct device *dev,
 				goto error_ret;
 			}
 		}
-		if (buffer->access->request_update) {
-			ret = buffer->access->request_update(buffer);
-			if (ret) {
-				printk(KERN_INFO
-				       "Buffer not started:"
-				       "buffer parameter update failed\n");
-				goto error_ret;
-			}
+		ret = buffer_request_update(buffer);
+		if (ret) {
+			printk(KERN_INFO
+				   "Buffer not started:"
+				   "buffer parameter update failed\n");
+			goto error_ret;
 		}
-		if (buffer->access->mark_in_use)
-			buffer->access->mark_in_use(buffer);
+		buffer_mark_in_use(buffer);
 		/* Definitely possible for devices to support both of these.*/
 		if (indio_dev->modes & INDIO_BUFFER_TRIGGERED) {
 			if (!indio_dev->trig) {
 				printk(KERN_INFO
 				       "Buffer not started: no trigger\n");
 				ret = -EINVAL;
-				if (buffer->access->unmark_in_use)
-					buffer->access->unmark_in_use(buffer);
+				buffer_unmark_in_use(buffer);
 				goto error_ret;
 			}
 			indio_dev->currentmode = INDIO_BUFFER_TRIGGERED;
@@ -472,8 +465,7 @@ ssize_t iio_buffer_store_enable(struct device *dev,
 				printk(KERN_INFO
 				       "Buffer not started:"
 				       "postenable failed\n");
-				if (buffer->access->unmark_in_use)
-					buffer->access->unmark_in_use(buffer);
+				buffer_unmark_in_use(buffer);
 				indio_dev->currentmode = previous_mode;
 				if (indio_dev->setup_ops->postdisable)
 					indio_dev->setup_ops->
@@ -487,8 +479,7 @@ ssize_t iio_buffer_store_enable(struct device *dev,
 			if (ret)
 				goto error_ret;
 		}
-		if (buffer->access->unmark_in_use)
-			buffer->access->unmark_in_use(buffer);
+		buffer_unmark_in_use(buffer);
 		indio_dev->currentmode = INDIO_DIRECT_MODE;
 		if (indio_dev->setup_ops->postdisable) {
 			ret = indio_dev->setup_ops->postdisable(indio_dev);
@@ -556,7 +547,7 @@ int iio_sw_buffer_preenable(struct iio_dev *indio_dev)
 			bytes += length - bytes % length;
 		bytes += length;
 	}
-	buffer->access->set_bytes_per_datum(buffer, bytes);
+	buffer_set_bytes_per_datum(buffer, bytes);
 
 	/* What scan mask do we actually have ?*/
 	if (indio_dev->available_scan_masks)
@@ -674,7 +665,7 @@ int iio_push_to_buffer(struct iio_buffer *buffer, unsigned char *data,
 {
 	unsigned char *dataout = iio_demux(buffer, data);
 
-	return buffer->access->store_to(buffer, dataout, timestamp);
+	return buffer_store_to(buffer, dataout, timestamp);
 }
 EXPORT_SYMBOL_GPL(iio_push_to_buffer);
 
-- 
1.7.7.3
