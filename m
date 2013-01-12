Return-Path: <linux-iio-owner@vger.kernel.org>
Received: from ppsw-41.csi.cam.ac.uk ([131.111.8.141]:52171 "EHLO
	ppsw-41.csi.cam.ac.uk" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751735Ab3ALKmY (ORCPT
	<rfc822;linux-iio@vger.kernel.org>); Sat, 12 Jan 2013 05:42:24 -0500
From: Jonathan Cameron <jic23@kernel.org>
To: linux-iio@vger.kernel.org
Cc: jbrenner@taosinc.com, Jonathan Cameron <jic23@kernel.org>
Subject: [PATCH 1/3] staging:iio:light:tsl2583 use read_raw, write_raw hooks.
Date: Sat, 12 Jan 2013 10:42:17 +0000
Message-Id: <1357987339-11800-2-git-send-email-jic23@kernel.org>
In-Reply-To: <1357987339-11800-1-git-send-email-jic23@kernel.org>
References: <1357987339-11800-1-git-send-email-jic23@kernel.org>
Sender: linux-iio-owner@vger.kernel.org
List-Id: linux-iio@vger.kernel.org

This driver predates the introduction of these hooks that both reduce
the amount of code needed to provide basic interfaces and allow for
inkernel access to these values from other drivers.

This will change a few interfaces by applying an in_ prefix.
The rest of the driver will be brought in line with this convention
in a follow up patch.

Signed-off-by: Jonathan Cameron <jic23@kernel.org>
---
 drivers/staging/iio/light/tsl2583.c | 187 ++++++++++++++++--------------------
 1 file changed, 85 insertions(+), 102 deletions(-)

diff --git a/drivers/staging/iio/light/tsl2583.c b/drivers/staging/iio/light/tsl2583.c
index b377dd3..30c1a36 100644
--- a/drivers/staging/iio/light/tsl2583.c
+++ b/drivers/staging/iio/light/tsl2583.c
@@ -506,62 +506,6 @@ static ssize_t taos_power_state_store(struct device *dev,
 	return len;
 }
 
-static ssize_t taos_gain_show(struct device *dev,
-	struct device_attribute *attr, char *buf)
-{
-	struct iio_dev *indio_dev = dev_to_iio_dev(dev);
-	struct tsl2583_chip *chip = iio_priv(indio_dev);
-	char gain[4] = {0};
-
-	switch (chip->taos_settings.als_gain) {
-	case 0:
-		strcpy(gain, "001");
-		break;
-	case 1:
-		strcpy(gain, "008");
-		break;
-	case 2:
-		strcpy(gain, "016");
-		break;
-	case 3:
-		strcpy(gain, "111");
-		break;
-	}
-
-	return sprintf(buf, "%s\n", gain);
-}
-
-static ssize_t taos_gain_store(struct device *dev,
-	struct device_attribute *attr, const char *buf, size_t len)
-{
-	struct iio_dev *indio_dev = dev_to_iio_dev(dev);
-	struct tsl2583_chip *chip = iio_priv(indio_dev);
-	unsigned long value;
-
-	if (strict_strtoul(buf, 0, &value))
-		return -EINVAL;
-
-	switch (value) {
-	case 1:
-		chip->taos_settings.als_gain = 0;
-		break;
-	case 8:
-		chip->taos_settings.als_gain = 1;
-		break;
-	case 16:
-		chip->taos_settings.als_gain = 2;
-		break;
-	case 111:
-		chip->taos_settings.als_gain = 3;
-		break;
-	default:
-		dev_err(dev, "Invalid Gain Index (must be 1,8,16,111)\n");
-		return -1;
-	}
-
-	return len;
-}
-
 static ssize_t taos_gain_available_show(struct device *dev,
 	struct device_attribute *attr, char *buf)
 {
@@ -605,31 +549,6 @@ static ssize_t taos_als_time_available_show(struct device *dev,
 		"50 100 150 200 250 300 350 400 450 500 550 600 650");
 }
 
-static ssize_t taos_als_trim_show(struct device *dev,
-	struct device_attribute *attr, char *buf)
-{
-	struct iio_dev *indio_dev = dev_to_iio_dev(dev);
-	struct tsl2583_chip *chip = iio_priv(indio_dev);
-
-	return sprintf(buf, "%d\n", chip->taos_settings.als_gain_trim);
-}
-
-static ssize_t taos_als_trim_store(struct device *dev,
-	struct device_attribute *attr, const char *buf, size_t len)
-{
-	struct iio_dev *indio_dev = dev_to_iio_dev(dev);
-	struct tsl2583_chip *chip = iio_priv(indio_dev);
-	unsigned long value;
-
-	if (strict_strtoul(buf, 0, &value))
-		return -EINVAL;
-
-	if (value)
-		chip->taos_settings.als_gain_trim = value;
-
-	return len;
-}
-
 static ssize_t taos_als_cal_target_show(struct device *dev,
 	struct device_attribute *attr, char *buf)
 {
@@ -655,18 +574,6 @@ static ssize_t taos_als_cal_target_store(struct device *dev,
 	return len;
 }
 
-static ssize_t taos_lux_show(struct device *dev, struct device_attribute *attr,
-	char *buf)
-{
-	int ret;
-
-	ret = taos_get_lux(dev_to_iio_dev(dev));
-	if (ret < 0)
-		return ret;
-
-	return sprintf(buf, "%d\n", ret);
-}
-
 static ssize_t taos_do_calibrate(struct device *dev,
 	struct device_attribute *attr, const char *buf, size_t len)
 {
@@ -745,8 +652,6 @@ static ssize_t taos_luxtable_store(struct device *dev,
 static DEVICE_ATTR(power_state, S_IRUGO | S_IWUSR,
 		taos_power_state_show, taos_power_state_store);
 
-static DEVICE_ATTR(illuminance0_calibscale, S_IRUGO | S_IWUSR,
-		taos_gain_show, taos_gain_store);
 static DEVICE_ATTR(illuminance0_calibscale_available, S_IRUGO,
 		taos_gain_available_show, NULL);
 
@@ -755,26 +660,19 @@ static DEVICE_ATTR(illuminance0_integration_time, S_IRUGO | S_IWUSR,
 static DEVICE_ATTR(illuminance0_integration_time_available, S_IRUGO,
 		taos_als_time_available_show, NULL);
 
-static DEVICE_ATTR(illuminance0_calibbias, S_IRUGO | S_IWUSR,
-		taos_als_trim_show, taos_als_trim_store);
-
 static DEVICE_ATTR(illuminance0_input_target, S_IRUGO | S_IWUSR,
 		taos_als_cal_target_show, taos_als_cal_target_store);
 
-static DEVICE_ATTR(illuminance0_input, S_IRUGO, taos_lux_show, NULL);
 static DEVICE_ATTR(illuminance0_calibrate, S_IWUSR, NULL, taos_do_calibrate);
 static DEVICE_ATTR(illuminance0_lux_table, S_IRUGO | S_IWUSR,
 		taos_luxtable_show, taos_luxtable_store);
 
 static struct attribute *sysfs_attrs_ctrl[] = {
 	&dev_attr_power_state.attr,
-	&dev_attr_illuminance0_calibscale.attr,			/* Gain  */
 	&dev_attr_illuminance0_calibscale_available.attr,
 	&dev_attr_illuminance0_integration_time.attr,	/* I time*/
 	&dev_attr_illuminance0_integration_time_available.attr,
-	&dev_attr_illuminance0_calibbias.attr,			/* trim  */
 	&dev_attr_illuminance0_input_target.attr,
-	&dev_attr_illuminance0_input.attr,
 	&dev_attr_illuminance0_calibrate.attr,
 	&dev_attr_illuminance0_lux_table.attr,
 	NULL
@@ -790,9 +688,92 @@ static int taos_tsl258x_device(unsigned char *bufp)
 	return ((bufp[TSL258X_CHIPID] & 0xf0) == 0x90);
 }
 
+static const int tsl2583_scales[] = {1, 8, 16, 111 };
+
+static int tsl2583_write_raw(struct iio_dev *indio_dev,
+			     struct iio_chan_spec const *chan,
+			     int val,
+			     int val2, 
+			     long m)
+{
+	struct tsl2583_chip *chip = iio_priv(indio_dev);
+	int ret = 0;
+
+	switch (m) {
+	case IIO_CHAN_INFO_CALIBBIAS:
+		chip->taos_settings.als_gain_trim = val;
+		break;
+	case IIO_CHAN_INFO_CALIBSCALE:
+		switch (val) {
+		case 1:
+			chip->taos_settings.als_gain = 0;
+			break;
+		case 8:
+			chip->taos_settings.als_gain = 1;
+			break;
+		case 16:
+			chip->taos_settings.als_gain = 2;
+			break;
+		case 111:
+			chip->taos_settings.als_gain = 3;
+			break;
+		default:
+			ret = -EINVAL;
+		}
+	default:
+		ret = -EINVAL;
+	}
+	return ret;
+}
+
+static int tsl2583_read_raw(struct iio_dev *indio_dev,
+			    struct iio_chan_spec const *chan,
+			    int *val,
+			    int *val2,
+			    long m)
+{
+	struct tsl2583_chip *chip = iio_priv(indio_dev);
+	int ret;
+
+	switch (m) {
+	case IIO_CHAN_INFO_PROCESSED:
+		ret = taos_get_lux(indio_dev);
+		if (ret < 0)
+			return ret;
+		*val = ret;
+		ret = IIO_VAL_INT;
+		break;
+	case IIO_CHAN_INFO_CALIBBIAS:
+		*val = chip->taos_settings.als_gain_trim;
+		ret = IIO_VAL_INT;
+		break;
+	case IIO_CHAN_INFO_CALIBSCALE:
+		*val = tsl2583_scales[chip->taos_settings.als_gain];
+		ret = IIO_VAL_INT;
+		break;
+	default:
+		ret = -EINVAL;
+	}
+
+	return ret;
+}
+
+static const struct iio_chan_spec tsl2583_channels[] = {
+	{
+		.type = IIO_LIGHT,
+		.indexed = 1,
+		.info_mask = IIO_CHAN_INFO_PROCESSED_SEPARATE_BIT |
+		IIO_CHAN_INFO_CALIBSCALE_SEPARATE_BIT |
+		IIO_CHAN_INFO_CALIBBIAS_SEPARATE_BIT,
+		.channel = 0,
+	},
+};
+
 static const struct iio_info tsl2583_info = {
 	.attrs = &tsl2583_attribute_group,
 	.driver_module = THIS_MODULE,
+	.read_raw = &tsl2583_read_raw,
+	.write_raw = &tsl2583_write_raw,
 };
 
 /*
@@ -863,6 +844,8 @@ static int taos_probe(struct i2c_client *clientp,
 	indio_dev->info = &tsl2583_info;
 	indio_dev->dev.parent = &clientp->dev;
 	indio_dev->modes = INDIO_DIRECT_MODE;
+	indio_dev->channels = tsl2583_channels;
+	indio_dev->num_channels = ARRAY_SIZE(tsl2583_channels);
 	indio_dev->name = chip->client->name;
 	ret = iio_device_register(indio_dev);
 	if (ret) {
-- 
1.8.1

