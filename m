Return-Path: <san@rosetechnology.dk>
Message-ID: <1409917484.12493.8.camel@sanws1.rosetechnology.dk>
Subject: [patch v3 2/3] iio: adc: mcp320x. Add support for more ADCs
From: =?ISO-8859-1?Q?S=F8ren?= Andersen <san@rosetechnology.dk>
To: jic23@kernel.org
Cc: linux-iio@vger.kernel.org
Date: Fri, 05 Sep 2014 13:44:44 +0200
Content-Type: text/plain; charset="UTF-8"
Mime-Version: 1.0
List-ID: <linux-iio@vger.kernel.org>

v3:
Functions moved around.
Return values is simpler.

Signed-off-by: Soeren Andersen <san at rosetechnology.dk>
---
drivers/iio/adc/mcp320x.c | 201
+++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++--------------------------
 1 file changed, 172 insertions(+), 29 deletions(-)

diff --git a/drivers/iio/adc/mcp320x.c b/drivers/iio/adc/mcp320x.c
index 28a086e..77ee363 100644
--- a/drivers/iio/adc/mcp320x.c
+++ b/drivers/iio/adc/mcp320x.c
@@ -1,9 +1,20 @@
 /*
  * Copyright (C) 2013 Oskar Andero <oskar.andero@gmail.com>
+ * Copyright (C) 2014 Allan Bendorff Jensen <abj@rosetechnology.dk>
  *
- * Driver for Microchip Technology's MCP3204 and MCP3208 ADC chips.
- * Datasheet can be found here:
- * http://ww1.microchip.com/downloads/en/devicedoc/21298c.pdf
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
  *
  * This program is free software; you can redistribute it and/or modify
  * it under the terms of the GNU General Public License version 2 as
@@ -16,10 +27,16 @@
 #include <linux/iio/iio.h>
 #include <linux/regulator/consumer.h>
 
-#define MCP_SINGLE_ENDED	(1 << 3)
-#define MCP_START_BIT		(1 << 4)
+static int mcp320x_channel_to_tx_data(int device_index,
+				const unsigned int channel, bool differential);
 
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
@@ -36,17 +53,48 @@ struct mcp320x {
 	struct mutex lock;
 };
 
-static int mcp320x_adc_conversion(struct mcp320x *adc, u8 msg)
+static int mcp320x_adc_conversion(struct mcp320x *adc, u8 channel,
+					bool differential, int device_index)
 {
 	int ret;
+	__be16 buf;
 
-	adc->tx_buf = msg;
-	ret = spi_sync(adc->spi, &adc->msg);
-	if (ret < 0)
-		return ret;
+	adc->rx_buf[0] = 0;
+	adc->rx_buf[1] = 0;
+	adc->tx_buf = mcp320x_channel_to_tx_data(device_index,
+						channel, differential);
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
 
-	return ((adc->rx_buf[0] & 0x3f) << 6)  |
-		(adc->rx_buf[1] >> 2);
+	switch (device_index) {
+	case mcp3001:
+		return ((be16_to_cpu(buf) >> 3) & 0x03ff);
+	case mcp3002:
+		return (((adc->rx_buf[0] << 2) |
+				((adc->rx_buf[1] & 0xC0) >> 6)) & 0x03ff);
+	case mcp3004:
+	case mcp3008:
+		return ((((adc->rx_buf[0] & 0x7f) << 3) |
+				((adc->rx_buf[1] & 0xe0) >> 5)) & 0x03ff);
+	case mcp3201:
+		return (be16_to_cpu(buf) >> 1);
+	case mcp3202:
+		return ((adc->rx_buf[0] << 4) | ((adc->rx_buf[1] & 0xf0) >> 4));
+	case mcp3204:
+	case mcp3208:
+		return (((adc->rx_buf[0] & 0x7f) << 5) |
+				((adc->rx_buf[1] & 0xf8) >> 3));
+	default:
+		return -EINVAL;
+	}
 }
 
 static int mcp320x_read_raw(struct iio_dev *indio_dev,
@@ -55,18 +103,17 @@ static int mcp320x_read_raw(struct iio_dev
*indio_dev,
 {
 	struct mcp320x *adc = iio_priv(indio_dev);
 	int ret = -EINVAL;
+	int device_index = 0;
 
 	mutex_lock(&adc->lock);
 
+	device_index = spi_get_device_id(adc->spi)->driver_data;
+
 	switch (mask) {
 	case IIO_CHAN_INFO_RAW:
-		if (channel->differential)
-			ret = mcp320x_adc_conversion(adc,
-				MCP_START_BIT | channel->address);
-		else
-			ret = mcp320x_adc_conversion(adc,
-				MCP_START_BIT | MCP_SINGLE_ENDED |
-				channel->address);
+		ret = mcp320x_adc_conversion(adc, channel->address,
+			channel->differential, device_index);
+
 		if (ret < 0)
 			goto out;
 
@@ -75,17 +122,23 @@ static int mcp320x_read_raw(struct iio_dev
*indio_dev,
 		break;
 
 	case IIO_CHAN_INFO_SCALE:
-		/* Digital output code = (4096 * Vin) / Vref */
+		/*
+		 * Digital output code = (resolution * Vin) / Vref
+		 * Get regulator output voltage in uV.
+		 */
 		ret = regulator_get_voltage(adc->reg);
 		if (ret < 0)
 			goto out;
 
+		/* convert regulator output voltage to mV */
 		*val = ret / 1000;
-		*val2 = 12;
-		ret = IIO_VAL_FRACTIONAL_LOG2;
-		break;
+		if (device_index == mcp3001 || device_index == mcp3002 ||
+			device_index == mcp3004 || device_index == mcp3008)
+			*val2 = 10;
+		else
+			*val2 = 12;
 
-	default:
+		ret = IIO_VAL_FRACTIONAL_LOG2;
 		break;
 	}
 
@@ -117,6 +170,16 @@ out:
 		.info_mask_shared_by_type = BIT(IIO_CHAN_INFO_SCALE) \
 	}
 
+static const struct iio_chan_spec mcp3201_channels[] = {
+	MCP320X_VOLTAGE_CHANNEL_DIFF(0),
+};
+
+static const struct iio_chan_spec mcp3202_channels[] = {
+	MCP320X_VOLTAGE_CHANNEL(0),
+	MCP320X_VOLTAGE_CHANNEL(1),
+	MCP320X_VOLTAGE_CHANNEL_DIFF(0),
+};
+
 static const struct iio_chan_spec mcp3204_channels[] = {
 	MCP320X_VOLTAGE_CHANNEL(0),
 	MCP320X_VOLTAGE_CHANNEL(1),
@@ -146,12 +209,36 @@ static const struct iio_info mcp320x_info = {
 	.driver_module = THIS_MODULE,
 };
 
-struct mcp3208_chip_info {
+struct mcp320x_chip_info {
 	const struct iio_chan_spec *channels;
 	unsigned int num_channels;
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
@@ -162,11 +249,29 @@ static const struct mcp3208_chip_info
mcp3208_chip_infos[] = {
 	},
 };
 
+static int mcp320x_channel_to_tx_data(int device_index,
+				const unsigned int channel, bool differential)
+{
+	switch (device_index) {
+	case mcp3002:
+	case mcp3202:
+		return(0x12 | (!differential << 3) | ((channel & 0x01) << 2));
+	case mcp3004:
+	case mcp3204:
+		return(0x20 | (!differential << 4) | ((channel & 0x03) << 1));
+	case mcp3008:
+	case mcp3208:
+		return(0x20 | (!differential << 4) | ((channel & 0x07) << 1));
+	default:
+		return -EINVAL;
+	}
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
@@ -181,7 +286,7 @@ static int mcp320x_probe(struct spi_device *spi)
 	indio_dev->modes = INDIO_DIRECT_MODE;
 	indio_dev->info = &mcp320x_info;
 
-	chip_info = &mcp3208_chip_infos[spi_get_device_id(spi)->driver_data];
+	chip_info = &mcp320x_chip_infos[spi_get_device_id(spi)->driver_data];
 	indio_dev->channels = chip_info->channels;
 	indio_dev->num_channels = chip_info->num_channels;
 
@@ -226,7 +331,45 @@ static int mcp320x_remove(struct spi_device *spi)
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
@@ -245,5 +388,5 @@ static struct spi_driver mcp320x_driver = {
 module_spi_driver(mcp320x_driver);
 
 MODULE_AUTHOR("Oskar Andero <oskar.andero@gmail.com>");
-MODULE_DESCRIPTION("Microchip Technology MCP3204/08");
+MODULE_DESCRIPTION("Microchip Technology MCP3x01/02/04/08");
 MODULE_LICENSE("GPL v2");
