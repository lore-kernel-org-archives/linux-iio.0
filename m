Return-Path: <jic23@cam.ac.uk>
From: Jonathan Cameron <jic23@cam.ac.uk>
To: linux-iio@vger.kernel.org
Cc: stefani@seibold.net,
	Jonathan Cameron <jic23@cam.ac.uk>
Subject: [RFC] staging:iio: kfifo initial tests.
Date: Wed,  5 May 2010 00:13:23 +0100
Message-Id: <1273014803-27906-1-git-send-email-jic23@cam.ac.uk>
List-ID: <linux-iio@vger.kernel.org>

---
This is the result of a quick investigation of a couple
of questions.

* Does Stefani's new kfifo implementation provide a good new option for
 an iio buffer (between device and userspace).

Not clear at the moment.  The problem we have is that I think we fit
fairly badly into the current code.  Typically we have records that
are of fixed size (between init's of the buffer) but this size is
not known at compile time and may take a lot of different options.

Suggestions welcome on this.

* What needs to change to allow iio to easily support different buffer
  options for a given device.

A few bits of industrialio-ring.c need pushing down into the individual
buffer implementations. This patch just kills them rather than fixing
the other buffers.

There are other issues I haven't addressed at all here, like the buffer
event interface.  kfifo won't provide us with any events (it doesn't
make sense for it to do so except for buffer full and that one typically
isn't used in quite the same way most of the other current events are.

Fun fun fun.

Comments on the general approach welcomed. Obviously there are a number
of cleanups that would occur before I'd actually propose merging this.

I've hand hacked this patch to make it more readable. It probably won't
apply and requires Stefani's patch set which Greg KH rejected until
a build issue is fixed.  I've also deployed c++ style comments to
highlight nasty hacks that won't be there in a real version.

Jonathan

 drivers/staging/iio/Kconfig                    |    3 +
 drivers/staging/iio/Makefile                   |    1 +
 drivers/staging/iio/accel/lis3l02dq_ring.c     |   15 +-
 drivers/staging/iio/industrialio-ring.c        |   22 +--
 drivers/staging/iio/kfifo_buf.c                |  204 ++++++++++++++++++++
 drivers/staging/iio/kfifo_buf.h                |   56 ++++++


diff --git a/drivers/staging/iio/Kconfig b/drivers/staging/iio/Kconfig
index ed38ef4..e13d728 100644
--- a/drivers/staging/iio/Kconfig
+++ b/drivers/staging/iio/Kconfig
@@ -28,6 +28,9 @@ config IIO_SW_RING
 	  with the intention that some devices would be able to write
 	  in interrupt context.
 
+config IIO_FIFO_BUF
+       tristate "Industrial I/O buffering based on kfifo"
+       
 endif # IIO_RINGBUFFER
 
 config IIO_TRIGGER
diff --git a/drivers/staging/iio/Makefile b/drivers/staging/iio/Makefile
index 92b81c2..9247f5d 100644
--- a/drivers/staging/iio/Makefile
+++ b/drivers/staging/iio/Makefile
@@ -8,6 +8,7 @@ industrialio-$(CONFIG_IIO_RING_BUFFER) += industrialio-ring.o
 industrialio-$(CONFIG_IIO_TRIGGER) += industrialio-trigger.o
 
 obj-$(CONFIG_IIO_SW_RING) += ring_sw.o
+obj-$(CONFIG_IIO_FIFO_BUF) += kfifo_buf.o
 
 obj-y += accel/
 obj-y += adc/
diff --git a/drivers/staging/iio/accel/lis3l02dq_ring.c b/drivers/staging/iio/accel/lis3l02dq_ring.c
index 7617da8..b5d0a2b 100644
--- a/drivers/staging/iio/accel/lis3l02dq_ring.c
+++ b/drivers/staging/iio/accel/lis3l02dq_ring.c
@@ -12,7 +12,8 @@
 
 #include "../iio.h"
 #include "../sysfs.h"
-#include "../ring_sw.h"
+//#include "../ring_sw.h"
+#include "../kfifo_buf.h"
 #include "accel.h"
 #include "../trigger.h"
 #include "lis3l02dq.h"
@@ -533,7 +534,8 @@ void lis3l02dq_remove_trigger(struct iio_dev *indio_dev)
 void lis3l02dq_unconfigure_ring(struct iio_dev *indio_dev)
 {
 	kfree(indio_dev->pollfunc);
-	iio_sw_rb_free(indio_dev->ring);
+//	iio_sw_rb_free(indio_dev->ring);
+	iio_kfifo_free(indio_dev->ring);
 }
 
 int lis3l02dq_configure_ring(struct iio_dev *indio_dev)
@@ -551,14 +553,16 @@ int lis3l02dq_configure_ring(struct iio_dev *indio_dev)
 
 	indio_dev->scan_el_attrs = &lis3l02dq_scan_el_group;
 
-	ring = iio_sw_rb_allocate(indio_dev);
+//	ring = iio_sw_rb_allocate(indio_dev);
+	ring = iio_kfifo_allocate(indio_dev);
 	if (!ring) {
 		ret = -ENOMEM;
 		return ret;
 	}
 	indio_dev->ring = ring;
 	/* Effectively select the ring buffer implementation */
-	iio_ring_sw_register_funcs(&ring->access);
+//	iio_ring_sw_register_funcs(&ring->access);
+	iio_kfifo_register_funcs(&ring->access);
 	ring->preenable = &lis3l02dq_data_rdy_ring_preenable;
 	ring->postenable = &lis3l02dq_data_rdy_ring_postenable;
 	ring->predisable = &lis3l02dq_data_rdy_ring_predisable;
@@ -575,7 +579,8 @@ int lis3l02dq_configure_ring(struct iio_dev *indio_dev)
 	return 0;
 
 error_iio_sw_rb_free:
-	iio_sw_rb_free(indio_dev->ring);
+//	iio_sw_rb_free(indio_dev->ring);
+	iio_kfifo_free(indio_dev->ring);
 	return ret;
 }
 
diff --git a/drivers/staging/iio/industrialio-ring.c b/drivers/staging/iio/industrialio-ring.c
index fc27d22..19bff1e 100644
--- a/drivers/staging/iio/industrialio-ring.c
+++ b/drivers/staging/iio/industrialio-ring.c
@@ -103,31 +103,11 @@ ssize_t iio_ring_rip_outer(struct file *filp,
 {
 	struct iio_ring_buffer *rb = filp->private_data;
 	int ret, dead_offset, copied;
-	u8 *data;
 	/* rip lots must exist. */
 	if (!rb->access.rip_lots)
 		return -EINVAL;
-	copied = rb->access.rip_lots(rb, count, &data, &dead_offset);
 
-	if (copied < 0) {
-		ret = copied;
-		goto error_ret;
-	}
-	if (copy_to_user(buf, data + dead_offset, copied))  {
-		ret =  -EFAULT;
-		goto error_free_data_cpy;
-	}
-	/* In clever ring buffer designs this may not need to be freed.
-	 * When such a design exists I'll add this to ring access funcs.
-	 */
-	kfree(data);
-
-	return copied;
-
-error_free_data_cpy:
-	kfree(data);
-error_ret:
-	return ret;
+	return rb->access.rip_lots(rb, count, &buf, &dead_offset);
 }
 
 static const struct file_operations iio_ring_fileops = {
diff --git a/drivers/staging/iio/kfifo_buf.c b/drivers/staging/iio/kfifo_buf.c
new file mode 100644
index 0000000..409ac3c
--- /dev/null
+++ b/drivers/staging/iio/kfifo_buf.c
@@ -0,0 +1,204 @@
+/* Wrapping of kfifo for iio use
+ *
+ * Copyright (c) 2008 Jonathan Cameron
+ *
+ * This program is free software; you can redistribute it and/or modify it
+ * under the terms of the GNU General Public License version 2 as published by
+ * the Free Software Foundation.
+ */
+
+#include <linux/slab.h>
+#include <linux/kernel.h>
+#include <linux/module.h>
+#include <linux/device.h>
+#include <linux/workqueue.h>
+#include <linux/kfifo.h>
+#include <linux/mutex.h>
+#include "kfifo_buf.h"
+
+static inline int __iio_allocate_kfifo(struct iio_kfifo *buf,
+				int bytes_per_datum, int length)
+{
+	if ((length == 0) || (bytes_per_datum == 0))
+		return -EINVAL;
+
+	__iio_update_ring_buffer(&buf->ring, bytes_per_datum, length);
+	return kfifo_alloc(&buf->kf, bytes_per_datum*length, GFP_KERNEL);
+}
+
+int iio_request_update_kfifo(struct iio_ring_buffer *r)
+{
+	int ret = 0;
+	struct iio_kfifo *buf = iio_to_kfifo(r);
+
+	mutex_lock(&buf->use_lock);
+	if (!buf->update_needed)
+		goto error_ret;
+	if (buf->use_count) {
+		ret = -EAGAIN;
+		goto error_ret;
+	}
+	kfifo_free(&buf->kf);
+	ret = __iio_allocate_kfifo(buf, buf->ring.bpd,
+				buf->ring.length);
+error_ret:
+	mutex_unlock(&buf->use_lock);
+	return ret;
+}
+EXPORT_SYMBOL(iio_request_update_kfifo);
+
+void iio_mark_kfifo_in_use(struct iio_ring_buffer *r)
+{
+	struct iio_kfifo *buf = iio_to_kfifo(r);
+	mutex_lock(&buf->use_lock);
+	buf->use_count++;
+	mutex_unlock(&buf->use_lock);
+}
+EXPORT_SYMBOL(iio_mark_kfifo_in_use);
+
+void iio_unmark_kfifo_in_use(struct iio_ring_buffer *r)
+{
+	struct iio_kfifo *buf = iio_to_kfifo(r);
+	mutex_lock(&buf->use_lock);
+	buf->use_count--;
+	mutex_unlock(&buf->use_lock);
+}
+EXPORT_SYMBOL(iio_unmark_kfifo_in_use);
+
+int iio_get_length_kfifo(struct iio_ring_buffer *r)
+{
+	return r->length;
+}
+EXPORT_SYMBOL(iio_get_length_kfifo);
+
+static inline void __iio_init_kfifo(struct iio_kfifo *kf)
+{
+	mutex_init(&kf->use_lock);
+}
+
+static IIO_RING_ENABLE_ATTR;
+static IIO_RING_BPS_ATTR;
+static IIO_RING_LENGTH_ATTR;
+
+static struct attribute *iio_kfifo_attributes[] = {
+	&dev_attr_length.attr,
+	&dev_attr_bps.attr,
+	&dev_attr_ring_enable.attr,
+	NULL,
+};
+
+static struct attribute_group iio_kfifo_attribute_group = {
+	.attrs = iio_kfifo_attributes,
+};
+
+static const struct attribute_group *iio_kfifo_attribute_groups[] = {
+	&iio_kfifo_attribute_group,
+	NULL
+};
+
+static void iio_kfifo_release(struct device *dev)
+{
+	struct iio_ring_buffer *r = to_iio_ring_buffer(dev);
+	struct iio_kfifo *kf = iio_to_kfifo(r);
+	kfifo_free(&kf->kf);
+	kfree(kf);
+}
+
+static struct device_type iio_kfifo_type = {
+	.release = iio_kfifo_release,
+	.groups = iio_kfifo_attribute_groups,
+};
+
+struct iio_ring_buffer *iio_kfifo_allocate(struct iio_dev *indio_dev)
+{
+	struct iio_kfifo *kf;
+
+	kf = kzalloc(sizeof *kf, GFP_KERNEL);
+	if (!kf)
+		return 0;
+	iio_ring_buffer_init(&kf->ring, indio_dev);
+	__iio_init_kfifo(kf);
+	kf->ring.dev.type = &iio_kfifo_type;
+	device_initialize(&kf->ring.dev);
+	kf->ring.dev.parent = &indio_dev->dev;
+	kf->ring.dev.bus = &iio_bus_type;
+	dev_set_drvdata(&kf->ring.dev, (void *)&(kf->ring));
+
+	return &kf->ring;	
+}
+EXPORT_SYMBOL(iio_kfifo_allocate);
+
+int iio_get_bpd_kfifo(struct iio_ring_buffer *r)
+{
+	return r->bpd;
+}
+EXPORT_SYMBOL(iio_get_bpd_kfifo);
+
+
+int iio_set_bpd_kfifo(struct iio_ring_buffer *r, size_t bpd)
+{
+	if (r->bpd != bpd) {
+		r->bpd = bpd;
+		if (r->access.mark_param_change)
+			r->access.mark_param_change(r);
+	}
+	return 0;
+}
+EXPORT_SYMBOL(iio_set_bpd_kfifo);
+
+int iio_mark_update_needed_kfifo(struct iio_ring_buffer *r)
+{
+	struct iio_kfifo *kf = iio_to_kfifo(r);
+	kf->update_needed = true;
+	return 0;
+}
+EXPORT_SYMBOL(iio_mark_update_needed_kfifo);
+
+int iio_set_length_kfifo(struct iio_ring_buffer *r, int length)
+{
+	if (r->length != length) {
+		r->length = length;
+		if (r->access.mark_param_change)
+			r->access.mark_param_change(r);
+	}
+	return 0;
+}
+EXPORT_SYMBOL(iio_set_length_kfifo);
+
+void iio_kfifo_free(struct iio_ring_buffer *r)
+{
+	if (r)
+		iio_put_ring_buffer(r);
+}
+EXPORT_SYMBOL(iio_kfifo_free);
+
+int iio_store_to_kfifo(struct iio_ring_buffer *r, u8 *data, s64 timestamp)
+{
+	int ret;
+	struct iio_kfifo *kf = iio_to_kfifo(r);
+	u8 *datal = kmalloc(r->bpd, GFP_KERNEL);
+	memcpy(datal, data, r->bpd - sizeof(timestamp));
+	memcpy(datal + r->bpd - sizeof(timestamp), &timestamp, sizeof(timestamp));
+	ret = kfifo_in(&kf->kf, data, r->bpd);
+	if (ret != r->bpd) {
+		kfree(datal);
+		return -EBUSY; //wrong error
+	}
+	kfree(datal);
+	return 0;
+}
+EXPORT_SYMBOL(iio_store_to_kfifo);
+
+int iio_rip_kfifo(struct iio_ring_buffer *r,
+		size_t count, u8 **data, int *deadoffset)
+{
+	int ret, copied;	
+	struct iio_kfifo *kf = iio_to_kfifo(r);
+
+	*deadoffset = 0;
+	ret = kfifo_to_user(&kf->kf, *data, r->bpd, &copied);
+
+	return copied;
+}
+EXPORT_SYMBOL(iio_rip_kfifo);
+MODULE_LICENSE("GPL");
diff --git a/drivers/staging/iio/kfifo_buf.h b/drivers/staging/iio/kfifo_buf.h
new file mode 100644
index 0000000..3d421ff
--- /dev/null
+++ b/drivers/staging/iio/kfifo_buf.h
@@ -0,0 +1,56 @@
+
+#include <linux/kfifo.h>
+#include "iio.h"
+#include "ring_generic.h"
+
+struct iio_kfifo {
+	struct iio_ring_buffer ring;
+	struct kfifo_rec_ptr_1 kf;
+	int			use_count;
+	int			update_needed;
+	struct mutex use_lock;
+};
+
+int iio_create_kfifo(struct iio_ring_buffer **r);
+int iio_init_kfifo(struct iio_ring_buffer *r, struct iio_dev *indio_dev);
+void iio_exit_kfifo(struct iio_ring_buffer *r);
+void iio_free_kfifo(struct iio_ring_buffer *r);
+void iio_mark_kfifo_in_use(struct iio_ring_buffer *r);
+void iio_unmark_kfifo_in_use(struct iio_ring_buffer *r);
+
+int iio_store_to_kfifo(struct iio_ring_buffer *r, u8 *data, s64 timestamp);
+int iio_rip_kfifo(struct iio_ring_buffer *r,
+		size_t count,
+		u8 **data,
+		int *dead_offset);
+
+int iio_request_update_kfifo(struct iio_ring_buffer *r);
+int iio_mark_update_needed_kfifo(struct iio_ring_buffer *r);
+
+int iio_get_bpd_kfifo(struct iio_ring_buffer *r);
+int iio_set_bpd_kfifo(struct iio_ring_buffer *r, size_t bpd);
+
+int iio_get_length_kfifo(struct iio_ring_buffer *r);
+int iio_set_length_kfifo(struct iio_ring_buffer *r, int length);
+
+static inline void iio_kfifo_register_funcs(struct iio_ring_access_funcs *ra)
+{
+	ra->mark_in_use = &iio_mark_kfifo_in_use;
+	ra->unmark_in_use = &iio_unmark_kfifo_in_use;
+
+	ra->store_to = &iio_store_to_kfifo;
+	ra->rip_lots = &iio_rip_kfifo;
+
+	ra->mark_param_change = &iio_mark_update_needed_kfifo;
+	ra->request_update = &iio_request_update_kfifo;
+
+	ra->get_bpd = &iio_get_bpd_kfifo;
+	ra->set_bpd = &iio_set_bpd_kfifo;
+	ra->get_length = &iio_get_length_kfifo;
+	ra->set_length = &iio_set_length_kfifo;
+};
+
+#define iio_to_kfifo(r) container_of(r, struct iio_kfifo, ring)
+
+struct iio_ring_buffer *iio_kfifo_allocate(struct iio_dev *indio_dev);
+void iio_kfifo_free(struct iio_ring_buffer *r);
-- 
1.7.0.4
