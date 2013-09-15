Return-Path: <lars@metafoo.de>
From: Lars-Peter Clausen <lars@metafoo.de>
To: Jonathan Cameron <jic23@kernel.org>
Cc: linux-iio@vger.kernel.org,
	Lars-Peter Clausen <lars@metafoo.de>
Subject: [PATCH 01/27] iio: iio_push_to_buffers(): Change type of 'data' to const void *
Date: Sun, 15 Sep 2013 18:50:54 +0200
Message-Id: <1379263880-18405-1-git-send-email-lars@metafoo.de>
List-ID: <linux-iio@vger.kernel.org>

Change the type of the 'data' parameter for iio_push_to_buffers() from 'u8 *' to
'const void *'. Drivers typically use the correct type (e.g. __be16 *) for their
data buffer. When passing the buffer to iio_push_to_buffers() it needs to be
cast to 'u8 *' for the compiler to not complain (and also having to add __force
if we want to keep sparse happy as well). Since the buffer implementation should
not care about the data layout (except the size of one sample) using a void
pointer is the correct thing to do. Also make it const as the buffer
implementations are not supposed to modify it.

Signed-off-by: Lars-Peter Clausen <lars@metafoo.de>
---
 drivers/iio/buffer_cb.c           |  6 +++---
 drivers/iio/industrialio-buffer.c | 10 +++++-----
 drivers/iio/kfifo_buf.c           |  2 +-
 include/linux/iio/buffer.h        |  6 +++---
 include/linux/iio/consumer.h      |  2 +-
 5 files changed, 13 insertions(+), 13 deletions(-)

diff --git a/drivers/iio/buffer_cb.c b/drivers/iio/buffer_cb.c
index 9d19ba7..5f40b3a 100644
--- a/drivers/iio/buffer_cb.c
+++ b/drivers/iio/buffer_cb.c
@@ -7,12 +7,12 @@
 
 struct iio_cb_buffer {
 	struct iio_buffer buffer;
-	int (*cb)(u8 *data, void *private);
+	int (*cb)(const void *data, void *private);
 	void *private;
 	struct iio_channel *channels;
 };
 
-static int iio_buffer_cb_store_to(struct iio_buffer *buffer, u8 *data)
+static int iio_buffer_cb_store_to(struct iio_buffer *buffer, const void *data)
 {
 	struct iio_cb_buffer *cb_buff = container_of(buffer,
 						     struct iio_cb_buffer,
@@ -26,7 +26,7 @@ static struct iio_buffer_access_funcs iio_cb_access = {
 };
 
 struct iio_cb_buffer *iio_channel_get_all_cb(struct device *dev,
-					     int (*cb)(u8 *data,
+					     int (*cb)(const void *data,
 						       void *private),
 					     void *private)
 {
diff --git a/drivers/iio/industrialio-buffer.c b/drivers/iio/industrialio-buffer.c
index 7ea2edb..a7ac4b5 100644
--- a/drivers/iio/industrialio-buffer.c
+++ b/drivers/iio/industrialio-buffer.c
@@ -769,8 +769,8 @@ struct iio_demux_table {
 	struct list_head l;
 };
 
-static unsigned char *iio_demux(struct iio_buffer *buffer,
-				 unsigned char *datain)
+static const void *iio_demux(struct iio_buffer *buffer,
+				 const void *datain)
 {
 	struct iio_demux_table *t;
 
@@ -783,9 +783,9 @@ static unsigned char *iio_demux(struct iio_buffer *buffer,
 	return buffer->demux_bounce;
 }
 
-static int iio_push_to_buffer(struct iio_buffer *buffer, unsigned char *data)
+static int iio_push_to_buffer(struct iio_buffer *buffer, const void *data)
 {
-	unsigned char *dataout = iio_demux(buffer, data);
+	const void *dataout = iio_demux(buffer, data);
 
 	return buffer->access->store_to(buffer, dataout);
 }
@@ -800,7 +800,7 @@ static void iio_buffer_demux_free(struct iio_buffer *buffer)
 }
 
 
-int iio_push_to_buffers(struct iio_dev *indio_dev, unsigned char *data)
+int iio_push_to_buffers(struct iio_dev *indio_dev, const void *data)
 {
 	int ret;
 	struct iio_buffer *buf;
diff --git a/drivers/iio/kfifo_buf.c b/drivers/iio/kfifo_buf.c
index 1bea41b..538d461 100644
--- a/drivers/iio/kfifo_buf.c
+++ b/drivers/iio/kfifo_buf.c
@@ -95,7 +95,7 @@ static int iio_set_length_kfifo(struct iio_buffer *r, int length)
 }
 
 static int iio_store_to_kfifo(struct iio_buffer *r,
-			      u8 *data)
+			      const void *data)
 {
 	int ret;
 	struct iio_kfifo *kf = iio_to_kfifo(r);
diff --git a/include/linux/iio/buffer.h b/include/linux/iio/buffer.h
index 2bac0eb..e5507e9 100644
--- a/include/linux/iio/buffer.h
+++ b/include/linux/iio/buffer.h
@@ -36,7 +36,7 @@ struct iio_buffer;
  * any of them not existing.
  **/
 struct iio_buffer_access_funcs {
-	int (*store_to)(struct iio_buffer *buffer, u8 *data);
+	int (*store_to)(struct iio_buffer *buffer, const void *data);
 	int (*read_first_n)(struct iio_buffer *buffer,
 			    size_t n,
 			    char __user *buf);
@@ -81,7 +81,7 @@ struct iio_buffer {
 	bool					stufftoread;
 	const struct attribute_group *attrs;
 	struct list_head			demux_list;
-	unsigned char				*demux_bounce;
+	void					*demux_bounce;
 	struct list_head			buffer_list;
 };
 
@@ -120,7 +120,7 @@ int iio_scan_mask_set(struct iio_dev *indio_dev,
  * @indio_dev:		iio_dev structure for device.
  * @data:		Full scan.
  */
-int iio_push_to_buffers(struct iio_dev *indio_dev, unsigned char *data);
+int iio_push_to_buffers(struct iio_dev *indio_dev, const void *data);
 
 int iio_update_demux(struct iio_dev *indio_dev);
 
diff --git a/include/linux/iio/consumer.h b/include/linux/iio/consumer.h
index 833926c..2752b1f 100644
--- a/include/linux/iio/consumer.h
+++ b/include/linux/iio/consumer.h
@@ -77,7 +77,7 @@ struct iio_cb_buffer;
  * fail.
  */
 struct iio_cb_buffer *iio_channel_get_all_cb(struct device *dev,
-					     int (*cb)(u8 *data,
+					     int (*cb)(const void *data,
 						       void *private),
 					     void *private);
 /**
-- 
1.8.0
