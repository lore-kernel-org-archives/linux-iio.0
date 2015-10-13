Return-Path: <linux-iio-owner@vger.kernel.org>
Received: from smtp-out-108.synserver.de ([212.40.185.108]:1035 "EHLO
	smtp-out-100.synserver.de" rhost-flags-OK-OK-OK-FAIL)
	by vger.kernel.org with ESMTP id S1752982AbbJMQFm (ORCPT
	<rfc822;linux-iio@vger.kernel.org>); Tue, 13 Oct 2015 12:05:42 -0400
From: Lars-Peter Clausen <lars@metafoo.de>
To: Jonathan Cameron <jic23@kernel.org>,
	Hartmut Knaack <knaack.h@gmx.de>,
	Peter Meerwald <pmeerw@pmeerw.net>
Cc: Octavian Purdila <octavian.purdila@intel.com>,
	linux-iio@vger.kernel.org, Lars-Peter Clausen <lars@metafoo.de>
Subject: [PATCH v2 3/6] iio: Add support for indicating fixed watermarks
Date: Tue, 13 Oct 2015 18:05:24 +0200
Message-Id: <1444752327-2629-4-git-send-email-lars@metafoo.de>
In-Reply-To: <1444752327-2629-1-git-send-email-lars@metafoo.de>
References: <1444752327-2629-1-git-send-email-lars@metafoo.de>
Sender: linux-iio-owner@vger.kernel.org
List-Id: linux-iio@vger.kernel.org

For buffers which have a fixed wake-up watermark the watermark attribute
should be read-only. Add a new FIXED_WATERMARK flag to the
struct iio_buffer_access_funcs, which can be set by a buffer
implementation.

Signed-off-by: Lars-Peter Clausen <lars@metafoo.de>
---
 drivers/iio/industrialio-buffer.c | 5 +++++
 include/linux/iio/buffer.h        | 8 ++++++++
 2 files changed, 13 insertions(+)

diff --git a/drivers/iio/industrialio-buffer.c b/drivers/iio/industrialio-buffer.c
index 5f2c8c8..98a6447 100644
--- a/drivers/iio/industrialio-buffer.c
+++ b/drivers/iio/industrialio-buffer.c
@@ -998,6 +998,8 @@ static DEVICE_ATTR(enable, S_IRUGO | S_IWUSR,
 		   iio_buffer_show_enable, iio_buffer_store_enable);
 static DEVICE_ATTR(watermark, S_IRUGO | S_IWUSR,
 		   iio_buffer_show_watermark, iio_buffer_store_watermark);
+static struct device_attribute dev_attr_watermark_ro = __ATTR(watermark,
+	S_IRUGO, iio_buffer_show_watermark, NULL);
 
 static struct attribute *iio_buffer_attrs[] = {
 	&dev_attr_length.attr,
@@ -1040,6 +1042,9 @@ int iio_buffer_alloc_sysfs_and_mask(struct iio_dev *indio_dev)
 	if (!buffer->access->set_length)
 		attr[0] = &dev_attr_length_ro.attr;
 
+	if (buffer->access->flags & INDIO_BUFFER_FLAG_FIXED_WATERMARK)
+		attr[2] = &dev_attr_watermark_ro.attr;
+
 	if (buffer->attrs)
 		memcpy(&attr[ARRAY_SIZE(iio_buffer_attrs)], buffer->attrs,
 		       sizeof(struct attribute *) * attrcount);
diff --git a/include/linux/iio/buffer.h b/include/linux/iio/buffer.h
index 1600c55..4d99a53 100644
--- a/include/linux/iio/buffer.h
+++ b/include/linux/iio/buffer.h
@@ -18,6 +18,12 @@
 struct iio_buffer;
 
 /**
+ * INDIO_BUFFER_FLAG_FIXED_WATERMARK - Watermark level of the buffer can not be
+ *   configured. It has a fixed value which will be buffer specific.
+ */
+#define INDIO_BUFFER_FLAG_FIXED_WATERMARK BIT(0)
+
+/**
  * struct iio_buffer_access_funcs - access functions for buffers.
  * @store_to:		actually store stuff to the buffer
  * @read_first_n:	try to get a specified number of bytes (must exist)
@@ -30,6 +36,7 @@ struct iio_buffer;
  * @release:		called when the last reference to the buffer is dropped,
  *			should free all resources allocated by the buffer.
  * @modes:		Supported operating modes by this buffer type
+ * @flags:		A bitmask combination of INDIO_BUFFER_FLAG_*
  *
  * The purpose of this structure is to make the buffer element
  * modular as event for a given driver, different usecases may require
@@ -54,6 +61,7 @@ struct iio_buffer_access_funcs {
 	void (*release)(struct iio_buffer *buffer);
 
 	unsigned int modes;
+	unsigned int flags;
 };
 
 /**
-- 
2.1.4

