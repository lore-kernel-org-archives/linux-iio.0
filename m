Return-Path: <linux-iio-owner@vger.kernel.org>
Received: from smtp-out-233.synserver.de ([212.40.185.233]:1173 "EHLO
	smtp-out-233.synserver.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1760604Ab2IGMoK (ORCPT
	<rfc822;linux-iio@vger.kernel.org>); Fri, 7 Sep 2012 08:44:10 -0400
From: Lars-Peter Clausen <lars@metafoo.de>
To: Jonathan Cameron <jic23@cam.ac.uk>
Cc: linux-iio@vger.kernel.org, drivers@analog.com,
	Lars-Peter Clausen <lars@metafoo.de>
Subject: [PATCH 05/10] staging:iio:ad7476: Squash driver into a single file.
Date: Fri,  7 Sep 2012 14:44:27 +0200
Message-Id: <1347021872-7885-5-git-send-email-lars@metafoo.de>
In-Reply-To: <1347021872-7885-1-git-send-email-lars@metafoo.de>
References: <1347021872-7885-1-git-send-email-lars@metafoo.de>
Sender: linux-iio-owner@vger.kernel.org
List-Id: linux-iio@vger.kernel.org

After the recent cleanups the buffer support is just a single 23 line function.
This does not really justify a file on its own, so move it to the main driver
file. And with only one source file left the header file containing the device
state struct becomes superflousious so move the content of the header
file to the main driver source file as well.

Signed-off-by: Lars-Peter Clausen <lars@metafoo.de>
---
 drivers/staging/iio/adc/Makefile                   |    2 -
 .../staging/iio/adc/{ad7476_core.c => ad7476.c}    |   82 +++++++++++++++++++-
 drivers/staging/iio/adc/ad7476.h                   |   56 -------------
 drivers/staging/iio/adc/ad7476_ring.c              |   57 --------------
 4 files changed, 81 insertions(+), 116 deletions(-)
 rename drivers/staging/iio/adc/{ad7476_core.c => ad7476.c} (73%)
 delete mode 100644 drivers/staging/iio/adc/ad7476.h
 delete mode 100644 drivers/staging/iio/adc/ad7476_ring.c

diff --git a/drivers/staging/iio/adc/Makefile b/drivers/staging/iio/adc/Makefile
index ecac9a0..6b60af0 100644
--- a/drivers/staging/iio/adc/Makefile
+++ b/drivers/staging/iio/adc/Makefile
@@ -17,8 +17,6 @@ ad799x-y := ad799x_core.o
 ad799x-$(CONFIG_AD799X_RING_BUFFER) += ad799x_ring.o
 obj-$(CONFIG_AD799X) += ad799x.o
 
-ad7476-y := ad7476_core.o
-ad7476-$(CONFIG_IIO_BUFFER) += ad7476_ring.o
 obj-$(CONFIG_AD7476) += ad7476.o
 
 ad7887-y := ad7887_core.o
diff --git a/drivers/staging/iio/adc/ad7476_core.c b/drivers/staging/iio/adc/ad7476.c
similarity index 73%
rename from drivers/staging/iio/adc/ad7476_core.c
rename to drivers/staging/iio/adc/ad7476.c
index 42523e6..13aed0e 100644
--- a/drivers/staging/iio/adc/ad7476_core.c
+++ b/drivers/staging/iio/adc/ad7476.c
@@ -18,8 +18,88 @@
 #include <linux/iio/iio.h>
 #include <linux/iio/sysfs.h>
 #include <linux/iio/buffer.h>
+#include <linux/iio/trigger_consumer.h>
+#include <linux/iio/triggered_buffer.h>
+
+#define RES_MASK(bits)	((1 << (bits)) - 1)
+
+struct ad7476_chip_info {
+	unsigned int			int_vref_uv;
+	struct iio_chan_spec		channel[2];
+};
+
+struct ad7476_state {
+	struct spi_device		*spi;
+	const struct ad7476_chip_info	*chip_info;
+	struct regulator		*reg;
+	struct spi_transfer		xfer;
+	struct spi_message		msg;
+	/*
+	 * DMA (thus cache coherency maintenance) requires the
+	 * transfer buffers to live in their own cache lines.
+	 * Make the buffer large enough for one 16 bit sample and one 64 bit
+	 * aligned 64 bit timestamp.
+	 */
+	unsigned char data[ALIGN(2, sizeof(s64)) + sizeof(s64)]
+			____cacheline_aligned;
+};
+
+enum ad7476_supported_device_ids {
+	ID_AD7466,
+	ID_AD7467,
+	ID_AD7468,
+	ID_AD7495
+};
+
+#if IS_ENABLED(CONFIG_IIO_BUFFER)
+
+static irqreturn_t ad7476_trigger_handler(int irq, void  *p)
+{
+	struct iio_poll_func *pf = p;
+	struct iio_dev *indio_dev = pf->indio_dev;
+	struct ad7476_state *st = iio_priv(indio_dev);
+	s64 time_ns;
+	int b_sent;
+
+	b_sent = spi_read(st->spi, st->data,
+			  st->chip_info->channel[0].scan_type.storagebits / 8);
+	if (b_sent < 0)
+		goto done;
+
+	time_ns = iio_get_time_ns();
+
+	if (indio_dev->scan_timestamp)
+		((s64 *)st->data)[1] = time_ns;
+
+	iio_push_to_buffer(indio_dev->buffer, st->data);
+done:
+	iio_trigger_notify_done(indio_dev->trig);
+
+	return IRQ_HANDLED;
+}
+
+static int ad7476_register_ring_funcs_and_init(struct iio_dev *indio_dev)
+{
+	return iio_triggered_buffer_setup(indio_dev, NULL,
+			&ad7476_trigger_handler, NULL);
+}
+
+static void ad7476_ring_cleanup(struct iio_dev *indio_dev)
+{
+	iio_triggered_buffer_cleanup(indio_dev);
+}
+
+#else
+
+static int ad7476_register_ring_funcs_and_init(struct iio_dev *indio_dev)
+{
+	return 0;
+}
+
+static void ad7476_ring_cleanup(struct iio_dev *indio_dev) {}
+
+#endif
 
-#include "ad7476.h"
 
 static int ad7476_scan_direct(struct ad7476_state *st)
 {
diff --git a/drivers/staging/iio/adc/ad7476.h b/drivers/staging/iio/adc/ad7476.h
deleted file mode 100644
index 4ed5494..0000000
--- a/drivers/staging/iio/adc/ad7476.h
+++ /dev/null
@@ -1,56 +0,0 @@
-/*
- * AD7476/5/7/8 (A) SPI ADC driver
- *
- * Copyright 2010 Analog Devices Inc.
- *
- * Licensed under the GPL-2 or later.
- */
-#ifndef IIO_ADC_AD7476_H_
-#define IIO_ADC_AD7476_H_
-
-#define RES_MASK(bits)	((1 << (bits)) - 1)
-
-struct ad7476_chip_info {
-	unsigned int			int_vref_uv;
-	struct iio_chan_spec		channel[2];
-};
-
-struct ad7476_state {
-	struct spi_device		*spi;
-	const struct ad7476_chip_info	*chip_info;
-	struct regulator		*reg;
-	struct spi_transfer		xfer;
-	struct spi_message		msg;
-	/*
-	 * DMA (thus cache coherency maintenance) requires the
-	 * transfer buffers to live in their own cache lines.
-	 * Make the buffer large enough for one 16 bit sample and one 64 bit
-	 * aligned 64 bit timestamp.
-	 */
-	unsigned char data[ALIGN(2, sizeof(s64)) + sizeof(s64)]
-			____cacheline_aligned;
-};
-
-enum ad7476_supported_device_ids {
-	ID_AD7466,
-	ID_AD7467,
-	ID_AD7468,
-	ID_AD7495
-};
-
-#ifdef CONFIG_IIO_BUFFER
-int ad7476_register_ring_funcs_and_init(struct iio_dev *indio_dev);
-void ad7476_ring_cleanup(struct iio_dev *indio_dev);
-#else /* CONFIG_IIO_BUFFER */
-
-static inline int
-ad7476_register_ring_funcs_and_init(struct iio_dev *indio_dev)
-{
-	return 0;
-}
-
-static inline void ad7476_ring_cleanup(struct iio_dev *indio_dev)
-{
-}
-#endif /* CONFIG_IIO_BUFFER */
-#endif /* IIO_ADC_AD7476_H_ */
diff --git a/drivers/staging/iio/adc/ad7476_ring.c b/drivers/staging/iio/adc/ad7476_ring.c
deleted file mode 100644
index 185cfde..0000000
--- a/drivers/staging/iio/adc/ad7476_ring.c
+++ /dev/null
@@ -1,57 +0,0 @@
-/*
- * Copyright 2010-2012 Analog Devices Inc.
- * Copyright (C) 2008 Jonathan Cameron
- *
- * Licensed under the GPL-2 or later.
- *
- * ad7476_ring.c
- */
-
-#include <linux/interrupt.h>
-#include <linux/device.h>
-#include <linux/kernel.h>
-#include <linux/slab.h>
-#include <linux/spi/spi.h>
-
-#include <linux/iio/iio.h>
-#include <linux/iio/buffer.h>
-#include <linux/iio/trigger_consumer.h>
-#include <linux/iio/triggered_buffer.h>
-
-#include "ad7476.h"
-
-static irqreturn_t ad7476_trigger_handler(int irq, void  *p)
-{
-	struct iio_poll_func *pf = p;
-	struct iio_dev *indio_dev = pf->indio_dev;
-	struct ad7476_state *st = iio_priv(indio_dev);
-	s64 time_ns;
-	int b_sent;
-
-	b_sent = spi_read(st->spi, st->data,
-			  st->chip_info->channel[0].scan_type.storagebits / 8);
-	if (b_sent < 0)
-		goto done;
-
-	time_ns = iio_get_time_ns();
-
-	if (indio_dev->scan_timestamp)
-		((s64 *)st->data)[1] = time_ns;
-
-	iio_push_to_buffer(indio_dev->buffer, st->data);
-done:
-	iio_trigger_notify_done(indio_dev->trig);
-
-	return IRQ_HANDLED;
-}
-
-int ad7476_register_ring_funcs_and_init(struct iio_dev *indio_dev)
-{
-	return iio_triggered_buffer_setup(indio_dev, NULL,
-			&ad7476_trigger_handler, NULL);
-}
-
-void ad7476_ring_cleanup(struct iio_dev *indio_dev)
-{
-	iio_triggered_buffer_cleanup(indio_dev);
-}
-- 
1.7.10.4

