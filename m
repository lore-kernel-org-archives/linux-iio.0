Return-Path: <linux-iio-owner@vger.kernel.org>
Received: from mga03.intel.com ([134.134.136.65]:60030 "EHLO mga03.intel.com"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1753926AbbAaAAb (ORCPT <rfc822;linux-iio@vger.kernel.org>);
	Fri, 30 Jan 2015 19:00:31 -0500
From: Octavian Purdila <octavian.purdila@intel.com>
To: linux-iio@vger.kernel.org
Cc: srinivas.pandruvada@linux.intel.com,
	Octavian Purdila <octavian.purdila@intel.com>
Subject: [PATCH v3 3/9] iio: add support for hardware fifo
Date: Sat, 31 Jan 2015 02:00:02 +0200
Message-Id: <1422662408-8149-4-git-send-email-octavian.purdila@intel.com>
In-Reply-To: <1422662408-8149-1-git-send-email-octavian.purdila@intel.com>
References: <1422662408-8149-1-git-send-email-octavian.purdila@intel.com>
Sender: linux-iio-owner@vger.kernel.org
List-Id: linux-iio@vger.kernel.org

Some devices have hardware buffers that can store a number of samples
for later consumption. Hardware usually provides interrupts to notify
the processor when the fifo is full or when it has reached a certain
threshold. This helps with reducing the number of interrupts to the
host processor and thus it helps decreasing the power consumption.

This patch adds support for hardware fifo to IIO by allowing the
drivers to register operations for flushing the hadware fifo and
setting the watermark level.

A driver implementing hardware fifo support must also provide a
watermark trigger which must contain "watermark" in its name.

Signed-off-by: Octavian Purdila <octavian.purdila@intel.com>
---
 Documentation/ABI/testing/sysfs-bus-iio | 30 +++++++++++++
 drivers/iio/industrialio-buffer.c       | 78 ++++++++++++++++++++++++++++++---
 include/linux/iio/iio.h                 | 18 ++++++++
 3 files changed, 121 insertions(+), 5 deletions(-)

diff --git a/Documentation/ABI/testing/sysfs-bus-iio b/Documentation/ABI/testing/sysfs-bus-iio
index 2a3dc12..34b4f99 100644
--- a/Documentation/ABI/testing/sysfs-bus-iio
+++ b/Documentation/ABI/testing/sysfs-bus-iio
@@ -1203,3 +1203,33 @@ Description:
 		Poll will block until the watermark is reached.
 		Blocking read will wait until the minimum between the requested
 		read amount or the low water mark is available.
+
+What:		/sys/bus/iio/devices/iio:deviceX/buffer/hwfifo_length
+KernelVersion:	3.20
+Contact:	linux-iio@vger.kernel.org
+Description:
+		A single positive integer specifying the maximum number of
+		samples that the hardware fifo has. If the device does not
+		support hardware fifo this is zero.
+		When a device supports hardware fifo it will expose a trigger
+		with the name that contains "watermark"
+		(e.g. i2c-BMC150A:00-watermark-dev0).
+		To use the hardware fifo the user must set an appropriate value
+		in the buffer/length, buffer/low_watermark and
+		buffer/hwfifo_watermark entries and select the watermark
+		trigger. At that point the hardware fifo will be enabled and the
+		samples will be collected in the hardware buffer. When the
+		number of samples in the hardware fifo reaches the watermark
+		level the watermark trigger is issued and data is flushed to the
+		devices buffer.
+		A hardware buffer flush will also be triggered when reading from
+		the device buffer and there is not enough data available.
+
+What:		/sys/bus/iio/devices/iio:deviceX/buffer/hwfifo_watermark
+KernelVersion:	3.20
+Contact:	linux-iio@vger.kernel.org
+Description:
+		A single positive integer specifying the watermark level for the
+		hardware fifo. When the number of samples in the hardware fifo
+		reaches the hardware fifo watermark the device watermark
+		trigger will be asserted.
diff --git a/drivers/iio/industrialio-buffer.c b/drivers/iio/industrialio-buffer.c
index e008ce03..624a9dd 100644
--- a/drivers/iio/industrialio-buffer.c
+++ b/drivers/iio/industrialio-buffer.c
@@ -37,9 +37,17 @@ static bool iio_buffer_is_active(struct iio_buffer *buf)
 	return !list_empty(&buf->buffer_list);
 }
 
-static size_t iio_buffer_data_available(struct iio_buffer *buf)
+static bool iio_check_and_flush_data(struct iio_dev *indio_dev,
+				     struct iio_buffer *buf, size_t required)
 {
-	return buf->access->data_available(buf);
+	size_t avail = buf->access->data_available(buf);
+
+	if (avail < required && indio_dev->hwfifo) {
+		indio_dev->hwfifo->flush(indio_dev, required);
+		avail = buf->access->data_available(buf);
+	}
+
+	return avail >= required;
 }
 
 /**
@@ -75,13 +83,13 @@ ssize_t iio_buffer_read_first_n_outer(struct file *filp, char __user *buf,
 
 	do {
 		if (filp->f_flags & O_NONBLOCK) {
-			if (!iio_buffer_data_available(rb)) {
+			if (!iio_check_and_flush_data(indio_dev, rb, 1)) {
 				ret = -EAGAIN;
 				break;
 			}
 		} else {
 			ret = wait_event_interruptible(rb->pollq,
-			       iio_buffer_data_available(rb) >= to_read ||
+			     iio_check_and_flush_data(indio_dev, rb, to_read) ||
 						       indio_dev->info == NULL);
 			if (ret)
 				return ret;
@@ -121,7 +129,7 @@ unsigned int iio_buffer_poll(struct file *filp,
 		return -ENODEV;
 
 	poll_wait(filp, &rb->pollq, wait);
-	if (iio_buffer_data_available(rb) >= rb->low_watermark)
+	if (iio_check_and_flush_data(indio_dev, rb, rb->low_watermark))
 		return POLLIN | POLLRDNORM;
 	return 0;
 }
@@ -829,6 +837,60 @@ out:
 	return ret ? ret : len;
 }
 
+ssize_t iio_buffer_hwfifo_read_length(struct device *dev,
+				      struct device_attribute *attr,
+				      char *buf)
+{
+	struct iio_dev *indio_dev = dev_to_iio_dev(dev);
+	struct iio_hwfifo *hwfifo = indio_dev->hwfifo;
+
+	return sprintf(buf, "%u\n", hwfifo ? hwfifo->length : 0);
+}
+
+static ssize_t iio_buffer_hwfifo_show_watermark(struct device *dev,
+						struct device_attribute *attr,
+						char *buf)
+{
+	struct iio_dev *indio_dev = dev_to_iio_dev(dev);
+	struct iio_hwfifo *hwfifo = indio_dev->hwfifo;
+
+	return sprintf(buf, "%u\n", hwfifo ? hwfifo->watermark : 0);
+}
+
+static ssize_t iio_buffer_hwfifo_store_watermark(struct device *dev,
+						 struct device_attribute *attr,
+						 const char *buf,
+						 size_t len)
+{
+	struct iio_dev *indio_dev = dev_to_iio_dev(dev);
+	struct iio_hwfifo *hwfifo = indio_dev->hwfifo;
+	unsigned int val;
+	int ret;
+
+	ret = kstrtouint(buf, 10, &val);
+	if (ret)
+		return ret;
+
+	if (!hwfifo || val > hwfifo->length)
+		return -EINVAL;
+
+	mutex_lock(&indio_dev->mlock);
+	if (iio_buffer_is_active(indio_dev->buffer)) {
+		ret = -EBUSY;
+		goto out;
+	}
+
+	ret = indio_dev->hwfifo->set_watermark(indio_dev, val);
+	if (ret)
+		goto out;
+
+	hwfifo->watermark = val;
+out:
+	mutex_unlock(&indio_dev->mlock);
+
+	return ret ? ret : len;
+}
+
 static DEVICE_ATTR(length, S_IRUGO | S_IWUSR, iio_buffer_read_length,
 		   iio_buffer_write_length);
 static struct device_attribute dev_attr_length_ro = __ATTR(length,
@@ -837,11 +899,17 @@ static DEVICE_ATTR(enable, S_IRUGO | S_IWUSR,
 		   iio_buffer_show_enable, iio_buffer_store_enable);
 static DEVICE_ATTR(low_watermark, S_IRUGO | S_IWUSR,
 		   iio_buffer_show_watermark, iio_buffer_store_watermark);
+static DEVICE_ATTR(hwfifo_length, S_IRUGO, iio_buffer_hwfifo_read_length, NULL);
+static DEVICE_ATTR(hwfifo_watermark, S_IRUGO | S_IWUSR,
+		   iio_buffer_hwfifo_show_watermark,
+		   iio_buffer_hwfifo_store_watermark);
 
 static struct attribute *iio_buffer_attrs[] = {
 	&dev_attr_length.attr,
 	&dev_attr_enable.attr,
 	&dev_attr_low_watermark.attr,
+	&dev_attr_hwfifo_length.attr,
+	&dev_attr_hwfifo_watermark.attr,
 };
 
 int iio_buffer_alloc_sysfs_and_mask(struct iio_dev *indio_dev)
diff --git a/include/linux/iio/iio.h b/include/linux/iio/iio.h
index 51f1643..9cde2f9 100644
--- a/include/linux/iio/iio.h
+++ b/include/linux/iio/iio.h
@@ -419,6 +419,22 @@ struct iio_buffer_setup_ops {
 };
 
 /**
+ * struct iio_hwfifo - hardware fifo ops and info
+ *
+ * @length:		[DRIVER] the hardware fifo length
+ * @watermark:		[INTERN] the current hardware fifo watermark level
+ * @set_watermark:	[DRIVER] function to set the watermark level
+ * @flush:		[DRIVER] copies data from the hardware buffer to the
+ *			device buffer
+ */
+struct iio_hwfifo {
+	int length;
+	int watermark;
+	int (*set_watermark)(struct iio_dev *, unsigned int);
+	int (*flush)(struct iio_dev *, int samples);
+};
+
+/**
  * struct iio_dev - industrial I/O device
  * @id:			[INTERN] used to identify device internally
  * @modes:		[DRIVER] operating modes supported by device
@@ -453,6 +469,7 @@ struct iio_buffer_setup_ops {
  * @groups:		[INTERN] attribute groups
  * @groupcounter:	[INTERN] index of next attribute group
  * @flags:		[INTERN] file ops related flags including busy flag.
+ * @hwfifo:		[INTERN] hardware fifo ops and info
  * @debugfs_dentry:	[INTERN] device specific debugfs dentry.
  * @cached_reg_addr:	[INTERN] cached register address for debugfs reads.
  */
@@ -493,6 +510,7 @@ struct iio_dev {
 	int				groupcounter;
 
 	unsigned long			flags;
+	struct iio_hwfifo		*hwfifo;
 #if defined(CONFIG_DEBUG_FS)
 	struct dentry			*debugfs_dentry;
 	unsigned			cached_reg_addr;
-- 
1.9.1

