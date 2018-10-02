Return-Path: <SRS0=8j9Q=MO=analog.com=alexandru.Ardelean@kernel.org>
From: Alexandru Ardelean <alexandru.ardelean@analog.com>
To: <linux-iio@vger.kernel.org>, <Michael.Hennerich@analog.com>
CC: <jic23@kernel.org>, <lars@metafoo.de>, <pmeerw@pmeerw.net>,
	<knaack.h@gmx.de>, Paul Cercueil <paul.cercueil@analog.com>, "Michael
 Hennerich" <michael.hennerich@analog.com>, Alexandru Ardelean
	<alexandru.ardelean@analog.com>
Subject: [PATCH] iio: amplifiers: ad8366: Add support for the ADA4961 DGA
Date: Tue, 2 Oct 2018 15:34:46 +0300
Message-ID: <20181002123446.27121-1-alexandru.ardelean@analog.com>
MIME-Version: 1.0
Content-Type: text/plain
List-ID: <linux-iio@vger.kernel.org>

From: Paul Cercueil <paul.cercueil@analog.com>

This change adds support for the ADA4961 BiCMOS RF Digital Gain Amplifier,
(DGA), which is optimized for driving heavy loads out 2.0 GHz and beyond.
The device typically achieves -90 dBc IMD3 performance at 500 MHz and
-85  dBc at 1.5 GHz.

Datasheet link:
 http://www.analog.com/media/en/technical-documentation/data-sheets/ADA4961.pdf

This change re-uses the existing ad8366 driver, as most logic is similar.

Signed-off-by: Paul Cercueil <paul.cercueil@analog.com>
Signed-off-by: Michael Hennerich <michael.hennerich@analog.com>
Signed-off-by: Alexandru Ardelean <alexandru.ardelean@analog.com>
---
 drivers/iio/amplifiers/Kconfig  |   9 ++-
 drivers/iio/amplifiers/ad8366.c | 100 +++++++++++++++++++++++++-------
 2 files changed, 84 insertions(+), 25 deletions(-)

diff --git a/drivers/iio/amplifiers/Kconfig b/drivers/iio/amplifiers/Kconfig
index e9c5f2cd9257..db7ebf3effc8 100644
--- a/drivers/iio/amplifiers/Kconfig
+++ b/drivers/iio/amplifiers/Kconfig
@@ -6,12 +6,15 @@
 menu "Amplifiers"
 
 config AD8366
-	tristate "Analog Devices AD8366 VGA"
+	tristate "Analog Devices AD8366 and similar SPI Gain Amplifiers"
 	depends on SPI
 	select BITREVERSE
 	help
-	  Say yes here to build support for Analog Devices AD8366
-	  SPI Dual-Digital Variable Gain Amplifier (VGA).
+	  Say yes here to build support for Analog Devices AD8366 and similar
+	  gain amplifiers. This driver supports the following gain amplifiers
+	  from Analog Devices:
+	    AD8366 SPI Dual-Digital Variable Gain Amplifier (VGA)
+	    ADA4961 SPI BiCMOS RF Digital Gain Amplifier (DGA)
 
 	  To compile this driver as a module, choose M here: the
 	  module will be called ad8366.
diff --git a/drivers/iio/amplifiers/ad8366.c b/drivers/iio/amplifiers/ad8366.c
index 4b76b61ba4be..04396c23e067 100644
--- a/drivers/iio/amplifiers/ad8366.c
+++ b/drivers/iio/amplifiers/ad8366.c
@@ -1,7 +1,10 @@
 /*
- * AD8366 SPI Dual-Digital Variable Gain Amplifier (VGA)
+ * AD8366 and similar SPI Gain Amplifiers
+ * This driver supports the following gain amplifiers:
+ *   AD8366 SPI Dual-Digital Variable Gain Amplifier (VGA)
+ *   ADA4961 SPI BiCMOS RF Digital Gain Amplifier (DGA)
  *
- * Copyright 2012 Analog Devices Inc.
+ * Copyright 2012-2018 Analog Devices Inc.
  *
  * Licensed under the GPL-2.
  */
@@ -19,10 +22,17 @@
 #include <linux/iio/iio.h>
 #include <linux/iio/sysfs.h>
 
+enum ad8366_type {
+	ID_AD8366,
+	ID_ADA4961,
+};
+
 struct ad8366_state {
 	struct spi_device	*spi;
 	struct regulator	*reg;
 	unsigned char		ch[2];
+	enum ad8366_type	type;
+
 	/*
 	 * DMA (thus cache coherency maintenance) requires the
 	 * transfer buffers to live in their own cache lines.
@@ -36,13 +46,20 @@ static int ad8366_write(struct iio_dev *indio_dev,
 	struct ad8366_state *st = iio_priv(indio_dev);
 	int ret;
 
-	ch_a = bitrev8(ch_a & 0x3F);
-	ch_b = bitrev8(ch_b & 0x3F);
+	switch (st->type) {
+	case ID_AD8366:
+		ch_a = bitrev8(ch_a & 0x3F);
+		ch_b = bitrev8(ch_b & 0x3F);
 
-	st->data[0] = ch_b >> 4;
-	st->data[1] = (ch_b << 4) | (ch_a >> 2);
+		st->data[0] = ch_b >> 4;
+		st->data[1] = (ch_b << 4) | (ch_a >> 2);
+		break;
+	case ID_ADA4961:
+		st->data[0] = ch_a & 0x1F;
+		break;
+	}
 
-	ret = spi_write(st->spi, st->data, ARRAY_SIZE(st->data));
+	ret = spi_write(st->spi, st->data, indio_dev->num_channels);
 	if (ret < 0)
 		dev_err(&indio_dev->dev, "write failed (%d)", ret);
 
@@ -57,15 +74,23 @@ static int ad8366_read_raw(struct iio_dev *indio_dev,
 {
 	struct ad8366_state *st = iio_priv(indio_dev);
 	int ret;
-	unsigned code;
+	int code;
 
 	mutex_lock(&indio_dev->mlock);
 	switch (m) {
 	case IIO_CHAN_INFO_HARDWAREGAIN:
 		code = st->ch[chan->channel];
 
+		switch (st->type) {
+		case ID_AD8366:
+			code = code * 253 + 4500;
+			break;
+		case ID_ADA4961:
+			code = 15000 - code * 1000;
+			break;
+		}
+
 		/* Values in dB */
-		code = code * 253 + 4500;
 		*val = code / 1000;
 		*val2 = (code % 1000) * 1000;
 
@@ -86,19 +111,24 @@ static int ad8366_write_raw(struct iio_dev *indio_dev,
 			    long mask)
 {
 	struct ad8366_state *st = iio_priv(indio_dev);
-	unsigned code;
+	int code;
 	int ret;
 
-	if (val < 0 || val2 < 0)
-		return -EINVAL;
-
 	/* Values in dB */
-	code = (((u8)val * 1000) + ((u32)val2 / 1000));
+	code = (((s8)val * 1000) + ((s32)val2 / 1000));
 
-	if (code > 20500 || code < 4500)
-		return -EINVAL;
-
-	code = (code - 4500) / 253;
+	switch (st->type) {
+	case ID_AD8366:
+		if (code > 20500 || code < 4500)
+			return -EINVAL;
+		code = (code - 4500) / 253;
+		break;
+	case ID_ADA4961:
+		if (code > 15000 || code < -6000)
+			return -EINVAL;
+		code = (15000 - code) / 1000;
+		break;
+	}
 
 	mutex_lock(&indio_dev->mlock);
 	switch (mask) {
@@ -132,6 +162,10 @@ static const struct iio_chan_spec ad8366_channels[] = {
 	AD8366_CHAN(1),
 };
 
+static const struct iio_chan_spec ada4961_channels[] = {
+	AD8366_CHAN(0),
+};
+
 static int ad8366_probe(struct spi_device *spi)
 {
 	struct iio_dev *indio_dev;
@@ -155,11 +189,32 @@ static int ad8366_probe(struct spi_device *spi)
 	st->spi = spi;
 
 	indio_dev->dev.parent = &spi->dev;
-	indio_dev->name = spi_get_device_id(spi)->name;
+
+	/* try to get a unique name */
+	if (spi->dev.platform_data)
+		indio_dev->name = spi->dev.platform_data;
+	else if (spi->dev.of_node)
+		indio_dev->name = spi->dev.of_node->name;
+	else
+		indio_dev->name = spi_get_device_id(spi)->name;
+
+	st->type = spi_get_device_id(spi)->driver_data;
+	switch (st->type) {
+	case ID_AD8366:
+		indio_dev->channels = ad8366_channels;
+		indio_dev->num_channels = ARRAY_SIZE(ad8366_channels);
+		break;
+	case ID_ADA4961:
+		indio_dev->channels = ada4961_channels;
+		indio_dev->num_channels = ARRAY_SIZE(ada4961_channels);
+		break;
+	default:
+		dev_err(&spi->dev, "Invalid device ID\n");
+		return -EINVAL;
+	}
+
 	indio_dev->info = &ad8366_info;
 	indio_dev->modes = INDIO_DIRECT_MODE;
-	indio_dev->channels = ad8366_channels;
-	indio_dev->num_channels = ARRAY_SIZE(ad8366_channels);
 
 	ret = ad8366_write(indio_dev, 0 , 0);
 	if (ret < 0)
@@ -193,7 +248,8 @@ static int ad8366_remove(struct spi_device *spi)
 }
 
 static const struct spi_device_id ad8366_id[] = {
-	{"ad8366", 0},
+	{"ad8366", ID_AD8366},
+	{"ada4961", ID_ADA4961},
 	{}
 };
 MODULE_DEVICE_TABLE(spi, ad8366_id);
-- 
2.17.1
