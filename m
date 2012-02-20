Return-Path: <linux-iio-owner@vger.kernel.org>
Received: from smtp-out-025.synserver.de ([212.40.185.25]:1044 "EHLO
	smtp-out-025.synserver.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751447Ab2BTLx7 (ORCPT
	<rfc822;linux-iio@vger.kernel.org>); Mon, 20 Feb 2012 06:53:59 -0500
From: Lars-Peter Clausen <lars@metafoo.de>
To: Jonathan Cameron <jic23@cam.ac.uk>
Cc: linux-iio@vger.kernel.org,
	device-drivers-devel@blackfin.uclinux.org, drivers@analog.com,
	Lars-Peter Clausen <lars@metafoo.de>
Subject: [PATCH v2 5/6] staging:iio:dac:ad5064: Add AD5628/AD5648/AD5668 support
Date: Mon, 20 Feb 2012 12:55:19 +0100
Message-Id: <1329738920-14281-5-git-send-email-lars@metafoo.de>
In-Reply-To: <1329738920-14281-1-git-send-email-lars@metafoo.de>
References: <1329738920-14281-1-git-send-email-lars@metafoo.de>
Sender: linux-iio-owner@vger.kernel.org
List-Id: linux-iio@vger.kernel.org

The AD5628/AD5648/AD5668 are similar to the AD5024/AD5044/AD5064. The difference
being that they have an internal reference voltage and 8 instead of 4 DAC
channels.

Signed-off-by: Lars-Peter Clausen <lars@metafoo.de>
---
 drivers/staging/iio/dac/Kconfig  |    5 +-
 drivers/staging/iio/dac/ad5064.c |  122 ++++++++++++++++++++++++++++++++------
 2 files changed, 107 insertions(+), 20 deletions(-)

diff --git a/drivers/staging/iio/dac/Kconfig b/drivers/staging/iio/dac/Kconfig
index 66b2504..ab8516d 100644
--- a/drivers/staging/iio/dac/Kconfig
+++ b/drivers/staging/iio/dac/Kconfig
@@ -4,11 +4,12 @@
 menu "Digital to analog converters"
 
 config AD5064
-	tristate "Analog Devices AD5064/64-1/65/44/45/24/25 DAC driver"
+	tristate "Analog Devices AD5064/64-1/65/44/45/24/25, AD5628/48/68 DAC driver"
 	depends on SPI
 	help
 	  Say yes here to build support for Analog Devices AD5024, AD5025, AD5044,
-	  AD5045, AD5064, AD5064-1, AD5065 Digital to Analog Converter.
+	  AD5045, AD5064, AD5064-1, AD5065, AD5628, AD5648, AD5668 Digital to Analog
+	  Converter.
 
 	  To compile this driver as a module, choose M here: the
 	  module will be called ad5064.
diff --git a/drivers/staging/iio/dac/ad5064.c b/drivers/staging/iio/dac/ad5064.c
index 865e81f..6dab064 100644
--- a/drivers/staging/iio/dac/ad5064.c
+++ b/drivers/staging/iio/dac/ad5064.c
@@ -1,6 +1,6 @@
 /*
- * AD5024, AD5025, AD5044, AD5045, AD5064, AD5064-1 Digital to analog converters
- * driver
+ * AD5024, AD5025, AD5044, AD5045, AD5064, AD5064-1, AD5065, AD5628, AD5648,
+ * AD5668 Digital to analog converters driver
  *
  * Copyright 2011 Analog Devices Inc.
  *
@@ -20,7 +20,7 @@
 #include "../sysfs.h"
 #include "dac.h"
 
-#define AD5064_MAX_DAC_CHANNELS			4
+#define AD5064_MAX_DAC_CHANNELS			8
 #define AD5064_MAX_VREFS			4
 
 #define AD5064_ADDR(x)				((x) << 20)
@@ -37,7 +37,10 @@
 #define AD5064_CMD_CLEAR			0x5
 #define AD5064_CMD_LDAC_MASK			0x6
 #define AD5064_CMD_RESET			0x7
-#define AD5064_CMD_DAISY_CHAIN_ENABLE		0x8
+#define AD5064_CMD_CONFIG			0x8
+
+#define AD5064_CONFIG_DAISY_CHAIN_ENABLE	BIT(1)
+#define AD5064_CONFIG_INT_VREF_ENABLE		BIT(0)
 
 #define AD5064_LDAC_PWRDN_NONE			0x0
 #define AD5064_LDAC_PWRDN_1K			0x1
@@ -47,12 +50,15 @@
 /**
  * struct ad5064_chip_info - chip specific information
  * @shared_vref:	whether the vref supply is shared between channels
+ * @internal_vref:	internal reference voltage. 0 if the chip has no internal
+ *			vref.
  * @channel:		channel specification
  * @num_channels:	number of channels
  */
 
 struct ad5064_chip_info {
 	bool shared_vref;
+	unsigned long internal_vref;
 	const struct iio_chan_spec *channels;
 	unsigned int num_channels;
 };
@@ -65,6 +71,8 @@ struct ad5064_chip_info {
  * @pwr_down:		whether channel is powered down
  * @pwr_down_mode:	channel's current power down mode
  * @dac_cache:		current DAC raw value (chip does not support readback)
+ * @use_internal_vref:	set to true if the internal reference voltage should be
+ *			used.
  * @data:		spi transfer buffers
  */
 
@@ -75,6 +83,7 @@ struct ad5064_state {
 	bool				pwr_down[AD5064_MAX_DAC_CHANNELS];
 	u8				pwr_down_mode[AD5064_MAX_DAC_CHANNELS];
 	unsigned int			dac_cache[AD5064_MAX_DAC_CHANNELS];
+	bool				use_internal_vref;
 
 	/*
 	 * DMA (thus cache coherency maintenance) requires the
@@ -91,6 +100,12 @@ enum ad5064_type {
 	ID_AD5064,
 	ID_AD5064_1,
 	ID_AD5065,
+	ID_AD5628_1,
+	ID_AD5628_2,
+	ID_AD5648_1,
+	ID_AD5648_2,
+	ID_AD5668_1,
+	ID_AD5668_2,
 };
 
 static int ad5064_spi_write(struct ad5064_state *st, unsigned int cmd,
@@ -196,6 +211,18 @@ static ssize_t ad5064_write_dac_powerdown(struct iio_dev *indio_dev,
 	return ret ? ret : len;
 }
 
+static int ad5064_get_vref(struct ad5064_state *st,
+	struct iio_chan_spec const *chan)
+{
+	unsigned int i;
+
+	if (st->use_internal_vref)
+		return st->chip_info->internal_vref;
+
+	i = st->chip_info->shared_vref ? 0 : chan->channel;
+	return regulator_get_voltage(st->vref_reg[i].consumer);
+}
+
 static int ad5064_read_raw(struct iio_dev *indio_dev,
 			   struct iio_chan_spec const *chan,
 			   int *val,
@@ -203,7 +230,6 @@ static int ad5064_read_raw(struct iio_dev *indio_dev,
 			   long m)
 {
 	struct ad5064_state *st = iio_priv(indio_dev);
-	unsigned int vref;
 	int scale_uv;
 
 	switch (m) {
@@ -211,8 +237,7 @@ static int ad5064_read_raw(struct iio_dev *indio_dev,
 		*val = st->dac_cache[chan->channel];
 		return IIO_VAL_INT;
 	case IIO_CHAN_INFO_SCALE:
-		vref = st->chip_info->shared_vref ? 0 : chan->channel;
-		scale_uv = regulator_get_voltage(st->vref_reg[vref].consumer);
+		scale_uv = ad5064_get_vref(st, chan);
 		if (scale_uv < 0)
 			return scale_uv;
 
@@ -293,6 +318,10 @@ const struct iio_chan_spec name[] = { \
 	AD5064_CHANNEL(1, bits), \
 	AD5064_CHANNEL(2, bits), \
 	AD5064_CHANNEL(3, bits), \
+	AD5064_CHANNEL(4, bits), \
+	AD5064_CHANNEL(5, bits), \
+	AD5064_CHANNEL(6, bits), \
+	AD5064_CHANNEL(7, bits), \
 }
 
 static DECLARE_AD5064_CHANNELS(ad5024_channels, 12);
@@ -335,6 +364,42 @@ static const struct ad5064_chip_info ad5064_chip_info_tbl[] = {
 		.channels = ad5064_channels,
 		.num_channels = 2,
 	},
+	[ID_AD5628_1] = {
+		.shared_vref = true,
+		.internal_vref = 2500000,
+		.channels = ad5024_channels,
+		.num_channels = 8,
+	},
+	[ID_AD5628_2] = {
+		.shared_vref = true,
+		.internal_vref = 5000000,
+		.channels = ad5024_channels,
+		.num_channels = 8,
+	},
+	[ID_AD5648_1] = {
+		.shared_vref = true,
+		.internal_vref = 2500000,
+		.channels = ad5044_channels,
+		.num_channels = 8,
+	},
+	[ID_AD5648_2] = {
+		.shared_vref = true,
+		.internal_vref = 5000000,
+		.channels = ad5044_channels,
+		.num_channels = 8,
+	},
+	[ID_AD5668_1] = {
+		.shared_vref = true,
+		.internal_vref = 2500000,
+		.channels = ad5064_channels,
+		.num_channels = 8,
+	},
+	[ID_AD5668_2] = {
+		.shared_vref = true,
+		.internal_vref = 5000000,
+		.channels = ad5064_channels,
+		.num_channels = 8,
+	},
 };
 
 static inline unsigned int ad5064_num_vref(struct ad5064_state *st)
@@ -378,12 +443,22 @@ static int __devinit ad5064_probe(struct spi_device *spi)
 
 	ret = regulator_bulk_get(&st->spi->dev, ad5064_num_vref(st),
 		st->vref_reg);
-	if (ret)
-		goto error_free;
-
-	ret = regulator_bulk_enable(ad5064_num_vref(st), st->vref_reg);
-	if (ret)
-		goto error_free_reg;
+	if (ret) {
+		if (!st->chip_info->internal_vref)
+			goto error_free;
+		st->use_internal_vref = true;
+		ret = ad5064_spi_write(st, AD5064_CMD_CONFIG, 0,
+			AD5064_CONFIG_INT_VREF_ENABLE, 0);
+		if (ret) {
+			dev_err(&spi->dev, "Failed to enable internal vref: %d\n",
+				ret);
+			goto error_free;
+		}
+	} else {
+		ret = regulator_bulk_enable(ad5064_num_vref(st), st->vref_reg);
+		if (ret)
+			goto error_free_reg;
+	}
 
 	for (i = 0; i < st->chip_info->num_channels; ++i) {
 		st->pwr_down_mode[i] = AD5064_LDAC_PWRDN_1K;
@@ -404,9 +479,11 @@ static int __devinit ad5064_probe(struct spi_device *spi)
 	return 0;
 
 error_disable_reg:
-	regulator_bulk_disable(ad5064_num_vref(st), st->vref_reg);
+	if (!st->use_internal_vref)
+		regulator_bulk_disable(ad5064_num_vref(st), st->vref_reg);
 error_free_reg:
-	regulator_bulk_free(ad5064_num_vref(st), st->vref_reg);
+	if (!st->use_internal_vref)
+		regulator_bulk_free(ad5064_num_vref(st), st->vref_reg);
 error_free:
 	iio_free_device(indio_dev);
 
@@ -421,8 +498,10 @@ static int __devexit ad5064_remove(struct spi_device *spi)
 
 	iio_device_unregister(indio_dev);
 
-	regulator_bulk_disable(ad5064_num_vref(st), st->vref_reg);
-	regulator_bulk_free(ad5064_num_vref(st), st->vref_reg);
+	if (!st->use_internal_vref) {
+		regulator_bulk_disable(ad5064_num_vref(st), st->vref_reg);
+		regulator_bulk_free(ad5064_num_vref(st), st->vref_reg);
+	}
 
 	iio_free_device(indio_dev);
 
@@ -437,6 +516,13 @@ static const struct spi_device_id ad5064_id[] = {
 	{"ad5064", ID_AD5064},
 	{"ad5064-1", ID_AD5064_1},
 	{"ad5065", ID_AD5065},
+	{"ad5628-1", ID_AD5628_1},
+	{"ad5628-2", ID_AD5628_2},
+	{"ad5648-1", ID_AD5648_1},
+	{"ad5648-2", ID_AD5648_2},
+	{"ad5668-1", ID_AD5668_1},
+	{"ad5668-2", ID_AD5668_2},
+	{"ad5668-3", ID_AD5668_2}, /* similar enough to ad5668-2 */
 	{}
 };
 MODULE_DEVICE_TABLE(spi, ad5064_id);
@@ -453,5 +539,5 @@ static struct spi_driver ad5064_driver = {
 module_spi_driver(ad5064_driver);
 
 MODULE_AUTHOR("Lars-Peter Clausen <lars@metafoo.de>");
-MODULE_DESCRIPTION("Analog Devices AD5024/25/44/45/64/64-1/65 DAC");
+MODULE_DESCRIPTION("Analog Devices AD5024/25/44/45/64/64-1/65, AD5628/48/68 DAC");
 MODULE_LICENSE("GPL v2");
-- 
1.7.9

