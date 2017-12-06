Return-Path: <SRS0=WhWb=DC=gmail.com=mfornero@kernel.org>
From: mfornero@gmail.com
To: jic23@kernel.org,
	lars@metafoo.de
Cc: linux-iio@vger.kernel.org,
	Matt Fornero <matt.fornero@mathworks.com>
Subject: [PATCH v3] iio: buffer: Expose data available
Date: Wed,  6 Dec 2017 14:43:30 -0500
Message-Id: <1512589410-9087-1-git-send-email-mfornero@gmail.com>
In-Reply-To: <1512161180-30116-1-git-send-email-mfornero@gmail.com>
References: <1512161180-30116-1-git-send-email-mfornero@gmail.com>
List-ID: <linux-iio@vger.kernel.org>

From: Matt Fornero <matt.fornero@mathworks.com>

Add a sysfs attribute that exposes buffer data available to userspace.
This attribute can be checked at runtime to determine the overall buffer
fill level (across all allocated buffers).

Signed-off-by: Matt Fornero <matt.fornero@mathworks.com>
---
v2 -> v3:
 - Use %zu for sprintf instead of %llu
 - Add documentation

 Documentation/ABI/testing/sysfs-bus-iio | 10 ++++++++++
 drivers/iio/industrialio-buffer.c       | 15 +++++++++++++++
 2 files changed, 25 insertions(+)

diff --git a/Documentation/ABI/testing/sysfs-bus-iio b/Documentation/ABI/testing/sysfs-bus-iio
index a478740..9cc0ea1 100644
--- a/Documentation/ABI/testing/sysfs-bus-iio
+++ b/Documentation/ABI/testing/sysfs-bus-iio
@@ -1413,6 +1413,16 @@ Description:
 		the available samples after the timeout expires and thus have a
 		maximum delay guarantee.
 
+What:		/sys/bus/iio/devices/iio:deviceX/buffer/data_available
+KernelVersion: 4.16
+Contact:	linux-iio@vger.kernel.org
+Description:
+		A read-only value indicating the bytes of data available in the
+		buffer. In the case of an output buffer, this indicates the
+		amount of empty space available to write data to. In the case of
+		an input buffer, this indicates the amount of data available for
+		reading.
+
 What:		/sys/bus/iio/devices/iio:deviceX/buffer/hwfifo_enabled
 KernelVersion: 4.2
 Contact:	linux-iio@vger.kernel.org
diff --git a/drivers/iio/industrialio-buffer.c b/drivers/iio/industrialio-buffer.c
index d2b4651..eda2a0f 100644
--- a/drivers/iio/industrialio-buffer.c
+++ b/drivers/iio/industrialio-buffer.c
@@ -1198,6 +1198,18 @@ static ssize_t iio_buffer_store_watermark(struct device *dev,
 	return ret ? ret : len;
 }
 
+static ssize_t iio_dma_show_data_available(struct device *dev,
+						struct device_attribute *attr,
+						char *buf)
+{
+	struct iio_dev *indio_dev = dev_to_iio_dev(dev);
+	size_t bytes;
+
+	bytes = iio_buffer_data_available(indio_dev->buffer);
+
+	return sprintf(buf, "%zu\n", bytes);
+}
+
 static DEVICE_ATTR(length, S_IRUGO | S_IWUSR, iio_buffer_read_length,
 		   iio_buffer_write_length);
 static struct device_attribute dev_attr_length_ro = __ATTR(length,
@@ -1208,11 +1220,14 @@ static DEVICE_ATTR(watermark, S_IRUGO | S_IWUSR,
 		   iio_buffer_show_watermark, iio_buffer_store_watermark);
 static struct device_attribute dev_attr_watermark_ro = __ATTR(watermark,
 	S_IRUGO, iio_buffer_show_watermark, NULL);
+static DEVICE_ATTR(data_available, S_IRUGO,
+		iio_dma_show_data_available, NULL);
 
 static struct attribute *iio_buffer_attrs[] = {
 	&dev_attr_length.attr,
 	&dev_attr_enable.attr,
 	&dev_attr_watermark.attr,
+	&dev_attr_data_available.attr,
 };
 
 int iio_buffer_alloc_sysfs_and_mask(struct iio_dev *indio_dev)
-- 
1.8.3.1
