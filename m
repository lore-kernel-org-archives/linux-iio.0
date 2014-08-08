Return-Path: <linux-iio-owner@vger.kernel.org>
Received: from dmz4.rosetechnology.dk ([5.206.196.244]:33538 "EHLO
	dmz4.rosetechnology.dk" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1755391AbaHHI7L (ORCPT
	<rfc822;linux-iio@vger.kernel.org>); Fri, 8 Aug 2014 04:59:11 -0400
Message-ID: <1407488350.6599.6.camel@sanws1.rosetechnology.dk>
Subject: [patch v2 2/3] iio: adc: mcp320x. Add support for more ADCs
From: =?ISO-8859-1?Q?S=F8ren?= Andersen <san@rosetechnology.dk>
To: jic23@kernel.org
Cc: linux-iio@vger.kernel.org
Date: Fri, 08 Aug 2014 10:59:10 +0200
Content-Type: text/plain; charset="UTF-8"
Mime-Version: 1.0
Sender: linux-iio-owner@vger.kernel.org
List-Id: linux-iio@vger.kernel.org

Signed-off-by: Soeren Andersen <san at rosetechnology.dk>
---
 drivers/iio/adc/mcp320x.c | 352
++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++-------------------------------------------
 1 file changed, 267 insertions(+), 85 deletions(-)

diff --git a/drivers/iio/adc/mcp320x.c b/drivers/iio/adc/mcp320x.c
index 28a086e..2871777 100644
--- a/drivers/iio/adc/mcp320x.c
+++ b/drivers/iio/adc/mcp320x.c
@@ -1,9 +1,22 @@
 /*
  * Copyright (C) 2013 Oskar Andero <oskar.andero@gmail.com>
+ * Copyright (C) 2014 Allan Bendorff Jensen <abj@rosetechnology.dk>
  *
- * Driver for Microchip Technology's MCP3204 and MCP3208 ADC chips.
+ * Driver for following ADC chips from Microchip Technology's:
+ * 10 Bit converter
+ * MCP3001
+ * MCP3002
+ * MCP3004
+ * MCP3008
+ * ------------
+ * 12 bit converter
+ * MCP3201
+ * MCP3202
+ * MCP3204
+ * MCP3208
+ * ------------
  * Datasheet can be found here:
- * http://ww1.microchip.com/downloads/en/devicedoc/21298c.pdf
+ * http://www.microchip.com/
  *
  * This program is free software; you can redistribute it and/or modify
  * it under the terms of the GNU General Public License version 2 as
@@ -16,10 +29,17 @@
 #include <linux/iio/iio.h>
 #include <linux/regulator/consumer.h>
 
-#define MCP_SINGLE_ENDED	(1 << 3)
-#define MCP_START_BIT		(1 << 4)
+static int mcp320x_read_raw(struct iio_dev *indio_dev,
+			struct iio_chan_spec const *channel, int *val,
+			int *val2, long mask);
 
 enum {
+	mcp3001,
+	mcp3002,
+	mcp3004,
+	mcp3008,
+	mcp3201,
+	mcp3202,
 	mcp3204,
 	mcp3208,
 };
@@ -36,86 +56,37 @@ struct mcp320x {
 	struct mutex lock;
 };
 
-static int mcp320x_adc_conversion(struct mcp320x *adc, u8 msg)
-{
-	int ret;
-
-	adc->tx_buf = msg;
-	ret = spi_sync(adc->spi, &adc->msg);
-	if (ret < 0)
-		return ret;
-
-	return ((adc->rx_buf[0] & 0x3f) << 6)  |
-		(adc->rx_buf[1] >> 2);
-}
-
-static int mcp320x_read_raw(struct iio_dev *indio_dev,
-			    struct iio_chan_spec const *channel, int *val,
-			    int *val2, long mask)
-{
-	struct mcp320x *adc = iio_priv(indio_dev);
-	int ret = -EINVAL;
-
-	mutex_lock(&adc->lock);
-
-	switch (mask) {
-	case IIO_CHAN_INFO_RAW:
-		if (channel->differential)
-			ret = mcp320x_adc_conversion(adc,
-				MCP_START_BIT | channel->address);
-		else
-			ret = mcp320x_adc_conversion(adc,
-				MCP_START_BIT | MCP_SINGLE_ENDED |
-				channel->address);
-		if (ret < 0)
-			goto out;
-
-		*val = ret;
-		ret = IIO_VAL_INT;
-		break;
-
-	case IIO_CHAN_INFO_SCALE:
-		/* Digital output code = (4096 * Vin) / Vref */
-		ret = regulator_get_voltage(adc->reg);
-		if (ret < 0)
-			goto out;
-
-		*val = ret / 1000;
-		*val2 = 12;
-		ret = IIO_VAL_FRACTIONAL_LOG2;
-		break;
-
-	default:
-		break;
+#define MCP320X_VOLTAGE_CHANNEL(num)					\
+	{								\
+		.type = IIO_VOLTAGE,					\
+		.indexed = 1,						\
+		.channel = (num),					\
+		.address = (num),					\
+		.info_mask_separate = BIT(IIO_CHAN_INFO_RAW),		\
+		.info_mask_shared_by_type = BIT(IIO_CHAN_INFO_SCALE)	\
 	}
 
-out:
-	mutex_unlock(&adc->lock);
-
-	return ret;
-}
-
-#define MCP320X_VOLTAGE_CHANNEL(num)				\
-	{							\
-		.type = IIO_VOLTAGE,				\
-		.indexed = 1,					\
-		.channel = (num),				\
-		.address = (num),				\
-		.info_mask_separate = BIT(IIO_CHAN_INFO_RAW),	\
-		.info_mask_shared_by_type = BIT(IIO_CHAN_INFO_SCALE) \
+#define MCP320X_VOLTAGE_CHANNEL_DIFF(num)				\
+	{								\
+		.type = IIO_VOLTAGE,					\
+		.indexed = 1,						\
+		.channel = (num * 2),					\
+		.channel2 = (num * 2 + 1),				\
+		.address = (num * 2),					\
+		.differential = 1,					\
+		.info_mask_separate = BIT(IIO_CHAN_INFO_RAW),		\
+		.info_mask_shared_by_type = BIT(IIO_CHAN_INFO_SCALE)	\
 	}
 
-#define MCP320X_VOLTAGE_CHANNEL_DIFF(num)			\
-	{							\
-		.type = IIO_VOLTAGE,				\
-		.indexed = 1,					\
-		.channel = (num * 2),				\
-		.channel2 = (num * 2 + 1),			\
-		.address = (num * 2),				\
-		.differential = 1,				\
-		.info_mask_separate = BIT(IIO_CHAN_INFO_RAW),	\
-		.info_mask_shared_by_type = BIT(IIO_CHAN_INFO_SCALE) \
-	}
+static const struct iio_chan_spec mcp3201_channels[] = {
+	MCP320X_VOLTAGE_CHANNEL_DIFF(0),
+};
+
+static const struct iio_chan_spec mcp3202_channels[] = {
+	MCP320X_VOLTAGE_CHANNEL(0),
+	MCP320X_VOLTAGE_CHANNEL(1),
+	MCP320X_VOLTAGE_CHANNEL_DIFF(0),
+};
 
 static const struct iio_chan_spec mcp3204_channels[] = {
 	MCP320X_VOLTAGE_CHANNEL(0),
@@ -146,12 +117,37 @@ static const struct iio_info mcp320x_info = {
 	.driver_module = THIS_MODULE,
 };
 
-struct mcp3208_chip_info {
+struct mcp320x_chip_info {
 	const struct iio_chan_spec *channels;
 	unsigned int num_channels;
+	unsigned int resolution;
 };
 
-static const struct mcp3208_chip_info mcp3208_chip_infos[] = {
+static const struct mcp320x_chip_info mcp320x_chip_infos[] = {
+	[mcp3001] = {
+		.channels = mcp3201_channels,
+		.num_channels = ARRAY_SIZE(mcp3201_channels)
+	},
+	[mcp3002] = {
+		.channels = mcp3202_channels,
+		.num_channels = ARRAY_SIZE(mcp3202_channels)
+	},
+	[mcp3004] = {
+		.channels = mcp3204_channels,
+		.num_channels = ARRAY_SIZE(mcp3204_channels)
+	},
+	[mcp3008] = {
+		.channels = mcp3208_channels,
+		.num_channels = ARRAY_SIZE(mcp3208_channels)
+	},
+	[mcp3201] = {
+		.channels = mcp3201_channels,
+		.num_channels = ARRAY_SIZE(mcp3201_channels)
+	},
+	[mcp3202] = {
+		.channels = mcp3202_channels,
+		.num_channels = ARRAY_SIZE(mcp3202_channels)
+	},
 	[mcp3204] = {
 		.channels = mcp3204_channels,
 		.num_channels = ARRAY_SIZE(mcp3204_channels)
@@ -162,11 +158,159 @@ static const struct mcp3208_chip_info
mcp3208_chip_infos[] = {
 	},
 };
 
+static int channel_to_tx_data(const struct mcp320x_chip_info
*chip_info,
+			const unsigned int channel, bool differential)
+{
+	unsigned int tx_data = 0;
+
+	if (chip_info->num_channels - 1 == 2) {
+		tx_data = 0x12 | (differential ? 0 << 3 : 1 << 3) |
+				((channel & 0x01) << 2);
+	} else if (chip_info->num_channels - 2 == 4) {
+		tx_data = 0x20 | (differential ? 0 << 4 : 1 << 4) |
+				((channel & 0x03) << 1);
+	} else if (chip_info->num_channels - 4 == 8) {
+		tx_data = 0x20 | (differential ? 0 << 4 : 1 << 4) |
+				((channel & 0x07) << 1);
+	}
+
+	return tx_data;
+}
+
+static int mcp320x_adc_conversion(struct mcp320x *adc, u8 channel,
+			bool differential, int device_index)
+{
+	int ret;
+	u16 adc_value;
+	__be16 buf;
+
+	const struct mcp320x_chip_info *chip_info = NULL;
+
+	if (device_index == -1)
+		return -1;
+
+	chip_info = &mcp320x_chip_infos[device_index];
+	if (chip_info == NULL)
+		return -1;
+
+	adc->rx_buf[0] = 0;
+	adc->rx_buf[1] = 0;
+	adc->tx_buf = channel_to_tx_data(chip_info, channel, differential);
+
+	if (device_index != mcp3001 && device_index != mcp3201) {
+		ret = spi_sync(adc->spi, &adc->msg);
+		if (ret < 0)
+			return ret;
+	} else {
+		ret = spi_read(adc->spi, (u8 *)&buf, 2);
+		if (ret < 0)
+			return ret;
+	}
+
+	switch (device_index) {
+	case mcp3001:
+		adc_value = (be16_to_cpu(buf) >> 3);
+		break;
+	case mcp3002:
+		spi_sync(adc->spi, &adc->msg);
+		adc_value = adc->rx_buf[0];
+		adc_value = ((adc_value << 2) |
+			((adc->rx_buf[1] & 0xC0) >> 6)) & 0x03ff;
+		break;
+	case mcp3004:
+	case mcp3008:
+		adc_value = adc->rx_buf[0] & 0x7f;
+		adc_value = ((adc_value << 3) |
+			((adc->rx_buf[1] & 0xe0) >> 5)) & 0x03ff;
+		break;
+	case mcp3201:
+		adc_value = (be16_to_cpu(buf) >> 1);
+		break;
+	case mcp3202:
+		adc_value = adc->rx_buf[0];
+		adc_value = ((adc_value << 4) |
+			((adc->rx_buf[1] & 0xf0) >> 4)) & 0x0fff;
+		break;
+	case mcp3204:
+	case mcp3208:
+		adc_value = adc->rx_buf[0] & 0x7f;
+		adc_value = ((adc_value << 5) |
+			((adc->rx_buf[1] & 0xf8) >> 3)) & 0x0fff;
+		break;
+	default:
+		adc_value = 0;
+		break;
+	}
+
+	return adc_value;
+}
+
+static int mcp320x_read_raw(struct iio_dev *indio_dev,
+			struct iio_chan_spec const *channel, int *val,
+			int *val2, long mask)
+{
+	struct mcp320x *adc = iio_priv(indio_dev);
+	int ret = -EINVAL;
+	int device_index = 0;
+
+	mutex_lock(&adc->lock);
+
+	device_index = spi_get_device_id(adc->spi)->driver_data;
+
+	if (device_index == -1)
+		goto out;
+
+	switch (mask) {
+	case IIO_CHAN_INFO_RAW:
+		ret = mcp320x_adc_conversion(adc, channel->address,
+			channel->differential, device_index);
+
+		if (ret < 0)
+			goto out;
+
+		*val = ret;
+		ret = IIO_VAL_INT;
+		break;
+
+	case IIO_CHAN_INFO_SCALE:
+		/*
+		 * Digital output code = (resolution * Vin) / Vref
+		 * Get regulator output voltage in uV.
+		 */
+		ret = regulator_get_voltage(adc->reg);
+		if (ret < 0)
+			goto out;
+
+		/* convert regulator output voltage to mV */
+		*val  = ret / 1000;
+		*val2 = -1;
+		if (device_index == mcp3001 || device_index == mcp3002 ||
+			device_index == mcp3004 || device_index == mcp3008)
+			*val2 = 10;
+		else if (device_index == mcp3201 || device_index == mcp3202 ||
+			device_index == mcp3204 || device_index == mcp3208)
+			*val2 = 12;
+		else
+			goto out;
+
+		ret = IIO_VAL_FRACTIONAL_LOG2;
+		break;
+
+	default:
+		break;
+	}
+
+out:
+	mutex_unlock(&adc->lock);
+
+	return ret;
+}
+
 static int mcp320x_probe(struct spi_device *spi)
 {
 	struct iio_dev *indio_dev;
 	struct mcp320x *adc;
-	const struct mcp3208_chip_info *chip_info;
+	const struct mcp320x_chip_info *chip_info;
 	int ret;
 
 	indio_dev = devm_iio_device_alloc(&spi->dev, sizeof(*adc));
@@ -181,7 +325,7 @@ static int mcp320x_probe(struct spi_device *spi)
 	indio_dev->modes = INDIO_DIRECT_MODE;
 	indio_dev->info = &mcp320x_info;
 
-	chip_info = &mcp3208_chip_infos[spi_get_device_id(spi)->driver_data];
+	chip_info = &mcp320x_chip_infos[spi_get_device_id(spi)->driver_data];
 	indio_dev->channels = chip_info->channels;
 	indio_dev->num_channels = chip_info->num_channels;
 
@@ -226,7 +370,45 @@ static int mcp320x_remove(struct spi_device *spi)
 	return 0;
 }
 
+#if defined(CONFIG_OF)
+static const struct of_device_id mcp320x_dt_ids[] = {
+	{
+		.compatible = "mcp3001",
+		.data = &mcp320x_chip_infos[mcp3001],
+	}, {
+		.compatible = "mcp3002",
+		.data = &mcp320x_chip_infos[mcp3002],
+	}, {
+		.compatible = "mcp3004",
+		.data = &mcp320x_chip_infos[mcp3004],
+	}, {
+		.compatible = "mcp3008",
+		.data = &mcp320x_chip_infos[mcp3004],
+	}, {
+		.compatible = "mcp3201",
+		.data = &mcp320x_chip_infos[mcp3201],
+	}, {
+		.compatible = "mcp3202",
+		.data = &mcp320x_chip_infos[mcp3202],
+	}, {
+		.compatible = "mcp3204",
+		.data = &mcp320x_chip_infos[mcp3204],
+	}, {
+		.compatible = "mcp3008",
+		.data = &mcp320x_chip_infos[mcp3208],
+	}, {
+	}
+};
+MODULE_DEVICE_TABLE(of, mcp320x_dt_ids);
+#endif
+
 static const struct spi_device_id mcp320x_id[] = {
+	{ "mcp3001", mcp3001 },
+	{ "mcp3002", mcp3002 },
+	{ "mcp3004", mcp3004 },
+	{ "mcp3008", mcp3008 },
+	{ "mcp3201", mcp3201 },
+	{ "mcp3202", mcp3202 },
 	{ "mcp3204", mcp3204 },
 	{ "mcp3208", mcp3208 },
 	{ }
@@ -245,5 +427,5 @@ static struct spi_driver mcp320x_driver = {
 module_spi_driver(mcp320x_driver);
 
 MODULE_AUTHOR("Oskar Andero <oskar.andero@gmail.com>");
-MODULE_DESCRIPTION("Microchip Technology MCP3204/08");
+MODULE_DESCRIPTION("Microchip Technology MCP3x01/02/04/08");
 MODULE_LICENSE("GPL v2");


