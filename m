Return-Path: <SRS0=TWgh=C5=mathworks.com=Matt.Fornero@kernel.org>
From: Matthew Fornero <mfornero@mathworks.com>
To: Jonathan Cameron <jic23@kernel.org>
CC: <linux-iio@vger.kernel.org>, Lars-Peter Clausen <lars@metafoo.de>,
	"Hartmut Knaack" <knaack.h@gmx.de>, Peter Meerwald-Stadler
	<pmeerw@pmeerw.net>, "Matt Fornero" <matt.fornero@mathworks.com>
Subject: [PATCH] iio: buffer-dma: Expose data available
Date: Fri, 1 Dec 2017 14:43:03 -0500
Message-ID: <1512157383-4520-1-git-send-email-mfornero@mathworks.com>
MIME-Version: 1.0
Content-Type: text/plain
List-ID: <linux-iio@vger.kernel.org>

From: Matt Fornero <matt.fornero@mathworks.com>

Add a sysfs attribute that exposes the buffer data available to
userspace. This attribute can be checked at runtime to determine the
overall buffer fill level (across all allocated DMA buffers).

Signed-off-by: Matt Fornero <matt.fornero@mathworks.com>
---
 drivers/iio/buffer/industrialio-buffer-dma.c | 24 ++++++++++++++++++++++++
 1 file changed, 24 insertions(+)

diff --git a/drivers/iio/buffer/industrialio-buffer-dma.c b/drivers/iio/buffer/industrialio-buffer-dma.c
index ff03324..8739a41 100644
--- a/drivers/iio/buffer/industrialio-buffer-dma.c
+++ b/drivers/iio/buffer/industrialio-buffer-dma.c
@@ -16,6 +16,7 @@
 #include <linux/iio/buffer.h>
 #include <linux/iio/buffer_impl.h>
 #include <linux/iio/buffer-dma.h>
+#include <linux/iio/sysfs.h>
 #include <linux/dma-mapping.h>
 #include <linux/sizes.h>
 
@@ -599,6 +600,28 @@ int iio_dma_buffer_set_length(struct iio_buffer *buffer, int length)
 }
 EXPORT_SYMBOL_GPL(iio_dma_buffer_set_length);
 
+
+static ssize_t iio_dma_get_data_available(struct device *dev,
+					       struct device_attribute *attr,
+					       char *buf)
+{
+	struct iio_dev *indio_dev = dev_to_iio_dev(dev);
+	size_t bytes;
+
+	bytes = iio_dma_buffer_data_available(indio_dev->buffer);
+
+	return sprintf(buf, "%llu\n", (unsigned long long)bytes);
+}
+
+static IIO_DEVICE_ATTR(data_available, S_IRUGO,
+		       iio_dma_get_data_available, NULL, 0);
+
+static const struct attribute *iio_dma_buffer_attributes[] = {
+	&iio_dev_attr_data_available.dev_attr.attr,
+	NULL,
+};
+
+
 /**
  * iio_dma_buffer_init() - Initialize DMA buffer queue
  * @queue: Buffer to initialize
@@ -615,6 +638,7 @@ int iio_dma_buffer_init(struct iio_dma_buffer_queue *queue,
 	iio_buffer_init(&queue->buffer);
 	queue->buffer.length = PAGE_SIZE;
 	queue->buffer.watermark = queue->buffer.length / 2;
+	queue->buffer.attrs = iio_dma_buffer_attributes;
 	queue->dev = dev;
 	queue->ops = ops;
 
-- 
2.1.4
