Return-Path: <jic23@cam.ac.uk>
From: Jonathan Cameron <jic23@cam.ac.uk>
To: linux-iio@vger.kernel.org
Cc: Michael Hennerich <michael.hennerich@analog.com>,
	Jonathan Cameron <jic23@cam.ac.uk>
Subject: [PATCH 08/16] staging:iio:adc:ad7152: increase readability by introducing proper bit defines
Date: Fri, 26 Aug 2011 11:19:25 +0100
Message-Id: <1314353973-7662-9-git-send-email-jic23@cam.ac.uk>
In-Reply-To: <1314353973-7662-1-git-send-email-jic23@cam.ac.uk>
References: <1314353973-7662-1-git-send-email-jic23@cam.ac.uk>
List-ID: <linux-iio@vger.kernel.org>

From: Michael Hennerich <michael.hennerich@analog.com>

Some other miscellaneous cleanup.

Signed-off-by: Michael Hennerich <michael.hennerich@analog.com>
Signed-off-by: Jonathan Cameron <jic23@cam.ac.uk>
---
 drivers/staging/iio/adc/ad7152.c |  133 +++++++++++++++++++++++--------------
 1 files changed, 83 insertions(+), 50 deletions(-)

diff --git a/drivers/staging/iio/adc/ad7152.c b/drivers/staging/iio/adc/ad7152.c
index debcea5..b0db745 100644
--- a/drivers/staging/iio/adc/ad7152.c
+++ b/drivers/staging/iio/adc/ad7152.c
@@ -1,7 +1,7 @@
 /*
  * AD7152 capacitive sensor driver supporting AD7152/3
  *
- * Copyright 2010 Analog Devices Inc.
+ * Copyright 2010-2011a Analog Devices Inc.
  *
  * Licensed under the GPL-2 or later.
  */
@@ -24,24 +24,55 @@
  * AD7152 registers definition
  */
 
-#define AD7152_STATUS              0
-#define AD7152_STATUS_RDY1         (1 << 0)
-#define AD7152_STATUS_RDY2         (1 << 1)
-#define AD7152_CH1_DATA_HIGH       1
-#define AD7152_CH2_DATA_HIGH       3
-#define AD7152_CH1_OFFS_HIGH       5
-#define AD7152_CH2_OFFS_HIGH       7
-#define AD7152_CH1_GAIN_HIGH       9
-#define AD7152_CH1_SETUP           11
-#define AD7152_CH2_GAIN_HIGH       12
-#define AD7152_CH2_SETUP           14
-#define AD7152_CFG                 15
-#define AD7152_RESEVERD            16
-#define AD7152_CAPDAC_POS          17
-#define AD7152_CAPDAC_NEG          18
-#define AD7152_CFG2                26
-
-#define AD7152_MAX_CONV_MODE       6
+#define AD7152_REG_STATUS		0
+#define AD7152_REG_CH1_DATA_HIGH	1
+#define AD7152_REG_CH2_DATA_HIGH	3
+#define AD7152_REG_CH1_OFFS_HIGH	5
+#define AD7152_REG_CH2_OFFS_HIGH	7
+#define AD7152_REG_CH1_GAIN_HIGH	9
+#define AD7152_REG_CH1_SETUP		11
+#define AD7152_REG_CH2_GAIN_HIGH	12
+#define AD7152_REG_CH2_SETUP		14
+#define AD7152_REG_CFG			15
+#define AD7152_REG_RESEVERD		16
+#define AD7152_REG_CAPDAC_POS		17
+#define AD7152_REG_CAPDAC_NEG		18
+#define AD7152_REG_CFG2			26
+
+/* Status Register Bit Designations (AD7152_REG_STATUS) */
+#define AD7152_STATUS_RDY1		(1 << 0)
+#define AD7152_STATUS_RDY2		(1 << 1)
+#define AD7152_STATUS_C1C2		(1 << 2)
+#define AD7152_STATUS_PWDN		(1 << 7)
+
+/* Setup Register Bit Designations (AD7152_REG_CHx_SETUP) */
+#define AD7152_SETUP_CAPDIFF		(1 << 5)
+#define AD7152_SETUP_RANGE_2pF		(0 << 6)
+#define AD7152_SETUP_RANGE_0_5pF	(1 << 6)
+#define AD7152_SETUP_RANGE_1pF		(2 << 6)
+#define AD7152_SETUP_RANGE_4pF		(3 << 6)
+
+/* Config Register Bit Designations (AD7152_REG_CFG) */
+#define AD7152_CONF_CH2EN		(1 << 3)
+#define AD7152_CONF_CH1EN		(1 << 4)
+#define AD7152_CONF_MODE_IDLE		(0 << 0)
+#define AD7152_CONF_MODE_CONT_CONV	(1 << 0)
+#define AD7152_CONF_MODE_SINGLE_CONV	(2 << 0)
+#define AD7152_CONF_MODE_OFFS_CAL	(5 << 0)
+#define AD7152_CONF_MODE_GAIN_CAL	(6 << 0)
+
+/* Capdac Register Bit Designations (AD7152_REG_CAPDAC_XXX) */
+#define AD7152_CAPDAC_DACEN		(1 << 7)
+#define AD7152_CAPDAC_DACP(x)		((x) & 0x1F)
+
+#define AD7152_MAX_CONV_MODE		6
+
+enum {
+	AD7152_DATA,
+	AD7152_OFFS,
+	AD7152_GAIN,
+	AD7152_SETUP
+};
 
 /*
  * struct ad7152_chip_info - chip specifc information
@@ -76,11 +107,11 @@ static inline ssize_t ad7152_start_calib(struct device *dev,
 		return 0;
 
 	if (this_attr->address == 0)
-		regval |= (1 << 4);
+		regval |= AD7152_CONF_CH1EN;
 	else
-		regval |= (1 << 3);
+		regval |= AD7152_CONF_CH2EN;
 
-	ret = i2c_smbus_write_byte_data(chip->client, AD7152_CFG, regval);
+	ret = i2c_smbus_write_byte_data(chip->client, AD7152_REG_CFG, regval);
 	if (ret < 0)
 		return ret;
 	/* Unclear on period this should be set for or whether it flips back
@@ -93,14 +124,16 @@ static ssize_t ad7152_start_offset_calib(struct device *dev,
 					 size_t len)
 {
 
-	return ad7152_start_calib(dev, attr, buf, len, 5);
+	return ad7152_start_calib(dev, attr, buf, len,
+				  AD7152_CONF_MODE_OFFS_CAL);
 }
 static ssize_t ad7152_start_gain_calib(struct device *dev,
 				       struct device_attribute *attr,
 				       const char *buf,
 				       size_t len)
 {
-	return ad7152_start_calib(dev, attr, buf, len, 6);
+	return ad7152_start_calib(dev, attr, buf, len,
+				  AD7152_CONF_MODE_GAIN_CAL);
 }
 
 static IIO_DEVICE_ATTR(in_capacitance0_calibbias_calibration,
@@ -139,7 +172,7 @@ static ssize_t ad7152_store_filter_rate_setup(struct device *dev,
 	if (ret < 0)
 		return ret;
 
-	ret = i2c_smbus_write_byte_data(chip->client, AD7152_CFG2, data);
+	ret = i2c_smbus_write_byte_data(chip->client, AD7152_REG_CFG2, data);
 	if (ret < 0)
 		return ret;
 
@@ -166,10 +199,10 @@ static const struct attribute_group ad7152_attribute_group = {
 };
 
 static const u8 ad7152_addresses[][4] = {
-	{ AD7152_CH1_DATA_HIGH, AD7152_CH1_OFFS_HIGH,
-	  AD7152_CH1_GAIN_HIGH, AD7152_CH1_SETUP },
-	{ AD7152_CH2_DATA_HIGH, AD7152_CH2_OFFS_HIGH,
-	  AD7152_CH2_GAIN_HIGH, AD7152_CH2_SETUP },
+	{ AD7152_REG_CH1_DATA_HIGH, AD7152_REG_CH1_OFFS_HIGH,
+	  AD7152_REG_CH1_GAIN_HIGH, AD7152_REG_CH1_SETUP },
+	{ AD7152_REG_CH2_DATA_HIGH, AD7152_REG_CH2_OFFS_HIGH,
+	  AD7152_REG_CH2_GAIN_HIGH, AD7152_REG_CH2_SETUP },
 };
 
 /* Values are micro relative to pf base. */
@@ -191,8 +224,8 @@ static int ad7152_write_raw(struct iio_dev *dev_info,
 		if ((val < 0) | (val > 0xFFFF))
 			return -EINVAL;
 		ret = i2c_smbus_write_word_data(chip->client,
-					ad7152_addresses[chan->channel][2],
-					val);
+				ad7152_addresses[chan->channel][AD7152_GAIN],
+				val);
 		if (ret < 0)
 			return ret;
 
@@ -202,8 +235,8 @@ static int ad7152_write_raw(struct iio_dev *dev_info,
 		if ((val < 0) | (val > 0xFFFF))
 			return -EINVAL;
 		ret = i2c_smbus_write_word_data(chip->client,
-					ad7152_addresses[chan->channel][1],
-					val);
+				ad7152_addresses[chan->channel][AD7152_OFFS],
+				val);
 		if (ret < 0)
 			return ret;
 
@@ -215,13 +248,13 @@ static int ad7152_write_raw(struct iio_dev *dev_info,
 			if (val2 <= ad7152_scale_table[i])
 				break;
 		ret = i2c_smbus_read_byte_data(chip->client,
-					ad7152_addresses[chan->channel][3]);
+				ad7152_addresses[chan->channel][AD7152_SETUP]);
 		if (ret < 0)
 			return ret;
 		if ((ret & 0xC0) != i)
 			ret = i2c_smbus_write_byte_data(chip->client,
-					ad7152_addresses[chan->channel][3],
-					(ret & ~0xC0) | i);
+				ad7152_addresses[chan->channel][AD7152_SETUP],
+				(ret & ~0xC0) | i);
 		if (ret < 0)
 			return ret;
 		else
@@ -242,25 +275,25 @@ static int ad7152_read_raw(struct iio_dev *dev_info,
 	case 0:
 		/* First set whether in differential mode */
 		if (chan->differential)
-			regval = (1 << 5);
+			regval = AD7152_SETUP_CAPDIFF;
 
 		/* Make sure the channel is enabled */
-		if (chan->channel == 0)
-			regval |= (1 << 4);
+		if (chan->address == 0)
+			regval |= AD7152_CONF_CH1EN;
 		else
-			regval |= (1 << 3);
+			regval |= AD7152_CONF_CH2EN;
 		/* Trigger a single read */
-		regval |= 0x02;
+		regval |= AD7152_CONF_MODE_SINGLE_CONV;
 		ret = i2c_smbus_write_byte_data(chip->client,
-					ad7152_addresses[chan->channel][3],
-					regval);
+				ad7152_addresses[chan->channel][AD7152_SETUP],
+				regval);
 		if (ret < 0)
 			return ret;
 
 		msleep(60); /* Slowest conversion time */
 		/* Now read the actual register */
 		ret = i2c_smbus_read_word_data(chip->client,
-					ad7152_addresses[chan->channel][0]);
+				ad7152_addresses[chan->channel][AD7152_DATA]);
 		if (ret < 0)
 			return ret;
 		*val = ret;
@@ -269,7 +302,7 @@ static int ad7152_read_raw(struct iio_dev *dev_info,
 	case (1 << IIO_CHAN_INFO_CALIBSCALE_SEPARATE):
 		/* FIXME: Hmm. very small. it's 1+ 1/(2^16 *val) */
 		ret = i2c_smbus_read_word_data(chip->client,
-					ad7152_addresses[chan->channel][2]);
+				ad7152_addresses[chan->channel][AD7152_GAIN]);
 		if (ret < 0)
 			return ret;
 		*val = ret;
@@ -277,7 +310,7 @@ static int ad7152_read_raw(struct iio_dev *dev_info,
 		return IIO_VAL_INT;
 	case (1 << IIO_CHAN_INFO_CALIBBIAS_SEPARATE):
 		ret = i2c_smbus_read_word_data(chip->client,
-					ad7152_addresses[chan->channel][1]);
+				ad7152_addresses[chan->channel][AD7152_OFFS]);
 		if (ret < 0)
 			return ret;
 		*val = ret;
@@ -285,7 +318,7 @@ static int ad7152_read_raw(struct iio_dev *dev_info,
 		return IIO_VAL_INT;
 	case (1 << IIO_CHAN_INFO_SCALE_SEPARATE):
 		ret = i2c_smbus_read_byte_data(chip->client,
-					ad7152_addresses[chan->channel][3]);
+				ad7152_addresses[chan->channel][AD7152_SETUP]);
 		if (ret < 0)
 			return ret;
 		*val = 0;
@@ -360,7 +393,7 @@ static int __devinit ad7152_probe(struct i2c_client *client,
 
 	chip->client = client;
 
-	/* Echipabilish that the iio_dev is a child of the i2c device */
+	/* Establish that the iio_dev is a child of the i2c device */
 	indio_dev->name = id->name;
 	indio_dev->dev.parent = &client->dev;
 	indio_dev->info = &ad7152_info;
@@ -405,7 +438,7 @@ MODULE_DEVICE_TABLE(i2c, ad7152_id);
 
 static struct i2c_driver ad7152_driver = {
 	.driver = {
-		.name = "ad7152",
+		.name = KBUILD_MODNAME,
 	},
 	.probe = ad7152_probe,
 	.remove = __devexit_p(ad7152_remove),
@@ -423,7 +456,7 @@ static __exit void ad7152_exit(void)
 }
 
 MODULE_AUTHOR("Barry Song <21cnbao@gmail.com>");
-MODULE_DESCRIPTION("Analog Devices ad7152/3 capacitive sensor driver");
+MODULE_DESCRIPTION("Analog Devices AD7152/3 capacitive sensor driver");
 MODULE_LICENSE("GPL v2");
 
 module_init(ad7152_init);
-- 
1.7.3.4
