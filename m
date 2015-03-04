Return-Path: <linux-iio-owner@vger.kernel.org>
Received: from mga02.intel.com ([134.134.136.20]:28567 "EHLO mga02.intel.com"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S933133AbbCDR4T (ORCPT <rfc822;linux-iio@vger.kernel.org>);
	Wed, 4 Mar 2015 12:56:19 -0500
From: Octavian Purdila <octavian.purdila@intel.com>
To: linux-iio@vger.kernel.org
Cc: srinivas.pandruvada@linux.intel.com,
	Josselin Costanzi <josselin.costanzi@mobile-devices.fr>,
	Octavian Purdila <octavian.purdila@intel.com>
Subject: [PATCH v5 1/3] iio: add watermark logic to iio read and poll
Date: Wed,  4 Mar 2015 19:56:11 +0200
Message-Id: <1425491773-28499-2-git-send-email-octavian.purdila@intel.com>
In-Reply-To: <1425491773-28499-1-git-send-email-octavian.purdila@intel.com>
References: <1425491773-28499-1-git-send-email-octavian.purdila@intel.com>
Sender: linux-iio-owner@vger.kernel.org
List-Id: linux-iio@vger.kernel.org

From: Josselin Costanzi <josselin.costanzi@mobile-devices.fr>

Currently the IIO buffer blocking read only wait until at least one
data element is available.
This patch makes the reader sleep until enough data is collected before
returning to userspace. This should limit the read() calls count when
trying to get data in batches.

Co-author: Yannick Bedhomme <yannick.bedhomme@mobile-devices.fr>
Signed-off-by: Josselin Costanzi <josselin.costanzi@mobile-devices.fr>
[rebased and remove buffer timeout]
Signed-off-by: Octavian Purdila <octavian.purdila@intel.com>
---
 Documentation/ABI/testing/sysfs-bus-iio  |  15 ++++
 drivers/iio/industrialio-buffer.c        | 118 +++++++++++++++++++++++++++----
 drivers/iio/kfifo_buf.c                  |  11 ++-
 drivers/staging/iio/accel/sca3000_ring.c |   4 +-
 include/linux/iio/buffer.h               |   8 ++-
 5 files changed, 129 insertions(+), 27 deletions(-)

diff --git a/Documentation/ABI/testing/sysfs-bus-iio b/Documentation/ABI/testing/sysfs-bus-iio
index 9a70c31..1283ca7 100644
--- a/Documentation/ABI/testing/sysfs-bus-iio
+++ b/Documentation/ABI/testing/sysfs-bus-iio
@@ -1249,3 +1249,18 @@ Contact:	linux-iio@vger.kernel.org
 Description:
 		Specifies number of seconds in which we compute the steps
 		that occur in order to decide if the consumer is making steps.
+
+What:		/sys/bus/iio/devices/iio:deviceX/buffer/watermark
+KernelVersion:	3.21
+Contact:	linux-iio@vger.kernel.org
+Description:
+		A single positive integer specifying the maximum number of scan
+		elements to wait for.
+		Poll will block until the watermark is reached.
+		Blocking read will wait until the minimum between the requested
+		read amount or the low water mark is available.
+		Non-blocking read will retrieve the available samples from the
+		buffer even if there are less samples then watermark level. This
+		allows the application to block on poll with a timeout and read
+		the available samples after the timeout expires and thus have a
+		maximum delay guarantee.
diff --git a/drivers/iio/industrialio-buffer.c b/drivers/iio/industrialio-buffer.c
index c2d5440..a4f4f07 100644
--- a/drivers/iio/industrialio-buffer.c
+++ b/drivers/iio/industrialio-buffer.c
@@ -37,11 +37,28 @@ static bool iio_buffer_is_active(struct iio_buffer *buf)
 	return !list_empty(&buf->buffer_list);
 }
 
-static bool iio_buffer_data_available(struct iio_buffer *buf)
+static size_t iio_buffer_data_available(struct iio_buffer *buf)
 {
 	return buf->access->data_available(buf);
 }
 
+static bool iio_buffer_ready(struct iio_dev *indio_dev, struct iio_buffer *buf,
+			     size_t to_wait)
+{
+	/* wakeup if the device was unregistered */
+	if (!indio_dev->info)
+		return true;
+
+	/* drain the buffer if it was disabled */
+	if (!iio_buffer_is_active(buf))
+		to_wait = min_t(size_t, to_wait, 1);
+
+	if (iio_buffer_data_available(buf) >= to_wait)
+		return true;
+
+	return false;
+}
+
 /**
  * iio_buffer_read_first_n_outer() - chrdev read for buffer access
  *
@@ -53,6 +70,8 @@ ssize_t iio_buffer_read_first_n_outer(struct file *filp, char __user *buf,
 {
 	struct iio_dev *indio_dev = filp->private_data;
 	struct iio_buffer *rb = indio_dev->buffer;
+	size_t datum_size = rb->bytes_per_datum;
+	size_t to_wait = 0;
 	int ret;
 
 	if (!indio_dev->info)
@@ -61,19 +80,24 @@ ssize_t iio_buffer_read_first_n_outer(struct file *filp, char __user *buf,
 	if (!rb || !rb->access->read_first_n)
 		return -EINVAL;
 
+	/*
+	 * If datum_size is 0 there will never be anything to read from the
+	 * buffer, so signal end of file now.
+	 */
+	if (!datum_size)
+		return 0;
+
+	if (!(filp->f_flags & O_NONBLOCK))
+		to_wait = min_t(size_t, n / datum_size, rb->watermark);
+
 	do {
-		if (!iio_buffer_data_available(rb)) {
-			if (filp->f_flags & O_NONBLOCK)
-				return -EAGAIN;
+		ret = wait_event_interruptible(rb->pollq,
+				      iio_buffer_ready(indio_dev, rb, to_wait));
+		if (ret)
+			return ret;
 
-			ret = wait_event_interruptible(rb->pollq,
-					iio_buffer_data_available(rb) ||
-					indio_dev->info == NULL);
-			if (ret)
-				return ret;
-			if (indio_dev->info == NULL)
-				return -ENODEV;
-		}
+		if (!indio_dev->info)
+			return -ENODEV;
 
 		ret = rb->access->read_first_n(rb, n, buf);
 		if (ret == 0 && (filp->f_flags & O_NONBLOCK))
@@ -96,9 +120,8 @@ unsigned int iio_buffer_poll(struct file *filp,
 		return -ENODEV;
 
 	poll_wait(filp, &rb->pollq, wait);
-	if (iio_buffer_data_available(rb))
+	if (iio_buffer_ready(indio_dev, rb, rb->watermark))
 		return POLLIN | POLLRDNORM;
-	/* need a way of knowing if there may be enough data... */
 	return 0;
 }
 
@@ -123,6 +146,7 @@ void iio_buffer_init(struct iio_buffer *buffer)
 	INIT_LIST_HEAD(&buffer->buffer_list);
 	init_waitqueue_head(&buffer->pollq);
 	kref_init(&buffer->ref);
+	buffer->watermark = 1;
 }
 EXPORT_SYMBOL(iio_buffer_init);
 
@@ -416,6 +440,11 @@ static ssize_t iio_buffer_write_length(struct device *dev,
 		buffer->access->set_length(buffer, val);
 		ret = 0;
 	}
+	if (ret)
+		goto out;
+	if (buffer->length && buffer->length < buffer->watermark)
+		buffer->watermark = buffer->length;
+out:
 	mutex_unlock(&indio_dev->mlock);
 
 	return ret ? ret : len;
@@ -472,6 +501,7 @@ static void iio_buffer_activate(struct iio_dev *indio_dev,
 static void iio_buffer_deactivate(struct iio_buffer *buffer)
 {
 	list_del_init(&buffer->buffer_list);
+	wake_up_interruptible(&buffer->pollq);
 	iio_buffer_put(buffer);
 }
 
@@ -754,16 +784,64 @@ done:
 
 static const char * const iio_scan_elements_group_name = "scan_elements";
 
+static ssize_t iio_buffer_show_watermark(struct device *dev,
+					 struct device_attribute *attr,
+					 char *buf)
+{
+	struct iio_dev *indio_dev = dev_to_iio_dev(dev);
+	struct iio_buffer *buffer = indio_dev->buffer;
+
+	return sprintf(buf, "%u\n", buffer->watermark);
+}
+
+static ssize_t iio_buffer_store_watermark(struct device *dev,
+					  struct device_attribute *attr,
+					  const char *buf,
+					  size_t len)
+{
+	struct iio_dev *indio_dev = dev_to_iio_dev(dev);
+	struct iio_buffer *buffer = indio_dev->buffer;
+	unsigned int val;
+	int ret;
+
+	ret = kstrtouint(buf, 10, &val);
+	if (ret)
+		return ret;
+	if (!val)
+		return -EINVAL;
+
+	mutex_lock(&indio_dev->mlock);
+
+	if (val > buffer->length) {
+		ret = -EINVAL;
+		goto out;
+	}
+
+	if (iio_buffer_is_active(indio_dev->buffer)) {
+		ret = -EBUSY;
+		goto out;
+	}
+
+	buffer->watermark = val;
+out:
+	mutex_unlock(&indio_dev->mlock);
+
+	return ret ? ret : len;
+}
+
 static DEVICE_ATTR(length, S_IRUGO | S_IWUSR, iio_buffer_read_length,
 		   iio_buffer_write_length);
 static struct device_attribute dev_attr_length_ro = __ATTR(length,
 	S_IRUGO, iio_buffer_read_length, NULL);
 static DEVICE_ATTR(enable, S_IRUGO | S_IWUSR,
 		   iio_buffer_show_enable, iio_buffer_store_enable);
+static DEVICE_ATTR(watermark, S_IRUGO | S_IWUSR,
+		   iio_buffer_show_watermark, iio_buffer_store_watermark);
 
 static struct attribute *iio_buffer_attrs[] = {
 	&dev_attr_length.attr,
 	&dev_attr_enable.attr,
+	&dev_attr_watermark.attr,
 };
 
 int iio_buffer_alloc_sysfs_and_mask(struct iio_dev *indio_dev)
@@ -944,8 +1022,18 @@ static const void *iio_demux(struct iio_buffer *buffer,
 static int iio_push_to_buffer(struct iio_buffer *buffer, const void *data)
 {
 	const void *dataout = iio_demux(buffer, data);
+	int ret;
+
+	ret = buffer->access->store_to(buffer, dataout);
+	if (ret)
+		return ret;
 
-	return buffer->access->store_to(buffer, dataout);
+	/*
+	 * We can't just test for watermark to decide if we wake the poll queue
+	 * because read may request less samples than the watermark.
+	 */
+	wake_up_interruptible_poll(&buffer->pollq, POLLIN | POLLRDNORM);
+	return 0;
 }
 
 static void iio_buffer_demux_free(struct iio_buffer *buffer)
diff --git a/drivers/iio/kfifo_buf.c b/drivers/iio/kfifo_buf.c
index b2beea0..847ca56 100644
--- a/drivers/iio/kfifo_buf.c
+++ b/drivers/iio/kfifo_buf.c
@@ -83,9 +83,6 @@ static int iio_store_to_kfifo(struct iio_buffer *r,
 	ret = kfifo_in(&kf->kf, data, 1);
 	if (ret != 1)
 		return -EBUSY;
-
-	wake_up_interruptible_poll(&r->pollq, POLLIN | POLLRDNORM);
-
 	return 0;
 }
 
@@ -109,16 +106,16 @@ static int iio_read_first_n_kfifo(struct iio_buffer *r,
 	return copied;
 }
 
-static bool iio_kfifo_buf_data_available(struct iio_buffer *r)
+static size_t iio_kfifo_buf_data_available(struct iio_buffer *r)
 {
 	struct iio_kfifo *kf = iio_to_kfifo(r);
-	bool empty;
+	size_t samples;
 
 	mutex_lock(&kf->user_lock);
-	empty = kfifo_is_empty(&kf->kf);
+	samples = kfifo_len(&kf->kf);
 	mutex_unlock(&kf->user_lock);
 
-	return !empty;
+	return samples;
 }
 
 static void iio_kfifo_buffer_release(struct iio_buffer *buffer)
diff --git a/drivers/staging/iio/accel/sca3000_ring.c b/drivers/staging/iio/accel/sca3000_ring.c
index f76a268..8589ead 100644
--- a/drivers/staging/iio/accel/sca3000_ring.c
+++ b/drivers/staging/iio/accel/sca3000_ring.c
@@ -129,9 +129,9 @@ error_ret:
 	return ret ? ret : num_read;
 }
 
-static bool sca3000_ring_buf_data_available(struct iio_buffer *r)
+static size_t sca3000_ring_buf_data_available(struct iio_buffer *r)
 {
-	return r->stufftoread;
+	return r->stufftoread ? r->watermark : 0;
 }
 
 /**
diff --git a/include/linux/iio/buffer.h b/include/linux/iio/buffer.h
index b65850a..eb8622b 100644
--- a/include/linux/iio/buffer.h
+++ b/include/linux/iio/buffer.h
@@ -21,8 +21,8 @@ struct iio_buffer;
  * struct iio_buffer_access_funcs - access functions for buffers.
  * @store_to:		actually store stuff to the buffer
  * @read_first_n:	try to get a specified number of bytes (must exist)
- * @data_available:	indicates whether data for reading from the buffer is
- *			available.
+ * @data_available:	indicates how much data is available for reading from
+ *			the buffer.
  * @request_update:	if a parameter change has been marked, update underlying
  *			storage.
  * @set_bytes_per_datum:set number of bytes per datum
@@ -43,7 +43,7 @@ struct iio_buffer_access_funcs {
 	int (*read_first_n)(struct iio_buffer *buffer,
 			    size_t n,
 			    char __user *buf);
-	bool (*data_available)(struct iio_buffer *buffer);
+	size_t (*data_available)(struct iio_buffer *buffer);
 
 	int (*request_update)(struct iio_buffer *buffer);
 
@@ -72,6 +72,7 @@ struct iio_buffer_access_funcs {
  * @demux_bounce:	[INTERN] buffer for doing gather from incoming scan.
  * @buffer_list:	[INTERN] entry in the devices list of current buffers.
  * @ref:		[INTERN] reference count of the buffer.
+ * @watermark:		[INTERN] number of datums to wait for poll/read.
  */
 struct iio_buffer {
 	int					length;
@@ -90,6 +91,7 @@ struct iio_buffer {
 	void					*demux_bounce;
 	struct list_head			buffer_list;
 	struct kref				ref;
+	unsigned int				watermark;
 };
 
 /**
-- 
1.9.1

