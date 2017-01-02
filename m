Return-Path: <linux-iio-owner@vger.kernel.org>
Received: from tarvos.retrosnub.co.uk ([217.168.153.95]:60334 "EHLO
        tarvos.retrosnub.co.uk" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S933922AbdABT2z (ORCPT
        <rfc822;linux-iio@vger.kernel.org>); Mon, 2 Jan 2017 14:28:55 -0500
From: Jonathan Cameron <jic23@kernel.org>
To: linux-iio@vger.kernel.org
Cc: Daniel Baluta <daniel.baluta@gmail.com>,
        Hartmut Knaack <knaack.h@gmx.de>,
        Lars-Peter Clausen <lars@metafoo.de>,
        Peter Meerwald-Stadler <pmeerw@pmeerw.net>,
        Jonathan Cameron <jic23@kernel.org>
Subject: [PATCH 03/11] iio:buffer: Introduced a function to assign the buffer specific attrs.
Date: Mon,  2 Jan 2017 19:28:26 +0000
Message-Id: <20170102192834.26546-4-jic23@kernel.org>
In-Reply-To: <20170102192834.26546-1-jic23@kernel.org>
References: <20170102192834.26546-1-jic23@kernel.org>
Sender: linux-iio-owner@vger.kernel.org
List-Id: linux-iio@vger.kernel.org

This is a necessary step in taking the buffer implementation
opaque.

Signed-off-by: Jonathan Cameron <jic23@kernel.org>
---
 drivers/iio/accel/bmc150-accel-core.c |  3 ++-
 drivers/iio/industrialio-buffer.c     | 12 ++++++++++++
 include/linux/iio/buffer.h            |  2 ++
 3 files changed, 16 insertions(+), 1 deletion(-)

diff --git a/drivers/iio/accel/bmc150-accel-core.c b/drivers/iio/accel/bmc150-accel-core.c
index 59b380dbf27f..6b5d3be283c4 100644
--- a/drivers/iio/accel/bmc150-accel-core.c
+++ b/drivers/iio/accel/bmc150-accel-core.c
@@ -1638,7 +1638,8 @@ int bmc150_accel_core_probe(struct device *dev, struct regmap *regmap, int irq,
 		if (block_supported) {
 			indio_dev->modes |= INDIO_BUFFER_SOFTWARE;
 			indio_dev->info = &bmc150_accel_info_fifo;
-			indio_dev->buffer->attrs = bmc150_accel_fifo_attributes;
+			iio_buffer_set_attrs(indio_dev->buffer,
+					     bmc150_accel_fifo_attributes);
 		}
 	}
 
diff --git a/drivers/iio/industrialio-buffer.c b/drivers/iio/industrialio-buffer.c
index 9f496eb84e0b..831537cc9500 100644
--- a/drivers/iio/industrialio-buffer.c
+++ b/drivers/iio/industrialio-buffer.c
@@ -209,6 +209,18 @@ void iio_buffer_init(struct iio_buffer *buffer)
 }
 EXPORT_SYMBOL(iio_buffer_init);
 
+/**
+ * iio_buffer_set_attrs - Set buffer specific attributes
+ * @buffer: The buffer for which we are setting attributes
+ * @attrs: Pointer to a null terminated list of pointers to attributes
+ */
+void iio_buffer_set_attrs(struct iio_buffer *buffer,
+			 const struct attribute **attrs)
+{
+	buffer->attrs = attrs;
+}
+EXPORT_SYMBOL_GPL(iio_buffer_set_attrs);
+
 static ssize_t iio_show_scan_index(struct device *dev,
 				   struct device_attribute *attr,
 				   char *buf)
diff --git a/include/linux/iio/buffer.h b/include/linux/iio/buffer.h
index 4a65a7bb40a4..30ea9806db67 100644
--- a/include/linux/iio/buffer.h
+++ b/include/linux/iio/buffer.h
@@ -17,6 +17,8 @@
 
 struct iio_buffer;
 
+void iio_buffer_set_attrs(struct iio_buffer *buffer,
+			 const struct attribute **attrs);
 /**
  * INDIO_BUFFER_FLAG_FIXED_WATERMARK - Watermark level of the buffer can not be
  *   configured. It has a fixed value which will be buffer specific.
-- 
2.11.0

