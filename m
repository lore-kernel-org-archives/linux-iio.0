Return-Path: <linux-iio-owner@vger.kernel.org>
Received: from mga02.intel.com ([134.134.136.20]:9091 "EHLO mga02.intel.com"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1751888AbbCVSd4 (ORCPT <rfc822;linux-iio@vger.kernel.org>);
	Sun, 22 Mar 2015 14:33:56 -0400
From: Octavian Purdila <octavian.purdila@intel.com>
To: jic23@kernel.org
Cc: lars@metafoo.de, pmeerw@pmeerw.net, knaack.h@gmx.de,
	linux-iio@vger.kernel.org,
	Octavian Purdila <octavian.purdila@intel.com>
Subject: [PATCH v6 2/3] iio: add support for hardware fifo
Date: Sun, 22 Mar 2015 20:33:39 +0200
Message-Id: <1427049220-2876-3-git-send-email-octavian.purdila@intel.com>
In-Reply-To: <1427049220-2876-1-git-send-email-octavian.purdila@intel.com>
References: <1427049220-2876-1-git-send-email-octavian.purdila@intel.com>
Sender: linux-iio-owner@vger.kernel.org
List-Id: linux-iio@vger.kernel.org

Some devices have hardware buffers that can store a number of samples
for later consumption. Hardware usually provides interrupts to notify
the processor when the FIFO is full or when it has reached a certain
watermark level. This helps with reducing the number of interrupts to
the host processor and thus it helps decreasing the power consumption.

This patch enables usage of hardware FIFOs for IIO devices in
conjunction with software device buffers. When the hardware FIFO is
enabled the samples are stored in the hardware FIFO. The samples are
later flushed to the device software buffer when the number of entries
in the hardware FIFO reaches the hardware watermark or when a flush
operation is triggered by the user when doing a non-blocking read
on an empty software device buffer.

In order to implement hardware FIFO support the device drivers must
implement the following new operations: setting and getting the
hardware FIFO watermark level, flushing the hardware FIFO to the
software device buffer. The device must also expose information about
the hardware FIFO such it's minimum and maximum watermark and if
necessary a list of supported watermark values. Finally, the device
driver must activate the hardware FIFO when the device buffer is
enabled, if the current device settings allows it.

The software device buffer watermark is passed by the IIO core to the
device driver as a hint for the hardware FIFO watermark. The device
driver can adjust this value to allow for hardware limitations (such
as capping it to the maximum hardware watermark or adjust it to a
value that is supported by the hardware). It can also disable the
hardware watermark (and implicitly the hardware FIFO) it this value is
below the minimum hardware watermark.

Since a driver may support hardware FIFO only when not in triggered
buffer mode (due to different semantics of hardware FIFO sampling and
triggered sampling) this patch changes the IIO core code to allow
falling back to non-triggered buffered mode if no trigger is enabled.

Signed-off-by: Octavian Purdila <octavian.purdila@intel.com>
---
 Documentation/ABI/testing/sysfs-bus-iio | 69 +++++++++++++++++++++++++++++++++
 drivers/iio/industrialio-buffer.c       | 58 ++++++++++++++++++++-------
 include/linux/iio/iio.h                 | 13 +++++++
 3 files changed, 127 insertions(+), 13 deletions(-)

diff --git a/Documentation/ABI/testing/sysfs-bus-iio b/Documentation/ABI/testing/sysfs-bus-iio
index 0051641..8742302 100644
--- a/Documentation/ABI/testing/sysfs-bus-iio
+++ b/Documentation/ABI/testing/sysfs-bus-iio
@@ -1288,3 +1288,72 @@ Description:
 		allows the application to block on poll with a timeout and read
 		the available samples after the timeout expires and thus have a
 		maximum delay guarantee.
+
+What:		/sys/bus/iio/devices/iio:deviceX/buffer/hwfifo_enabled
+KernelVersion: 4.2
+Contact:	linux-iio@vger.kernel.org
+Description:
+		A read-only boolean value that indicates if the hardware fifo is
+		currently enabled or disabled. If the device does not have a
+		hardware fifo this entry is not present.
+		The hardware fifo is enabled when the buffer is enabled if the
+		current hardware fifo watermark level is set and other current
+		device settings allows it (e.g. if a trigger is set that samples
+		data differently that the hardware fifo does then hardware fifo
+		will not enabled).
+		If the hardware fifo is enabled and the level of the hardware
+		fifo reaches the hardware fifo watermark level the device will
+		flush its hardware fifo to the device buffer. Doing a non
+		blocking read on the device when no samples are present in the
+		device buffer will also force a flush.
+		When the hardware fifo is enabled there is no need to use a
+		trigger to use buffer mode since the watermark settings
+		guarantees that the hardware fifo is flushed to the device
+		buffer.
+
+What:		/sys/bus/iio/devices/iio:deviceX/buffer/hwfifo_watermark
+KernelVersion: 4.2
+Contact:	linux-iio@vger.kernel.org
+Description:
+		Read-only entry that contains a single integer specifying the
+		current watermark level for the hardware fifo. If the device
+		does not have a hardware fifo this entry is not present.
+		The watermark level for the hardware fifo is set by the driver
+		based on the value set by the user in buffer/watermark but
+		taking into account hardware limitations (e.g. most hardware
+		buffers are limited to 32-64 samples, some hardware buffers
+		watermarks are fixed or have minimum levels).  A value of 0
+		means that the hardware watermark is unset.
+
+What:		/sys/bus/iio/devices/iio:deviceX/buffer/hwfifo_watermark_min
+KernelVersion: 4.2
+Contact:       linux-iio@vger.kernel.org
+Description:
+		A single positive integer specifying the minimum watermark level
+		for the hardware fifo of this device. If the device does not
+		have a hardware fifo this entry is not present.
+		If the user sets buffer/watermark to a value less than this one,
+		then the hardware watermark will remain unset.
+
+What:	       /sys/bus/iio/devices/iio:deviceX/buffer/hwfifo_watermark_max
+KernelVersion: 4.2
+Contact:       linux-iio@vger.kernel.org
+Description:
+		A single positive integer specifying the maximum watermark level
+		for the hardware fifo of this device. If the device does not
+		have a hardware fifo this entry is not present.
+		If the user sets buffer/watermark to a value greater than this
+		one, then the hardware watermark will be capped at this value.
+
+What:	       /sys/bus/iio/devices/iio:deviceX/buffer/hwfifo_watermark_available
+KernelVersion: 4.2
+Contact:       linux-iio@vger.kernel.org
+Description:
+		A list of positive integers specifying the available watermark
+		levels for the hardware fifo. This entry is optional and if it
+		is not present it means that all the values between
+		hwfifo_watermark_min and hwfifo_watermark_max are supported.
+		If the user sets buffer/watermark to a value greater than
+		hwfifo_watermak_min but not equal to any of the values in this
+		list, the driver will chose an appropriate value for the
+		hardware fifo watermark level.
diff --git a/drivers/iio/industrialio-buffer.c b/drivers/iio/industrialio-buffer.c
index a4f4f07..87142bb 100644
--- a/drivers/iio/industrialio-buffer.c
+++ b/drivers/iio/industrialio-buffer.c
@@ -42,18 +42,47 @@ static size_t iio_buffer_data_available(struct iio_buffer *buf)
 	return buf->access->data_available(buf);
 }
 
+static int iio_buffer_flush_hwfifo(struct iio_dev *indio_dev,
+				   struct iio_buffer *buf, size_t required)
+{
+	if (!indio_dev->info->hwfifo_flush_to_buffer)
+		return -ENODEV;
+
+	return indio_dev->info->hwfifo_flush_to_buffer(indio_dev, required);
+}
+
 static bool iio_buffer_ready(struct iio_dev *indio_dev, struct iio_buffer *buf,
-			     size_t to_wait)
+			     size_t to_wait, int to_flush)
 {
+	size_t avail;
+	int flushed = 0;
+
 	/* wakeup if the device was unregistered */
 	if (!indio_dev->info)
 		return true;
 
 	/* drain the buffer if it was disabled */
-	if (!iio_buffer_is_active(buf))
+	if (!iio_buffer_is_active(buf)) {
 		to_wait = min_t(size_t, to_wait, 1);
+		to_flush = 0;
+	}
+
+	avail = iio_buffer_data_available(buf);
 
-	if (iio_buffer_data_available(buf) >= to_wait)
+	if (avail >= to_wait) {
+		/* force a flush for non-blocking reads */
+		if (!to_wait && !avail && to_flush)
+			iio_buffer_flush_hwfifo(indio_dev, buf, to_flush);
+		return true;
+	}
+
+	if (to_flush)
+		flushed = iio_buffer_flush_hwfifo(indio_dev, buf,
+						  to_wait - avail);
+	if (flushed <= 0)
+		return false;
+
+	if (avail + flushed >= to_wait)
 		return true;
 
 	return false;
@@ -72,6 +101,7 @@ ssize_t iio_buffer_read_first_n_outer(struct file *filp, char __user *buf,
 	struct iio_buffer *rb = indio_dev->buffer;
 	size_t datum_size = rb->bytes_per_datum;
 	size_t to_wait = 0;
+	size_t to_read;
 	int ret;
 
 	if (!indio_dev->info)
@@ -87,12 +117,14 @@ ssize_t iio_buffer_read_first_n_outer(struct file *filp, char __user *buf,
 	if (!datum_size)
 		return 0;
 
+	to_read = min_t(size_t, n / datum_size, rb->watermark);
+
 	if (!(filp->f_flags & O_NONBLOCK))
-		to_wait = min_t(size_t, n / datum_size, rb->watermark);
+		to_wait = to_read;
 
 	do {
 		ret = wait_event_interruptible(rb->pollq,
-				      iio_buffer_ready(indio_dev, rb, to_wait));
+			iio_buffer_ready(indio_dev, rb, to_wait, to_read));
 		if (ret)
 			return ret;
 
@@ -120,7 +152,7 @@ unsigned int iio_buffer_poll(struct file *filp,
 		return -ENODEV;
 
 	poll_wait(filp, &rb->pollq, wait);
-	if (iio_buffer_ready(indio_dev, rb, rb->watermark))
+	if (iio_buffer_ready(indio_dev, rb, rb->watermark, 0))
 		return POLLIN | POLLRDNORM;
 	return 0;
 }
@@ -659,19 +691,16 @@ static int __iio_update_buffers(struct iio_dev *indio_dev,
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
@@ -823,6 +852,9 @@ static ssize_t iio_buffer_store_watermark(struct device *dev,
 	}
 
 	buffer->watermark = val;
+
+	if (indio_dev->info->hwfifo_set_watermark)
+		indio_dev->info->hwfifo_set_watermark(indio_dev, val);
 out:
 	mutex_unlock(&indio_dev->mlock);
 
diff --git a/include/linux/iio/iio.h b/include/linux/iio/iio.h
index 80d8550..d86b753 100644
--- a/include/linux/iio/iio.h
+++ b/include/linux/iio/iio.h
@@ -338,6 +338,16 @@ struct iio_dev;
  *			provide a custom of_xlate function that reads the
  *			*args* and returns the appropriate index in registered
  *			IIO channels array.
+ * @hwfifo_set_watermark: function pointer to set the current hardware
+ *			fifo watermark level; see hwfifo_* entries in
+ *			Documentation/ABI/testing/sysfs-bus-iio for details on
+ *			how the hardware fifo operates
+ * @hwfifo_flush_to_buffer: function pointer to flush the samples stored
+ *			in the hardware fifo to the device buffer. The driver
+ *			should not flush more than count samples. The function
+ *			must return the number of samples flushed, 0 if no
+ *			samples were flushed or a negative integer if no samples
+ *			were flushed and there was an error.
  **/
 struct iio_info {
 	struct module			*driver_module;
@@ -399,6 +409,9 @@ struct iio_info {
 				  unsigned *readval);
 	int (*of_xlate)(struct iio_dev *indio_dev,
 			const struct of_phandle_args *iiospec);
+	int (*hwfifo_set_watermark)(struct iio_dev *indio_dev, unsigned val);
+	int (*hwfifo_flush_to_buffer)(struct iio_dev *indio_dev,
+				      unsigned count);
 };
 
 /**
-- 
1.9.1

