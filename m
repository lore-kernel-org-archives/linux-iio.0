Return-Path: <jic23@cam.ac.uk>
From: Jonathan Cameron <jic23@cam.ac.uk>
To: linux-iio@vger.kernel.org
Cc: Michael.Hennerich@analog.com,
	Jonathan Cameron <jic23@cam.ac.uk>
Subject: [PATCH 2/5] staging:iio:kfifo buffer implementation
Date: Sun, 19 Dec 2010 20:33:42 +0000
Message-Id: <1292790825-19156-3-git-send-email-jic23@cam.ac.uk>
In-Reply-To: <1292790825-19156-1-git-send-email-jic23@cam.ac.uk>
References: <1292790825-19156-1-git-send-email-jic23@cam.ac.uk>
List-ID: <linux-iio@vger.kernel.org>

A very simple use of a kfifo as an alternative for the ring_sw

Signed-off-by: Jonathan Cameron <jic23@cam.ac.uk>
---
 drivers/staging/iio/Kconfig     |    6 +
 drivers/staging/iio/Makefile    |    1 +
 drivers/staging/iio/kfifo_buf.c |  196 +++++++++++++++++++++++++++++++++++++++
 drivers/staging/iio/kfifo_buf.h |   56 +++++++++++
 4 files changed, 259 insertions(+), 0 deletions(-)

diff --git a/drivers/staging/iio/Kconfig b/drivers/staging/iio/Kconfig
index e2ac07d..f664a44 100644
--- a/drivers/staging/iio/Kconfig
+++ b/drivers/staging/iio/Kconfig
@@ -29,6 +29,12 @@ config IIO_SW_RING
 	  with the intention that some devices would be able to write
 	  in interrupt context.
 
+config IIO_KFIFO_BUF
+       select IIO_TRIGGER
+       tristate "Industrial I/O buffering based on kfifo"
+       help
+         Initial version of a kfifo buffer.       
+
 endif # IIO_RINGBUFFER
 
 config IIO_TRIGGER
diff --git a/drivers/staging/iio/Makefile b/drivers/staging/iio/Makefile
index f9b5fb2..bb5c95c 100644
--- a/drivers/staging/iio/Makefile
+++ b/drivers/staging/iio/Makefile
@@ -8,6 +8,7 @@ industrialio-$(CONFIG_IIO_RING_BUFFER) += industrialio-ring.o
 industrialio-$(CONFIG_IIO_TRIGGER) += industrialio-trigger.o
 
 obj-$(CONFIG_IIO_SW_RING) += ring_sw.o
+obj-$(CONFIG_IIO_KFIFO_BUF) += kfifo_buf.o
 
 obj-y += accel/
 obj-y += adc/
diff --git a/drivers/staging/iio/kfifo_buf.c b/drivers/staging/iio/kfifo_buf.c
new file mode 100644
index 0000000..811b39d
--- /dev/null
+++ b/drivers/staging/iio/kfifo_buf.c
@@ -0,0 +1,196 @@
+#include <linux/slab.h>
+#include <linux/kernel.h>
+#include <linux/module.h>
+#include <linux/device.h>
+#include <linux/workqueue.h>
+#include <linux/kfifo.h>
+#include <linux/mutex.h>
+
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
+	ret = __iio_allocate_kfifo(buf, buf->ring.bytes_per_datum,
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
+static IIO_RING_BYTES_PER_DATUM_ATTR;
+static IIO_RING_LENGTH_ATTR;
+
+static struct attribute *iio_kfifo_attributes[] = {
+	&dev_attr_length.attr,
+	&dev_attr_bytes_per_datum.attr,
+	&dev_attr_enable.attr,
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
+int iio_get_bytes_per_datum_kfifo(struct iio_ring_buffer *r)
+{
+	return r->bytes_per_datum;
+}
+EXPORT_SYMBOL(iio_get_bytes_per_datum_kfifo);
+
+int iio_set_bytes_per_datum_kfifo(struct iio_ring_buffer *r, size_t bpd)
+{
+	if (r->bytes_per_datum != bpd) {
+		r->bytes_per_datum = bpd;
+		if (r->access.mark_param_change)
+			r->access.mark_param_change(r);
+	}
+	return 0;
+}
+EXPORT_SYMBOL(iio_set_bytes_per_datum_kfifo);
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
+	u8 *datal = kmalloc(r->bytes_per_datum, GFP_KERNEL);
+	memcpy(datal, data, r->bytes_per_datum - sizeof(timestamp));
+	memcpy(datal + r->bytes_per_datum - sizeof(timestamp),
+		&timestamp, sizeof(timestamp));
+	ret = kfifo_in(&kf->kf, data, r->bytes_per_datum);
+	if (ret != r->bytes_per_datum) {
+		kfree(datal);
+		return -EBUSY;
+	}
+	kfree(datal);
+	return 0;
+}
+EXPORT_SYMBOL(iio_store_to_kfifo);
+
+int iio_rip_kfifo(struct iio_ring_buffer *r,
+		size_t count, char __user *buf, int *deadoffset)
+{
+	int ret, copied;
+	struct iio_kfifo *kf = iio_to_kfifo(r);
+
+	*deadoffset = 0;
+	ret = kfifo_to_user(&kf->kf, buf, r->bytes_per_datum*count, &copied);
+
+	return copied;
+}
+EXPORT_SYMBOL(iio_rip_kfifo);
+MODULE_LICENSE("GPL");
diff --git a/drivers/staging/iio/kfifo_buf.h b/drivers/staging/iio/kfifo_buf.h
new file mode 100644
index 0000000..8064383
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
+	struct kfifo kf;
+	int use_count;
+	int update_needed;
+	struct mutex use_lock;
+};
+
+#define iio_to_kfifo(r) container_of(r, struct iio_kfifo, ring)
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
+		char __user *buf,
+		int *dead_offset);
+
+int iio_request_update_kfifo(struct iio_ring_buffer *r);
+int iio_mark_update_needed_kfifo(struct iio_ring_buffer *r);
+
+int iio_get_bytes_per_datum_kfifo(struct iio_ring_buffer *r);
+int iio_set_bytes_per_datum_kfifo(struct iio_ring_buffer *r, size_t bpd);
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
+	ra->get_bytes_per_datum = &iio_get_bytes_per_datum_kfifo;
+	ra->set_bytes_per_datum = &iio_set_bytes_per_datum_kfifo;
+	ra->get_length = &iio_get_length_kfifo;
+	ra->set_length = &iio_set_length_kfifo;
+};
+
+struct iio_ring_buffer *iio_kfifo_allocate(struct iio_dev *indio_dev);
+void iio_kfifo_free(struct iio_ring_buffer *r);
+
-- 
1.7.0.4
