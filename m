Return-Path: <linux-iio-owner@vger.kernel.org>
Received: from smtp-out-134.synserver.de ([212.40.185.134]:1160 "EHLO
	smtp-out-123.synserver.de" rhost-flags-OK-OK-OK-FAIL)
	by vger.kernel.org with ESMTP id S1752595Ab2FFMAS (ORCPT
	<rfc822;linux-iio@vger.kernel.org>); Wed, 6 Jun 2012 08:00:18 -0400
From: Lars-Peter Clausen <lars@metafoo.de>
To: Jonathan Cameron <jic23@cam.ac.uk>
Cc: linux-iio@vger.kernel.org, Lars-Peter Clausen <lars@metafoo.de>
Subject: [PATCH 1/9] staging:iio: Add helper function for initializing triggered buffers
Date: Wed,  6 Jun 2012 13:55:48 +0200
Message-Id: <1338983756-31243-2-git-send-email-lars@metafoo.de>
In-Reply-To: <1338983756-31243-1-git-send-email-lars@metafoo.de>
References: <1338983756-31243-1-git-send-email-lars@metafoo.de>
Sender: linux-iio-owner@vger.kernel.org
List-Id: linux-iio@vger.kernel.org

Add a helper function for executing the common tasks which are usually involved
in setting up a simple triggered buffer. It will allocate the buffer, allocate
the pollfunc and register the buffer.

Signed-off-by: Lars-Peter Clausen <lars@metafoo.de>
---
 drivers/iio/Kconfig                         |    7 ++
 drivers/iio/Makefile                        |    1 +
 drivers/iio/industrialio-triggered-buffer.c |  109 +++++++++++++++++++++++++++
 include/linux/iio/buffer.h                  |    7 ++
 4 files changed, 124 insertions(+)
 create mode 100644 drivers/iio/industrialio-triggered-buffer.c

diff --git a/drivers/iio/Kconfig b/drivers/iio/Kconfig
index 103349f..612073f 100644
--- a/drivers/iio/Kconfig
+++ b/drivers/iio/Kconfig
@@ -30,6 +30,13 @@ config IIO_KFIFO_BUF
 	  no buffer events so it is up to userspace to work out how
 	  often to read from the buffer.
 
+config IIO_TRIGGERED_BUFFER
+	tristate
+	select IIO_TRIGGER
+	select IIO_KFIFO_BUF
+	help
+	  Provides helper functions for setting up triggered buffers.
+
 endif # IIO_BUFFER
 
 config IIO_TRIGGER
diff --git a/drivers/iio/Makefile b/drivers/iio/Makefile
index c38fa2a..34309ab 100644
--- a/drivers/iio/Makefile
+++ b/drivers/iio/Makefile
@@ -7,6 +7,7 @@ industrialio-y := industrialio-core.o industrialio-event.o inkern.o
 industrialio-$(CONFIG_IIO_BUFFER) += industrialio-buffer.o
 industrialio-$(CONFIG_IIO_TRIGGER) += industrialio-trigger.o
 
+obj-$(CONFIG_IIO_TRIGGERED_BUFFER) += industrialio-triggered-buffer.o
 obj-$(CONFIG_IIO_KFIFO_BUF) += kfifo_buf.o
 
 obj-y += adc/
diff --git a/drivers/iio/industrialio-triggered-buffer.c b/drivers/iio/industrialio-triggered-buffer.c
new file mode 100644
index 0000000..653ebe5
--- /dev/null
+++ b/drivers/iio/industrialio-triggered-buffer.c
@@ -0,0 +1,109 @@
+ /*
+ * Copyright (c) 2012 Analog Devices, Inc.
+ *  Author: Lars-Peter Clausen <lars@metafoo.de>
+ *
+ * This program is free software; you can redistribute it and/or modify it
+ * under the terms of the GNU General Public License version 2 as published by
+ * the Free Software Foundation.
+ *
+  */
+
+#include <linux/kernel.h>
+#include <linux/export.h>
+#include <linux/module.h>
+#include <linux/iio/iio.h>
+#include <linux/iio/buffer.h>
+#include <linux/iio/trigger_consumer.h>
+#include <linux/iio/kfifo_buf.h>
+
+static const struct iio_buffer_setup_ops iio_triggered_buffer_setup_ops = {
+	.preenable = &iio_sw_buffer_preenable,
+	.postenable = &iio_triggered_buffer_postenable,
+	.predisable = &iio_triggered_buffer_predisable,
+};
+
+/**
+ * iio_triggered_buffer_setup() - Setup simple software ringbuffer and pollfunc
+ * @indio_dev:		IIO device structure
+ * @pollfunc_bh:	Function which will be used as pollfunc bottom half
+ * @pollfunc_th:	Function which will be used as pollfunc top half
+ * @setup_ops:		Buffer setup functions to use for this device.
+ *			If NULL the default setup functions for triggered
+ *			buffers will be used.
+ *
+ * This function combines some common tasks which will normally be performed
+ * when setting up a triggered buffer. It will allocate the buffer and the
+ * pollfunc, as well as register the buffer with IIO core.
+ *
+ * Before calling this function the indio_dev structure should already be
+ * completly initzialized but not yet registered.
+ *
+ * To free the resources allocated by this function
+ * iio_triggered_buffer_cleanup() should be called.
+ */
+int iio_triggered_buffer_setup(struct iio_dev *indio_dev,
+	irqreturn_t (*pollfunc_bh)(int irq, void *p),
+	irqreturn_t (*pollfunc_th)(int irq, void *p),
+	const struct iio_buffer_setup_ops *setup_ops)
+{
+	int ret;
+
+	indio_dev->buffer = iio_kfifo_allocate(indio_dev);
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
+		indio_dev->setup_ops = &iio_triggered_buffer_setup_ops;
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
+	iio_kfifo_free(indio_dev->buffer);
+error_ret:
+	return ret;
+}
+EXPORT_SYMBOL(iio_triggered_buffer_setup);
+
+/**
+ * iio_triggered_buffer_cleanup() - Free resources allocated by iio_triggered_buffer_setup()
+ * @indio_dev: IIO device structure
+ */
+void iio_triggered_buffer_cleanup(struct iio_dev *indio_dev)
+{
+	iio_buffer_unregister(indio_dev);
+	iio_dealloc_pollfunc(indio_dev->pollfunc);
+	iio_kfifo_free(indio_dev->buffer);
+}
+EXPORT_SYMBOL(iio_triggered_buffer_cleanup);
+
+MODULE_AUTHOR("Lars-Peter Clausen <lars@metafoo.de>");
+MODULE_DESCRIPTION("IIO helper functions for setting up triggered buffers");
+MODULE_LICENSE("GPL");
diff --git a/include/linux/iio/buffer.h b/include/linux/iio/buffer.h
index fb0fe46..1b3d3eb 100644
--- a/include/linux/iio/buffer.h
+++ b/include/linux/iio/buffer.h
@@ -10,6 +10,7 @@
 #ifndef _IIO_BUFFER_GENERIC_H_
 #define _IIO_BUFFER_GENERIC_H_
 #include <linux/sysfs.h>
+#include <linux/interrupt.h>
 #include <linux/iio/iio.h>
 
 #ifdef CONFIG_IIO_BUFFER
@@ -174,6 +175,12 @@ ssize_t iio_buffer_show_enable(struct device *dev,
 
 int iio_sw_buffer_preenable(struct iio_dev *indio_dev);
 
+int iio_triggered_buffer_setup(struct iio_dev *indio_dev,
+	irqreturn_t (*pollfunc_bh)(int irq, void *p),
+	irqreturn_t (*pollfunc_th)(int irq, void *p),
+	const struct iio_buffer_setup_ops *setup_ops);
+void iio_triggered_buffer_cleanup(struct iio_dev *indio_dev);
+
 #else /* CONFIG_IIO_BUFFER */
 
 static inline int iio_buffer_register(struct iio_dev *indio_dev,
-- 
1.7.10

