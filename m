Return-Path: <linux-iio-owner@vger.kernel.org>
Received: from mga14.intel.com ([192.55.52.115]:20331 "EHLO mga14.intel.com"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1756819AbbCCQVV (ORCPT <rfc822;linux-iio@vger.kernel.org>);
	Tue, 3 Mar 2015 11:21:21 -0500
From: Octavian Purdila <octavian.purdila@intel.com>
To: linux-iio@vger.kernel.org
Cc: srinivas.pandruvada@linux.intel.com,
	Octavian Purdila <octavian.purdila@intel.com>
Subject: [PATCH v4 2/3] iio: add support for hardware fifo
Date: Tue,  3 Mar 2015 18:21:01 +0200
Message-Id: <1425399662-5539-3-git-send-email-octavian.purdila@intel.com>
In-Reply-To: <1425399662-5539-1-git-send-email-octavian.purdila@intel.com>
References: <1425399662-5539-1-git-send-email-octavian.purdila@intel.com>
Sender: linux-iio-owner@vger.kernel.org
List-Id: linux-iio@vger.kernel.org

Some devices have hardware buffers that can store a number of samples
for later consumption. Hardware usually provides interrupts to notify
the processor when the fifo is full or when it has reached a certain
threshold. This helps with reducing the number of interrupts to the
host processor and thus it helps decreasing the power consumption.

This patch adds support for hardware fifo to IIO by adding drivers
operations for flushing the hadware fifo and setting and getting the
watermark level.

Since a driver may support hardware fifo only when not in triggered
buffer mode (due to different samantics of hardware fifo sampling and
triggered sampling) this patch changes the IIO core code to allow
falling back to non-triggered buffered mode if no trigger is enabled.

Signed-off-by: Octavian Purdila <octavian.purdila@intel.com>
---
 Documentation/ABI/testing/sysfs-bus-iio | 25 +++++++++++
 drivers/iio/industrialio-buffer.c       | 78 ++++++++++++++++++++++++++++-----
 include/linux/iio/iio.h                 | 26 +++++++++++
 3 files changed, 119 insertions(+), 10 deletions(-)

diff --git a/Documentation/ABI/testing/sysfs-bus-iio b/Documentation/ABI/testing/sysfs-bus-iio
index 1283ca7..143ddf2d 100644
--- a/Documentation/ABI/testing/sysfs-bus-iio
+++ b/Documentation/ABI/testing/sysfs-bus-iio
@@ -1264,3 +1264,28 @@ Description:
 		allows the application to block on poll with a timeout and read
 		the available samples after the timeout expires and thus have a
 		maximum delay guarantee.
+
+What:          /sys/bus/iio/devices/iio:deviceX/buffer/hwfifo_watermark
+KernelVersion: 3.21
+Contact:       linux-iio@vger.kernel.org
+Description:
+	       Read-only entry that contains a single integer specifying the
+	       current level for the hardware fifo watermark level. If this
+	       value is negative it means that the device does not support a
+	       hardware fifo. If this value is 0 it means that the hardware fifo
+	       is currently disabled.
+	       If this value is strictly positive it signals that the hardware
+	       fifo of the device is active and that samples are stored in an
+	       internal hardware buffer. When the level of the hardware fifo
+	       reaches the watermark level the device will flush its internal
+	       buffer to the device buffer. Because of this a trigger is not
+	       needed to use the device in buffer mode.
+	       The hardware watermark level is set by the driver based on the
+	       value set by the user in buffer/watermark but taking into account
+	       the limitations of the hardware (e.g. most hardware buffers are
+	       limited to 32-64 samples).
+	       Because the sematics of triggers and hardware fifo may be
+	       different (e.g. the hadware fifo may record samples according to
+	       the sample rate while an any-motion trigger generates samples
+	       based on the set rate of change) setting a trigger may disable
+	       the hardware fifo.
diff --git a/drivers/iio/industrialio-buffer.c b/drivers/iio/industrialio-buffer.c
index ecf01c9..3697e5e 100644
--- a/drivers/iio/industrialio-buffer.c
+++ b/drivers/iio/industrialio-buffer.c
@@ -42,6 +42,44 @@ static size_t iio_buffer_data_available(struct iio_buffer *buf)
 	return buf->access->data_available(buf);
 }
 
+static int iio_buffer_flush_hwfifo(struct iio_dev *indio_dev,
+				   struct iio_buffer *buf, size_t required)
+{
+	int ret = -ENODEV;
+
+	if (!indio_dev->info->hwfifo_flush)
+		return ret;
+
+	mutex_lock(&indio_dev->mlock);
+	if (indio_dev->active_scan_mask)
+		ret = indio_dev->info->hwfifo_flush(indio_dev, required);
+	mutex_unlock(&indio_dev->mlock);
+
+	return ret;
+}
+
+static bool iio_buffer_ready(struct iio_dev *indio_dev, struct iio_buffer *rb,
+			     size_t to_read)
+{
+	size_t avail = iio_buffer_data_available(rb);
+	int flushed;
+
+	if (!indio_dev->info)
+		return true;
+
+	if (avail >= to_read)
+		return true;
+
+	flushed = iio_buffer_flush_hwfifo(indio_dev, rb, to_read - avail);
+	if (flushed <= 0)
+		return false;
+
+	if (avail + flushed >= to_read)
+		return true;
+
+	return false;
+}
+
 /**
  * iio_buffer_read_first_n_outer() - chrdev read for buffer access
  *
@@ -75,14 +113,14 @@ ssize_t iio_buffer_read_first_n_outer(struct file *filp, char __user *buf,
 
 	do {
 		if (filp->f_flags & O_NONBLOCK) {
-			if (!iio_buffer_data_available(rb)) {
+			if (!iio_buffer_data_available(rb) &&
+			    iio_buffer_flush_hwfifo(indio_dev, rb, 1) <= 0) {
 				ret = -EAGAIN;
 				break;
 			}
 		} else {
 			ret = wait_event_interruptible(rb->pollq,
-			       iio_buffer_data_available(rb) >= to_read ||
-						       indio_dev->info == NULL);
+			       iio_buffer_ready(indio_dev, rb, to_read));
 			if (ret)
 				return ret;
 			if (indio_dev->info == NULL) {
@@ -664,19 +702,16 @@ static int __iio_update_buffers(struct iio_dev *indio_dev,
 		}
 	}
 	/* Definitely possible for devices to support both of these. */
-	if (indio_dev->modes & INDIO_BUFFER_TRIGGERED) {
-		if (!indio_dev->trig) {
-			printk(KERN_INFO "Buffer not started: no trigger\n");
-			ret = -EINVAL;
-			/* Can only occur on first buffer */
-			goto error_run_postdisable;
-		}
+	if ((indio_dev->modes & INDIO_BUFFER_TRIGGERED) && indio_dev->trig) {
 		indio_dev->currentmode = INDIO_BUFFER_TRIGGERED;
 	} else if (indio_dev->modes & INDIO_BUFFER_HARDWARE) {
 		indio_dev->currentmode = INDIO_BUFFER_HARDWARE;
 	} else if (indio_dev->modes & INDIO_BUFFER_SOFTWARE) {
 		indio_dev->currentmode = INDIO_BUFFER_SOFTWARE;
 	} else { /* Should never be reached */
+		/* Can only occur on first buffer */
+		if (indio_dev->modes & INDIO_BUFFER_TRIGGERED)
+			pr_info("Buffer not started: no trigger\n");
 		ret = -EINVAL;
 		goto error_run_postdisable;
 	}
@@ -823,12 +858,32 @@ static ssize_t iio_buffer_store_watermark(struct device *dev,
 	}
 
 	buffer->watermark = val;
+
+	if (indio_dev->info->hwfifo_set_watermark) {
+		ret = indio_dev->info->hwfifo_set_watermark(indio_dev, val);
+		if (ret)
+			dev_err(dev, "hwfifo_set_watermark failed: %d\n", val);
+	}
+
 	ret = 0;
 out:
 	mutex_unlock(&indio_dev->mlock);
 	return ret ? ret : len;
 }
 
+static ssize_t iio_buffer_show_hwfifo_watermark(struct device *dev,
+						struct device_attribute *attr,
+						char *buf)
+{
+	struct iio_dev *indio_dev = dev_to_iio_dev(dev);
+	int ret = -1;
+
+	if (indio_dev->info->hwfifo_get_watermark)
+		ret = indio_dev->info->hwfifo_get_watermark(indio_dev);
+
+	return sprintf(buf, "%d\n", ret < -1 ? -1 : ret);
+}
+
 static DEVICE_ATTR(length, S_IRUGO | S_IWUSR, iio_buffer_read_length,
 		   iio_buffer_write_length);
 static struct device_attribute dev_attr_length_ro = __ATTR(length,
@@ -837,11 +892,14 @@ static DEVICE_ATTR(enable, S_IRUGO | S_IWUSR,
 		   iio_buffer_show_enable, iio_buffer_store_enable);
 static DEVICE_ATTR(watermark, S_IRUGO | S_IWUSR,
 		   iio_buffer_show_watermark, iio_buffer_store_watermark);
+static DEVICE_ATTR(hwfifo_watermark, S_IRUGO, iio_buffer_show_hwfifo_watermark,
+		   NULL);
 
 static struct attribute *iio_buffer_attrs[] = {
 	&dev_attr_length.attr,
 	&dev_attr_enable.attr,
 	&dev_attr_watermark.attr,
+	&dev_attr_hwfifo_watermark.attr,
 };
 
 int iio_buffer_alloc_sysfs_and_mask(struct iio_dev *indio_dev)
diff --git a/include/linux/iio/iio.h b/include/linux/iio/iio.h
index 80d8550..1b1cd7d 100644
--- a/include/linux/iio/iio.h
+++ b/include/linux/iio/iio.h
@@ -338,6 +338,29 @@ struct iio_dev;
  *			provide a custom of_xlate function that reads the
  *			*args* and returns the appropriate index in registered
  *			IIO channels array.
+ * @hwfifo_set_watermark: function pointer to set the current hardware fifo
+ *			watermark level. It receives the desired watermark as a
+ *			hint and the device driver may adjust it to take into
+ *			account hardware limitations. Setting the watermark to a
+ *			strictly positive value should enable the hardware fifo
+ *			if not already enabled. When the hardware fifo is
+ *			enabled and its level reaches the watermark level the
+ *			device must flush the samples stored in the hardware
+ *			fifo to the device buffer. Setting the watermark to 0
+ *			should disable the hardware fifo. The device driver must
+ *			disable the hardware fifo when a trigger with different
+ *			sampling semantic (then the hardware fifo) is set
+ *			(e.g. when setting an any-motion trigger to a device
+ *			that has its hardware fifo sample based on the set
+ *			sample frequency).
+ * @hwfifo_get_watermark: function pointer to obtain the current hardware fifo
+ *			watermark level
+ * @hwfifo_flush:	function pointer to flush the samples stored in the
+ *			hardware fifo to the device buffer. The driver should
+ *			not flush more then count samples. The function must
+ *			return the number of samples flushed, 0 if no samples
+ *			were flushed or a negative integer if no samples were
+ *			flushed and there was an error.
  **/
 struct iio_info {
 	struct module			*driver_module;
@@ -399,6 +422,9 @@ struct iio_info {
 				  unsigned *readval);
 	int (*of_xlate)(struct iio_dev *indio_dev,
 			const struct of_phandle_args *iiospec);
+	int (*hwfifo_set_watermark)(struct iio_dev *indio_dev, unsigned val);
+	int (*hwfifo_get_watermark)(struct iio_dev *indio_dev);
+	int (*hwfifo_flush)(struct iio_dev *indio_dev, unsigned count);
 };
 
 /**
-- 
1.9.1

