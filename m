Return-Path: <linux-iio-owner@vger.kernel.org>
Received: from tarvos.retrosnub.co.uk ([217.168.153.95]:60310 "EHLO
        tarvos.retrosnub.co.uk" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S933448AbdABT2w (ORCPT
        <rfc822;linux-iio@vger.kernel.org>); Mon, 2 Jan 2017 14:28:52 -0500
From: Jonathan Cameron <jic23@kernel.org>
To: linux-iio@vger.kernel.org
Cc: Daniel Baluta <daniel.baluta@gmail.com>,
        Hartmut Knaack <knaack.h@gmx.de>,
        Lars-Peter Clausen <lars@metafoo.de>,
        Peter Meerwald-Stadler <pmeerw@pmeerw.net>,
        Jonathan Cameron <jic23@kernel.org>
Subject: [PATCH 01/11] iio:buffer: Stop exporting iio_update_demux
Date: Mon,  2 Jan 2017 19:28:24 +0000
Message-Id: <20170102192834.26546-2-jic23@kernel.org>
In-Reply-To: <20170102192834.26546-1-jic23@kernel.org>
References: <20170102192834.26546-1-jic23@kernel.org>
Sender: linux-iio-owner@vger.kernel.org
List-Id: linux-iio@vger.kernel.org

Nothing outside of indiustrialio-buffer.c should be using this.
Requires a large amount of juggling of functions to avoid a
forward definition.

Signed-off-by: Jonathan Cameron <jic23@kernel.org>
---
 drivers/iio/industrialio-buffer.c | 260 +++++++++++++++++++-------------------
 include/linux/iio/buffer.h        |   2 -
 2 files changed, 129 insertions(+), 133 deletions(-)

diff --git a/drivers/iio/industrialio-buffer.c b/drivers/iio/industrialio-buffer.c
index b12830b09c7d..9f496eb84e0b 100644
--- a/drivers/iio/industrialio-buffer.c
+++ b/drivers/iio/industrialio-buffer.c
@@ -751,6 +751,135 @@ static int iio_verify_update(struct iio_dev *indio_dev,
 	return 0;
 }
 
+/**
+ * struct iio_demux_table - table describing demux memcpy ops
+ * @from:	index to copy from
+ * @to:		index to copy to
+ * @length:	how many bytes to copy
+ * @l:		list head used for management
+ */
+struct iio_demux_table {
+	unsigned from;
+	unsigned to;
+	unsigned length;
+	struct list_head l;
+};
+
+static void iio_buffer_demux_free(struct iio_buffer *buffer)
+{
+	struct iio_demux_table *p, *q;
+	list_for_each_entry_safe(p, q, &buffer->demux_list, l) {
+		list_del(&p->l);
+		kfree(p);
+	}
+}
+
+static int iio_buffer_add_demux(struct iio_buffer *buffer,
+	struct iio_demux_table **p, unsigned int in_loc, unsigned int out_loc,
+	unsigned int length)
+{
+
+	if (*p && (*p)->from + (*p)->length == in_loc &&
+		(*p)->to + (*p)->length == out_loc) {
+		(*p)->length += length;
+	} else {
+		*p = kmalloc(sizeof(**p), GFP_KERNEL);
+		if (*p == NULL)
+			return -ENOMEM;
+		(*p)->from = in_loc;
+		(*p)->to = out_loc;
+		(*p)->length = length;
+		list_add_tail(&(*p)->l, &buffer->demux_list);
+	}
+
+	return 0;
+}
+
+static int iio_buffer_update_demux(struct iio_dev *indio_dev,
+				   struct iio_buffer *buffer)
+{
+	int ret, in_ind = -1, out_ind, length;
+	unsigned in_loc = 0, out_loc = 0;
+	struct iio_demux_table *p = NULL;
+
+	/* Clear out any old demux */
+	iio_buffer_demux_free(buffer);
+	kfree(buffer->demux_bounce);
+	buffer->demux_bounce = NULL;
+
+	/* First work out which scan mode we will actually have */
+	if (bitmap_equal(indio_dev->active_scan_mask,
+			 buffer->scan_mask,
+			 indio_dev->masklength))
+		return 0;
+
+	/* Now we have the two masks, work from least sig and build up sizes */
+	for_each_set_bit(out_ind,
+			 buffer->scan_mask,
+			 indio_dev->masklength) {
+		in_ind = find_next_bit(indio_dev->active_scan_mask,
+				       indio_dev->masklength,
+				       in_ind + 1);
+		while (in_ind != out_ind) {
+			in_ind = find_next_bit(indio_dev->active_scan_mask,
+					       indio_dev->masklength,
+					       in_ind + 1);
+			length = iio_storage_bytes_for_si(indio_dev, in_ind);
+			/* Make sure we are aligned */
+			in_loc = roundup(in_loc, length) + length;
+		}
+		length = iio_storage_bytes_for_si(indio_dev, in_ind);
+		out_loc = roundup(out_loc, length);
+		in_loc = roundup(in_loc, length);
+		ret = iio_buffer_add_demux(buffer, &p, in_loc, out_loc, length);
+		if (ret)
+			goto error_clear_mux_table;
+		out_loc += length;
+		in_loc += length;
+	}
+	/* Relies on scan_timestamp being last */
+	if (buffer->scan_timestamp) {
+		length = iio_storage_bytes_for_timestamp(indio_dev);
+		out_loc = roundup(out_loc, length);
+		in_loc = roundup(in_loc, length);
+		ret = iio_buffer_add_demux(buffer, &p, in_loc, out_loc, length);
+		if (ret)
+			goto error_clear_mux_table;
+		out_loc += length;
+		in_loc += length;
+	}
+	buffer->demux_bounce = kzalloc(out_loc, GFP_KERNEL);
+	if (buffer->demux_bounce == NULL) {
+		ret = -ENOMEM;
+		goto error_clear_mux_table;
+	}
+	return 0;
+
+error_clear_mux_table:
+	iio_buffer_demux_free(buffer);
+
+	return ret;
+}
+
+static int iio_update_demux(struct iio_dev *indio_dev)
+{
+	struct iio_buffer *buffer;
+	int ret;
+
+	list_for_each_entry(buffer, &indio_dev->buffer_list, buffer_list) {
+		ret = iio_buffer_update_demux(indio_dev, buffer);
+		if (ret < 0)
+			goto error_clear_mux_table;
+	}
+	return 0;
+
+error_clear_mux_table:
+	list_for_each_entry(buffer, &indio_dev->buffer_list, buffer_list)
+		iio_buffer_demux_free(buffer);
+
+	return ret;
+}
+
 static int iio_enable_buffers(struct iio_dev *indio_dev,
 	struct iio_device_config *config)
 {
@@ -1213,20 +1342,6 @@ int iio_scan_mask_query(struct iio_dev *indio_dev,
 };
 EXPORT_SYMBOL_GPL(iio_scan_mask_query);
 
-/**
- * struct iio_demux_table - table describing demux memcpy ops
- * @from:	index to copy from
- * @to:		index to copy to
- * @length:	how many bytes to copy
- * @l:		list head used for management
- */
-struct iio_demux_table {
-	unsigned from;
-	unsigned to;
-	unsigned length;
-	struct list_head l;
-};
-
 static const void *iio_demux(struct iio_buffer *buffer,
 				 const void *datain)
 {
@@ -1258,16 +1373,6 @@ static int iio_push_to_buffer(struct iio_buffer *buffer, const void *data)
 	return 0;
 }
 
-static void iio_buffer_demux_free(struct iio_buffer *buffer)
-{
-	struct iio_demux_table *p, *q;
-	list_for_each_entry_safe(p, q, &buffer->demux_list, l) {
-		list_del(&p->l);
-		kfree(p);
-	}
-}
-
-
 int iio_push_to_buffers(struct iio_dev *indio_dev, const void *data)
 {
 	int ret;
@@ -1283,113 +1388,6 @@ int iio_push_to_buffers(struct iio_dev *indio_dev, const void *data)
 }
 EXPORT_SYMBOL_GPL(iio_push_to_buffers);
 
-static int iio_buffer_add_demux(struct iio_buffer *buffer,
-	struct iio_demux_table **p, unsigned int in_loc, unsigned int out_loc,
-	unsigned int length)
-{
-
-	if (*p && (*p)->from + (*p)->length == in_loc &&
-		(*p)->to + (*p)->length == out_loc) {
-		(*p)->length += length;
-	} else {
-		*p = kmalloc(sizeof(**p), GFP_KERNEL);
-		if (*p == NULL)
-			return -ENOMEM;
-		(*p)->from = in_loc;
-		(*p)->to = out_loc;
-		(*p)->length = length;
-		list_add_tail(&(*p)->l, &buffer->demux_list);
-	}
-
-	return 0;
-}
-
-static int iio_buffer_update_demux(struct iio_dev *indio_dev,
-				   struct iio_buffer *buffer)
-{
-	int ret, in_ind = -1, out_ind, length;
-	unsigned in_loc = 0, out_loc = 0;
-	struct iio_demux_table *p = NULL;
-
-	/* Clear out any old demux */
-	iio_buffer_demux_free(buffer);
-	kfree(buffer->demux_bounce);
-	buffer->demux_bounce = NULL;
-
-	/* First work out which scan mode we will actually have */
-	if (bitmap_equal(indio_dev->active_scan_mask,
-			 buffer->scan_mask,
-			 indio_dev->masklength))
-		return 0;
-
-	/* Now we have the two masks, work from least sig and build up sizes */
-	for_each_set_bit(out_ind,
-			 buffer->scan_mask,
-			 indio_dev->masklength) {
-		in_ind = find_next_bit(indio_dev->active_scan_mask,
-				       indio_dev->masklength,
-				       in_ind + 1);
-		while (in_ind != out_ind) {
-			in_ind = find_next_bit(indio_dev->active_scan_mask,
-					       indio_dev->masklength,
-					       in_ind + 1);
-			length = iio_storage_bytes_for_si(indio_dev, in_ind);
-			/* Make sure we are aligned */
-			in_loc = roundup(in_loc, length) + length;
-		}
-		length = iio_storage_bytes_for_si(indio_dev, in_ind);
-		out_loc = roundup(out_loc, length);
-		in_loc = roundup(in_loc, length);
-		ret = iio_buffer_add_demux(buffer, &p, in_loc, out_loc, length);
-		if (ret)
-			goto error_clear_mux_table;
-		out_loc += length;
-		in_loc += length;
-	}
-	/* Relies on scan_timestamp being last */
-	if (buffer->scan_timestamp) {
-		length = iio_storage_bytes_for_timestamp(indio_dev);
-		out_loc = roundup(out_loc, length);
-		in_loc = roundup(in_loc, length);
-		ret = iio_buffer_add_demux(buffer, &p, in_loc, out_loc, length);
-		if (ret)
-			goto error_clear_mux_table;
-		out_loc += length;
-		in_loc += length;
-	}
-	buffer->demux_bounce = kzalloc(out_loc, GFP_KERNEL);
-	if (buffer->demux_bounce == NULL) {
-		ret = -ENOMEM;
-		goto error_clear_mux_table;
-	}
-	return 0;
-
-error_clear_mux_table:
-	iio_buffer_demux_free(buffer);
-
-	return ret;
-}
-
-int iio_update_demux(struct iio_dev *indio_dev)
-{
-	struct iio_buffer *buffer;
-	int ret;
-
-	list_for_each_entry(buffer, &indio_dev->buffer_list, buffer_list) {
-		ret = iio_buffer_update_demux(indio_dev, buffer);
-		if (ret < 0)
-			goto error_clear_mux_table;
-	}
-	return 0;
-
-error_clear_mux_table:
-	list_for_each_entry(buffer, &indio_dev->buffer_list, buffer_list)
-		iio_buffer_demux_free(buffer);
-
-	return ret;
-}
-EXPORT_SYMBOL_GPL(iio_update_demux);
-
 /**
  * iio_buffer_release() - Free a buffer's resources
  * @ref: Pointer to the kref embedded in the iio_buffer struct
diff --git a/include/linux/iio/buffer.h b/include/linux/iio/buffer.h
index 70a5164f4728..889d0f2f5d7b 100644
--- a/include/linux/iio/buffer.h
+++ b/include/linux/iio/buffer.h
@@ -168,8 +168,6 @@ static inline int iio_push_to_buffers_with_timestamp(struct iio_dev *indio_dev,
 	return iio_push_to_buffers(indio_dev, data);
 }
 
-int iio_update_demux(struct iio_dev *indio_dev);
-
 bool iio_validate_scan_mask_onehot(struct iio_dev *indio_dev,
 	const unsigned long *mask);
 
-- 
2.11.0

