Return-Path: <linux-iio-owner@vger.kernel.org>
Received: from smtp-out-020.synserver.de ([212.40.185.20]:1052 "EHLO
	smtp-out-017.synserver.de" rhost-flags-OK-OK-OK-FAIL)
	by vger.kernel.org with ESMTP id S1755472Ab3JGOJz (ORCPT
	<rfc822;linux-iio@vger.kernel.org>); Mon, 7 Oct 2013 10:09:55 -0400
From: Lars-Peter Clausen <lars@metafoo.de>
To: Jonathan Cameron <jic23@kernel.org>
Cc: linux-iio@vger.kernel.org, Lars-Peter Clausen <lars@metafoo.de>
Subject: [PATCH v2 19/20] staging:iio:ad7291: Use event spec for threshold hysteresis
Date: Mon,  7 Oct 2013 16:11:33 +0200
Message-Id: <1381155094-20166-19-git-send-email-lars@metafoo.de>
In-Reply-To: <1381155094-20166-1-git-send-email-lars@metafoo.de>
References: <1381155094-20166-1-git-send-email-lars@metafoo.de>
Sender: linux-iio-owner@vger.kernel.org
List-Id: linux-iio@vger.kernel.org

Register the event threshold hysteresis attributes by using the new
IIO_EV_INFO_HYSTERESIS event spec type. This allows us to throw away a good
portion of boiler-plate code.

Signed-off-by: Lars-Peter Clausen <lars@metafoo.de>
---
 drivers/staging/iio/adc/ad7291.c | 139 ++++++++-------------------------------
 1 file changed, 28 insertions(+), 111 deletions(-)

diff --git a/drivers/staging/iio/adc/ad7291.c b/drivers/staging/iio/adc/ad7291.c
index be4d93a..d13f8ae 100644
--- a/drivers/staging/iio/adc/ad7291.c
+++ b/drivers/staging/iio/adc/ad7291.c
@@ -164,92 +164,8 @@ static irqreturn_t ad7291_event_handler(int irq, void *private)
 	return IRQ_HANDLED;
 }
 
-static inline ssize_t ad7291_show_hyst(struct device *dev,
-		struct device_attribute *attr,
-		char *buf)
-{
-	struct iio_dev *indio_dev = dev_to_iio_dev(dev);
-	struct ad7291_chip_info *chip = iio_priv(indio_dev);
-	struct iio_dev_attr *this_attr = to_iio_dev_attr(attr);
-	u16 data;
-	int ret;
-
-	ret = ad7291_i2c_read(chip, this_attr->address, &data);
-	if (ret < 0)
-		return ret;
-
-	return sprintf(buf, "%d\n", data & AD7291_VALUE_MASK);
-}
-
-static inline ssize_t ad7291_set_hyst(struct device *dev,
-				      struct device_attribute *attr,
-				      const char *buf,
-				      size_t len)
-{
-	struct iio_dev *indio_dev = dev_to_iio_dev(dev);
-	struct ad7291_chip_info *chip = iio_priv(indio_dev);
-	struct iio_dev_attr *this_attr = to_iio_dev_attr(attr);
-	u16 data;
-	int ret;
-
-	ret = kstrtou16(buf, 10, &data);
-
-	if (ret < 0)
-		return ret;
-	if (data > AD7291_VALUE_MASK)
-		return -EINVAL;
-
-	ret = ad7291_i2c_write(chip, this_attr->address, data);
-	if (ret < 0)
-		return ret;
-
-	return len;
-}
-
-static IIO_DEVICE_ATTR(in_temp0_thresh_both_hyst_raw,
-		       S_IRUGO | S_IWUSR,
-		       ad7291_show_hyst, ad7291_set_hyst,
-		       AD7291_HYST(8));
-static IIO_DEVICE_ATTR(in_voltage0_thresh_both_hyst_raw,
-		       S_IRUGO | S_IWUSR,
-		       ad7291_show_hyst, ad7291_set_hyst, AD7291_HYST(0));
-static IIO_DEVICE_ATTR(in_voltage1_thresh_both_hyst_raw,
-		       S_IRUGO | S_IWUSR,
-		       ad7291_show_hyst, ad7291_set_hyst, AD7291_HYST(1));
-static IIO_DEVICE_ATTR(in_voltage2_thresh_both_hyst_raw,
-		       S_IRUGO | S_IWUSR,
-		       ad7291_show_hyst, ad7291_set_hyst, AD7291_HYST(2));
-static IIO_DEVICE_ATTR(in_voltage3_thresh_both_hyst_raw,
-		       S_IRUGO | S_IWUSR,
-		       ad7291_show_hyst, ad7291_set_hyst, AD7291_HYST(3));
-static IIO_DEVICE_ATTR(in_voltage4_thresh_both_hyst_raw,
-		       S_IRUGO | S_IWUSR,
-		       ad7291_show_hyst, ad7291_set_hyst, AD7291_HYST(4));
-static IIO_DEVICE_ATTR(in_voltage5_thresh_both_hyst_raw,
-		       S_IRUGO | S_IWUSR,
-		       ad7291_show_hyst, ad7291_set_hyst, AD7291_HYST(5));
-static IIO_DEVICE_ATTR(in_voltage6_thresh_both_hyst_raw,
-		       S_IRUGO | S_IWUSR,
-		       ad7291_show_hyst, ad7291_set_hyst, AD7291_HYST(6));
-static IIO_DEVICE_ATTR(in_voltage7_thresh_both_hyst_raw,
-		       S_IRUGO | S_IWUSR,
-		       ad7291_show_hyst, ad7291_set_hyst, AD7291_HYST(7));
-
-static struct attribute *ad7291_event_attributes[] = {
-	&iio_dev_attr_in_temp0_thresh_both_hyst_raw.dev_attr.attr,
-	&iio_dev_attr_in_voltage0_thresh_both_hyst_raw.dev_attr.attr,
-	&iio_dev_attr_in_voltage1_thresh_both_hyst_raw.dev_attr.attr,
-	&iio_dev_attr_in_voltage2_thresh_both_hyst_raw.dev_attr.attr,
-	&iio_dev_attr_in_voltage3_thresh_both_hyst_raw.dev_attr.attr,
-	&iio_dev_attr_in_voltage4_thresh_both_hyst_raw.dev_attr.attr,
-	&iio_dev_attr_in_voltage5_thresh_both_hyst_raw.dev_attr.attr,
-	&iio_dev_attr_in_voltage6_thresh_both_hyst_raw.dev_attr.attr,
-	&iio_dev_attr_in_voltage7_thresh_both_hyst_raw.dev_attr.attr,
-	NULL,
-};
-
 static unsigned int ad7291_threshold_reg(const struct iio_chan_spec *chan,
-	enum iio_event_direction dir)
+	enum iio_event_direction dir, enum iio_event_info info)
 {
 	unsigned int offset;
 
@@ -264,10 +180,18 @@ static unsigned int ad7291_threshold_reg(const struct iio_chan_spec *chan,
 	    return 0;
 	}
 
-	if (dir == IIO_EV_DIR_FALLING)
-		return AD7291_DATA_LOW(offset);
-	else
-		return AD7291_DATA_HIGH(offset);
+	switch (info) {
+	case IIO_EV_INFO_VALUE:
+			if (dir == IIO_EV_DIR_FALLING)
+					return AD7291_DATA_HIGH(offset);
+			else
+					return AD7291_DATA_LOW(offset);
+	case IIO_EV_INFO_HYSTERESIS:
+			return AD7291_HYST(offset);
+	default:
+			break;
+	}
+	return 0;
 }
 
 static int ad7291_read_event_value(struct iio_dev *indio_dev,
@@ -281,20 +205,18 @@ static int ad7291_read_event_value(struct iio_dev *indio_dev,
 	int ret;
 	u16 uval;
 
-	ret = ad7291_i2c_read(chip, ad7291_threshold_reg(chan, dir), &uval);
+	ret = ad7291_i2c_read(chip, ad7291_threshold_reg(chan, dir, info),
+		&uval);
 	if (ret < 0)
 		return ret;
 
-	switch (chan->type) {
-	case IIO_VOLTAGE:
+	if (info == IIO_EV_INFO_HYSTERESIS || chan->type == IIO_VOLTAGE)
 		*val = uval & AD7291_VALUE_MASK;
-		return IIO_VAL_INT;
-	case IIO_TEMP:
+
+	else
 		*val = sign_extend32(uval, 11);
-		return IIO_VAL_INT;
-	default:
-		return -EINVAL;
-	};
+
+	return IIO_VAL_INT;
 }
 
 static int ad7291_write_event_value(struct iio_dev *indio_dev,
@@ -306,20 +228,16 @@ static int ad7291_write_event_value(struct iio_dev *indio_dev,
 {
 	struct ad7291_chip_info *chip = iio_priv(indio_dev);
 
-	switch (chan->type) {
-	case IIO_VOLTAGE:
+	if (info == IIO_EV_INFO_HYSTERESIS || chan->type == IIO_VOLTAGE) {
 		if (val > AD7291_VALUE_MASK || val < 0)
 			return -EINVAL;
-		break;
-	case IIO_TEMP:
+	} else {
 		if (val > 2047 || val < -2048)
 			return -EINVAL;
-		break;
-	default:
-		return -EINVAL;
 	}
 
-	return ad7291_i2c_write(chip, ad7291_threshold_reg(chan, dir), val);
+	return ad7291_i2c_write(chip, ad7291_threshold_reg(chan, dir, info),
+		val);
 }
 
 static int ad7291_read_event_config(struct iio_dev *indio_dev,
@@ -493,6 +411,10 @@ static const struct iio_event_spec ad7291_events[] = {
 		.dir = IIO_EV_DIR_FALLING,
 		.mask_separate = BIT(IIO_EV_INFO_VALUE) |
 			BIT(IIO_EV_INFO_ENABLE),
+	}, {
+		.type = IIO_EV_TYPE_THRESH,
+		.dir = IIO_EV_DIR_EITHER,
+		.mask_separate = BIT(IIO_EV_INFO_HYSTERESIS),
 	},
 };
 
@@ -528,17 +450,12 @@ static const struct iio_chan_spec ad7291_channels[] = {
 	}
 };
 
-static struct attribute_group ad7291_event_attribute_group = {
-	.attrs = ad7291_event_attributes,
-};
-
 static const struct iio_info ad7291_info = {
 	.read_raw = &ad7291_read_raw,
 	.read_event_config_new = &ad7291_read_event_config,
 	.write_event_config_new = &ad7291_write_event_config,
 	.read_event_value_new = &ad7291_read_event_value,
 	.write_event_value_new = &ad7291_write_event_value,
-	.event_attrs = &ad7291_event_attribute_group,
 	.driver_module = THIS_MODULE,
 };
 
-- 
1.8.0

