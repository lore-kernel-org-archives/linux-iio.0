Return-Path: <jic23@cam.ac.uk>
From: Jonathan Cameron <jic23@cam.ac.uk>
To: linux-iio@vger.kernel.org
Cc: Jonathan Cameron <jic23@cam.ac.uk>
Subject: [PATCH 07/16] staging:iio:adc:ad7152 bring more into line with abi.
Date: Fri, 26 Aug 2011 11:19:24 +0100
Message-Id: <1314353973-7662-8-git-send-email-jic23@cam.ac.uk>
In-Reply-To: <1314353973-7662-1-git-send-email-jic23@cam.ac.uk>
References: <1314353973-7662-1-git-send-email-jic23@cam.ac.uk>
List-ID: <linux-iio@vger.kernel.org>

Get rid of explicit writes to registers and conversion mode
control.

Couple of bits I'm unsure about.
* Do calibration modes self reset when done?  How do you tell they are
done?

* Should we poll the status register just to be sure we have a new conversion?

All done sans hardware.

Signed-off-by: Jonathan Cameron <jic23@cam.ac.uk>
---
 drivers/staging/iio/adc/ad7152.c |  294 +++++++++++++++++---------------------
 1 files changed, 129 insertions(+), 165 deletions(-)

diff --git a/drivers/staging/iio/adc/ad7152.c b/drivers/staging/iio/adc/ad7152.c
index 5acaf8a..debcea5 100644
--- a/drivers/staging/iio/adc/ad7152.c
+++ b/drivers/staging/iio/adc/ad7152.c
@@ -12,6 +12,7 @@
 #include <linux/slab.h>
 #include <linux/sysfs.h>
 #include <linux/i2c.h>
+#include <linux/delay.h>
 
 #include "../iio.h"
 #include "../sysfs.h"
@@ -48,184 +49,71 @@
 
 struct ad7152_chip_info {
 	struct i2c_client *client;
-	u8  ch1_setup;
-	u8  ch2_setup;
 	/*
 	 * Capacitive channel digital filter setup;
 	 * conversion time/update rate setup per channel
 	 */
 	u8  filter_rate_setup;
-	char *conversion_mode;
 };
 
-struct ad7152_conversion_mode {
-	char *name;
-	u8 reg_cfg;
-};
-
-static struct ad7152_conversion_mode
-ad7152_conv_mode_table[AD7152_MAX_CONV_MODE] = {
-	{ "idle", 0 },
-	{ "continuous-conversion", 1 },
-	{ "single-conversion", 2 },
-	{ "power-down", 3 },
-	{ "offset-calibration", 5 },
-	{ "gain-calibration", 6 },
-};
-
-/*
- * sysfs nodes
- */
-
-#define IIO_DEV_ATTR_AVAIL_CONVERSION_MODES(_show)			\
-	IIO_DEVICE_ATTR(available_conversion_modes, S_IRUGO, _show, NULL, 0)
-#define IIO_DEV_ATTR_CONVERSION_MODE(_mode, _show, _store)              \
-	IIO_DEVICE_ATTR(conversion_mode, _mode, _show, _store, 0)
-#define IIO_DEV_ATTR_CH1_SETUP(_mode, _show, _store)		\
-	IIO_DEVICE_ATTR(ch1_setup, _mode, _show, _store, 0)
-#define IIO_DEV_ATTR_CH2_SETUP(_mode, _show, _store)              \
-	IIO_DEVICE_ATTR(ch2_setup, _mode, _show, _store, 0)
-#define IIO_DEV_ATTR_FILTER_RATE_SETUP(_mode, _show, _store)              \
-	IIO_DEVICE_ATTR(filter_rate_setup, _mode, _show, _store, 0)
-
-static ssize_t ad7152_show_conversion_modes(struct device *dev,
-		struct device_attribute *attr,
-		char *buf)
-{
-	int i;
-	int len = 0;
-
-	for (i = 0; i < AD7152_MAX_CONV_MODE; i++)
-		len += sprintf(buf + len, "%s ",
-			       ad7152_conv_mode_table[i].name);
-
-	len += sprintf(buf + len, "\n");
-
-	return len;
-}
-
-static IIO_DEV_ATTR_AVAIL_CONVERSION_MODES(ad7152_show_conversion_modes);
-
-static ssize_t ad7152_show_conversion_mode(struct device *dev,
-		struct device_attribute *attr,
-		char *buf)
+static inline ssize_t ad7152_start_calib(struct device *dev,
+					 struct device_attribute *attr,
+					 const char *buf,
+					 size_t len,
+					 u8 regval)
 {
 	struct iio_dev *dev_info = dev_get_drvdata(dev);
 	struct ad7152_chip_info *chip = iio_priv(dev_info);
+	struct iio_dev_attr *this_attr = to_iio_dev_attr(attr);
+	bool doit;
+	int ret;
 
-	return sprintf(buf, "%s\n", chip->conversion_mode);
-}
-
-static ssize_t ad7152_store_conversion_mode(struct device *dev,
-		struct device_attribute *attr,
-		const char *buf,
-		size_t len)
-{
-	struct iio_dev *dev_info = dev_get_drvdata(dev);
-	struct ad7152_chip_info *chip = iio_priv(dev_info);
-	u8 cfg;
-	int i, ret;
-
-	ret = i2c_smbus_read_byte_data(chip->client, AD7152_CFG);
+	ret = strtobool(buf, &doit);
 	if (ret < 0)
 		return ret;
-	cfg = ret;
-
-	for (i = 0; i < AD7152_MAX_CONV_MODE; i++)
-		if (strncmp(buf, ad7152_conv_mode_table[i].name,
-				strlen(ad7152_conv_mode_table[i].name) - 1) ==
-		    0) {
-			chip->conversion_mode = ad7152_conv_mode_table[i].name;
-			cfg |= 0x18 | ad7152_conv_mode_table[i].reg_cfg;
-			ret = i2c_smbus_write_byte_data(chip->client,
-							AD7152_CFG, cfg);
-			if (ret < 0)
-				return ret;
-			return len;
-		}
-
-	dev_err(dev, "not supported conversion mode\n");
-
-	return -EINVAL;
-}
-
-static IIO_DEV_ATTR_CONVERSION_MODE(S_IRUGO | S_IWUSR,
-		ad7152_show_conversion_mode,
-		ad7152_store_conversion_mode);
-
-static ssize_t ad7152_show_ch1_setup(struct device *dev,
-		struct device_attribute *attr,
-		char *buf)
-{
-	struct iio_dev *dev_info = dev_get_drvdata(dev);
-	struct ad7152_chip_info *chip = iio_priv(dev_info);
-
-	return sprintf(buf, "0x%02x\n", chip->ch1_setup);
-}
 
-static ssize_t ad7152_store_ch1_setup(struct device *dev,
-		struct device_attribute *attr,
-		const char *buf,
-		size_t len)
-{
-	struct iio_dev *dev_info = dev_get_drvdata(dev);
-	struct ad7152_chip_info *chip = iio_priv(dev_info);
-	u8 data;
-	int ret;
+	if (!doit)
+		return 0;
 
-	ret = kstrtou8(buf, 10, &data);
-	if (ret < 0)
-		return ret;
+	if (this_attr->address == 0)
+		regval |= (1 << 4);
+	else
+		regval |= (1 << 3);
 
-	ret = i2c_smbus_write_byte_data(chip->client, AD7152_CH1_SETUP, data);
+	ret = i2c_smbus_write_byte_data(chip->client, AD7152_CFG, regval);
 	if (ret < 0)
 		return ret;
-
-	chip->ch1_setup = data;
-
+	/* Unclear on period this should be set for or whether it flips back
+	 * to idle automatically */
 	return len;
 }
-
-static IIO_DEV_ATTR_CH1_SETUP(S_IRUGO | S_IWUSR,
-		ad7152_show_ch1_setup,
-		ad7152_store_ch1_setup);
-
-static ssize_t ad7152_show_ch2_setup(struct device *dev,
-		struct device_attribute *attr,
-		char *buf)
+static ssize_t ad7152_start_offset_calib(struct device *dev,
+					 struct device_attribute *attr,
+					 const char *buf,
+					 size_t len)
 {
-	struct iio_dev *dev_info = dev_get_drvdata(dev);
-	struct ad7152_chip_info *chip = iio_priv(dev_info);
 
-	return sprintf(buf, "0x%02x\n", chip->ch2_setup);
+	return ad7152_start_calib(dev, attr, buf, len, 5);
 }
-
-static ssize_t ad7152_store_ch2_setup(struct device *dev,
-		struct device_attribute *attr,
-		const char *buf,
-		size_t len)
+static ssize_t ad7152_start_gain_calib(struct device *dev,
+				       struct device_attribute *attr,
+				       const char *buf,
+				       size_t len)
 {
-	struct iio_dev *dev_info = dev_get_drvdata(dev);
-	struct ad7152_chip_info *chip = iio_priv(dev_info);
-	u8 data;
-	int ret;
-
-	ret = kstrtou8(buf, 10, &data);
-	if (ret < 0)
-		return ret;
-
-	ret = i2c_smbus_write_byte_data(chip->client, AD7152_CH2_SETUP, data);
-	if (ret < 0)
-		return ret;
-
-	chip->ch2_setup = data;
-
-	return len;
+	return ad7152_start_calib(dev, attr, buf, len, 6);
 }
 
-static IIO_DEV_ATTR_CH2_SETUP(S_IRUGO | S_IWUSR,
-		ad7152_show_ch2_setup,
-		ad7152_store_ch2_setup);
+static IIO_DEVICE_ATTR(in_capacitance0_calibbias_calibration,
+		       S_IWUSR, NULL, ad7152_start_offset_calib, 0);
+static IIO_DEVICE_ATTR(in_capacitance1_calibbias_calibration,
+		       S_IWUSR, NULL, ad7152_start_offset_calib, 1);
+static IIO_DEVICE_ATTR(in_capacitance0_calibscale_calibration,
+		       S_IWUSR, NULL, ad7152_start_gain_calib, 0);
+static IIO_DEVICE_ATTR(in_capacitance1_calibscale_calibration,
+		       S_IWUSR, NULL, ad7152_start_gain_calib, 1);
+
+#define IIO_DEV_ATTR_FILTER_RATE_SETUP(_mode, _show, _store)              \
+	IIO_DEVICE_ATTR(filter_rate_setup, _mode, _show, _store, 0)
 
 static ssize_t ad7152_show_filter_rate_setup(struct device *dev,
 		struct device_attribute *attr,
@@ -265,11 +153,11 @@ static IIO_DEV_ATTR_FILTER_RATE_SETUP(S_IRUGO | S_IWUSR,
 		ad7152_store_filter_rate_setup);
 
 static struct attribute *ad7152_attributes[] = {
-	&iio_dev_attr_available_conversion_modes.dev_attr.attr,
-	&iio_dev_attr_conversion_mode.dev_attr.attr,
-	&iio_dev_attr_ch1_setup.dev_attr.attr,
-	&iio_dev_attr_ch2_setup.dev_attr.attr,
 	&iio_dev_attr_filter_rate_setup.dev_attr.attr,
+	&iio_dev_attr_in_capacitance0_calibbias_calibration.dev_attr.attr,
+	&iio_dev_attr_in_capacitance1_calibbias_calibration.dev_attr.attr,
+	&iio_dev_attr_in_capacitance0_calibscale_calibration.dev_attr.attr,
+	&iio_dev_attr_in_capacitance1_calibscale_calibration.dev_attr.attr,
 	NULL,
 };
 
@@ -277,10 +165,18 @@ static const struct attribute_group ad7152_attribute_group = {
 	.attrs = ad7152_attributes,
 };
 
-static const u8 ad7152_addresses[][3] = {
-	{ AD7152_CH1_DATA_HIGH, AD7152_CH1_OFFS_HIGH, AD7152_CH1_GAIN_HIGH },
-	{ AD7152_CH2_DATA_HIGH, AD7152_CH2_OFFS_HIGH, AD7152_CH2_GAIN_HIGH },
+static const u8 ad7152_addresses[][4] = {
+	{ AD7152_CH1_DATA_HIGH, AD7152_CH1_OFFS_HIGH,
+	  AD7152_CH1_GAIN_HIGH, AD7152_CH1_SETUP },
+	{ AD7152_CH2_DATA_HIGH, AD7152_CH2_OFFS_HIGH,
+	  AD7152_CH2_GAIN_HIGH, AD7152_CH2_SETUP },
+};
+
+/* Values are micro relative to pf base. */
+static const int ad7152_scale_table[] = {
+	488, 244, 122, 61
 };
+
 static int ad7152_write_raw(struct iio_dev *dev_info,
 			    struct iio_chan_spec const *chan,
 			    int val,
@@ -288,7 +184,7 @@ static int ad7152_write_raw(struct iio_dev *dev_info,
 			    long mask)
 {
 	struct ad7152_chip_info *chip = iio_priv(dev_info);
-	int ret;
+	int ret, i;
 
 	switch (mask) {
 	case (1 << IIO_CHAN_INFO_CALIBSCALE_SEPARATE):
@@ -312,7 +208,24 @@ static int ad7152_write_raw(struct iio_dev *dev_info,
 			return ret;
 
 		return 0;
-
+	case (1 << IIO_CHAN_INFO_SCALE_SEPARATE):
+		if (val != 0)
+			return -EINVAL;
+		for (i = 0; i < ARRAY_SIZE(ad7152_scale_table); i++)
+			if (val2 <= ad7152_scale_table[i])
+				break;
+		ret = i2c_smbus_read_byte_data(chip->client,
+					ad7152_addresses[chan->channel][3]);
+		if (ret < 0)
+			return ret;
+		if ((ret & 0xC0) != i)
+			ret = i2c_smbus_write_byte_data(chip->client,
+					ad7152_addresses[chan->channel][3],
+					(ret & ~0xC0) | i);
+		if (ret < 0)
+			return ret;
+		else
+			return 0;
 	default:
 		return -EINVAL;
 	}
@@ -324,14 +237,34 @@ static int ad7152_read_raw(struct iio_dev *dev_info,
 {
 	struct ad7152_chip_info *chip = iio_priv(dev_info);
 	int ret;
-
+	u8 regval = 0;
 	switch (mask) {
 	case 0:
+		/* First set whether in differential mode */
+		if (chan->differential)
+			regval = (1 << 5);
+
+		/* Make sure the channel is enabled */
+		if (chan->channel == 0)
+			regval |= (1 << 4);
+		else
+			regval |= (1 << 3);
+		/* Trigger a single read */
+		regval |= 0x02;
+		ret = i2c_smbus_write_byte_data(chip->client,
+					ad7152_addresses[chan->channel][3],
+					regval);
+		if (ret < 0)
+			return ret;
+
+		msleep(60); /* Slowest conversion time */
+		/* Now read the actual register */
 		ret = i2c_smbus_read_word_data(chip->client,
 					ad7152_addresses[chan->channel][0]);
 		if (ret < 0)
 			return ret;
 		*val = ret;
+
 		return IIO_VAL_INT;
 	case (1 << IIO_CHAN_INFO_CALIBSCALE_SEPARATE):
 		/* FIXME: Hmm. very small. it's 1+ 1/(2^16 *val) */
@@ -340,6 +273,7 @@ static int ad7152_read_raw(struct iio_dev *dev_info,
 		if (ret < 0)
 			return ret;
 		*val = ret;
+
 		return IIO_VAL_INT;
 	case (1 << IIO_CHAN_INFO_CALIBBIAS_SEPARATE):
 		ret = i2c_smbus_read_word_data(chip->client,
@@ -347,7 +281,17 @@ static int ad7152_read_raw(struct iio_dev *dev_info,
 		if (ret < 0)
 			return ret;
 		*val = ret;
+
 		return IIO_VAL_INT;
+	case (1 << IIO_CHAN_INFO_SCALE_SEPARATE):
+		ret = i2c_smbus_read_byte_data(chip->client,
+					ad7152_addresses[chan->channel][3]);
+		if (ret < 0)
+			return ret;
+		*val = 0;
+		*val2 = ad7152_scale_table[ret >> 6];
+
+		return IIO_VAL_INT_PLUS_MICRO;
 	default:
 		return -EINVAL;
 	};
@@ -365,13 +309,33 @@ static const struct iio_chan_spec ad7152_channels[] = {
 		.indexed = 1,
 		.channel = 0,
 		.info_mask = (1 << IIO_CHAN_INFO_CALIBSCALE_SEPARATE) |
-		(1 << IIO_CHAN_INFO_CALIBBIAS_SEPARATE),
+		(1 << IIO_CHAN_INFO_CALIBBIAS_SEPARATE) |
+		(1 << IIO_CHAN_INFO_SCALE_SEPARATE),
+	}, {
+		.type = IIO_CAPACITANCE,
+		.indexed = 1,
+		.channel = 1,
+		.info_mask = (1 << IIO_CHAN_INFO_CALIBSCALE_SEPARATE) |
+		(1 << IIO_CHAN_INFO_CALIBBIAS_SEPARATE) |
+		(1 << IIO_CHAN_INFO_SCALE_SEPARATE),
+	}, {
+		.type = IIO_CAPACITANCE,
+		.differential = 1,
+		.indexed = 1,
+		.channel = 0,
+		.channel2 = 2,
+		.info_mask = (1 << IIO_CHAN_INFO_CALIBSCALE_SEPARATE) |
+		(1 << IIO_CHAN_INFO_CALIBBIAS_SEPARATE) |
+		(1 << IIO_CHAN_INFO_SCALE_SEPARATE),
 	}, {
 		.type = IIO_CAPACITANCE,
+		.differential = 1,
 		.indexed = 1,
 		.channel = 1,
+		.channel2 = 3,
 		.info_mask = (1 << IIO_CHAN_INFO_CALIBSCALE_SEPARATE) |
-		(1 << IIO_CHAN_INFO_CALIBBIAS_SEPARATE),
+		(1 << IIO_CHAN_INFO_CALIBBIAS_SEPARATE) |
+		(1 << IIO_CHAN_INFO_SCALE_SEPARATE),
 	}
 };
 /*
@@ -404,7 +368,7 @@ static int __devinit ad7152_probe(struct i2c_client *client,
 	if (id->driver_data == 0)
 		indio_dev->num_channels = ARRAY_SIZE(ad7152_channels);
 	else
-		indio_dev->num_channels = 1;
+		indio_dev->num_channels = 2;
 	indio_dev->num_channels = ARRAY_SIZE(ad7152_channels);
 	indio_dev->modes = INDIO_DIRECT_MODE;
 
-- 
1.7.3.4
