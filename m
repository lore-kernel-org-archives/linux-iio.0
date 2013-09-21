Return-Path: <linux-iio-owner@vger.kernel.org>
Received: from smtp-out-194.synserver.de ([212.40.185.194]:1046 "EHLO
	smtp-out-194.synserver.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751850Ab3IUPim (ORCPT
	<rfc822;linux-iio@vger.kernel.org>); Sat, 21 Sep 2013 11:38:42 -0400
From: Lars-Peter Clausen <lars@metafoo.de>
To: Jonathan Cameron <jic23@kernel.org>
Cc: linux-iio@vger.kernel.org, Lars-Peter Clausen <lars@metafoo.de>
Subject: [PATCH 1/2] iio: Add reference counting for buffers
Date: Sat, 21 Sep 2013 17:21:40 +0200
Message-Id: <1379776901-19429-1-git-send-email-lars@metafoo.de>
Sender: linux-iio-owner@vger.kernel.org
List-Id: linux-iio@vger.kernel.org

Since the buffer is accessed by userspace we can not just free the buffers
memory once we are done with it in kernel space. There might still be open file
descriptors and userspace still might be accessing the buffer. This patch adds
support for reference counting to the IIO buffers. When a buffer is created and
initialized its initial reference count is set to 1. Instead of freeing the
memory of the buffer the buffer's _free() function will drop that reference
again. But only after the last reference to the buffer has been dropped the
buffer the buffer's memory will be freed. The IIO device will take a reference
to its primary buffer. The patch adds a small helper function for this called
iio_device_attach_buffer() which will get a reference to the buffer and assign
the buffer to the IIO device. This function must be used instead of assigning
the buffer to the device by hand. The reference is only dropped once the IIO
device is freed and we can be sure that there are no more open file handles. A
reference to a buffer will also be taken whenever the buffer is active to avoid
the buffer being freed while data is still being send to it.

Signed-off-by: Lars-Peter Clausen <lars@metafoo.de>
---
 drivers/iio/buffer_cb.c                         | 21 +++++++----
 drivers/iio/industrialio-buffer.c               | 41 +++++++++++++++++++---
 drivers/iio/industrialio-core.c                 |  4 +++
 drivers/iio/industrialio-triggered-buffer.c     |  7 ++--
 drivers/iio/kfifo_buf.c                         |  8 ++++-
 drivers/staging/iio/accel/lis3l02dq_ring.c      |  2 +-
 drivers/staging/iio/accel/sca3000_ring.c        | 13 ++++---
 drivers/staging/iio/iio_simple_dummy_buffer.c   |  2 +-
 drivers/staging/iio/impedance-analyzer/ad5933.c |  8 +++--
 drivers/staging/iio/meter/ade7758_ring.c        |  7 ++--
 include/linux/iio/buffer.h                      | 46 +++++++++++++++++++++++++
 11 files changed, 135 insertions(+), 24 deletions(-)

diff --git a/drivers/iio/buffer_cb.c b/drivers/iio/buffer_cb.c
index 415f3c6..659c97f 100644
--- a/drivers/iio/buffer_cb.c
+++ b/drivers/iio/buffer_cb.c
@@ -12,17 +12,27 @@ struct iio_cb_buffer {
 	struct iio_channel *channels;
 };
 
-static int iio_buffer_cb_store_to(struct iio_buffer *buffer, u8 *data)
+static struct iio_cb_buffer *buffer_to_cb_buffer(struct iio_buffer *buffer)
 {
-	struct iio_cb_buffer *cb_buff = container_of(buffer,
-						     struct iio_cb_buffer,
-						     buffer);
+	return container_of(buffer, struct iio_cb_buffer, buffer);
+}
 
+static int iio_buffer_cb_store_to(struct iio_buffer *buffer, u8 *data)
+{
+	struct iio_cb_buffer *cb_buff = buffer_to_cb_buffer(buffer);
 	return cb_buff->cb(data, cb_buff->private);
 }
 
+static void iio_buffer_cb_release(struct iio_buffer *buffer)
+{
+	struct iio_cb_buffer *cb_buff = buffer_to_cb_buffer(buffer);
+	kfree(cb_buff->buffer.scan_mask);
+	kfree(cb_buff);
+}
+
 static struct iio_buffer_access_funcs iio_cb_access = {
 	.store_to = &iio_buffer_cb_store_to,
+	.release = &iio_buffer_cb_release,
 };
 
 struct iio_cb_buffer *iio_channel_get_all_cb(struct device *dev,
@@ -104,9 +114,8 @@ EXPORT_SYMBOL_GPL(iio_channel_stop_all_cb);
 
 void iio_channel_release_all_cb(struct iio_cb_buffer *cb_buff)
 {
-	kfree(cb_buff->buffer.scan_mask);
 	iio_channel_release_all(cb_buff->channels);
-	kfree(cb_buff);
+	iio_buffer_put(&cb_buff->buffer);
 }
 EXPORT_SYMBOL_GPL(iio_channel_release_all_cb);
 
diff --git a/drivers/iio/industrialio-buffer.c b/drivers/iio/industrialio-buffer.c
index 2710f72..9f84b22 100644
--- a/drivers/iio/industrialio-buffer.c
+++ b/drivers/iio/industrialio-buffer.c
@@ -80,6 +80,7 @@ void iio_buffer_init(struct iio_buffer *buffer)
 {
 	INIT_LIST_HEAD(&buffer->demux_list);
 	init_waitqueue_head(&buffer->pollq);
+	kref_init(&buffer->ref);
 }
 EXPORT_SYMBOL(iio_buffer_init);
 
@@ -460,6 +461,19 @@ static int iio_compute_scan_bytes(struct iio_dev *indio_dev, const long *mask,
 	return bytes;
 }
 
+static void iio_buffer_activate(struct iio_dev *indio_dev,
+	struct iio_buffer *buffer)
+{
+	iio_buffer_get(buffer);
+	list_add(&buffer->buffer_list, &indio_dev->buffer_list);
+}
+
+static void iio_buffer_deactivate(struct iio_buffer *buffer)
+{
+	list_del_init(&buffer->buffer_list);
+	iio_buffer_put(buffer);
+}
+
 void iio_disable_all_buffers(struct iio_dev *indio_dev)
 {
 	struct iio_buffer *buffer, *_buffer;
@@ -472,7 +486,7 @@ void iio_disable_all_buffers(struct iio_dev *indio_dev)
 
 	list_for_each_entry_safe(buffer, _buffer,
 			&indio_dev->buffer_list, buffer_list)
-		list_del_init(&buffer->buffer_list);
+		iio_buffer_deactivate(buffer);
 
 	indio_dev->currentmode = INDIO_DIRECT_MODE;
 	if (indio_dev->setup_ops->postdisable)
@@ -509,9 +523,9 @@ int iio_update_buffers(struct iio_dev *indio_dev,
 		indio_dev->active_scan_mask = NULL;
 
 	if (remove_buffer)
-		list_del(&remove_buffer->buffer_list);
+		iio_buffer_deactivate(remove_buffer);
 	if (insert_buffer)
-		list_add(&insert_buffer->buffer_list, &indio_dev->buffer_list);
+		iio_buffer_activate(indio_dev, insert_buffer);
 
 	/* If no buffers in list, we are done */
 	if (list_empty(&indio_dev->buffer_list)) {
@@ -546,7 +560,7 @@ int iio_update_buffers(struct iio_dev *indio_dev,
 			 * Roll back.
 			 * Note can only occur when adding a buffer.
 			 */
-			list_del(&insert_buffer->buffer_list);
+			iio_buffer_deactivate(insert_buffer);
 			if (old_mask) {
 				indio_dev->active_scan_mask = old_mask;
 				success = -EINVAL;
@@ -637,7 +651,7 @@ error_run_postdisable:
 error_remove_inserted:
 
 	if (insert_buffer)
-		list_del(&insert_buffer->buffer_list);
+		iio_buffer_deactivate(insert_buffer);
 	indio_dev->active_scan_mask = old_mask;
 	kfree(compound_mask);
 error_ret:
@@ -958,3 +972,20 @@ error_clear_mux_table:
 	return ret;
 }
 EXPORT_SYMBOL_GPL(iio_update_demux);
+
+/**
+ * __iio_buffer_release() - Free a buffer's resources
+ * @ref: Pointer to the kref embedded in the iio_buffer struct
+ *
+ * This function is called when the last reference to the buffer has been
+ * dropped. It will typically free all resources allocated by the buffer. Do not
+ * call this function manually, always use iio_buffer_put() when done using a
+ * buffer.
+ */
+void __iio_buffer_release(struct kref *ref)
+{
+	struct iio_buffer *buffer = container_of(ref, struct iio_buffer, ref);
+
+	buffer->access->release(buffer);
+}
+EXPORT_SYMBOL_GPL(__iio_buffer_release);
diff --git a/drivers/iio/industrialio-core.c b/drivers/iio/industrialio-core.c
index 8e84cd5..d189f6c 100644
--- a/drivers/iio/industrialio-core.c
+++ b/drivers/iio/industrialio-core.c
@@ -28,6 +28,7 @@
 #include "iio_core_trigger.h"
 #include <linux/iio/sysfs.h>
 #include <linux/iio/events.h>
+#include <linux/iio/buffer.h>
 
 /* IDA to assign each registered device a unique id */
 static DEFINE_IDA(iio_ida);
@@ -854,6 +855,9 @@ static void iio_dev_release(struct device *device)
 	iio_device_unregister_sysfs(indio_dev);
 	iio_device_unregister_debugfs(indio_dev);
 
+	if (indio_dev->buffer)
+		iio_buffer_put(indio_dev->buffer);
+
 	ida_simple_remove(&iio_ida, indio_dev->id);
 	kfree(indio_dev);
 }
diff --git a/drivers/iio/industrialio-triggered-buffer.c b/drivers/iio/industrialio-triggered-buffer.c
index 46c619b..c1cb1f9 100644
--- a/drivers/iio/industrialio-triggered-buffer.c
+++ b/drivers/iio/industrialio-triggered-buffer.c
@@ -47,14 +47,17 @@ int iio_triggered_buffer_setup(struct iio_dev *indio_dev,
 	irqreturn_t (*pollfunc_th)(int irq, void *p),
 	const struct iio_buffer_setup_ops *setup_ops)
 {
+	struct iio_buffer *buffer;
 	int ret;
 
-	indio_dev->buffer = iio_kfifo_allocate(indio_dev);
-	if (!indio_dev->buffer) {
+	buffer = iio_kfifo_allocate(indio_dev);
+	if (!buffer) {
 		ret = -ENOMEM;
 		goto error_ret;
 	}
 
+	iio_device_attach_buffer(indio_dev, buffer);
+
 	indio_dev->pollfunc = iio_alloc_pollfunc(pollfunc_bh,
 						 pollfunc_th,
 						 IRQF_ONESHOT,
diff --git a/drivers/iio/kfifo_buf.c b/drivers/iio/kfifo_buf.c
index a923c78..7ac90fb 100644
--- a/drivers/iio/kfifo_buf.c
+++ b/drivers/iio/kfifo_buf.c
@@ -129,6 +129,11 @@ static int iio_read_first_n_kfifo(struct iio_buffer *r,
 	return copied;
 }
 
+static void iio_kfifo_buffer_release(struct iio_buffer *buffer)
+{
+	kfree(iio_to_kfifo(buffer));
+}
+
 static const struct iio_buffer_access_funcs kfifo_access_funcs = {
 	.store_to = &iio_store_to_kfifo,
 	.read_first_n = &iio_read_first_n_kfifo,
@@ -137,6 +142,7 @@ static const struct iio_buffer_access_funcs kfifo_access_funcs = {
 	.set_bytes_per_datum = &iio_set_bytes_per_datum_kfifo,
 	.get_length = &iio_get_length_kfifo,
 	.set_length = &iio_set_length_kfifo,
+	.release = &iio_kfifo_buffer_release,
 };
 
 struct iio_buffer *iio_kfifo_allocate(struct iio_dev *indio_dev)
@@ -157,7 +163,7 @@ EXPORT_SYMBOL(iio_kfifo_allocate);
 
 void iio_kfifo_free(struct iio_buffer *r)
 {
-	kfree(iio_to_kfifo(r));
+	iio_buffer_put(r);
 }
 EXPORT_SYMBOL(iio_kfifo_free);
 
diff --git a/drivers/staging/iio/accel/lis3l02dq_ring.c b/drivers/staging/iio/accel/lis3l02dq_ring.c
index 5b8f0f6..2a0d012 100644
--- a/drivers/staging/iio/accel/lis3l02dq_ring.c
+++ b/drivers/staging/iio/accel/lis3l02dq_ring.c
@@ -401,7 +401,7 @@ int lis3l02dq_configure_buffer(struct iio_dev *indio_dev)
 	if (!buffer)
 		return -ENOMEM;
 
-	indio_dev->buffer = buffer;
+	iio_device_attach_buffer(indio_dev, buffer);
 
 	buffer->scan_timestamp = true;
 	indio_dev->setup_ops = &lis3l02dq_buffer_setup_ops;
diff --git a/drivers/staging/iio/accel/sca3000_ring.c b/drivers/staging/iio/accel/sca3000_ring.c
index 3e5e860..5ca80b3 100644
--- a/drivers/staging/iio/accel/sca3000_ring.c
+++ b/drivers/staging/iio/accel/sca3000_ring.c
@@ -265,7 +265,7 @@ static struct iio_buffer *sca3000_rb_allocate(struct iio_dev *indio_dev)
 	return buf;
 }
 
-static inline void sca3000_rb_free(struct iio_buffer *r)
+static void sca3000_ring_release(struct iio_buffer *r)
 {
 	kfree(iio_to_hw_buf(r));
 }
@@ -274,23 +274,28 @@ static const struct iio_buffer_access_funcs sca3000_ring_access_funcs = {
 	.read_first_n = &sca3000_read_first_n_hw_rb,
 	.get_length = &sca3000_ring_get_length,
 	.get_bytes_per_datum = &sca3000_ring_get_bytes_per_datum,
+	.release = sca3000_ring_release,
 };
 
 int sca3000_configure_ring(struct iio_dev *indio_dev)
 {
-	indio_dev->buffer = sca3000_rb_allocate(indio_dev);
-	if (indio_dev->buffer == NULL)
+	struct iio_buffer *buffer;
+
+	buffer = sca3000_rb_allocate(indio_dev);
+	if (buffer == NULL)
 		return -ENOMEM;
 	indio_dev->modes |= INDIO_BUFFER_HARDWARE;
 
 	indio_dev->buffer->access = &sca3000_ring_access_funcs;
 
+	iio_device_attach_buffer(indio_dev, buffer);
+
 	return 0;
 }
 
 void sca3000_unconfigure_ring(struct iio_dev *indio_dev)
 {
-	sca3000_rb_free(indio_dev->buffer);
+	iio_buffer_put(indio_dev->buffer);
 }
 
 static inline
diff --git a/drivers/staging/iio/iio_simple_dummy_buffer.c b/drivers/staging/iio/iio_simple_dummy_buffer.c
index 72f400c..272eaac 100644
--- a/drivers/staging/iio/iio_simple_dummy_buffer.c
+++ b/drivers/staging/iio/iio_simple_dummy_buffer.c
@@ -138,7 +138,7 @@ int iio_simple_dummy_configure_buffer(struct iio_dev *indio_dev,
 		goto error_ret;
 	}
 
-	indio_dev->buffer = buffer;
+	iio_device_attach_buffer(indio_dev, buffer);
 
 	/* Enable timestamps by default */
 	buffer->scan_timestamp = true;
diff --git a/drivers/staging/iio/impedance-analyzer/ad5933.c b/drivers/staging/iio/impedance-analyzer/ad5933.c
index 6330af6..f282b34 100644
--- a/drivers/staging/iio/impedance-analyzer/ad5933.c
+++ b/drivers/staging/iio/impedance-analyzer/ad5933.c
@@ -630,10 +630,14 @@ static const struct iio_buffer_setup_ops ad5933_ring_setup_ops = {
 
 static int ad5933_register_ring_funcs_and_init(struct iio_dev *indio_dev)
 {
-	indio_dev->buffer = iio_kfifo_allocate(indio_dev);
-	if (!indio_dev->buffer)
+	struct iio_buffer *buffer;
+
+	buffer = iio_kfifo_allocate(indio_dev);
+	if (buffer)
 		return -ENOMEM;
 
+	iio_device_attach_buffer(indio_dev, buffer);
+
 	/* Ring buffer functions - here trigger setup related */
 	indio_dev->setup_ops = &ad5933_ring_setup_ops;
 
diff --git a/drivers/staging/iio/meter/ade7758_ring.c b/drivers/staging/iio/meter/ade7758_ring.c
index 7d5db71..28d4a02 100644
--- a/drivers/staging/iio/meter/ade7758_ring.c
+++ b/drivers/staging/iio/meter/ade7758_ring.c
@@ -125,14 +125,17 @@ void ade7758_unconfigure_ring(struct iio_dev *indio_dev)
 int ade7758_configure_ring(struct iio_dev *indio_dev)
 {
 	struct ade7758_state *st = iio_priv(indio_dev);
+	struct iio_buffer *buffer;
 	int ret = 0;
 
-	indio_dev->buffer = iio_kfifo_allocate(indio_dev);
-	if (!indio_dev->buffer) {
+	buffer = iio_kfifo_allocate(indio_dev);
+	if (!buffer) {
 		ret = -ENOMEM;
 		return ret;
 	}
 
+	iio_device_attach_buffer(indio_dev, buffer);
+
 	indio_dev->setup_ops = &ade7758_ring_setup_ops;
 
 	indio_dev->pollfunc = iio_alloc_pollfunc(&iio_pollfunc_store_time,
diff --git a/include/linux/iio/buffer.h b/include/linux/iio/buffer.h
index 2bac0eb..3fd8256 100644
--- a/include/linux/iio/buffer.h
+++ b/include/linux/iio/buffer.h
@@ -11,6 +11,7 @@
 #define _IIO_BUFFER_GENERIC_H_
 #include <linux/sysfs.h>
 #include <linux/iio/iio.h>
+#include <linux/kref.h>
 
 #ifdef CONFIG_IIO_BUFFER
 
@@ -26,6 +27,8 @@ struct iio_buffer;
  * @set_bytes_per_datum:set number of bytes per datum
  * @get_length:		get number of datums in buffer
  * @set_length:		set number of datums in buffer
+ * @release:		called when the last reference to the buffer is dropped,
+ *			should free all resources allocated by the buffer.
  *
  * The purpose of this structure is to make the buffer element
  * modular as event for a given driver, different usecases may require
@@ -47,6 +50,8 @@ struct iio_buffer_access_funcs {
 	int (*set_bytes_per_datum)(struct iio_buffer *buffer, size_t bpd);
 	int (*get_length)(struct iio_buffer *buffer);
 	int (*set_length)(struct iio_buffer *buffer, int length);
+
+	void (*release)(struct iio_buffer *buffer);
 };
 
 /**
@@ -67,6 +72,7 @@ struct iio_buffer_access_funcs {
  * @demux_list:		[INTERN] list of operations required to demux the scan.
  * @demux_bounce:	[INTERN] buffer for doing gather from incoming scan.
  * @buffer_list:	[INTERN] entry in the devices list of current buffers.
+ * @ref:		[INTERN] reference count of the buffer.
  */
 struct iio_buffer {
 	int					length;
@@ -83,6 +89,7 @@ struct iio_buffer {
 	struct list_head			demux_list;
 	unsigned char				*demux_bounce;
 	struct list_head			buffer_list;
+	struct kref				ref;
 };
 
 /**
@@ -179,6 +186,42 @@ int iio_sw_buffer_preenable(struct iio_dev *indio_dev);
 bool iio_validate_scan_mask_onehot(struct iio_dev *indio_dev,
 	const unsigned long *mask);
 
+void __iio_buffer_release(struct kref *kref);
+
+/**
+ * iio_buffer_get() - Grab a reference to the buffer
+ * @buffer: The buffer to grab a reference for
+ */
+static inline void iio_buffer_get(struct iio_buffer *buffer)
+{
+	kref_get(&buffer->ref);
+}
+
+/**
+ * iio_buffer_put() - Release the reference to the buffer
+ * @buffer: The buffer to release the reference for
+ */
+static inline void iio_buffer_put(struct iio_buffer *buffer)
+{
+	kref_put(&buffer->ref, __iio_buffer_release);
+}
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
+static inline void iio_device_attach_buffer(struct iio_dev *indio_dev,
+	struct iio_buffer *buffer)
+{
+	iio_buffer_get(buffer);
+	indio_dev->buffer = buffer;
+}
+
 #else /* CONFIG_IIO_BUFFER */
 
 static inline int iio_buffer_register(struct iio_dev *indio_dev,
@@ -191,6 +234,9 @@ static inline int iio_buffer_register(struct iio_dev *indio_dev,
 static inline void iio_buffer_unregister(struct iio_dev *indio_dev)
 {}
 
+static inline void iio_buffer_get(struct iio_buffer *buffer) {}
+static inline void iio_buffer_put(struct iio_buffer *buffer) {}
+
 #endif /* CONFIG_IIO_BUFFER */
 
 #endif /* _IIO_BUFFER_GENERIC_H_ */
-- 
1.8.0

