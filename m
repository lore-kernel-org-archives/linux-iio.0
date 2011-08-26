Return-Path: <jic23@cam.ac.uk>
From: Jonathan Cameron <jic23@cam.ac.uk>
To: linux-iio@vger.kernel.org
Cc: Jonathan Cameron <jic23@cam.ac.uk>
Subject: [PATCH 05/16] staging:iio:adc:ad7152 use smbus read / write functions + checkpatch fixes
Date: Fri, 26 Aug 2011 11:19:22 +0100
Message-Id: <1314353973-7662-6-git-send-email-jic23@cam.ac.uk>
In-Reply-To: <1314353973-7662-1-git-send-email-jic23@cam.ac.uk>
References: <1314353973-7662-1-git-send-email-jic23@cam.ac.uk>
List-ID: <linux-iio@vger.kernel.org>

This is fine IF I  have read the data sheet correctly.

Signed-off-by: Jonathan Cameron <jic23@cam.ac.uk>
---
 drivers/staging/iio/adc/ad7152.c |  418 +++++++++++++------------------------
 1 files changed, 147 insertions(+), 271 deletions(-)

diff --git a/drivers/staging/iio/adc/ad7152.c b/drivers/staging/iio/adc/ad7152.c
index 21f5f38..8dbc00c 100644
--- a/drivers/staging/iio/adc/ad7152.c
+++ b/drivers/staging/iio/adc/ad7152.c
@@ -17,6 +17,9 @@
 #include "../sysfs.h"
 
 /*
+ * TODO: Check compliance of calibscale and calibbias with abi (units)
+ */
+/*
  * AD7152 registers definition
  */
 
@@ -24,18 +27,12 @@
 #define AD7152_STATUS_RDY1         (1 << 0)
 #define AD7152_STATUS_RDY2         (1 << 1)
 #define AD7152_CH1_DATA_HIGH       1
-#define AD7152_CH1_DATA_LOW        2
 #define AD7152_CH2_DATA_HIGH       3
-#define AD7152_CH2_DATA_LOW        4
 #define AD7152_CH1_OFFS_HIGH       5
-#define AD7152_CH1_OFFS_LOW        6
 #define AD7152_CH2_OFFS_HIGH       7
-#define AD7152_CH2_OFFS_LOW        8
 #define AD7152_CH1_GAIN_HIGH       9
-#define AD7152_CH1_GAIN_LOW        10
 #define AD7152_CH1_SETUP           11
 #define AD7152_CH2_GAIN_HIGH       12
-#define AD7152_CH2_GAIN_LOW        13
 #define AD7152_CH2_SETUP           14
 #define AD7152_CFG                 15
 #define AD7152_RESEVERD            16
@@ -51,13 +48,13 @@
 
 struct ad7152_chip_info {
 	struct i2c_client *client;
-	u16 ch1_offset;     /* Channel 1 offset calibration coefficient */
-	u16 ch1_gain;       /* Channel 1 gain coefficient */
 	u8  ch1_setup;
-	u16 ch2_offset;     /* Channel 2 offset calibration coefficient */
-	u16 ch2_gain;       /* Channel 1 gain coefficient */
 	u8  ch2_setup;
-	u8  filter_rate_setup; /* Capacitive channel digital filter setup; conversion time/update rate setup per channel */
+	/*
+	 * Capacitive channel digital filter setup;
+	 * conversion time/update rate setup per channel
+	 */
+	u8  filter_rate_setup;
 	char *conversion_mode;
 };
 
@@ -77,65 +74,13 @@ ad7152_conv_mode_table[AD7152_MAX_CONV_MODE] = {
 };
 
 /*
- * ad7152 register access by I2C
- */
-
-static int ad7152_i2c_read(struct ad7152_chip_info *chip, u8 reg, u8 *data, int len)
-{
-	struct i2c_client *client = chip->client;
-	int ret;
-
-	ret = i2c_master_send(client, &reg, 1);
-	if (ret < 0) {
-		dev_err(&client->dev, "I2C write error\n");
-		return ret;
-	}
-
-	ret = i2c_master_recv(client, data, len);
-	if (ret < 0) {
-		dev_err(&client->dev, "I2C read error\n");
-	}
-
-	return ret;
-}
-
-static int ad7152_i2c_write(struct ad7152_chip_info *chip, u8 reg, u8 data)
-{
-	struct i2c_client *client = chip->client;
-	int ret;
-
-	u8 tx[2] = {
-		reg,
-		data,
-	};
-
-	ret = i2c_master_send(client, tx, 2);
-	if (ret < 0)
-		dev_err(&client->dev, "I2C write error\n");
-
-	return ret;
-}
-
-/*
  * sysfs nodes
  */
 
-#define IIO_DEV_ATTR_AVAIL_CONVERSION_MODES(_show)				\
+#define IIO_DEV_ATTR_AVAIL_CONVERSION_MODES(_show)			\
 	IIO_DEVICE_ATTR(available_conversion_modes, S_IRUGO, _show, NULL, 0)
 #define IIO_DEV_ATTR_CONVERSION_MODE(_mode, _show, _store)              \
 	IIO_DEVICE_ATTR(conversion_mode, _mode, _show, _store, 0)
-#define IIO_DEV_ATTR_CH1_OFFSET(_mode, _show, _store)		\
-	IIO_DEVICE_ATTR(ch1_offset, _mode, _show, _store, 0)
-#define IIO_DEV_ATTR_CH2_OFFSET(_mode, _show, _store)		\
-	IIO_DEVICE_ATTR(ch2_offset, _mode, _show, _store, 0)
-#define IIO_DEV_ATTR_CH1_GAIN(_mode, _show, _store)		\
-	IIO_DEVICE_ATTR(ch1_gain, _mode, _show, _store, 0)
-#define IIO_DEV_ATTR_CH2_GAIN(_mode, _show, _store)		\
-	IIO_DEVICE_ATTR(ch2_gain, _mode, _show, _store, 0)
-#define IIO_DEV_ATTR_CH1_VALUE(_show)		\
-	IIO_DEVICE_ATTR(ch1_value, S_IRUGO, _show, NULL, 0)
-#define IIO_DEV_ATTR_CH2_VALUE(_show)		\
-	IIO_DEVICE_ATTR(ch2_value, S_IRUGO, _show, NULL, 0)
 #define IIO_DEV_ATTR_CH1_SETUP(_mode, _show, _store)		\
 	IIO_DEVICE_ATTR(ch1_setup, _mode, _show, _store, 0)
 #define IIO_DEV_ATTR_CH2_SETUP(_mode, _show, _store)              \
@@ -151,7 +96,8 @@ static ssize_t ad7152_show_conversion_modes(struct device *dev,
 	int len = 0;
 
 	for (i = 0; i < AD7152_MAX_CONV_MODE; i++)
-		len += sprintf(buf + len, "%s ", ad7152_conv_mode_table[i].name);
+		len += sprintf(buf + len, "%s ",
+			       ad7152_conv_mode_table[i].name);
 
 	len += sprintf(buf + len, "\n");
 
@@ -160,34 +106,6 @@ static ssize_t ad7152_show_conversion_modes(struct device *dev,
 
 static IIO_DEV_ATTR_AVAIL_CONVERSION_MODES(ad7152_show_conversion_modes);
 
-static ssize_t ad7152_show_ch1_value(struct device *dev,
-		struct device_attribute *attr,
-		char *buf)
-{
-	struct iio_dev *dev_info = dev_get_drvdata(dev);
-	struct ad7152_chip_info *chip = iio_priv(dev_info);
-	u8 data[2];
-
-	ad7152_i2c_read(chip, AD7152_CH1_DATA_HIGH, data, 2);
-	return sprintf(buf, "%d\n", ((int)data[0] << 8) | data[1]);
-}
-
-static IIO_DEV_ATTR_CH1_VALUE(ad7152_show_ch1_value);
-
-static ssize_t ad7152_show_ch2_value(struct device *dev,
-		struct device_attribute *attr,
-		char *buf)
-{
-	struct iio_dev *dev_info = dev_get_drvdata(dev);
-	struct ad7152_chip_info *chip = iio_priv(dev_info);
-	u8 data[2];
-
-	ad7152_i2c_read(chip, AD7152_CH2_DATA_HIGH, data, 2);
-	return sprintf(buf, "%d\n", ((int)data[0] << 8) | data[1]);
-}
-
-static IIO_DEV_ATTR_CH2_VALUE(ad7152_show_ch2_value);
-
 static ssize_t ad7152_show_conversion_mode(struct device *dev,
 		struct device_attribute *attr,
 		char *buf)
@@ -206,16 +124,23 @@ static ssize_t ad7152_store_conversion_mode(struct device *dev,
 	struct iio_dev *dev_info = dev_get_drvdata(dev);
 	struct ad7152_chip_info *chip = iio_priv(dev_info);
 	u8 cfg;
-	int i;
+	int i, ret;
 
-	ad7152_i2c_read(chip, AD7152_CFG, &cfg, 1);
+	ret = i2c_smbus_read_byte_data(chip->client, AD7152_CFG);
+	if (ret < 0)
+		return ret;
+	cfg = ret;
 
 	for (i = 0; i < AD7152_MAX_CONV_MODE; i++)
 		if (strncmp(buf, ad7152_conv_mode_table[i].name,
-				strlen(ad7152_conv_mode_table[i].name) - 1) == 0) {
+				strlen(ad7152_conv_mode_table[i].name) - 1) ==
+		    0) {
 			chip->conversion_mode = ad7152_conv_mode_table[i].name;
 			cfg |= 0x18 | ad7152_conv_mode_table[i].reg_cfg;
-			ad7152_i2c_write(chip, AD7152_CFG, cfg);
+			ret = i2c_smbus_write_byte_data(chip->client,
+							AD7152_CFG, cfg);
+			if (ret < 0)
+				return ret;
 			return len;
 		}
 
@@ -228,150 +153,6 @@ static IIO_DEV_ATTR_CONVERSION_MODE(S_IRUGO | S_IWUSR,
 		ad7152_show_conversion_mode,
 		ad7152_store_conversion_mode);
 
-static ssize_t ad7152_show_ch1_offset(struct device *dev,
-		struct device_attribute *attr,
-		char *buf)
-{
-	struct iio_dev *dev_info = dev_get_drvdata(dev);
-	struct ad7152_chip_info *chip = iio_priv(dev_info);
-
-	return sprintf(buf, "%d\n", chip->ch1_offset);
-}
-
-static ssize_t ad7152_store_ch1_offset(struct device *dev,
-		struct device_attribute *attr,
-		const char *buf,
-		size_t len)
-{
-	struct iio_dev *dev_info = dev_get_drvdata(dev);
-	struct ad7152_chip_info *chip = iio_priv(dev_info);
-	unsigned long data;
-	int ret;
-
-	ret = strict_strtoul(buf, 10, &data);
-
-	if ((!ret) && (data < 0x10000)) {
-		ad7152_i2c_write(chip, AD7152_CH1_OFFS_HIGH, data >> 8);
-		ad7152_i2c_write(chip, AD7152_CH1_OFFS_LOW, data);
-		chip->ch1_offset = data;
-		return len;
-	}
-
-	return -EINVAL;
-}
-
-static IIO_DEV_ATTR_CH1_OFFSET(S_IRUGO | S_IWUSR,
-		ad7152_show_ch1_offset,
-		ad7152_store_ch1_offset);
-
-static ssize_t ad7152_show_ch2_offset(struct device *dev,
-		struct device_attribute *attr,
-		char *buf)
-{
-	struct iio_dev *dev_info = dev_get_drvdata(dev);
-	struct ad7152_chip_info *chip = iio_priv(dev_info);
-
-	return sprintf(buf, "%d\n", chip->ch2_offset);
-}
-
-static ssize_t ad7152_store_ch2_offset(struct device *dev,
-		struct device_attribute *attr,
-		const char *buf,
-		size_t len)
-{
-	struct iio_dev *dev_info = dev_get_drvdata(dev);
-	struct ad7152_chip_info *chip = iio_priv(dev_info);
-	unsigned long data;
-	int ret;
-
-	ret = strict_strtoul(buf, 10, &data);
-
-	if ((!ret) && (data < 0x10000)) {
-		ad7152_i2c_write(chip, AD7152_CH2_OFFS_HIGH, data >> 8);
-		ad7152_i2c_write(chip, AD7152_CH2_OFFS_LOW, data);
-		chip->ch2_offset = data;
-		return len;
-	}
-
-	return -EINVAL;
-}
-
-static IIO_DEV_ATTR_CH2_OFFSET(S_IRUGO | S_IWUSR,
-		ad7152_show_ch2_offset,
-		ad7152_store_ch2_offset);
-
-static ssize_t ad7152_show_ch1_gain(struct device *dev,
-		struct device_attribute *attr,
-		char *buf)
-{
-	struct iio_dev *dev_info = dev_get_drvdata(dev);
-	struct ad7152_chip_info *chip = iio_priv(dev_info);
-
-	return sprintf(buf, "%d\n", chip->ch1_gain);
-}
-
-static ssize_t ad7152_store_ch1_gain(struct device *dev,
-		struct device_attribute *attr,
-		const char *buf,
-		size_t len)
-{
-	struct iio_dev *dev_info = dev_get_drvdata(dev);
-	struct ad7152_chip_info *chip = iio_priv(dev_info);
-	unsigned long data;
-	int ret;
-
-	ret = strict_strtoul(buf, 10, &data);
-
-	if ((!ret) && (data < 0x10000)) {
-		ad7152_i2c_write(chip, AD7152_CH1_GAIN_HIGH, data >> 8);
-		ad7152_i2c_write(chip, AD7152_CH1_GAIN_LOW, data);
-		chip->ch1_gain = data;
-		return len;
-	}
-
-	return -EINVAL;
-}
-
-static IIO_DEV_ATTR_CH1_GAIN(S_IRUGO | S_IWUSR,
-		ad7152_show_ch1_gain,
-		ad7152_store_ch1_gain);
-
-static ssize_t ad7152_show_ch2_gain(struct device *dev,
-		struct device_attribute *attr,
-		char *buf)
-{
-	struct iio_dev *dev_info = dev_get_drvdata(dev);
-	struct ad7152_chip_info *chip = iio_priv(dev_info);
-
-	return sprintf(buf, "%d\n", chip->ch2_gain);
-}
-
-static ssize_t ad7152_store_ch2_gain(struct device *dev,
-		struct device_attribute *attr,
-		const char *buf,
-		size_t len)
-{
-	struct iio_dev *dev_info = dev_get_drvdata(dev);
-	struct ad7152_chip_info *chip = iio_priv(dev_info);
-	unsigned long data;
-	int ret;
-
-	ret = strict_strtoul(buf, 10, &data);
-
-	if ((!ret) && (data < 0x10000)) {
-		ad7152_i2c_write(chip, AD7152_CH2_GAIN_HIGH, data >> 8);
-		ad7152_i2c_write(chip, AD7152_CH2_GAIN_LOW, data);
-		chip->ch2_gain = data;
-		return len;
-	}
-
-	return -EINVAL;
-}
-
-static IIO_DEV_ATTR_CH2_GAIN(S_IRUGO | S_IWUSR,
-		ad7152_show_ch2_gain,
-		ad7152_store_ch2_gain);
-
 static ssize_t ad7152_show_ch1_setup(struct device *dev,
 		struct device_attribute *attr,
 		char *buf)
@@ -389,18 +170,20 @@ static ssize_t ad7152_store_ch1_setup(struct device *dev,
 {
 	struct iio_dev *dev_info = dev_get_drvdata(dev);
 	struct ad7152_chip_info *chip = iio_priv(dev_info);
-	unsigned long data;
+	u8 data;
 	int ret;
 
-	ret = strict_strtoul(buf, 10, &data);
+	ret = kstrtou8(buf, 10, &data);
+	if (ret < 0)
+		return ret;
 
-	if ((!ret) && (data < 0x100)) {
-		ad7152_i2c_write(chip, AD7152_CH1_SETUP, data);
-		chip->ch1_setup = data;
-		return len;
-	}
+	ret = i2c_smbus_write_byte_data(chip->client, AD7152_CH1_SETUP, data);
+	if (ret < 0)
+		return ret;
 
-	return -EINVAL;
+	chip->ch1_setup = data;
+
+	return len;
 }
 
 static IIO_DEV_ATTR_CH1_SETUP(S_IRUGO | S_IWUSR,
@@ -424,18 +207,20 @@ static ssize_t ad7152_store_ch2_setup(struct device *dev,
 {
 	struct iio_dev *dev_info = dev_get_drvdata(dev);
 	struct ad7152_chip_info *chip = iio_priv(dev_info);
-	unsigned long data;
+	u8 data;
 	int ret;
 
-	ret = strict_strtoul(buf, 10, &data);
+	ret = kstrtou8(buf, 10, &data);
+	if (ret < 0)
+		return ret;
 
-	if ((!ret) && (data < 0x100)) {
-		ad7152_i2c_write(chip, AD7152_CH2_SETUP, data);
-		chip->ch2_setup = data;
-		return len;
-	}
+	ret = i2c_smbus_write_byte_data(chip->client, AD7152_CH2_SETUP, data);
+	if (ret < 0)
+		return ret;
 
-	return -EINVAL;
+	chip->ch2_setup = data;
+
+	return len;
 }
 
 static IIO_DEV_ATTR_CH2_SETUP(S_IRUGO | S_IWUSR,
@@ -459,18 +244,20 @@ static ssize_t ad7152_store_filter_rate_setup(struct device *dev,
 {
 	struct iio_dev *dev_info = dev_get_drvdata(dev);
 	struct ad7152_chip_info *chip = iio_priv(dev_info);
-	unsigned long data;
+	u8 data;
 	int ret;
 
-	ret = strict_strtoul(buf, 10, &data);
+	ret = kstrtou8(buf, 10, &data);
+	if (ret < 0)
+		return ret;
+
+	ret = i2c_smbus_write_byte_data(chip->client, AD7152_CFG2, data);
+	if (ret < 0)
+		return ret;
 
-	if ((!ret) && (data < 0x100)) {
-		ad7152_i2c_write(chip, AD7152_CFG2, data);
-		chip->filter_rate_setup = data;
-		return len;
-	}
+	chip->filter_rate_setup = data;
 
-	return -EINVAL;
+	return len;
 }
 
 static IIO_DEV_ATTR_FILTER_RATE_SETUP(S_IRUGO | S_IWUSR,
@@ -480,12 +267,6 @@ static IIO_DEV_ATTR_FILTER_RATE_SETUP(S_IRUGO | S_IWUSR,
 static struct attribute *ad7152_attributes[] = {
 	&iio_dev_attr_available_conversion_modes.dev_attr.attr,
 	&iio_dev_attr_conversion_mode.dev_attr.attr,
-	&iio_dev_attr_ch1_gain.dev_attr.attr,
-	&iio_dev_attr_ch2_gain.dev_attr.attr,
-	&iio_dev_attr_ch1_offset.dev_attr.attr,
-	&iio_dev_attr_ch2_offset.dev_attr.attr,
-	&iio_dev_attr_ch1_value.dev_attr.attr,
-	&iio_dev_attr_ch2_value.dev_attr.attr,
 	&iio_dev_attr_ch1_setup.dev_attr.attr,
 	&iio_dev_attr_ch2_setup.dev_attr.attr,
 	&iio_dev_attr_filter_rate_setup.dev_attr.attr,
@@ -496,10 +277,103 @@ static const struct attribute_group ad7152_attribute_group = {
 	.attrs = ad7152_attributes,
 };
 
+static const u8 ad7152_addresses[][3] = {
+	{ AD7152_CH1_DATA_HIGH, AD7152_CH1_OFFS_HIGH, AD7152_CH1_GAIN_HIGH },
+	{ AD7152_CH2_DATA_HIGH, AD7152_CH2_OFFS_HIGH, AD7152_CH2_GAIN_HIGH },
+};
+static int ad7152_write_raw(struct iio_dev *dev_info,
+			    struct iio_chan_spec const *chan,
+			    int val,
+			    int val2,
+			    long mask)
+{
+	struct ad7152_chip_info *chip = iio_priv(dev_info);
+	int ret;
+
+	switch (mask) {
+	case (1 << IIO_CHAN_INFO_CALIBSCALE_SEPARATE):
+		if ((val < 0) | (val > 0xFFFF))
+			return -EINVAL;
+		ret = i2c_smbus_write_word_data(chip->client,
+					ad7152_addresses[chan->channel][2],
+					val);
+		if (ret < 0)
+			return ret;
+
+		return 0;
+
+	case (1 << IIO_CHAN_INFO_CALIBBIAS_SEPARATE):
+		if ((val < 0) | (val > 0xFFFF))
+			return -EINVAL;
+		ret = i2c_smbus_write_word_data(chip->client,
+					ad7152_addresses[chan->channel][1],
+					val);
+		if (ret < 0)
+			return ret;
+
+		return 0;
+
+	default:
+		return -EINVAL;
+	}
+}
+static int ad7152_read_raw(struct iio_dev *dev_info,
+			   struct iio_chan_spec const *chan,
+			   int *val, int *val2,
+			   long mask)
+{
+	struct ad7152_chip_info *chip = iio_priv(dev_info);
+	int ret;
+
+	switch (mask) {
+	case 0:
+		ret = i2c_smbus_read_word_data(chip->client,
+					ad7152_addresses[chan->channel][0]);
+		if (ret < 0)
+			return ret;
+		*val = ret;
+		return IIO_VAL_INT;
+	case (1 << IIO_CHAN_INFO_CALIBSCALE_SEPARATE):
+		/* FIXME: Hmm. very small. it's 1+ 1/(2^16 *val) */
+		ret = i2c_smbus_read_word_data(chip->client,
+					ad7152_addresses[chan->channel][2]);
+		if (ret < 0)
+			return ret;
+		*val = ret;
+		return IIO_VAL_INT;
+	case (1 << IIO_CHAN_INFO_CALIBBIAS_SEPARATE):
+		ret = i2c_smbus_read_word_data(chip->client,
+					ad7152_addresses[chan->channel][1]);
+		if (ret < 0)
+			return ret;
+		*val = ret;
+		return IIO_VAL_INT;
+	default:
+		return -EINVAL;
+	};
+}
 static const struct iio_info ad7152_info = {
 	.attrs = &ad7152_attribute_group,
+	.read_raw = &ad7152_read_raw,
+	.write_raw = &ad7152_write_raw,
 	.driver_module = THIS_MODULE,
 };
+
+static const struct iio_chan_spec ad7152_channels[] = {
+	{
+		.type = IIO_CAPACITANCE,
+		.indexed = 1,
+		.channel = 0,
+		.info_mask = (1 << IIO_CHAN_INFO_CALIBSCALE_SEPARATE) |
+		(1 << IIO_CHAN_INFO_CALIBBIAS_SEPARATE),
+	}, {
+		.type = IIO_CAPACITANCE,
+		.indexed = 1,
+		.channel = 1,
+		.info_mask = (1 << IIO_CHAN_INFO_CALIBSCALE_SEPARATE) |
+		(1 << IIO_CHAN_INFO_CALIBBIAS_SEPARATE),
+	}
+};
 /*
  * device probe and remove
  */
@@ -526,6 +400,8 @@ static int __devinit ad7152_probe(struct i2c_client *client,
 	indio_dev->name = id->name;
 	indio_dev->dev.parent = &client->dev;
 	indio_dev->info = &ad7152_info;
+	indio_dev->channels = ad7152_channels;
+	indio_dev->num_channels = ARRAY_SIZE(ad7152_channels);
 	indio_dev->modes = INDIO_DIRECT_MODE;
 
 	ret = iio_device_register(indio_dev);
-- 
1.7.3.4
