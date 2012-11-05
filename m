Return-Path: <linux-iio-owner@vger.kernel.org>
Received: from smtp-out-191.synserver.de ([212.40.185.191]:1057 "EHLO
	smtp-out-191.synserver.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1753536Ab2KEJ5G (ORCPT
	<rfc822;linux-iio@vger.kernel.org>); Mon, 5 Nov 2012 04:57:06 -0500
From: Lars-Peter Clausen <lars@metafoo.de>
To: Jonathan Cameron <jic23@cam.ac.uk>
Cc: linux-iio@vger.kernel.org, drivers@analog.com,
	Lars-Peter Clausen <lars@metafoo.de>
Subject: [PATCH 3/7] staging:iio:ad7887: Squash everything into one file
Date: Mon,  5 Nov 2012 10:56:42 +0100
Message-Id: <1352109406-7206-3-git-send-email-lars@metafoo.de>
In-Reply-To: <1352109406-7206-1-git-send-email-lars@metafoo.de>
References: <1352109406-7206-1-git-send-email-lars@metafoo.de>
Sender: linux-iio-owner@vger.kernel.org
List-Id: linux-iio@vger.kernel.org

The recent cleanups have decimated the drivers code size by quite a bit. It is
only a few hundred lines in total now and we also always build buffer support,
so there really is no need to spread the driver out over multiple files. Putting
everything into one file also allows to reduce the code size a bit more by
removing a few lines of boilerplate code.

Signed-off-by: Lars-Peter Clausen <lars@metafoo.de>
---
 drivers/staging/iio/adc/Makefile                   |   2 -
 .../staging/iio/adc/{ad7887_core.c => ad7887.c}    | 133 ++++++++++++++++++++-
 drivers/staging/iio/adc/ad7887.h                   |  66 ----------
 drivers/staging/iio/adc/ad7887_ring.c              | 111 -----------------
 4 files changed, 130 insertions(+), 182 deletions(-)
 rename drivers/staging/iio/adc/{ad7887_core.c => ad7887.c} (62%)
 delete mode 100644 drivers/staging/iio/adc/ad7887_ring.c

diff --git a/drivers/staging/iio/adc/Makefile b/drivers/staging/iio/adc/Makefile
index ff561c5..8036fd1 100644
--- a/drivers/staging/iio/adc/Makefile
+++ b/drivers/staging/iio/adc/Makefile
@@ -17,8 +17,6 @@ ad799x-y := ad799x_core.o
 ad799x-$(CONFIG_AD799X_RING_BUFFER) += ad799x_ring.o
 obj-$(CONFIG_AD799X) += ad799x.o
 
-ad7887-y := ad7887_core.o
-ad7887-$(CONFIG_IIO_BUFFER) += ad7887_ring.o
 obj-$(CONFIG_AD7887) += ad7887.o
 
 ad7298-y := ad7298_core.o
diff --git a/drivers/staging/iio/adc/ad7887_core.c b/drivers/staging/iio/adc/ad7887.c
similarity index 62%
rename from drivers/staging/iio/adc/ad7887_core.c
rename to drivers/staging/iio/adc/ad7887.c
index cf33ba6..88ffc46 100644
--- a/drivers/staging/iio/adc/ad7887_core.c
+++ b/drivers/staging/iio/adc/ad7887.c
@@ -14,14 +14,140 @@
 #include <linux/regulator/consumer.h>
 #include <linux/err.h>
 #include <linux/module.h>
+#include <linux/interrupt.h>
 
 #include <linux/iio/iio.h>
 #include <linux/iio/sysfs.h>
 #include <linux/iio/buffer.h>
 
+#include <linux/iio/trigger_consumer.h>
+#include <linux/iio/triggered_buffer.h>
 
 #include "ad7887.h"
 
+#define AD7887_REF_DIS		(1 << 5) /* on-chip reference disable */
+#define AD7887_DUAL		(1 << 4) /* dual-channel mode */
+#define AD7887_CH_AIN1		(1 << 3) /* convert on channel 1, DUAL=1 */
+#define AD7887_CH_AIN0		(0 << 3) /* convert on channel 0, DUAL=0,1 */
+#define AD7887_PM_MODE1		(0)	 /* CS based shutdown */
+#define AD7887_PM_MODE2		(1)	 /* full on */
+#define AD7887_PM_MODE3		(2)	 /* auto shutdown after conversion */
+#define AD7887_PM_MODE4		(3)	 /* standby mode */
+
+enum ad7887_channels {
+	AD7887_CH0,
+	AD7887_CH0_CH1,
+	AD7887_CH1,
+};
+
+#define RES_MASK(bits)	((1 << (bits)) - 1)
+
+/**
+ * struct ad7887_chip_info - chip specifc information
+ * @int_vref_mv:	the internal reference voltage
+ * @channel:		channel specification
+ */
+struct ad7887_chip_info {
+	u16				int_vref_mv;
+	struct iio_chan_spec		channel[3];
+};
+
+struct ad7887_state {
+	struct spi_device		*spi;
+	const struct ad7887_chip_info	*chip_info;
+	struct regulator		*reg;
+	struct spi_transfer		xfer[4];
+	struct spi_message		msg[3];
+	struct spi_message		*ring_msg;
+	unsigned char			tx_cmd_buf[8];
+
+	/*
+	 * DMA (thus cache coherency maintenance) requires the
+	 * transfer buffers to live in their own cache lines.
+	 * Buffer needs to be large enough to hold two 16 bit samples and a
+	 * 64 bit aligned 64 bit timestamp.
+	 */
+	unsigned char data[ALIGN(4, sizeof(s64)) + sizeof(s64)]
+		____cacheline_aligned;
+};
+
+enum ad7887_supported_device_ids {
+	ID_AD7887
+};
+
+static int ad7887_ring_preenable(struct iio_dev *indio_dev)
+{
+	struct ad7887_state *st = iio_priv(indio_dev);
+	int ret;
+
+	ret = iio_sw_buffer_preenable(indio_dev);
+	if (ret < 0)
+		return ret;
+
+	/* We know this is a single long so can 'cheat' */
+	switch (*indio_dev->active_scan_mask) {
+	case (1 << 0):
+		st->ring_msg = &st->msg[AD7887_CH0];
+		break;
+	case (1 << 1):
+		st->ring_msg = &st->msg[AD7887_CH1];
+		/* Dummy read: push CH1 setting down to hardware */
+		spi_sync(st->spi, st->ring_msg);
+		break;
+	case ((1 << 1) | (1 << 0)):
+		st->ring_msg = &st->msg[AD7887_CH0_CH1];
+		break;
+	}
+
+	return 0;
+}
+
+static int ad7887_ring_postdisable(struct iio_dev *indio_dev)
+{
+	struct ad7887_state *st = iio_priv(indio_dev);
+
+	/* dummy read: restore default CH0 settin */
+	return spi_sync(st->spi, &st->msg[AD7887_CH0]);
+}
+
+/**
+ * ad7887_trigger_handler() bh of trigger launched polling to ring buffer
+ *
+ * Currently there is no option in this driver to disable the saving of
+ * timestamps within the ring.
+ **/
+static irqreturn_t ad7887_trigger_handler(int irq, void *p)
+{
+	struct iio_poll_func *pf = p;
+	struct iio_dev *indio_dev = pf->indio_dev;
+	struct ad7887_state *st = iio_priv(indio_dev);
+	s64 time_ns;
+	int b_sent;
+
+	b_sent = spi_sync(st->spi, st->ring_msg);
+	if (b_sent)
+		goto done;
+
+	time_ns = iio_get_time_ns();
+
+	if (indio_dev->scan_timestamp)
+		memcpy(st->data + indio_dev->scan_bytes - sizeof(s64),
+		       &time_ns, sizeof(time_ns));
+
+	iio_push_to_buffer(indio_dev->buffer, st->data);
+done:
+	iio_trigger_notify_done(indio_dev->trig);
+
+	return IRQ_HANDLED;
+}
+
+static const struct iio_buffer_setup_ops ad7887_ring_setup_ops = {
+	.preenable = &ad7887_ring_preenable,
+	.postenable = &iio_triggered_buffer_postenable,
+	.predisable = &iio_triggered_buffer_predisable,
+	.postdisable = &ad7887_ring_postdisable,
+};
+
 static int ad7887_scan_direct(struct ad7887_state *st, unsigned ch)
 {
 	int ret = spi_sync(st->spi, &st->msg[ch]);
@@ -192,7 +318,8 @@ static int __devinit ad7887_probe(struct spi_device *spi)
 		indio_dev->num_channels = 2;
 	}
 
-	ret = ad7887_register_ring_funcs_and_init(indio_dev);
+	ret = iio_triggered_buffer_setup(indio_dev, &iio_pollfunc_store_time,
+			&ad7887_trigger_handler, &ad7887_ring_setup_ops);
 	if (ret)
 		goto error_disable_reg;
 
@@ -202,7 +329,7 @@ static int __devinit ad7887_probe(struct spi_device *spi)
 
 	return 0;
 error_unregister_ring:
-	ad7887_ring_cleanup(indio_dev);
+	iio_triggered_buffer_cleanup(indio_dev);
 error_disable_reg:
 	if (st->reg)
 		regulator_disable(st->reg);
@@ -221,7 +348,7 @@ static int __devexit ad7887_remove(struct spi_device *spi)
 	struct ad7887_state *st = iio_priv(indio_dev);
 
 	iio_device_unregister(indio_dev);
-	ad7887_ring_cleanup(indio_dev);
+	iio_triggered_buffer_cleanup(indio_dev);
 	if (st->reg) {
 		regulator_disable(st->reg);
 		regulator_put(st->reg);
diff --git a/drivers/staging/iio/adc/ad7887.h b/drivers/staging/iio/adc/ad7887.h
index 25d5b40..b9078fc 100644
--- a/drivers/staging/iio/adc/ad7887.h
+++ b/drivers/staging/iio/adc/ad7887.h
@@ -8,23 +8,6 @@
 #ifndef IIO_ADC_AD7887_H_
 #define IIO_ADC_AD7887_H_
 
-#define AD7887_REF_DIS		(1 << 5) /* on-chip reference disable */
-#define AD7887_DUAL		(1 << 4) /* dual-channel mode */
-#define AD7887_CH_AIN1		(1 << 3) /* convert on channel 1, DUAL=1 */
-#define AD7887_CH_AIN0		(0 << 3) /* convert on channel 0, DUAL=0,1 */
-#define AD7887_PM_MODE1		(0)	 /* CS based shutdown */
-#define AD7887_PM_MODE2		(1)	 /* full on */
-#define AD7887_PM_MODE3		(2)	 /* auto shutdown after conversion */
-#define AD7887_PM_MODE4		(3)	 /* standby mode */
-
-enum ad7887_channels {
-	AD7887_CH0,
-	AD7887_CH0_CH1,
-	AD7887_CH1,
-};
-
-#define RES_MASK(bits)	((1 << (bits)) - 1) /* TODO: move this into a common header */
-
 /*
  * TODO: struct ad7887_platform_data needs to go into include/linux/iio
  */
@@ -46,53 +29,4 @@ struct ad7887_platform_data {
 	bool				use_onchip_ref;
 };
 
-/**
- * struct ad7887_chip_info - chip specifc information
- * @int_vref_mv:	the internal reference voltage
- * @channel:		channel specification
- */
-
-struct ad7887_chip_info {
-	u16				int_vref_mv;
-	struct iio_chan_spec		channel[3];
-};
-
-struct ad7887_state {
-	struct spi_device		*spi;
-	const struct ad7887_chip_info	*chip_info;
-	struct regulator		*reg;
-	struct spi_transfer		xfer[4];
-	struct spi_message		msg[3];
-	struct spi_message		*ring_msg;
-	unsigned char			tx_cmd_buf[8];
-
-	/*
-	 * DMA (thus cache coherency maintenance) requires the
-	 * transfer buffers to live in their own cache lines.
-	 * Buffer needs to be large enough to hold two 16 bit samples and a
-	 * 64 bit aligned 64 bit timestamp.
-	 */
-	unsigned char data[ALIGN(4, sizeof(s64)) + sizeof(s64)]
-		____cacheline_aligned;
-};
-
-enum ad7887_supported_device_ids {
-	ID_AD7887
-};
-
-#ifdef CONFIG_IIO_BUFFER
-int ad7887_register_ring_funcs_and_init(struct iio_dev *indio_dev);
-void ad7887_ring_cleanup(struct iio_dev *indio_dev);
-#else /* CONFIG_IIO_BUFFER */
-
-static inline int
-ad7887_register_ring_funcs_and_init(struct iio_dev *indio_dev)
-{
-	return 0;
-}
-
-static inline void ad7887_ring_cleanup(struct iio_dev *indio_dev)
-{
-}
-#endif /* CONFIG_IIO_BUFFER */
 #endif /* IIO_ADC_AD7887_H_ */
diff --git a/drivers/staging/iio/adc/ad7887_ring.c b/drivers/staging/iio/adc/ad7887_ring.c
deleted file mode 100644
index f11925e..0000000
--- a/drivers/staging/iio/adc/ad7887_ring.c
+++ /dev/null
@@ -1,111 +0,0 @@
-/*
- * Copyright 2010-2012 Analog Devices Inc.
- * Copyright (C) 2008 Jonathan Cameron
- *
- * Licensed under the GPL-2.
- *
- * ad7887_ring.c
- */
-
-#include <linux/interrupt.h>
-#include <linux/kernel.h>
-#include <linux/slab.h>
-#include <linux/spi/spi.h>
-
-#include <linux/iio/iio.h>
-#include <linux/iio/buffer.h>
-#include <linux/iio/trigger_consumer.h>
-#include <linux/iio/triggered_buffer.h>
-
-#include "ad7887.h"
-
-/**
- * ad7887_ring_preenable() setup the parameters of the ring before enabling
- *
- * The complex nature of the setting of the nuber of bytes per datum is due
- * to this driver currently ensuring that the timestamp is stored at an 8
- * byte boundary.
- **/
-static int ad7887_ring_preenable(struct iio_dev *indio_dev)
-{
-	struct ad7887_state *st = iio_priv(indio_dev);
-	int ret;
-
-	ret = iio_sw_buffer_preenable(indio_dev);
-	if (ret < 0)
-		return ret;
-
-	/* We know this is a single long so can 'cheat' */
-	switch (*indio_dev->active_scan_mask) {
-	case (1 << 0):
-		st->ring_msg = &st->msg[AD7887_CH0];
-		break;
-	case (1 << 1):
-		st->ring_msg = &st->msg[AD7887_CH1];
-		/* Dummy read: push CH1 setting down to hardware */
-		spi_sync(st->spi, st->ring_msg);
-		break;
-	case ((1 << 1) | (1 << 0)):
-		st->ring_msg = &st->msg[AD7887_CH0_CH1];
-		break;
-	}
-
-	return 0;
-}
-
-static int ad7887_ring_postdisable(struct iio_dev *indio_dev)
-{
-	struct ad7887_state *st = iio_priv(indio_dev);
-
-	/* dummy read: restore default CH0 settin */
-	return spi_sync(st->spi, &st->msg[AD7887_CH0]);
-}
-
-/**
- * ad7887_trigger_handler() bh of trigger launched polling to ring buffer
- *
- * Currently there is no option in this driver to disable the saving of
- * timestamps within the ring.
- **/
-static irqreturn_t ad7887_trigger_handler(int irq, void *p)
-{
-	struct iio_poll_func *pf = p;
-	struct iio_dev *indio_dev = pf->indio_dev;
-	struct ad7887_state *st = iio_priv(indio_dev);
-	s64 time_ns;
-	int b_sent;
-
-	b_sent = spi_sync(st->spi, st->ring_msg);
-	if (b_sent)
-		goto done;
-
-	time_ns = iio_get_time_ns();
-
-	if (indio_dev->scan_timestamp)
-		memcpy(st->data + indio_dev->scan_bytes - sizeof(s64),
-		       &time_ns, sizeof(time_ns));
-
-	iio_push_to_buffer(indio_dev->buffer, st->data);
-done:
-	iio_trigger_notify_done(indio_dev->trig);
-
-	return IRQ_HANDLED;
-}
-
-static const struct iio_buffer_setup_ops ad7887_ring_setup_ops = {
-	.preenable = &ad7887_ring_preenable,
-	.postenable = &iio_triggered_buffer_postenable,
-	.predisable = &iio_triggered_buffer_predisable,
-	.postdisable = &ad7887_ring_postdisable,
-};
-
-int ad7887_register_ring_funcs_and_init(struct iio_dev *indio_dev)
-{
-	return iio_triggered_buffer_setup(indio_dev, &iio_pollfunc_store_time,
-			&ad7887_trigger_handler, &ad7887_ring_setup_ops);
-}
-
-void ad7887_ring_cleanup(struct iio_dev *indio_dev)
-{
-	iio_triggered_buffer_cleanup(indio_dev);
-}
-- 
1.8.0

