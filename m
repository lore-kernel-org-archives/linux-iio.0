Return-Path: <linux-iio-owner@vger.kernel.org>
Received: from mail-pg0-f68.google.com ([74.125.83.68]:34264 "EHLO
        mail-pg0-f68.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1752117AbcLINam (ORCPT
        <rfc822;linux-iio@vger.kernel.org>); Fri, 9 Dec 2016 08:30:42 -0500
From: Eva Rachel Retuya <eraretuya@gmail.com>
To: linux-iio@vger.kernel.org, devel@driverdev.osuosl.org,
        linux-kernel@vger.kernel.org
Cc: lars@metafoo.de, Michael.Hennerich@analog.com, jic23@kernel.org,
        knaack.h@gmx.de, pmeerw@pmeerw.net, gregkh@linuxfoundation.org,
        Eva Rachel Retuya <eraretuya@gmail.com>
Subject: [PATCH v2 1/2] staging: iio: ad7606: replace range/range_available with corresponding scale
Date: Fri,  9 Dec 2016 21:30:01 +0800
Message-Id: <283f3a0338e0227e03aa893418e134aaed79788e.1481289277.git.eraretuya@gmail.com>
In-Reply-To: <cover.1481289277.git.eraretuya@gmail.com>
References: <cover.1481289277.git.eraretuya@gmail.com>
In-Reply-To: <cover.1481289277.git.eraretuya@gmail.com>
References: <cover.1481289277.git.eraretuya@gmail.com>
Sender: linux-iio-owner@vger.kernel.org
List-Id: linux-iio@vger.kernel.org

Eliminate the non-standard attributes in_voltage_range and
in_voltage_range_available. Implement in_voltage_scale_available in place
of these attributes and update the SCALE accordingly. The array
scale_avail is introduced to hold the available scale values.

Signed-off-by: Eva Rachel Retuya <eraretuya@gmail.com>
---
Changes in v2:
* Update commit message to reflect changes.
* Introduce scale_avail[] array to hold the available scales.
* Rewrite read_raw's SCALE to make use of the scale_avail[].
* Provide write_raw and write_raw_get_fmt for implementing SCALE.
* Populate the scale_avail[] with values in probe().

 drivers/staging/iio/adc/ad7606.c | 99 ++++++++++++++++++++++++----------------
 drivers/staging/iio/adc/ad7606.h |  1 +
 2 files changed, 61 insertions(+), 39 deletions(-)

diff --git a/drivers/staging/iio/adc/ad7606.c b/drivers/staging/iio/adc/ad7606.c
index 4531908..7a9471d 100644
--- a/drivers/staging/iio/adc/ad7606.c
+++ b/drivers/staging/iio/adc/ad7606.c
@@ -151,9 +151,9 @@ static int ad7606_read_raw(struct iio_dev *indio_dev,
 		*val = (short)ret;
 		return IIO_VAL_INT;
 	case IIO_CHAN_INFO_SCALE:
-		*val = st->range * 2;
-		*val2 = st->chip_info->channels[0].scan_type.realbits;
-		return IIO_VAL_FRACTIONAL_LOG2;
+		*val = st->scale_avail[st->range][0];
+		*val2 = st->scale_avail[st->range][1];
+		return IIO_VAL_INT_PLUS_NANO;
 	case IIO_CHAN_INFO_OVERSAMPLING_RATIO:
 		*val = st->oversampling;
 		return IIO_VAL_INT;
@@ -161,42 +161,24 @@ static int ad7606_read_raw(struct iio_dev *indio_dev,
 	return -EINVAL;
 }
 
-static ssize_t ad7606_show_range(struct device *dev,
-				 struct device_attribute *attr, char *buf)
+static ssize_t in_voltage_scale_available_show(struct device *dev,
+					       struct device_attribute *attr,
+					       char *buf)
 {
 	struct iio_dev *indio_dev = dev_to_iio_dev(dev);
 	struct ad7606_state *st = iio_priv(indio_dev);
+	int i, len = 0;
 
-	return sprintf(buf, "%u\n", st->range);
-}
-
-static ssize_t ad7606_store_range(struct device *dev,
-				  struct device_attribute *attr,
-				  const char *buf, size_t count)
-{
-	struct iio_dev *indio_dev = dev_to_iio_dev(dev);
-	struct ad7606_state *st = iio_priv(indio_dev);
-	unsigned long lval;
-	int ret;
-
-	ret = kstrtoul(buf, 10, &lval);
-	if (ret)
-		return ret;
-
-	if (!(lval == 5000 || lval == 10000))
-		return -EINVAL;
+	for (i = 0; i < ARRAY_SIZE(st->scale_avail); i++)
+		len += scnprintf(buf + len, PAGE_SIZE - len, "%d.%09u ",
+				 st->scale_avail[i][0], st->scale_avail[i][1]);
 
-	mutex_lock(&indio_dev->mlock);
-	gpiod_set_value(st->gpio_range, lval == 10000);
-	st->range = lval;
-	mutex_unlock(&indio_dev->mlock);
+	buf[len - 1] = '\n';
 
-	return count;
+	return len;
 }
 
-static IIO_DEVICE_ATTR(in_voltage_range, S_IRUGO | S_IWUSR,
-		       ad7606_show_range, ad7606_store_range, 0);
-static IIO_CONST_ATTR(in_voltage_range_available, "5000 10000");
+static IIO_DEVICE_ATTR_RO(in_voltage_scale_available, 0);
 
 static int ad7606_oversampling_get_index(unsigned int val)
 {
@@ -218,9 +200,23 @@ static int ad7606_write_raw(struct iio_dev *indio_dev,
 {
 	struct ad7606_state *st = iio_priv(indio_dev);
 	int values[3];
-	int ret;
+	int ret, i;
 
 	switch (mask) {
+	case IIO_CHAN_INFO_SCALE:
+		ret = -EINVAL;
+		mutex_lock(&indio_dev->mlock);
+		for (i = 0; i < ARRAY_SIZE(st->scale_avail); i++)
+			if (val2 == st->scale_avail[i][1]) {
+				gpiod_set_value(st->gpio_range, i);
+				st->range = i;
+
+				ret = 0;
+				break;
+			}
+		mutex_unlock(&indio_dev->mlock);
+
+		return ret;
 	case IIO_CHAN_INFO_OVERSAMPLING_RATIO:
 		if (val2)
 			return -EINVAL;
@@ -244,11 +240,22 @@ static int ad7606_write_raw(struct iio_dev *indio_dev,
 	}
 }
 
+static int ad7606_write_raw_get_fmt(struct iio_dev *indio_dev,
+				    struct iio_chan_spec const *chan,
+				    long mask)
+{
+	switch (mask) {
+	case IIO_CHAN_INFO_SCALE:
+		return IIO_VAL_INT_PLUS_NANO;
+	default:
+		return -EINVAL;
+	}
+}
+
 static IIO_CONST_ATTR(oversampling_ratio_available, "1 2 4 8 16 32 64");
 
 static struct attribute *ad7606_attributes_os_and_range[] = {
-	&iio_dev_attr_in_voltage_range.dev_attr.attr,
-	&iio_const_attr_in_voltage_range_available.dev_attr.attr,
+	&iio_dev_attr_in_voltage_scale_available.dev_attr.attr,
 	&iio_const_attr_oversampling_ratio_available.dev_attr.attr,
 	NULL,
 };
@@ -267,8 +274,7 @@ static const struct attribute_group ad7606_attribute_group_os = {
 };
 
 static struct attribute *ad7606_attributes_range[] = {
-	&iio_dev_attr_in_voltage_range.dev_attr.attr,
-	&iio_const_attr_in_voltage_range_available.dev_attr.attr,
+	&iio_dev_attr_in_voltage_scale_available.dev_attr.attr,
 	NULL,
 };
 
@@ -384,6 +390,7 @@ static const struct iio_info ad7606_info_os_and_range = {
 	.driver_module = THIS_MODULE,
 	.read_raw = &ad7606_read_raw,
 	.write_raw = &ad7606_write_raw,
+	.write_raw_get_fmt = &ad7606_write_raw_get_fmt,
 	.attrs = &ad7606_attribute_group_os_and_range,
 };
 
@@ -397,6 +404,8 @@ static const struct iio_info ad7606_info_os = {
 static const struct iio_info ad7606_info_range = {
 	.driver_module = THIS_MODULE,
 	.read_raw = &ad7606_read_raw,
+	.write_raw = &ad7606_write_raw,
+	.write_raw_get_fmt = &ad7606_write_raw_get_fmt,
 	.attrs = &ad7606_attribute_group_range,
 };
 
@@ -405,7 +414,8 @@ int ad7606_probe(struct device *dev, int irq, void __iomem *base_address,
 		 const struct ad7606_bus_ops *bops)
 {
 	struct ad7606_state *st;
-	int ret;
+	unsigned int scale, range;
+	int ret, i, j;
 	struct iio_dev *indio_dev;
 
 	indio_dev = devm_iio_device_alloc(dev, sizeof(*st));
@@ -417,8 +427,19 @@ int ad7606_probe(struct device *dev, int irq, void __iomem *base_address,
 	st->dev = dev;
 	st->bops = bops;
 	st->base_address = base_address;
-	st->range = 5000;
+	/* tied to logic low, analog input range is +/- 5V */
+	st->range = 0;
 	st->oversampling = 1;
+	/* Populate the scales, 2.5/2**16 then 5/2**16 */
+	range = 5000;
+	for (i = 0, j = 1; i < ARRAY_SIZE(st->scale_avail); i++, j--) {
+		scale = ((u64)range * 100000000) >>
+			ad7606_channels[1].scan_type.realbits;
+		scale >>= j;
+
+		st->scale_avail[i][1] = do_div(scale, 100000000) * 10;
+		st->scale_avail[i][0] = scale;
+	}
 	INIT_WORK(&st->poll_work, &ad7606_poll_bh_to_ring);
 
 	st->reg = devm_regulator_get(dev, "avcc");
@@ -525,7 +546,7 @@ static int ad7606_resume(struct device *dev)
 	struct ad7606_state *st = iio_priv(indio_dev);
 
 	if (st->gpio_standby) {
-		gpiod_set_value(st->gpio_range, st->range == 10000);
+		gpiod_set_value(st->gpio_range, st->range);
 		gpiod_set_value(st->gpio_standby, 1);
 		ad7606_reset(st);
 	}
diff --git a/drivers/staging/iio/adc/ad7606.h b/drivers/staging/iio/adc/ad7606.h
index 746f955..671c456 100644
--- a/drivers/staging/iio/adc/ad7606.h
+++ b/drivers/staging/iio/adc/ad7606.h
@@ -34,6 +34,7 @@ struct ad7606_state {
 	const struct ad7606_bus_ops	*bops;
 	unsigned int			range;
 	unsigned int			oversampling;
+	unsigned int			scale_avail[2][2];
 	bool				done;
 	void __iomem			*base_address;
 
-- 
2.7.4

