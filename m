Return-Path: <lars@metafoo.de>
From: Lars-Peter Clausen <lars@metafoo.de>
To: Jonathan Cameron <jic23@kernel.org>
Cc: linux-iio@vger.kernel.org,
	Lars-Peter Clausen <lars@metafoo.de>
Subject: [PATCH] iio:buffer: Simplify iio_buffer_is_active()
Date: Sun, 15 Sep 2013 17:31:06 +0200
Message-Id: <1379259066-22475-1-git-send-email-lars@metafoo.de>
List-ID: <linux-iio@vger.kernel.org>

We can skip having to loop through all the device's buffers to see if a certain
buffer is active, if we let the buffer's list head point to itself when the
buffer is inactive.

Signed-off-by: Lars-Peter Clausen <lars@metafoo.de>
---
 drivers/iio/industrialio-buffer.c | 31 +++++++++++--------------------
 1 file changed, 11 insertions(+), 20 deletions(-)

diff --git a/drivers/iio/industrialio-buffer.c b/drivers/iio/industrialio-buffer.c
index e73033f..96e97ad 100644
--- a/drivers/iio/industrialio-buffer.c
+++ b/drivers/iio/industrialio-buffer.c
@@ -31,16 +31,9 @@ static const char * const iio_endian_prefix[] = {
 	[IIO_LE] = "le",
 };
 
-static bool iio_buffer_is_active(struct iio_dev *indio_dev,
-				 struct iio_buffer *buf)
+static bool iio_buffer_is_active(struct iio_buffer *buf)
 {
-	struct list_head *p;
-
-	list_for_each(p, &indio_dev->buffer_list)
-		if (p == &buf->buffer_list)
-			return true;
-
-	return false;
+	return !list_empty(&buf->buffer_list);
 }
 
 /**
@@ -79,6 +72,7 @@ unsigned int iio_buffer_poll(struct file *filp,
 void iio_buffer_init(struct iio_buffer *buffer)
 {
 	INIT_LIST_HEAD(&buffer->demux_list);
+	INIT_LIST_HEAD(&buffer->buffer_list);
 	init_waitqueue_head(&buffer->pollq);
 }
 EXPORT_SYMBOL(iio_buffer_init);
@@ -146,7 +140,7 @@ static ssize_t iio_scan_el_store(struct device *dev,
 	if (ret < 0)
 		return ret;
 	mutex_lock(&indio_dev->mlock);
-	if (iio_buffer_is_active(indio_dev, indio_dev->buffer)) {
+	if (iio_buffer_is_active(indio_dev->buffer)) {
 		ret = -EBUSY;
 		goto error_ret;
 	}
@@ -192,7 +186,7 @@ static ssize_t iio_scan_el_ts_store(struct device *dev,
 		return ret;
 
 	mutex_lock(&indio_dev->mlock);
-	if (iio_buffer_is_active(indio_dev, indio_dev->buffer)) {
+	if (iio_buffer_is_active(indio_dev->buffer)) {
 		ret = -EBUSY;
 		goto error_ret;
 	}
@@ -396,7 +390,7 @@ ssize_t iio_buffer_write_length(struct device *dev,
 			return len;
 
 	mutex_lock(&indio_dev->mlock);
-	if (iio_buffer_is_active(indio_dev, indio_dev->buffer)) {
+	if (iio_buffer_is_active(indio_dev->buffer)) {
 		ret = -EBUSY;
 	} else {
 		if (buffer->access->set_length)
@@ -414,9 +408,7 @@ ssize_t iio_buffer_show_enable(struct device *dev,
 			       char *buf)
 {
 	struct iio_dev *indio_dev = dev_to_iio_dev(dev);
-	return sprintf(buf, "%d\n",
-		       iio_buffer_is_active(indio_dev,
-					    indio_dev->buffer));
+	return sprintf(buf, "%d\n", iio_buffer_is_active(indio_dev->buffer));
 }
 EXPORT_SYMBOL(iio_buffer_show_enable);
 
@@ -490,7 +482,7 @@ int iio_update_buffers(struct iio_dev *indio_dev,
 		indio_dev->active_scan_mask = NULL;
 
 	if (remove_buffer)
-		list_del(&remove_buffer->buffer_list);
+		list_del_init(&remove_buffer->buffer_list);
 	if (insert_buffer)
 		list_add(&insert_buffer->buffer_list, &indio_dev->buffer_list);
 
@@ -527,7 +519,7 @@ int iio_update_buffers(struct iio_dev *indio_dev,
 			 * Roll back.
 			 * Note can only occur when adding a buffer.
 			 */
-			list_del(&insert_buffer->buffer_list);
+			list_del_init(&insert_buffer->buffer_list);
 			indio_dev->active_scan_mask = old_mask;
 			success = -EINVAL;
 		}
@@ -611,7 +603,7 @@ error_run_postdisable:
 error_remove_inserted:
 
 	if (insert_buffer)
-		list_del(&insert_buffer->buffer_list);
+		list_del_init(&insert_buffer->buffer_list);
 	indio_dev->active_scan_mask = old_mask;
 	kfree(compound_mask);
 error_ret:
@@ -628,7 +620,6 @@ ssize_t iio_buffer_store_enable(struct device *dev,
 	int ret;
 	bool requested_state;
 	struct iio_dev *indio_dev = dev_to_iio_dev(dev);
-	struct iio_buffer *pbuf = indio_dev->buffer;
 	bool inlist;
 
 	ret = strtobool(buf, &requested_state);
@@ -638,7 +629,7 @@ ssize_t iio_buffer_store_enable(struct device *dev,
 	mutex_lock(&indio_dev->mlock);
 
 	/* Find out if it is in the list */
-	inlist = iio_buffer_is_active(indio_dev, pbuf);
+	inlist = iio_buffer_is_active(indio_dev->buffer);
 	/* Already in desired state */
 	if (inlist == requested_state)
 		goto done;
-- 
1.8.0
