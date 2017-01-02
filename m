Return-Path: <linux-iio-owner@vger.kernel.org>
Received: from tarvos.retrosnub.co.uk ([217.168.153.95]:60396 "EHLO
        tarvos.retrosnub.co.uk" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S933930AbdABT3D (ORCPT
        <rfc822;linux-iio@vger.kernel.org>); Mon, 2 Jan 2017 14:29:03 -0500
From: Jonathan Cameron <jic23@kernel.org>
To: linux-iio@vger.kernel.org
Cc: Daniel Baluta <daniel.baluta@gmail.com>,
        Hartmut Knaack <knaack.h@gmx.de>,
        Lars-Peter Clausen <lars@metafoo.de>,
        Peter Meerwald-Stadler <pmeerw@pmeerw.net>,
        Jonathan Cameron <jic23@kernel.org>
Subject: [PATCH 11/11] iio:buffer.h - split into buffer.h and buffer_impl.h
Date: Mon,  2 Jan 2017 19:28:34 +0000
Message-Id: <20170102192834.26546-12-jic23@kernel.org>
In-Reply-To: <20170102192834.26546-1-jic23@kernel.org>
References: <20170102192834.26546-1-jic23@kernel.org>
Sender: linux-iio-owner@vger.kernel.org
List-Id: linux-iio@vger.kernel.org

buffer.h supplies everything needed for devices using buffers.
buffer_impl.h supplies access to the internals as needed to write
a buffer implementation.

This was really motivated by the mess that turned up in the
kernel-doc documentation pulled in by the new sphinx docs.
It made it clear that our logical separations in headers were
generally terrible.  The buffer case was easy to sort out without
greatly effecting drivers so here it is.

Signed-off-by: Jonathan Cameron <jic23@kernel.org>
---
 drivers/iio/buffer/industrialio-buffer-cb.c |   2 +-
 drivers/iio/buffer/kfifo_buf.c              |   1 +
 drivers/iio/industrialio-buffer.c           |   1 +
 drivers/iio/industrialio-core.c             |   1 +
 include/linux/iio/buffer.h                  | 155 +-------------------------
 include/linux/iio/buffer_impl.h             | 162 ++++++++++++++++++++++++++++
 6 files changed, 167 insertions(+), 155 deletions(-)

diff --git a/drivers/iio/buffer/industrialio-buffer-cb.c b/drivers/iio/buffer/industrialio-buffer-cb.c
index 79fb2f9de759..4847534700e7 100644
--- a/drivers/iio/buffer/industrialio-buffer-cb.c
+++ b/drivers/iio/buffer/industrialio-buffer-cb.c
@@ -11,7 +11,7 @@
 #include <linux/err.h>
 #include <linux/export.h>
 #include <linux/iio/iio.h>
-#include <linux/iio/buffer.h>
+#include <linux/iio/buffer_impl.h>
 #include <linux/iio/consumer.h>
 
 struct iio_cb_buffer {
diff --git a/drivers/iio/buffer/kfifo_buf.c b/drivers/iio/buffer/kfifo_buf.c
index 2267ce190335..f584742f191e 100644
--- a/drivers/iio/buffer/kfifo_buf.c
+++ b/drivers/iio/buffer/kfifo_buf.c
@@ -7,6 +7,7 @@
 #include <linux/mutex.h>
 #include <linux/iio/iio.h>
 #include <linux/iio/kfifo_buf.h>
+#include <linux/iio/buffer_impl.h>
 #include <linux/sched.h>
 #include <linux/poll.h>
 
diff --git a/drivers/iio/industrialio-buffer.c b/drivers/iio/industrialio-buffer.c
index a04498231f94..4972986f6455 100644
--- a/drivers/iio/industrialio-buffer.c
+++ b/drivers/iio/industrialio-buffer.c
@@ -26,6 +26,7 @@
 #include "iio_core.h"
 #include <linux/iio/sysfs.h>
 #include <linux/iio/buffer.h>
+#include <linux/iio/buffer_impl.h>
 
 static const char * const iio_endian_prefix[] = {
 	[IIO_BE] = "be",
diff --git a/drivers/iio/industrialio-core.c b/drivers/iio/industrialio-core.c
index aaca42862389..d507c0f5cd2c 100644
--- a/drivers/iio/industrialio-core.c
+++ b/drivers/iio/industrialio-core.c
@@ -32,6 +32,7 @@
 #include <linux/iio/sysfs.h>
 #include <linux/iio/events.h>
 #include <linux/iio/buffer.h>
+#include <linux/iio/buffer_impl.h>
 
 /* IDA to assign each registered device a unique id */
 static DEFINE_IDA(iio_ida);
diff --git a/include/linux/iio/buffer.h b/include/linux/iio/buffer.h
index 45a8d59e39cd..48767c776119 100644
--- a/include/linux/iio/buffer.h
+++ b/include/linux/iio/buffer.h
@@ -11,155 +11,11 @@
 #define _IIO_BUFFER_GENERIC_H_
 #include <linux/sysfs.h>
 #include <linux/iio/iio.h>
-#include <linux/kref.h>
-
-#ifdef CONFIG_IIO_BUFFER
 
 struct iio_buffer;
 
 void iio_buffer_set_attrs(struct iio_buffer *buffer,
 			 const struct attribute **attrs);
-/**
- * INDIO_BUFFER_FLAG_FIXED_WATERMARK - Watermark level of the buffer can not be
- *   configured. It has a fixed value which will be buffer specific.
- */
-#define INDIO_BUFFER_FLAG_FIXED_WATERMARK BIT(0)
-
-/**
- * struct iio_buffer_access_funcs - access functions for buffers.
- * @store_to:		actually store stuff to the buffer
- * @read_first_n:	try to get a specified number of bytes (must exist)
- * @data_available:	indicates how much data is available for reading from
- *			the buffer.
- * @request_update:	if a parameter change has been marked, update underlying
- *			storage.
- * @set_bytes_per_datum:set number of bytes per datum
- * @set_length:		set number of datums in buffer
- * @enable:             called if the buffer is attached to a device and the
- *                      device starts sampling. Calls are balanced with
- *                      @disable.
- * @disable:            called if the buffer is attached to a device and the
- *                      device stops sampling. Calles are balanced with @enable.
- * @release:		called when the last reference to the buffer is dropped,
- *			should free all resources allocated by the buffer.
- * @modes:		Supported operating modes by this buffer type
- * @flags:		A bitmask combination of INDIO_BUFFER_FLAG_*
- *
- * The purpose of this structure is to make the buffer element
- * modular as event for a given driver, different usecases may require
- * different buffer designs (space efficiency vs speed for example).
- *
- * It is worth noting that a given buffer implementation may only support a
- * small proportion of these functions.  The core code 'should' cope fine with
- * any of them not existing.
- **/
-struct iio_buffer_access_funcs {
-	int (*store_to)(struct iio_buffer *buffer, const void *data);
-	int (*read_first_n)(struct iio_buffer *buffer,
-			    size_t n,
-			    char __user *buf);
-	size_t (*data_available)(struct iio_buffer *buffer);
-
-	int (*request_update)(struct iio_buffer *buffer);
-
-	int (*set_bytes_per_datum)(struct iio_buffer *buffer, size_t bpd);
-	int (*set_length)(struct iio_buffer *buffer, int length);
-
-	int (*enable)(struct iio_buffer *buffer, struct iio_dev *indio_dev);
-	int (*disable)(struct iio_buffer *buffer, struct iio_dev *indio_dev);
-
-	void (*release)(struct iio_buffer *buffer);
-
-	unsigned int modes;
-	unsigned int flags;
-};
-
-/**
- * struct iio_buffer - general buffer structure
- *
- * Note that the internals of this structure should only be of interest to
- * those writing new buffer implementations.
- */
-struct iio_buffer {
-	/** @length: Number of datums in buffer. */
-	int length;
-
-	/**  @bytes_per_datum: Size of individual datum including timestamp. */
-	int bytes_per_datum;
-
-	/**
-	 * @access: Buffer access functions associated with the
-	 * implementation.
-	 */
-	const struct iio_buffer_access_funcs *access;
-
-	/** @scan_mask: Bitmask used in masking scan mode elements. */
-	long *scan_mask;
-
-	/** @demux_list: List of operations required to demux the scan. */
-	struct list_head demux_list;
-
-	/** @pollq: Wait queue to allow for polling on the buffer. */
-	wait_queue_head_t pollq;
-
-	/** @watermark: Number of datums to wait for poll/read. */
-	unsigned int watermark;
-
-	/* private: */
-	/*
-	 * @scan_el_attrs: Control of scan elements if that scan mode
-	 * control method is used.
-	 */
-	struct attribute_group *scan_el_attrs;
-
-	/* @scan_timestamp: Does the scan mode include a timestamp. */
-	bool scan_timestamp;
-
-	/* @scan_el_dev_attr_list: List of scan element related attributes. */
-	struct list_head scan_el_dev_attr_list;
-
-	/* @buffer_group: Attributes of the buffer group. */
-	struct attribute_group buffer_group;
-
-	/*
-	 * @scan_el_group: Attribute group for those attributes not
-	 * created from the iio_chan_info array.
-	 */
-	struct attribute_group scan_el_group;
-
-	/* @stufftoread: Flag to indicate new data. */
-	bool stufftoread;
-
-	/* @attrs: Standard attributes of the buffer. */
-	const struct attribute **attrs;
-
-	/* @demux_bounce: Buffer for doing gather from incoming scan. */
-	void *demux_bounce;
-
-	/* @buffer_list: Entry in the devices list of current buffers. */
-	struct list_head buffer_list;
-
-	/* @ref: Reference count of the buffer. */
-	struct kref ref;
-};
-
-/**
- * iio_update_buffers() - add or remove buffer from active list
- * @indio_dev:		device to add buffer to
- * @insert_buffer:	buffer to insert
- * @remove_buffer:	buffer_to_remove
- *
- * Note this will tear down the all buffering and build it up again
- */
-int iio_update_buffers(struct iio_dev *indio_dev,
-		       struct iio_buffer *insert_buffer,
-		       struct iio_buffer *remove_buffer);
-
-/**
- * iio_buffer_init() - Initialize the buffer structure
- * @buffer:		buffer to be initialized
- **/
-void iio_buffer_init(struct iio_buffer *buffer);
 
 int iio_push_to_buffers(struct iio_dev *indio_dev, const void *data);
 
@@ -189,18 +45,9 @@ static inline int iio_push_to_buffers_with_timestamp(struct iio_dev *indio_dev,
 }
 
 bool iio_validate_scan_mask_onehot(struct iio_dev *indio_dev,
-	const unsigned long *mask);
-
-struct iio_buffer *iio_buffer_get(struct iio_buffer *buffer);
-void iio_buffer_put(struct iio_buffer *buffer);
-
-#else /* CONFIG_IIO_BUFFER */
-
-static inline void iio_buffer_get(struct iio_buffer *buffer) {}
-static inline void iio_buffer_put(struct iio_buffer *buffer) {}
+				   const unsigned long *mask);
 
 void iio_device_attach_buffer(struct iio_dev *indio_dev,
 			      struct iio_buffer *buffer);
-#endif /* CONFIG_IIO_BUFFER */
 
 #endif /* _IIO_BUFFER_GENERIC_H_ */
diff --git a/include/linux/iio/buffer_impl.h b/include/linux/iio/buffer_impl.h
new file mode 100644
index 000000000000..8daba198fafa
--- /dev/null
+++ b/include/linux/iio/buffer_impl.h
@@ -0,0 +1,162 @@
+#ifndef _IIO_BUFFER_GENERIC_IMPL_H_
+#define _IIO_BUFFER_GENERIC_IMPL_H_
+#include <linux/sysfs.h>
+#include <linux/kref.h>
+
+#ifdef CONFIG_IIO_BUFFER
+
+struct iio_dev;
+struct iio_buffer;
+
+/**
+ * INDIO_BUFFER_FLAG_FIXED_WATERMARK - Watermark level of the buffer can not be
+ *   configured. It has a fixed value which will be buffer specific.
+ */
+#define INDIO_BUFFER_FLAG_FIXED_WATERMARK BIT(0)
+
+/**
+ * struct iio_buffer_access_funcs - access functions for buffers.
+ * @store_to:		actually store stuff to the buffer
+ * @read_first_n:	try to get a specified number of bytes (must exist)
+ * @data_available:	indicates how much data is available for reading from
+ *			the buffer.
+ * @request_update:	if a parameter change has been marked, update underlying
+ *			storage.
+ * @set_bytes_per_datum:set number of bytes per datum
+ * @set_length:		set number of datums in buffer
+ * @enable:             called if the buffer is attached to a device and the
+ *                      device starts sampling. Calls are balanced with
+ *                      @disable.
+ * @disable:            called if the buffer is attached to a device and the
+ *                      device stops sampling. Calles are balanced with @enable.
+ * @release:		called when the last reference to the buffer is dropped,
+ *			should free all resources allocated by the buffer.
+ * @modes:		Supported operating modes by this buffer type
+ * @flags:		A bitmask combination of INDIO_BUFFER_FLAG_*
+ *
+ * The purpose of this structure is to make the buffer element
+ * modular as event for a given driver, different usecases may require
+ * different buffer designs (space efficiency vs speed for example).
+ *
+ * It is worth noting that a given buffer implementation may only support a
+ * small proportion of these functions.  The core code 'should' cope fine with
+ * any of them not existing.
+ **/
+struct iio_buffer_access_funcs {
+	int (*store_to)(struct iio_buffer *buffer, const void *data);
+	int (*read_first_n)(struct iio_buffer *buffer,
+			    size_t n,
+			    char __user *buf);
+	size_t (*data_available)(struct iio_buffer *buffer);
+
+	int (*request_update)(struct iio_buffer *buffer);
+
+	int (*set_bytes_per_datum)(struct iio_buffer *buffer, size_t bpd);
+	int (*set_length)(struct iio_buffer *buffer, int length);
+
+	int (*enable)(struct iio_buffer *buffer, struct iio_dev *indio_dev);
+	int (*disable)(struct iio_buffer *buffer, struct iio_dev *indio_dev);
+
+	void (*release)(struct iio_buffer *buffer);
+
+	unsigned int modes;
+	unsigned int flags;
+};
+
+/**
+ * struct iio_buffer - general buffer structure
+ *
+ * Note that the internals of this structure should only be of interest to
+ * those writing new buffer implementations.
+ */
+struct iio_buffer {
+	/** @length: Number of datums in buffer. */
+	int length;
+
+	/**  @bytes_per_datum: Size of individual datum including timestamp. */
+	int bytes_per_datum;
+
+	/**
+	 * @access: Buffer access functions associated with the
+	 * implementation.
+	 */
+	const struct iio_buffer_access_funcs *access;
+
+	/** @scan_mask: Bitmask used in masking scan mode elements. */
+	long *scan_mask;
+
+	/** @demux_list: List of operations required to demux the scan. */
+	struct list_head demux_list;
+
+	/** @pollq: Wait queue to allow for polling on the buffer. */
+	wait_queue_head_t pollq;
+
+	/** @watermark: Number of datums to wait for poll/read. */
+	unsigned int watermark;
+
+	/* private: */
+	/*
+	 * @scan_el_attrs: Control of scan elements if that scan mode
+	 * control method is used.
+	 */
+	struct attribute_group *scan_el_attrs;
+
+	/* @scan_timestamp: Does the scan mode include a timestamp. */
+	bool scan_timestamp;
+
+	/* @scan_el_dev_attr_list: List of scan element related attributes. */
+	struct list_head scan_el_dev_attr_list;
+
+	/* @buffer_group: Attributes of the buffer group. */
+	struct attribute_group buffer_group;
+
+	/*
+	 * @scan_el_group: Attribute group for those attributes not
+	 * created from the iio_chan_info array.
+	 */
+	struct attribute_group scan_el_group;
+
+	/* @stufftoread: Flag to indicate new data. */
+	bool stufftoread;
+
+	/* @attrs: Standard attributes of the buffer. */
+	const struct attribute **attrs;
+
+	/* @demux_bounce: Buffer for doing gather from incoming scan. */
+	void *demux_bounce;
+
+	/* @buffer_list: Entry in the devices list of current buffers. */
+	struct list_head buffer_list;
+
+	/* @ref: Reference count of the buffer. */
+	struct kref ref;
+};
+
+/**
+ * iio_update_buffers() - add or remove buffer from active list
+ * @indio_dev:		device to add buffer to
+ * @insert_buffer:	buffer to insert
+ * @remove_buffer:	buffer_to_remove
+ *
+ * Note this will tear down the all buffering and build it up again
+ */
+int iio_update_buffers(struct iio_dev *indio_dev,
+		       struct iio_buffer *insert_buffer,
+		       struct iio_buffer *remove_buffer);
+
+/**
+ * iio_buffer_init() - Initialize the buffer structure
+ * @buffer:		buffer to be initialized
+ **/
+void iio_buffer_init(struct iio_buffer *buffer);
+
+struct iio_buffer *iio_buffer_get(struct iio_buffer *buffer);
+void iio_buffer_put(struct iio_buffer *buffer);
+
+#else /* CONFIG_IIO_BUFFER */
+
+static inline void iio_buffer_get(struct iio_buffer *buffer) {}
+static inline void iio_buffer_put(struct iio_buffer *buffer) {}
+
+#endif /* CONFIG_IIO_BUFFER */
+#endif /* _IIO_BUFFER_GENERIC_IMPL_H_ */
-- 
2.11.0

