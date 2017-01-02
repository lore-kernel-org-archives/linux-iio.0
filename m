Return-Path: <linux-iio-owner@vger.kernel.org>
Received: from tarvos.retrosnub.co.uk ([217.168.153.95]:60396 "EHLO
        tarvos.retrosnub.co.uk" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S933928AbdABT3B (ORCPT
        <rfc822;linux-iio@vger.kernel.org>); Mon, 2 Jan 2017 14:29:01 -0500
From: Jonathan Cameron <jic23@kernel.org>
To: linux-iio@vger.kernel.org
Cc: Daniel Baluta <daniel.baluta@gmail.com>,
        Hartmut Knaack <knaack.h@gmx.de>,
        Lars-Peter Clausen <lars@metafoo.de>,
        Peter Meerwald-Stadler <pmeerw@pmeerw.net>,
        Jonathan Cameron <jic23@kernel.org>
Subject: [PATCH 09/11] iio:buffer: Push implementation of iio_device_attach_buffer into .c file
Date: Mon,  2 Jan 2017 19:28:32 +0000
Message-Id: <20170102192834.26546-10-jic23@kernel.org>
In-Reply-To: <20170102192834.26546-1-jic23@kernel.org>
References: <20170102192834.26546-1-jic23@kernel.org>
Sender: linux-iio-owner@vger.kernel.org
List-Id: linux-iio@vger.kernel.org

This is a precursor to the splitting of buffer.h into parts relevant
to buffer implementation vs those for devices using buffers.
struct buffer is about to become opaque as far as the header is
concerned.

Signed-off-by: Jonathan Cameron <jic23@kernel.org>
---
 drivers/iio/industrialio-buffer.c | 16 ++++++++++++++++
 include/linux/iio/buffer.h        | 17 ++---------------
 2 files changed, 18 insertions(+), 15 deletions(-)

diff --git a/drivers/iio/industrialio-buffer.c b/drivers/iio/industrialio-buffer.c
index 0067e184c9ae..a04498231f94 100644
--- a/drivers/iio/industrialio-buffer.c
+++ b/drivers/iio/industrialio-buffer.c
@@ -1445,3 +1445,19 @@ void iio_buffer_put(struct iio_buffer *buffer)
 		kref_put(&buffer->ref, iio_buffer_release);
 }
 EXPORT_SYMBOL_GPL(iio_buffer_put);
+
+/**
+ * iio_device_attach_buffer - Attach a buffer to a IIO device
+ * @indio_dev: The device the buffer should be attached to
+ * @buffer: The buffer to attach to the device
+ *
+ * This function attaches a buffer to a IIO device. The buffer stays attached to
+ * the device until the device is freed. The function should only be called at
+ * most once per device.
+ */
+void iio_device_attach_buffer(struct iio_dev *indio_dev,
+			      struct iio_buffer *buffer)
+{
+	indio_dev->buffer = iio_buffer_get(buffer);
+}
+EXPORT_SYMBOL_GPL(iio_device_attach_buffer);
diff --git a/include/linux/iio/buffer.h b/include/linux/iio/buffer.h
index 8c915c2c18f1..45a8d59e39cd 100644
--- a/include/linux/iio/buffer.h
+++ b/include/linux/iio/buffer.h
@@ -194,26 +194,13 @@ bool iio_validate_scan_mask_onehot(struct iio_dev *indio_dev,
 struct iio_buffer *iio_buffer_get(struct iio_buffer *buffer);
 void iio_buffer_put(struct iio_buffer *buffer);
 
-/**
- * iio_device_attach_buffer - Attach a buffer to a IIO device
- * @indio_dev: The device the buffer should be attached to
- * @buffer: The buffer to attach to the device
- *
- * This function attaches a buffer to a IIO device. The buffer stays attached to
- * the device until the device is freed. The function should only be called at
- * most once per device.
- */
-static inline void iio_device_attach_buffer(struct iio_dev *indio_dev,
-	struct iio_buffer *buffer)
-{
-	indio_dev->buffer = iio_buffer_get(buffer);
-}
-
 #else /* CONFIG_IIO_BUFFER */
 
 static inline void iio_buffer_get(struct iio_buffer *buffer) {}
 static inline void iio_buffer_put(struct iio_buffer *buffer) {}
 
+void iio_device_attach_buffer(struct iio_dev *indio_dev,
+			      struct iio_buffer *buffer);
 #endif /* CONFIG_IIO_BUFFER */
 
 #endif /* _IIO_BUFFER_GENERIC_H_ */
-- 
2.11.0

