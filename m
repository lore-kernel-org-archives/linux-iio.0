Return-Path: <jic23@cam.ac.uk>
From: Jonathan Cameron <jic23@cam.ac.uk>
To: greg@kroah.com
Cc: linux-iio@vger.kernel.org,
	Jonathan Cameron <jic23@cam.ac.uk>
Subject: [PATCH 3/3] staging:iio:dummy Add buffered reading support
Date: Fri, 14 Oct 2011 16:34:15 +0100
Message-Id: <1318606455-3471-4-git-send-email-jic23@cam.ac.uk>
In-Reply-To: <1318606455-3471-1-git-send-email-jic23@cam.ac.uk>
References: <1318606455-3471-1-git-send-email-jic23@cam.ac.uk>
List-ID: <linux-iio@vger.kernel.org>

Very simple buffered reading.  Did not provide a trigger as
the sysfs trigger already meets that requirement.

Signed-off-by: Jonathan Cameron <jic23@cam.ac.uk>
---
 drivers/staging/iio/Kconfig                   |    5 +
 drivers/staging/iio/Makefile                  |    1 +
 drivers/staging/iio/iio_simple_dummy.c        |   73 ++++++++-
 drivers/staging/iio/iio_simple_dummy.h        |   27 ++++
 drivers/staging/iio/iio_simple_dummy_buffer.c |  206 +++++++++++++++++++++++++
 5 files changed, 303 insertions(+), 9 deletions(-)

diff --git a/drivers/staging/iio/Kconfig b/drivers/staging/iio/Kconfig
index 75128a0..09cf580 100644
--- a/drivers/staging/iio/Kconfig
+++ b/drivers/staging/iio/Kconfig
@@ -89,6 +89,11 @@ config IIO_SIMPLE_DUMMY_EVENTS
        help
          Add some dummy events to the simple dummy driver.
 
+config IIO_SIMPLE_DUMMY_BUFFER
+       boolean "Buffered capture support"
+       depends on IIO_KFIFO_BUF
+       help
+         Add buffered data capture to the simple dummy driver.
 
 endif # IIO_SIMPLE_DUMMY
 
diff --git a/drivers/staging/iio/Makefile b/drivers/staging/iio/Makefile
index 75aacfd..eaa07b0 100644
--- a/drivers/staging/iio/Makefile
+++ b/drivers/staging/iio/Makefile
@@ -13,6 +13,7 @@ obj-$(CONFIG_IIO_KFIFO_BUF) += kfifo_buf.o
 obj-$(CONFIG_IIO_SIMPLE_DUMMY) += iio_dummy.o
 iio_dummy-y := iio_simple_dummy.o
 iio_dummy-$(CONFIG_IIO_SIMPLE_DUMMY_EVENTS) += iio_simple_dummy_events.o
+iio_dummy-$(CONFIG_IIO_SIMPLE_DUMMY_BUFFER) += iio_simple_dummy_buffer.o
 
 obj-$(CONFIG_IIO_DUMMY_EVGEN) += iio_dummy_evgen.o
 
diff --git a/drivers/staging/iio/iio_simple_dummy.c b/drivers/staging/iio/iio_simple_dummy.c
index c5119a0..af0c992 100644
--- a/drivers/staging/iio/iio_simple_dummy.c
+++ b/drivers/staging/iio/iio_simple_dummy.c
@@ -21,6 +21,7 @@
 
 #include "iio.h"
 #include "sysfs.h"
+#include "buffer_generic.h"
 #include "iio_simple_dummy.h"
 
 /*
@@ -82,7 +83,14 @@ static struct iio_chan_spec iio_dummy_channels[] = {
 		 * when converting to standard units (microvolts)
 		 */
 		(1 << IIO_CHAN_INFO_SCALE_SEPARATE),
-
+		/* The ordering of elements in the buffer via an enum */
+		.scan_index = voltage0,
+		.scan_type = { /* Description of storage in buffer */
+			.sign = 'u', /* unsigned */
+			.realbits = 13, /* 13 bits */
+			.storagebits = 16, /* 16 bits used for storage */
+			.shift = 0, /* zero shift */
+		},
 #ifdef CONFIG_IIO_SIMPLE_DUMMY_EVENTS
 		/*
 		 * simple event - triggered when value rises above
@@ -110,6 +118,13 @@ static struct iio_chan_spec iio_dummy_channels[] = {
 		 * input channels of type IIO_VOLTAGE.
 		 */
 		(1 << IIO_CHAN_INFO_SCALE_SHARED),
+		.scan_index = diffvoltage1m2,
+		.scan_type = { /* Description of storage in buffer */
+			.sign = 's', /* signed */
+			.realbits = 12, /* 12 bits */
+			.storagebits = 16, /* 16 bits used for storage */
+			.shift = 0, /* zero shift */
+		},
 	},
 	/* Differential ADC channel in_voltage3-voltage4_raw etc*/
 	{
@@ -120,13 +135,13 @@ static struct iio_chan_spec iio_dummy_channels[] = {
 		.channel2 = 4,
 		.info_mask =
 		(1 << IIO_CHAN_INFO_SCALE_SHARED),
-	},
-	/* DAC channel out_voltage0_raw */
-	{
-		.type = IIO_VOLTAGE,
-		.output = 1,
-		.indexed = 1,
-		.channel = 0,
+		.scan_index = diffvoltage3m4,
+		.scan_type = {
+			.sign = 's',
+			.realbits = 11,
+			.storagebits = 16,
+			.shift = 0,
+		},
 	},
 	/*
 	 * 'modified' (i.e. axis specified) acceleration channel
@@ -145,6 +160,25 @@ static struct iio_chan_spec iio_dummy_channels[] = {
 		 * calibration.
 		 */
 		(1 << IIO_CHAN_INFO_CALIBBIAS_SEPARATE),
+		.scan_index = accelx,
+		.scan_type = { /* Description of storage in buffer */
+			.sign = 's', /* signed */
+			.realbits = 16, /* 12 bits */
+			.storagebits = 16, /* 16 bits used for storage */
+			.shift = 0, /* zero shift */
+		},
+	},
+	/*
+	 * Convenience macro for timestamps. 4 is the index in
+	 * the buffer.
+	 */
+	IIO_CHAN_SOFT_TIMESTAMP(4),
+	/* DAC channel out_voltage0_raw */
+	{
+		.type = IIO_VOLTAGE,
+		.output = 1,
+		.indexed = 1,
+		.channel = 0,
 	},
 };
 
@@ -391,11 +425,29 @@ static int __devinit iio_dummy_probe(int index)
 	ret = iio_simple_dummy_events_register(indio_dev);
 	if (ret < 0)
 		goto error_free_device;
-	ret = iio_device_register(indio_dev);
+
+	/* Configure buffered capture support. */
+	ret = iio_simple_dummy_configure_buffer(indio_dev);
 	if (ret < 0)
 		goto error_unregister_events;
 
+	/*
+	 * Register the channels with the buffer, but avoid the output
+	 * channel being registered by reducing the number of channels by 1.
+	 */
+	ret = iio_buffer_register(indio_dev, iio_dummy_channels, 5);
+	if (ret < 0)
+		goto error_unconfigure_buffer;
+
+	ret = iio_device_register(indio_dev);
+	if (ret < 0)
+		goto error_unregister_buffer;
+
 	return 0;
+error_unregister_buffer:
+	iio_buffer_unregister(indio_dev);
+error_unconfigure_buffer:
+	iio_simple_dummy_unconfigure_buffer(indio_dev);
 error_unregister_events:
 	iio_simple_dummy_events_unregister(indio_dev);
 error_free_device:
@@ -429,6 +481,9 @@ static int iio_dummy_remove(int index)
 
 	/* Device specific code to power down etc */
 
+	/* Buffered capture related cleanup */
+	iio_buffer_unregister(indio_dev);
+	iio_simple_dummy_unconfigure_buffer(indio_dev);
 
 	ret = iio_simple_dummy_events_unregister(indio_dev);
 	if (ret)
diff --git a/drivers/staging/iio/iio_simple_dummy.h b/drivers/staging/iio/iio_simple_dummy.h
index 998fd1f..53975d9 100644
--- a/drivers/staging/iio/iio_simple_dummy.h
+++ b/drivers/staging/iio/iio_simple_dummy.h
@@ -78,4 +78,31 @@ iio_simple_dummy_events_unregister(struct iio_dev *indio_dev)
 
 #endif /* CONFIG_IIO_SIMPLE_DUMMY_EVENTS*/
 
+/**
+ * enum iio_simple_dummy_scan_elements - scan index enum
+ * @voltage0:		the single ended voltage channel
+ * @diffvoltage1m2:	first differential channel
+ * @diffvoltage3m4:	second differenial channel
+ * @accelx:		acceleration channel
+ *
+ * Enum provides convenient numbering for the scan index.
+ */
+enum iio_simple_dummy_scan_elements {
+	voltage0,
+	diffvoltage1m2,
+	diffvoltage3m4,
+	accelx,
+};
 
+#ifdef CONFIG_IIO_SIMPLE_DUMMY_BUFFER
+int iio_simple_dummy_configure_buffer(struct iio_dev *indio_dev);
+void iio_simple_dummy_unconfigure_buffer(struct iio_dev *indio_dev);
+#else
+static inline int iio_simple_dummy_configure_buffer(struct iio_dev *indio_dev)
+{
+	return 0;
+};
+static inline
+void iio_simple_dummy_unconfigure_buffer(struct iio_dev *indio_dev)
+{};
+#endif /* CONFIG_IIO_SIMPLE_DUMMY_BUFFER */
diff --git a/drivers/staging/iio/iio_simple_dummy_buffer.c b/drivers/staging/iio/iio_simple_dummy_buffer.c
new file mode 100644
index 0000000..f0b36d2
--- /dev/null
+++ b/drivers/staging/iio/iio_simple_dummy_buffer.c
@@ -0,0 +1,206 @@
+/**
+ * Copyright (c) 2011 Jonathan Cameron
+ *
+ * This program is free software; you can redistribute it and/or modify it
+ * under the terms of the GNU General Public License version 2 as published by
+ * the Free Software Foundation.
+ *
+ * Buffer handling elements of industrial I/O reference driver.
+ * Uses the kfifo buffer.
+ *
+ * To test without hardware use the sysfs trigger.
+ */
+
+#include <linux/kernel.h>
+#include <linux/slab.h>
+#include <linux/interrupt.h>
+#include <linux/irq.h>
+#include <linux/bitmap.h>
+
+#include "iio.h"
+#include "trigger_consumer.h"
+#include "kfifo_buf.h"
+
+#include "iio_simple_dummy.h"
+
+/* Some fake data */
+
+static const s16 fakedata[] = {
+	[voltage0] = 7,
+	[diffvoltage1m2] = -33,
+	[diffvoltage3m4] = -2,
+	[accelx] = 344,
+};
+/**
+ * iio_simple_dummy_trigger_h() - the trigger handler function
+ * @irq: the interrupt number
+ * @p: private data - always a pointer to the poll func.
+ *
+ * This is the guts of buffered capture. On a trigger event occuring,
+ * if the pollfunc is attached then this handler is called as a threaded
+ * interrupt (and hence may sleep). It is responsible for grabbing data
+ * from the device and pushing it into the associated buffer.
+ */
+static irqreturn_t iio_simple_dummy_trigger_h(int irq, void *p)
+{
+	struct iio_poll_func *pf = p;
+	struct iio_dev *indio_dev = pf->indio_dev;
+	struct iio_buffer *buffer = indio_dev->buffer;
+	int len = 0;
+	/*
+	 * The datasize is obtained from the buffer. It was stored when
+	 * the preenable setup function was called.
+	 */
+	size_t datasize = buffer->access->get_bytes_per_datum(buffer);
+	u16 *data = kmalloc(datasize, GFP_KERNEL);
+	if (data == NULL)
+		return -ENOMEM;
+
+	if (buffer->scan_count) {
+		/*
+		 * Three common options here:
+		 * hardware scans: certain combinations of channels make
+		 *   up a fast read.  The capture will consist of all of them.
+		 *   Hence we just call the grab data function and fill the
+		 *   buffer without processing.
+		 * sofware scans: can be considered to be random access
+		 *   so efficient reading is just a case of minimal bus
+		 *   transactions.
+		 * software culled hardware scans:
+		 *   occasionally a driver may process the nearest hardware
+		 *   scan to avoid storing elements that are not desired. This
+		 *   is the fidliest option by far.
+		 * Here lets pretend we have random access. And the values are
+		 * in the constant table fakedata.
+		 */
+		int i, j;
+		for (i = 0, j = 0; i < buffer->scan_count; i++) {
+			j = find_next_bit(buffer->scan_mask,
+					  indio_dev->masklength, j + 1);
+			/* random access read form the 'device' */
+			data[i] = fakedata[j];
+			len += 2;
+		}
+	}
+	/* Store a timestampe at an 8 byte boundary */
+	if (buffer->scan_timestamp)
+		*(s64 *)(((phys_addr_t)data + len
+				+ sizeof(s64) - 1) & ~(sizeof(s64) - 1))
+			= iio_get_time_ns();
+	buffer->access->store_to(buffer, (u8 *)data, pf->timestamp);
+
+	kfree(data);
+
+	/*
+	 * Tell the core we are done with this trigger and ready for the
+	 * next one.
+	 */
+	iio_trigger_notify_done(indio_dev->trig);
+
+	return IRQ_HANDLED;
+}
+
+static const struct iio_buffer_setup_ops iio_simple_dummy_buffer_setup_ops = {
+	/*
+	 * iio_sw_buffer_preenable:
+	 * Generic function for equal sized ring elements + 64 bit timestamp
+	 * Assumes that any combination of channels can be enabled.
+	 * Typically replaced to implement restrictions on what combinations
+	 * can be captured (hardware scan modes).
+	 */
+	.preenable = &iio_sw_buffer_preenable,
+	/*
+	 * iio_triggered_buffer_postenable:
+	 * Generic function that simply attaches the pollfunc to the trigger.
+	 * Replace this to mess with hardware state before we attach the
+	 * trigger.
+	 */
+	.postenable = &iio_triggered_buffer_postenable,
+	/*
+	 * iio_triggered_buffer_predisable:
+	 * Generic function that simple detaches the pollfunc from the trigger.
+	 * Replace this to put hardware state back again after the trigger is
+	 * detached but before userspace knows we have disabled the ring.
+	 */
+	.predisable = &iio_triggered_buffer_predisable,
+};
+
+int iio_simple_dummy_configure_buffer(struct iio_dev *indio_dev)
+{
+	int ret;
+	struct iio_buffer *buffer;
+
+	/* Allocate a buffer to use - here a kfifo */
+	buffer = iio_kfifo_allocate(indio_dev);
+	if (buffer == NULL) {
+		ret = -ENOMEM;
+		goto error_ret;
+	}
+
+	indio_dev->buffer = buffer;
+	/* Tell the core how to access the buffer */
+	buffer->access = &kfifo_access_funcs;
+
+	/* Number of bytes per element */
+	buffer->bpe = 2;
+	/* Enable timestamps by default */
+	buffer->scan_timestamp = true;
+
+	/*
+	 * Tell the core what device type specific functions should
+	 * be run on either side of buffer capture enable / disable.
+	 */
+	buffer->setup_ops = &iio_simple_dummy_buffer_setup_ops;
+	buffer->owner = THIS_MODULE;
+
+	/*
+	 * Configure a polling function.
+	 * When a trigger event with this polling function connected
+	 * occurs, this function is run. Typically this grabs data
+	 * from the device.
+	 *
+	 * NULL for the top half. This is normally implemented only if we
+	 * either want to ping a capture now pin (no sleeping) or grab
+	 * a timestamp as close as possible to a data ready trigger firing.
+	 *
+	 * IRQF_ONESHOT ensures irqs are masked such that only one instance
+	 * of the handler can run at a time.
+	 *
+	 * "iio_simple_dummy_consumer%d" formatting string for the irq 'name'
+	 * as seen under /proc/interrupts. Remaining parameters as per printk.
+	 */
+	indio_dev->pollfunc = iio_alloc_pollfunc(NULL,
+						 &iio_simple_dummy_trigger_h,
+						 IRQF_ONESHOT,
+						 indio_dev,
+						 "iio_simple_dummy_consumer%d",
+						 indio_dev->id);
+
+	if (indio_dev->pollfunc == NULL) {
+		ret = -ENOMEM;
+		goto error_free_buffer;
+	}
+
+	/*
+	 * Notify the core that this device is capable of buffered capture
+	 * driven by a trigger.
+	 */
+	indio_dev->modes |= INDIO_BUFFER_TRIGGERED;
+	return 0;
+
+error_free_buffer:
+	iio_kfifo_free(indio_dev->buffer);
+error_ret:
+	return ret;
+
+}
+
+/**
+ * iio_simple_dummy_unconfigure_buffer() - release buffer resources
+ * @indo_dev: device instance state
+ */
+void iio_simple_dummy_unconfigure_buffer(struct iio_dev *indio_dev)
+{
+	iio_dealloc_pollfunc(indio_dev->pollfunc);
+	iio_kfifo_free(indio_dev->buffer);
+}
-- 
1.7.7
