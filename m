Return-Path: <SRS0=wbiz=B2=pmeerw.net=pmeerw@kernel.org>
From: Peter Meerwald-Stadler <pmeerw@pmeerw.net>
To: Jonathan Cameron <jic23@kernel.org>
Cc: linux-iio@vger.kernel.org,
	Peter Meerwald-Stadler <pmeerw@pmeerw.net>,
	Matt Ranostay <matt@ranostay.consulting>
Subject: [PATCH 12/13] iio: health: max30102: Add MAX30105 support
Date: Fri, 27 Oct 2017 21:29:52 +0200
Message-Id: <1509132593-1815-18-git-send-email-pmeerw@pmeerw.net>
In-Reply-To: <1509132593-1815-1-git-send-email-pmeerw@pmeerw.net>
References: <1509132593-1815-1-git-send-email-pmeerw@pmeerw.net>
List-ID: <linux-iio@vger.kernel.org>

The Maxim MAX30105 part adds a third LED (green) and uses a multi-LED
measuring mode producing three measurements

Signed-off-by: Peter Meerwald-Stadler <pmeerw@pmeerw.net>
Cc: Matt Ranostay <matt@ranostay.consulting>
---
 drivers/iio/health/max30102.c | 144 ++++++++++++++++++++++++++++++++++++++----
 1 file changed, 130 insertions(+), 14 deletions(-)

diff --git a/drivers/iio/health/max30102.c b/drivers/iio/health/max30102.c
index 86058f0..15ccadc 100644
--- a/drivers/iio/health/max30102.c
+++ b/drivers/iio/health/max30102.c
@@ -3,6 +3,9 @@
  *
  * Copyright (C) 2017 Matt Ranostay <matt@ranostay.consulting>
  *
+ * Support for MAX30105 optical particle sensor
+ * Copyright (C) 2017 Peter Meerwald-Stadler <pmeerw@pmeerw.net>
+ *
  * This program is free software; you can redistribute it and/or modify
  * it under the terms of the GNU General Public License as published by
  * the Free Software Foundation; either version 2 of the License, or
@@ -13,6 +16,7 @@
  * MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE. See the
  * GNU General Public License for more details.
  *
+ * 7-bit I2C chip address: 0x57
  * TODO: proximity power saving feature
  */
 
@@ -34,9 +38,15 @@
 #define MAX30102_DRV_NAME	"max30102"
 #define MAX30102_PART_NUMBER	0x15
 
+enum max30102_chip_id {
+	max30102,
+	max30105,
+};
+
 enum max3012_led_idx {
 	MAX30102_LED_RED,
 	MAX30102_LED_IR,
+	MAX30105_LED_GREEN,
 };
 
 #define MAX30102_REG_INT_STATUS			0x00
@@ -73,6 +83,11 @@ enum max3012_led_idx {
 #define MAX30102_REG_MODE_CONFIG_MODE_MASK	GENMASK(2, 0)
 #define MAX30102_REG_MODE_CONFIG_PWR		BIT(7)
 
+#define MAX30102_REG_MODE_CONTROL_SLOT21	0x11 /* multi-LED control */
+#define MAX30102_REG_MODE_CONTROL_SLOT43	0x12
+#define MAX30102_REG_MODE_CONTROL_SLOT_MASK	(GENMASK(6, 4) | GENMASK(2, 0))
+#define MAX30102_REG_MODE_CONTROL_SLOT_SHIFT	4
+
 #define MAX30102_REG_SPO2_CONFIG		0x0a
 #define MAX30102_REG_SPO2_CONFIG_PULSE_411_US	0x03
 #define MAX30102_REG_SPO2_CONFIG_SR_400HZ	0x03
@@ -83,6 +98,7 @@ enum max3012_led_idx {
 
 #define MAX30102_REG_RED_LED_CONFIG		0x0c
 #define MAX30102_REG_IR_LED_CONFIG		0x0d
+#define MAX30105_REG_GREEN_LED_CONFIG		0x0e
 
 #define MAX30102_REG_TEMP_CONFIG		0x21
 #define MAX30102_REG_TEMP_CONFIG_TEMP_EN	BIT(0)
@@ -98,9 +114,10 @@ struct max30102_data {
 	struct iio_dev *indio_dev;
 	struct mutex lock;
 	struct regmap *regmap;
+	enum max30102_chip_id chip_id;
 
-	u8 buffer[8];
-	__be32 processed_buffer[2]; /* 2 x 18-bit (padded to 32-bits) */
+	u8 buffer[12];
+	__be32 processed_buffer[3]; /* 3 x 18-bit (padded to 32-bits) */
 };
 
 static const struct regmap_config max30102_regmap_config = {
@@ -115,6 +132,13 @@ static const unsigned long max30102_scan_masks[] = {
 	0
 };
 
+static const unsigned long max30105_scan_masks[] = {
+	BIT(MAX30102_LED_RED) | BIT(MAX30102_LED_IR),
+	BIT(MAX30102_LED_RED) | BIT(MAX30102_LED_IR) |
+		BIT(MAX30105_LED_GREEN),
+	0
+};
+
 #define MAX30102_INTENSITY_CHANNEL(_si, _mod) { \
 		.type = IIO_INTENSITY, \
 		.channel2 = _mod, \
@@ -140,6 +164,18 @@ static const struct iio_chan_spec max30102_channels[] = {
 	},
 };
 
+static const struct iio_chan_spec max30105_channels[] = {
+	MAX30102_INTENSITY_CHANNEL(MAX30102_LED_RED, IIO_MOD_LIGHT_RED),
+	MAX30102_INTENSITY_CHANNEL(MAX30102_LED_IR, IIO_MOD_LIGHT_IR),
+	MAX30102_INTENSITY_CHANNEL(MAX30105_LED_GREEN, IIO_MOD_LIGHT_GREEN),
+	{
+		.type = IIO_TEMP,
+		.info_mask_separate =
+			BIT(IIO_CHAN_INFO_RAW) | BIT(IIO_CHAN_INFO_SCALE),
+		.scan_index = -1,
+	},
+};
+
 static int max30102_set_power(struct max30102_data *data, bool en)
 {
 	return regmap_update_bits(data->regmap, MAX30102_REG_MODE_CONFIG,
@@ -159,12 +195,40 @@ static int max30102_set_powermode(struct max30102_data *data, u8 mode, bool en)
 				  MAX30102_REG_MODE_CONFIG_MODE_MASK, reg);
 }
 
+#define MAX30102_MODE_CONTROL_LED_SLOTS(slot2, slot1) \
+	((slot2 << MAX30102_REG_MODE_CONTROL_SLOT_SHIFT) | slot1)
+
 static int max30102_buffer_postenable(struct iio_dev *indio_dev)
 {
 	struct max30102_data *data = iio_priv(indio_dev);
+	int ret;
 	u8 reg;
 
-	reg = MAX30102_REG_MODE_CONFIG_MODE_HR_SPO2;
+	switch (*indio_dev->active_scan_mask) {
+	case BIT(MAX30102_LED_RED) | BIT(MAX30102_LED_IR):
+		reg = MAX30102_REG_MODE_CONFIG_MODE_HR_SPO2;
+		break;
+	case BIT(MAX30102_LED_RED) | BIT(MAX30102_LED_IR) |
+	     BIT(MAX30105_LED_GREEN):
+		ret = regmap_update_bits(data->regmap,
+					 MAX30102_REG_MODE_CONTROL_SLOT21,
+					 MAX30102_REG_MODE_CONTROL_SLOT_MASK,
+					 MAX30102_MODE_CONTROL_LED_SLOTS(2, 1));
+		if (ret)
+			return ret;
+
+		ret = regmap_update_bits(data->regmap,
+					 MAX30102_REG_MODE_CONTROL_SLOT43,
+					 MAX30102_REG_MODE_CONTROL_SLOT_MASK,
+					 MAX30102_MODE_CONTROL_LED_SLOTS(0, 3));
+		if (ret)
+			return ret;
+
+		reg = MAX30102_REG_MODE_CONFIG_MODE_MULTI;
+		break;
+	default:
+		return -EINVAL;
+	}
 
 	return max30102_set_powermode(data, reg, true);
 }
@@ -203,32 +267,46 @@ static inline int max30102_fifo_count(struct max30102_data *data)
 	       &buffer[(i) * MAX30102_REG_FIFO_DATA_BYTES], \
 	       MAX30102_REG_FIFO_DATA_BYTES)
 
-static int max30102_read_measurement(struct max30102_data *data)
+static int max30102_read_measurement(struct max30102_data *data,
+				     unsigned int measurements)
 {
 	int ret;
 	u8 *buffer = (u8 *) &data->buffer;
 
 	ret = i2c_smbus_read_i2c_block_data(data->client,
 					    MAX30102_REG_FIFO_DATA,
-					    2 * MAX30102_REG_FIFO_DATA_BYTES,
+					    measurements *
+					    MAX30102_REG_FIFO_DATA_BYTES,
 					    buffer);
 
-	MAX30102_COPY_DATA(0);
-	MAX30102_COPY_DATA(1);
+	switch (measurements) {
+	case 3:
+		MAX30102_COPY_DATA(2);
+	case 2: /* fall-through */
+		MAX30102_COPY_DATA(1);
+	case 1: /* fall-through */
+		MAX30102_COPY_DATA(0);
+		break;
+	default:
+		return -EINVAL;
+	}
 
-	return (ret == 2 * MAX30102_REG_FIFO_DATA_BYTES) ? 0 : -EINVAL;
+	return (ret == measurements * MAX30102_REG_FIFO_DATA_BYTES) ?
+	       0 : -EINVAL;
 }
 
 static irqreturn_t max30102_interrupt_handler(int irq, void *private)
 {
 	struct iio_dev *indio_dev = private;
 	struct max30102_data *data = iio_priv(indio_dev);
+	unsigned int measurements = bitmap_weight(indio_dev->active_scan_mask,
+						  indio_dev->masklength);
 	int ret, cnt = 0;
 
 	mutex_lock(&data->lock);
 
 	while (cnt || (cnt = max30102_fifo_count(data)) > 0) {
-		ret = max30102_read_measurement(data);
+		ret = max30102_read_measurement(data, measurements);
 		if (ret)
 			break;
 
@@ -274,6 +352,29 @@ static int max30102_led_init(struct max30102_data *data)
 	if (ret)
 		return ret;
 
+	if (data->chip_id == max30105) {
+		ret = of_property_read_u32(np,
+			"maxim,green-led-current-microamp", &val);
+		if (ret) {
+			dev_info(dev, "no green-led-current-microamp set\n");
+
+			/* Default to 7 mA green LED */
+			val = 7000;
+		}
+
+		ret = max30102_get_current_idx(val, &reg);
+		if (ret) {
+			dev_err(dev, "invalid green LED current setting %d\n",
+				val);
+			return ret;
+		}
+
+		ret = regmap_write(data->regmap, MAX30105_REG_GREEN_LED_CONFIG,
+				   reg);
+		if (ret)
+			return ret;
+	}
+
 	ret = of_property_read_u32(np, "maxim,ir-led-current-microamp", &val);
 	if (ret) {
 		dev_info(dev, "no ir-led-current-microamp set\n");
@@ -429,10 +530,7 @@ static int max30102_probe(struct i2c_client *client,
 	iio_device_attach_buffer(indio_dev, buffer);
 
 	indio_dev->name = MAX30102_DRV_NAME;
-	indio_dev->channels = max30102_channels;
 	indio_dev->info = &max30102_info;
-	indio_dev->num_channels = ARRAY_SIZE(max30102_channels);
-	indio_dev->available_scan_masks = max30102_scan_masks;
 	indio_dev->modes = (INDIO_BUFFER_SOFTWARE | INDIO_DIRECT_MODE);
 	indio_dev->setup_ops = &max30102_buffer_setup_ops;
 	indio_dev->dev.parent = &client->dev;
@@ -440,10 +538,26 @@ static int max30102_probe(struct i2c_client *client,
 	data = iio_priv(indio_dev);
 	data->indio_dev = indio_dev;
 	data->client = client;
+	data->chip_id = id->driver_data;
 
 	mutex_init(&data->lock);
 	i2c_set_clientdata(client, indio_dev);
 
+	switch (data->chip_id) {
+	case max30105:
+		indio_dev->channels = max30105_channels;
+		indio_dev->num_channels = ARRAY_SIZE(max30105_channels);
+		indio_dev->available_scan_masks = max30105_scan_masks;
+		break;
+	case max30102:
+		indio_dev->channels = max30102_channels;
+		indio_dev->num_channels = ARRAY_SIZE(max30102_channels);
+		indio_dev->available_scan_masks = max30102_scan_masks;
+		break;
+	default:
+		return -ENODEV;
+	}
+
 	data->regmap = devm_regmap_init_i2c(client, &max30102_regmap_config);
 	if (IS_ERR(data->regmap)) {
 		dev_err(&client->dev, "regmap initialization failed\n");
@@ -502,13 +616,15 @@ static int max30102_remove(struct i2c_client *client)
 }
 
 static const struct i2c_device_id max30102_id[] = {
-	{ "max30102", 0 },
+	{ "max30102", max30102 },
+	{ "max30105", max30105 },
 	{}
 };
 MODULE_DEVICE_TABLE(i2c, max30102_id);
 
 static const struct of_device_id max30102_dt_ids[] = {
 	{ .compatible = "maxim,max30102" },
+	{ .compatible = "maxim,max30105" },
 	{ }
 };
 MODULE_DEVICE_TABLE(of, max30102_dt_ids);
@@ -525,5 +641,5 @@ static struct i2c_driver max30102_driver = {
 module_i2c_driver(max30102_driver);
 
 MODULE_AUTHOR("Matt Ranostay <matt@ranostay.consulting>");
-MODULE_DESCRIPTION("MAX30102 heart rate and pulse oximeter sensor");
+MODULE_DESCRIPTION("MAX30102 heart rate/pulse oximeter and MAX30105 particle sensor driver");
 MODULE_LICENSE("GPL");
-- 
2.7.4
