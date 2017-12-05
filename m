Return-Path: <linux-iio-owner@vger.kernel.org>
Received: from mail-qt0-f193.google.com ([209.85.216.193]:42495 "EHLO
        mail-qt0-f193.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1751112AbdLEU5F (ORCPT
        <rfc822;linux-iio@vger.kernel.org>); Tue, 5 Dec 2017 15:57:05 -0500
Received: by mail-qt0-f193.google.com with SMTP id g9so4075125qth.9
        for <linux-iio@vger.kernel.org>; Tue, 05 Dec 2017 12:57:04 -0800 (PST)
From: mfornero@gmail.com
To: jic23@kernel.org, lars@metafoo.de
Cc: linux-iio@vger.kernel.org,
        Matt Fornero <matt.fornero@mathworks.com>
Subject: [PATCH v2] iio: buffer: Expose data available
Date: Tue,  5 Dec 2017 15:56:56 -0500
Message-Id: <1512507416-21856-1-git-send-email-mfornero@gmail.com>
In-Reply-To: <1512161180-30116-1-git-send-email-mfornero@gmail.com>
References: <1512161180-30116-1-git-send-email-mfornero@gmail.com>
Sender: linux-iio-owner@vger.kernel.org
List-Id: linux-iio@vger.kernel.org

From: Matt Fornero <matt.fornero@mathworks.com>

Add a sysfs attribute that exposes buffer data available to userspace.
This attribute can be checked at runtime to determine the overall buffer
fill level (across all allocated buffers).

Signed-off-by: Matt Fornero <matt.fornero@mathworks.com>
---
v1 -> v2:
 - Use iio_buffer_data_available() for all buffers instead
   of only DMA buffers

 drivers/iio/industrialio-buffer.c | 15 +++++++++++++++
 1 file changed, 15 insertions(+)

diff --git a/drivers/iio/industrialio-buffer.c b/drivers/iio/industrialio-buffer.c
index d80f830..e7bdfa3 100644
--- a/drivers/iio/industrialio-buffer.c
+++ b/drivers/iio/industrialio-buffer.c
@@ -1121,6 +1121,18 @@ static ssize_t iio_buffer_store_watermark(struct device *dev,
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
+	return sprintf(buf, "%llu\n", (unsigned long long)bytes);
+}
+
 static DEVICE_ATTR(length, S_IRUGO | S_IWUSR, iio_buffer_read_length,
 	iio_buffer_write_length);
 static struct device_attribute dev_attr_length_ro = __ATTR(length,
@@ -1131,11 +1143,14 @@ static DEVICE_ATTR(watermark, S_IRUGO | S_IWUSR,
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

