Return-Path: <jic23@cam.ac.uk>
From: Jonathan Cameron <jic23@cam.ac.uk>
To: linux-iio@vger.kernel.org
Cc: Michael Hennerich <michael.hennerich@analog.com>,
	Jonathan Cameron <jic23@cam.ac.uk>
Subject: [PATCH 03/16] staging:iio:adc:ad7150: remove conversion mode handling.
Date: Fri, 26 Aug 2011 11:19:20 +0100
Message-Id: <1314353973-7662-4-git-send-email-jic23@cam.ac.uk>
In-Reply-To: <1314353973-7662-1-git-send-email-jic23@cam.ac.uk>
References: <1314353973-7662-1-git-send-email-jic23@cam.ac.uk>
List-ID: <linux-iio@vger.kernel.org>

From: Michael Hennerich <michael.hennerich@analog.com>

The AD7150 family of devices power up in continues conversion mode.
We can stay in this mode, unless power consumption becomes a real issue.
Actually the event generation as well as the running average
relies on continues conversion mode, so we better stay there.

Signed-off-by: Michael Hennerich <michael.hennerich@analog.com>
Signed-off-by: Jonathan Cameron <jic23@cam.ac.uk>
---
 drivers/staging/iio/adc/ad7150.c |   94 --------------------------------------
 1 files changed, 0 insertions(+), 94 deletions(-)

diff --git a/drivers/staging/iio/adc/ad7150.c b/drivers/staging/iio/adc/ad7150.c
index 0eb1992..deb0339 100644
--- a/drivers/staging/iio/adc/ad7150.c
+++ b/drivers/staging/iio/adc/ad7150.c
@@ -88,93 +88,10 @@ struct ad7150_chip_info {
 	struct mutex state_lock;
 };
 
-struct ad7150_conversion_mode {
-	char *name;
-	u8 reg_cfg;
-};
-
-static struct ad7150_conversion_mode
-ad7150_conv_mode_table[AD7150_MAX_CONV_MODE] = {
-	{ "idle", 0 },
-	{ "continuous-conversion", 1 },
-	{ "single-conversion", 2 },
-	{ "power-down", 3 },
-};
-
 /*
  * sysfs nodes
  */
 
-#define IIO_DEV_ATTR_AVAIL_CONVERSION_MODES(_show)			\
-	IIO_DEVICE_ATTR(available_conversion_modes, S_IRUGO, _show, NULL, 0)
-#define IIO_DEV_ATTR_CONVERSION_MODE(_mode, _show, _store)              \
-	IIO_DEVICE_ATTR(conversion_mode, _mode, _show, _store, 0)
-
-static ssize_t ad7150_show_conversion_modes(struct device *dev,
-		struct device_attribute *attr,
-		char *buf)
-{
-	int i;
-	int len = 0;
-
-	for (i = 0; i < AD7150_MAX_CONV_MODE; i++)
-		len += sprintf(buf + len, "%s\n",
-			       ad7150_conv_mode_table[i].name);
-
-	return len;
-}
-
-static IIO_DEV_ATTR_AVAIL_CONVERSION_MODES(ad7150_show_conversion_modes);
-
-static ssize_t ad7150_show_conversion_mode(struct device *dev,
-		struct device_attribute *attr,
-		char *buf)
-{
-	struct iio_dev *dev_info = dev_get_drvdata(dev);
-	struct ad7150_chip_info *chip = iio_priv(dev_info);
-
-	return sprintf(buf, "%s\n", chip->conversion_mode);
-}
-
-static ssize_t ad7150_store_conversion_mode(struct device *dev,
-		struct device_attribute *attr,
-		const char *buf,
-		size_t len)
-{
-	struct iio_dev *dev_info = dev_get_drvdata(dev);
-	struct ad7150_chip_info *chip = iio_priv(dev_info);
-	u8 cfg;
-	int i, ret;
-
-	ret = i2c_smbus_read_byte_data(chip->client, AD7150_CFG);
-	if (ret < 0)
-		return ret;
-	cfg = ret;
-
-	for (i = 0; i < AD7150_MAX_CONV_MODE; i++) {
-		if (strncmp(buf, ad7150_conv_mode_table[i].name,
-				strlen(ad7150_conv_mode_table[i].name) - 1) ==
-		    0) {
-			chip->conversion_mode = ad7150_conv_mode_table[i].name;
-			cfg |= 0x18 | ad7150_conv_mode_table[i].reg_cfg;
-			ret = i2c_smbus_write_byte_data(chip->client,
-							AD7150_CFG,
-							cfg);
-			if (ret < 0)
-				return ret;
-			return len;
-		}
-	}
-
-	dev_err(dev, "not supported conversion mode\n");
-
-	return -EINVAL;
-}
-
-static IIO_DEV_ATTR_CONVERSION_MODE(S_IRUGO | S_IWUSR,
-		ad7150_show_conversion_mode,
-		ad7150_store_conversion_mode);
-
 static const u8 ad7150_addresses[][6] = {
 	{ AD7150_CH1_DATA_HIGH, AD7150_CH1_AVG_HIGH,
 	  AD7150_CH1_SETUP, AD7150_CH1_THR_HOLD_H,
@@ -542,16 +459,6 @@ static const struct iio_chan_spec ad7150_channels[] = {
 	},
 };
 
-static struct attribute *ad7150_attributes[] = {
-	&iio_dev_attr_available_conversion_modes.dev_attr.attr,
-	&iio_dev_attr_conversion_mode.dev_attr.attr,
-	NULL,
-};
-
-static const struct attribute_group ad7150_attribute_group = {
-	.attrs = ad7150_attributes,
-};
-
 /*
  * threshold events
  */
@@ -636,7 +543,6 @@ static struct attribute_group ad7150_event_attribute_group = {
 };
 
 static const struct iio_info ad7150_info = {
-	.attrs = &ad7150_attribute_group,
 	.event_attrs = &ad7150_event_attribute_group,
 	.driver_module = THIS_MODULE,
 	.read_raw = &ad7150_read_raw,
-- 
1.7.3.4
