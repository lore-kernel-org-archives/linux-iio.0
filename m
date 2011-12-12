Return-Path: <lars@metafoo.de>
From: Lars-Peter Clausen <lars@metafoo.de>
To: Jonathan Cameron <jic23@cam.ac.uk>
CC: Michael Hennerich <michael.hennerich@analog.com>,
	<linux-iio@vger.kernel.org>, <device-drivers-devel@blackfin.uclinux.org>,
	<drivers@analog.com>, Lars-Peter Clausen <lars@metafoo.de>
Subject: [PATCH v2 01/13] staging:iio:ring_sw: Add helper function for initializing simple setups
Date: Mon, 12 Dec 2011 11:42:53 +0100
Message-ID: <1323686585-15181-1-git-send-email-lars@metafoo.de>
MIME-Version: 1.0
Content-Type: text/plain
List-ID: <linux-iio@vger.kernel.org>

Add a helper function for executing the common tasks which are usually involved
in setting up a simple software ringbuffer. It will allocate the buffer,
allocate the pollfunc and register the buffer.

Signed-off-by: Lars-Peter Clausen <lars@metafoo.de>

---
Changes since v1:
	Added an optional setup_ops parameter to iio_sw_rb_simple_setup which allows
	a driver to provide it's own setup_ops which is sometimes necessary if for
	example the device needs to enter a special mode before the conversions
	starts and should leave after the conversions are done. This change allows
	to convert some more drivers. Infact now almost all users of the ring_sw
	buffer use this helper function.
---
 drivers/staging/iio/ring_sw.c |   88 +++++++++++++++++++++++++++++++++++++++++
 drivers/staging/iio/ring_sw.h |    9 ++++
 2 files changed, 97 insertions(+), 0 deletions(-)

diff --git a/drivers/staging/iio/ring_sw.c b/drivers/staging/iio/ring_sw.c
index 98b66a0..9b57ced 100644
--- a/drivers/staging/iio/ring_sw.c
+++ b/drivers/staging/iio/ring_sw.c
@@ -16,6 +16,7 @@
 #include <linux/poll.h>
 #include "ring_sw.h"
 #include "trigger.h"
+#include "trigger_consumer.h"
 
 /**
  * struct iio_sw_ring_buffer - software ring buffer
@@ -402,5 +403,92 @@ const struct iio_buffer_access_funcs ring_sw_access_funcs = {
 };
 EXPORT_SYMBOL(ring_sw_access_funcs);
 
+static const struct iio_buffer_setup_ops iio_sw_rb_simple_setup_ops = {
+	.preenable = &iio_sw_buffer_preenable,
+	.postenable = &iio_triggered_buffer_postenable,
+	.predisable = &iio_triggered_buffer_predisable,
+};
+
+/**
+ * iio_sw_rb_simple_setup() - Setup simple software ringbuffer and pollfunc
+ * @indio_dev:		IIO device structure
+ * @pollfunc_bh:	Function which will be used as pollfunc bottom half
+ * @pollfunc_th:	Function which will be used as pollfunc top half
+ * @setup_ops:		Buffer setup functions to use for this device.
+ *			If NULL the default setup functions for triggered
+ *			buffers will be used.
+ *
+ * This function combines some common tasks which will normally be performed
+ * when setting up a simple software ringbuffer. It will allocate the ringbuffer
+ * and the pollfunc, as well as register the buffer with IIO core.
+ * Before calling this function the indio_dev structure should already be
+ * completly initzialized but not yet registered.
+ *
+ * To free the resources allocated by this function iio_sw_rb_simple_cleanup
+ * should be called.
+ */
+int iio_sw_rb_simple_setup(struct iio_dev *indio_dev,
+	irqreturn_t (*pollfunc_bh)(int irq, void *p),
+	irqreturn_t (*pollfunc_th)(int irq, void *p),
+	const struct iio_buffer_setup_ops *setup_ops)
+{
+	int ret;
+
+	indio_dev->buffer = iio_sw_rb_allocate(indio_dev);
+	if (!indio_dev->buffer) {
+		ret = -ENOMEM;
+		goto error_ret;
+	}
+
+	indio_dev->pollfunc = iio_alloc_pollfunc(pollfunc_bh,
+						 pollfunc_th,
+						 IRQF_ONESHOT,
+						 indio_dev,
+						 "%s_consumer%d",
+						 indio_dev->name,
+						 indio_dev->id);
+	if (indio_dev->pollfunc == NULL) {
+		ret = -ENOMEM;
+		goto error_deallocate_sw_rb;
+	}
+
+	/* Ring buffer functions - here trigger setup related */
+	if (setup_ops)
+		indio_dev->setup_ops = setup_ops;
+	else
+		indio_dev->setup_ops = &iio_sw_rb_simple_setup_ops;
+
+	/* Flag that polled ring buffering is possible */
+	indio_dev->modes |= INDIO_BUFFER_TRIGGERED;
+
+	ret = iio_buffer_register(indio_dev,
+				  indio_dev->channels,
+				  indio_dev->num_channels);
+	if (ret)
+		goto error_dealloc_pollfunc;
+
+	return 0;
+
+error_dealloc_pollfunc:
+	iio_dealloc_pollfunc(indio_dev->pollfunc);
+error_deallocate_sw_rb:
+	iio_sw_rb_free(indio_dev->buffer);
+error_ret:
+	return ret;
+}
+EXPORT_SYMBOL(iio_sw_rb_simple_setup);
+
+/**
+ * iio_sw_rb_simple_cleanup() - Free resources allocated by iio_sw_rb_simple_setup
+ * @indio_dev:		IIO device structure
+ */
+void iio_sw_rb_simple_cleanup(struct iio_dev *indio_dev)
+{
+	iio_buffer_unregister(indio_dev);
+	iio_dealloc_pollfunc(indio_dev->pollfunc);
+	iio_sw_rb_free(indio_dev->buffer);
+}
+EXPORT_SYMBOL(iio_sw_rb_simple_cleanup);
+
 MODULE_DESCRIPTION("Industrialio I/O software ring buffer");
 MODULE_LICENSE("GPL");
diff --git a/drivers/staging/iio/ring_sw.h b/drivers/staging/iio/ring_sw.h
index e6a6e2c..3a61fe3 100644
--- a/drivers/staging/iio/ring_sw.h
+++ b/drivers/staging/iio/ring_sw.h
@@ -23,6 +23,8 @@
 
 #ifndef _IIO_RING_SW_H_
 #define _IIO_RING_SW_H_
+
+#include <linux/interrupt.h>
 #include "buffer.h"
 
 /**
@@ -32,4 +34,11 @@ extern const struct iio_buffer_access_funcs ring_sw_access_funcs;
 
 struct iio_buffer *iio_sw_rb_allocate(struct iio_dev *indio_dev);
 void iio_sw_rb_free(struct iio_buffer *ring);
+
+int iio_sw_rb_simple_setup(struct iio_dev *indio_dev,
+	irqreturn_t (*pollfunc_bh)(int irq, void *p),
+	irqreturn_t (*pollfunc_th)(int irq, void *p),
+	const struct iio_buffer_setup_ops *setup_ops);
+void iio_sw_rb_simple_cleanup(struct iio_dev *indio_dev);
+
 #endif /* _IIO_RING_SW_H_ */
-- 
1.7.7.3
