Return-Path: <linux-iio-owner@vger.kernel.org>
Received: from smtp-out-220.synserver.de ([212.40.185.220]:1084 "EHLO
	smtp-out-129.synserver.de" rhost-flags-OK-OK-OK-FAIL)
	by vger.kernel.org with ESMTP id S1752229AbaCJKaz (ORCPT
	<rfc822;linux-iio@vger.kernel.org>); Mon, 10 Mar 2014 06:30:55 -0400
From: Lars-Peter Clausen <lars@metafoo.de>
To: Jonathan Cameron <jic23@kernel.org>
Cc: linux-iio@vger.kernel.org, Hartmut Knaack <knaack.h@gmx.de>,
	Lars-Peter Clausen <lars@metafoo.de>
Subject: [PATCH 1/2] staging:iio:ad799x: Move ring functions to the main file
Date: Mon, 10 Mar 2014 11:31:23 +0100
Message-Id: <1394447484-29334-1-git-send-email-lars@metafoo.de>
Sender: linux-iio-owner@vger.kernel.org
List-Id: linux-iio@vger.kernel.org

The ad799x_ring.c file is pretty much only one function these days. No need to
keep it in a separate file. Since there is then only one user of the header left
also move everything from the header to the main file.

Signed-off-by: Lars-Peter Clausen <lars@metafoo.de>
---
 drivers/staging/iio/adc/Kconfig       |  13 +--
 drivers/staging/iio/adc/Makefile      |   1 -
 drivers/staging/iio/adc/ad799x.h      | 121 ----------------------------
 drivers/staging/iio/adc/ad799x_core.c | 145 +++++++++++++++++++++++++++++++++-
 drivers/staging/iio/adc/ad799x_ring.c |  84 --------------------
 5 files changed, 143 insertions(+), 221 deletions(-)
 delete mode 100644 drivers/staging/iio/adc/ad799x.h
 delete mode 100644 drivers/staging/iio/adc/ad799x_ring.c

diff --git a/drivers/staging/iio/adc/Kconfig b/drivers/staging/iio/adc/Kconfig
index 3633298..ed23cceb 100644
--- a/drivers/staging/iio/adc/Kconfig
+++ b/drivers/staging/iio/adc/Kconfig
@@ -40,23 +40,14 @@ config AD7606_IFACE_SPI
 config AD799X
 	tristate "Analog Devices AD799x ADC driver"
 	depends on I2C
-	select IIO_TRIGGER if IIO_BUFFER
-	select AD799X_RING_BUFFER
+	select IIO_BUFFER
+	select IIO_TRIGGERED_BUFFER
 	help
 	  Say yes here to build support for Analog Devices:
 	  ad7991, ad7995, ad7999, ad7992, ad7993, ad7994, ad7997, ad7998
 	  i2c analog to digital converters (ADC). Provides direct access
 	  via sysfs.
 
-config AD799X_RING_BUFFER
-	bool "Analog Devices AD799x: use ring buffer"
-	depends on AD799X
-	select IIO_BUFFER
-	select IIO_TRIGGERED_BUFFER
-	help
-	  Say yes here to include ring buffer support in the AD799X
-	  ADC driver.
-
 config AD7780
 	tristate "Analog Devices AD7780 and similar ADCs driver"
 	depends on SPI
diff --git a/drivers/staging/iio/adc/Makefile b/drivers/staging/iio/adc/Makefile
index 3e9fb14..b2d35f8 100644
--- a/drivers/staging/iio/adc/Makefile
+++ b/drivers/staging/iio/adc/Makefile
@@ -9,7 +9,6 @@ ad7606-$(CONFIG_AD7606_IFACE_SPI) += ad7606_spi.o
 obj-$(CONFIG_AD7606) += ad7606.o
 
 ad799x-y := ad799x_core.o
-ad799x-$(CONFIG_AD799X_RING_BUFFER) += ad799x_ring.o
 obj-$(CONFIG_AD799X) += ad799x.o
 
 obj-$(CONFIG_AD7291) += ad7291.o
diff --git a/drivers/staging/iio/adc/ad799x.h b/drivers/staging/iio/adc/ad799x.h
deleted file mode 100644
index fc8c852..0000000
--- a/drivers/staging/iio/adc/ad799x.h
+++ /dev/null
@@ -1,121 +0,0 @@
-/*
- * Copyright (C) 2010-2011 Michael Hennerich, Analog Devices Inc.
- * Copyright (C) 2008-2010 Jonathan Cameron
- *
- * This program is free software; you can redistribute it and/or modify
- * it under the terms of the GNU General Public License version 2 as
- * published by the Free Software Foundation.
- *
- * ad799x.h
- */
-
-#ifndef _AD799X_H_
-#define  _AD799X_H_
-
-#define AD799X_CHANNEL_SHIFT			4
-#define AD799X_STORAGEBITS			16
-/*
- * AD7991, AD7995 and AD7999 defines
- */
-
-#define AD7991_REF_SEL				0x08
-#define AD7991_FLTR				0x04
-#define AD7991_BIT_TRIAL_DELAY			0x02
-#define AD7991_SAMPLE_DELAY			0x01
-
-/*
- * AD7992, AD7993, AD7994, AD7997 and AD7998 defines
- */
-
-#define AD7998_FLTR				0x08
-#define AD7998_ALERT_EN				0x04
-#define AD7998_BUSY_ALERT			0x02
-#define AD7998_BUSY_ALERT_POL			0x01
-
-#define AD7998_CONV_RES_REG			0x0
-#define AD7998_ALERT_STAT_REG			0x1
-#define AD7998_CONF_REG				0x2
-#define AD7998_CYCLE_TMR_REG			0x3
-
-#define AD7998_DATALOW_REG(x)			((x) * 3 + 0x4)
-#define AD7998_DATAHIGH_REG(x)			((x) * 3 + 0x5)
-#define AD7998_HYST_REG(x)			((x) * 3 + 0x6)
-
-#define AD7998_CYC_MASK				0x7
-#define AD7998_CYC_DIS				0x0
-#define AD7998_CYC_TCONF_32			0x1
-#define AD7998_CYC_TCONF_64			0x2
-#define AD7998_CYC_TCONF_128			0x3
-#define AD7998_CYC_TCONF_256			0x4
-#define AD7998_CYC_TCONF_512			0x5
-#define AD7998_CYC_TCONF_1024			0x6
-#define AD7998_CYC_TCONF_2048			0x7
-
-#define AD7998_ALERT_STAT_CLEAR			0xFF
-
-/*
- * AD7997 and AD7997 defines
- */
-
-#define AD7997_8_READ_SINGLE			0x80
-#define AD7997_8_READ_SEQUENCE			0x70
-/* TODO: move this into a common header */
-#define RES_MASK(bits)	((1 << (bits)) - 1)
-
-enum {
-	ad7991,
-	ad7995,
-	ad7999,
-	ad7992,
-	ad7993,
-	ad7994,
-	ad7997,
-	ad7998
-};
-
-struct ad799x_state;
-
-/**
- * struct ad799x_chip_info - chip specifc information
- * @channel:		channel specification
- * @num_channels:	number of channels
- * @monitor_mode:	whether the chip supports monitor interrupts
- * @default_config:	device default configuration
- * @event_attrs:	pointer to the monitor event attribute group
- */
-
-struct ad799x_chip_info {
-	struct iio_chan_spec		channel[9];
-	int				num_channels;
-	u16				default_config;
-	const struct iio_info		*info;
-};
-
-struct ad799x_state {
-	struct i2c_client		*client;
-	const struct ad799x_chip_info	*chip_info;
-	struct regulator		*reg;
-	struct regulator		*vref;
-	unsigned			id;
-	u16				config;
-
-	u8				*rx_buf;
-	unsigned int			transfer_size;
-};
-
-#ifdef CONFIG_AD799X_RING_BUFFER
-int ad799x_register_ring_funcs_and_init(struct iio_dev *indio_dev);
-void ad799x_ring_cleanup(struct iio_dev *indio_dev);
-#else /* CONFIG_AD799X_RING_BUFFER */
-
-static inline int
-ad799x_register_ring_funcs_and_init(struct iio_dev *indio_dev)
-{
-	return 0;
-}
-
-static inline void ad799x_ring_cleanup(struct iio_dev *indio_dev)
-{
-}
-#endif /* CONFIG_AD799X_RING_BUFFER */
-#endif /* _AD799X_H_ */
diff --git a/drivers/staging/iio/adc/ad799x_core.c b/drivers/staging/iio/adc/ad799x_core.c
index 979ec77..bcbf610 100644
--- a/drivers/staging/iio/adc/ad799x_core.c
+++ b/drivers/staging/iio/adc/ad799x_core.c
@@ -37,8 +37,144 @@
 #include <linux/iio/sysfs.h>
 #include <linux/iio/events.h>
 #include <linux/iio/buffer.h>
+#include <linux/iio/trigger_consumer.h>
+#include <linux/iio/triggered_buffer.h>
 
-#include "ad799x.h"
+#define AD799X_CHANNEL_SHIFT			4
+#define AD799X_STORAGEBITS			16
+/*
+ * AD7991, AD7995 and AD7999 defines
+ */
+
+#define AD7991_REF_SEL				0x08
+#define AD7991_FLTR				0x04
+#define AD7991_BIT_TRIAL_DELAY			0x02
+#define AD7991_SAMPLE_DELAY			0x01
+
+/*
+ * AD7992, AD7993, AD7994, AD7997 and AD7998 defines
+ */
+
+#define AD7998_FLTR				0x08
+#define AD7998_ALERT_EN				0x04
+#define AD7998_BUSY_ALERT			0x02
+#define AD7998_BUSY_ALERT_POL			0x01
+
+#define AD7998_CONV_RES_REG			0x0
+#define AD7998_ALERT_STAT_REG			0x1
+#define AD7998_CONF_REG				0x2
+#define AD7998_CYCLE_TMR_REG			0x3
+
+#define AD7998_DATALOW_REG(x)			((x) * 3 + 0x4)
+#define AD7998_DATAHIGH_REG(x)			((x) * 3 + 0x5)
+#define AD7998_HYST_REG(x)			((x) * 3 + 0x6)
+
+#define AD7998_CYC_MASK				0x7
+#define AD7998_CYC_DIS				0x0
+#define AD7998_CYC_TCONF_32			0x1
+#define AD7998_CYC_TCONF_64			0x2
+#define AD7998_CYC_TCONF_128			0x3
+#define AD7998_CYC_TCONF_256			0x4
+#define AD7998_CYC_TCONF_512			0x5
+#define AD7998_CYC_TCONF_1024			0x6
+#define AD7998_CYC_TCONF_2048			0x7
+
+#define AD7998_ALERT_STAT_CLEAR			0xFF
+
+/*
+ * AD7997 and AD7997 defines
+ */
+
+#define AD7997_8_READ_SINGLE			0x80
+#define AD7997_8_READ_SEQUENCE			0x70
+/* TODO: move this into a common header */
+#define RES_MASK(bits)	((1 << (bits)) - 1)
+
+enum {
+	ad7991,
+	ad7995,
+	ad7999,
+	ad7992,
+	ad7993,
+	ad7994,
+	ad7997,
+	ad7998
+};
+
+/**
+ * struct ad799x_chip_info - chip specifc information
+ * @channel:		channel specification
+ * @num_channels:	number of channels
+ * @monitor_mode:	whether the chip supports monitor interrupts
+ * @default_config:	device default configuration
+ * @event_attrs:	pointer to the monitor event attribute group
+ */
+struct ad799x_chip_info {
+	struct iio_chan_spec		channel[9];
+	int				num_channels;
+	u16				default_config;
+	const struct iio_info		*info;
+};
+
+struct ad799x_state {
+	struct i2c_client		*client;
+	const struct ad799x_chip_info	*chip_info;
+	struct regulator		*reg;
+	struct regulator		*vref;
+	unsigned			id;
+	u16				config;
+
+	u8				*rx_buf;
+	unsigned int			transfer_size;
+};
+
+/**
+ * ad799x_trigger_handler() bh of trigger launched polling to ring buffer
+ *
+ * Currently there is no option in this driver to disable the saving of
+ * timestamps within the ring.
+ **/
+static irqreturn_t ad799x_trigger_handler(int irq, void *p)
+{
+	struct iio_poll_func *pf = p;
+	struct iio_dev *indio_dev = pf->indio_dev;
+	struct ad799x_state *st = iio_priv(indio_dev);
+	int b_sent;
+	u8 cmd;
+
+	switch (st->id) {
+	case ad7991:
+	case ad7995:
+	case ad7999:
+		cmd = st->config |
+			(*indio_dev->active_scan_mask << AD799X_CHANNEL_SHIFT);
+		break;
+	case ad7992:
+	case ad7993:
+	case ad7994:
+		cmd = (*indio_dev->active_scan_mask << AD799X_CHANNEL_SHIFT) |
+			AD7998_CONV_RES_REG;
+		break;
+	case ad7997:
+	case ad7998:
+		cmd = AD7997_8_READ_SEQUENCE | AD7998_CONV_RES_REG;
+		break;
+	default:
+		cmd = 0;
+	}
+
+	b_sent = i2c_smbus_read_i2c_block_data(st->client,
+			cmd, st->transfer_size, st->rx_buf);
+	if (b_sent < 0)
+		goto out;
+
+	iio_push_to_buffers_with_timestamp(indio_dev, st->rx_buf,
+			iio_get_time_ns());
+out:
+	iio_trigger_notify_done(indio_dev->trig);
+
+	return IRQ_HANDLED;
+}
 
 /*
  * ad799x register access by I2C
@@ -578,7 +714,8 @@ static int ad799x_probe(struct i2c_client *client,
 	indio_dev->channels = st->chip_info->channel;
 	indio_dev->num_channels = st->chip_info->num_channels;
 
-	ret = ad799x_register_ring_funcs_and_init(indio_dev);
+	ret = iio_triggered_buffer_setup(indio_dev, NULL,
+		&ad799x_trigger_handler, NULL);
 	if (ret)
 		goto error_disable_reg;
 
@@ -601,7 +738,7 @@ static int ad799x_probe(struct i2c_client *client,
 	return 0;
 
 error_cleanup_ring:
-	ad799x_ring_cleanup(indio_dev);
+	iio_triggered_buffer_cleanup(indio_dev);
 error_disable_reg:
 	if (!IS_ERR(st->vref))
 		regulator_disable(st->vref);
@@ -618,7 +755,7 @@ static int ad799x_remove(struct i2c_client *client)
 
 	iio_device_unregister(indio_dev);
 
-	ad799x_ring_cleanup(indio_dev);
+	iio_triggered_buffer_cleanup(indio_dev);
 	if (!IS_ERR(st->vref))
 		regulator_disable(st->vref);
 	if (!IS_ERR(st->reg))
diff --git a/drivers/staging/iio/adc/ad799x_ring.c b/drivers/staging/iio/adc/ad799x_ring.c
deleted file mode 100644
index 0ff6c03..0000000
--- a/drivers/staging/iio/adc/ad799x_ring.c
+++ /dev/null
@@ -1,84 +0,0 @@
-/*
- * Copyright (C) 2010-2012 Michael Hennerich, Analog Devices Inc.
- * Copyright (C) 2008-2010 Jonathan Cameron
- *
- * This program is free software; you can redistribute it and/or modify
- * it under the terms of the GNU General Public License version 2 as
- * published by the Free Software Foundation.
- *
- * ad799x_ring.c
- */
-
-#include <linux/interrupt.h>
-#include <linux/slab.h>
-#include <linux/kernel.h>
-#include <linux/list.h>
-#include <linux/i2c.h>
-#include <linux/bitops.h>
-
-#include <linux/iio/iio.h>
-#include <linux/iio/buffer.h>
-#include <linux/iio/trigger_consumer.h>
-#include <linux/iio/triggered_buffer.h>
-
-#include "ad799x.h"
-
-/**
- * ad799x_trigger_handler() bh of trigger launched polling to ring buffer
- *
- * Currently there is no option in this driver to disable the saving of
- * timestamps within the ring.
- **/
-
-static irqreturn_t ad799x_trigger_handler(int irq, void *p)
-{
-	struct iio_poll_func *pf = p;
-	struct iio_dev *indio_dev = pf->indio_dev;
-	struct ad799x_state *st = iio_priv(indio_dev);
-	int b_sent;
-	u8 cmd;
-
-	switch (st->id) {
-	case ad7991:
-	case ad7995:
-	case ad7999:
-		cmd = st->config |
-			(*indio_dev->active_scan_mask << AD799X_CHANNEL_SHIFT);
-		break;
-	case ad7992:
-	case ad7993:
-	case ad7994:
-		cmd = (*indio_dev->active_scan_mask << AD799X_CHANNEL_SHIFT) |
-			AD7998_CONV_RES_REG;
-		break;
-	case ad7997:
-	case ad7998:
-		cmd = AD7997_8_READ_SEQUENCE | AD7998_CONV_RES_REG;
-		break;
-	default:
-		cmd = 0;
-	}
-
-	b_sent = i2c_smbus_read_i2c_block_data(st->client,
-			cmd, st->transfer_size, st->rx_buf);
-	if (b_sent < 0)
-		goto out;
-
-	iio_push_to_buffers_with_timestamp(indio_dev, st->rx_buf,
-			iio_get_time_ns());
-out:
-	iio_trigger_notify_done(indio_dev->trig);
-
-	return IRQ_HANDLED;
-}
-
-int ad799x_register_ring_funcs_and_init(struct iio_dev *indio_dev)
-{
-	return iio_triggered_buffer_setup(indio_dev, NULL,
-		&ad799x_trigger_handler, NULL);
-}
-
-void ad799x_ring_cleanup(struct iio_dev *indio_dev)
-{
-	iio_triggered_buffer_cleanup(indio_dev);
-}
-- 
1.8.0

