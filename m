Return-Path: <linux-iio-owner@vger.kernel.org>
Received: from mail-pg0-f66.google.com ([74.125.83.66]:35924 "EHLO
        mail-pg0-f66.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1031972AbdAGLLR (ORCPT
        <rfc822;linux-iio@vger.kernel.org>); Sat, 7 Jan 2017 06:11:17 -0500
From: Eva Rachel Retuya <eraretuya@gmail.com>
To: linux-iio@vger.kernel.org, devel@driverdev.osuosl.org,
        linux-kernel@vger.kernel.org
Cc: lars@metafoo.de, Michael.Hennerich@analog.com, jic23@kernel.org,
        knaack.h@gmx.de, pmeerw@pmeerw.net, gregkh@linuxfoundation.org,
        daniel.baluta@gmail.com, amsfield22@gmail.com,
        Eva Rachel Retuya <eraretuya@gmail.com>
Subject: [PATCH v4] staging: iio: ad7606: replace range/range_available with corresponding scale
Date: Sat,  7 Jan 2017 19:10:23 +0800
Message-Id: <1483787423-7357-1-git-send-email-eraretuya@gmail.com>
Sender: linux-iio-owner@vger.kernel.org
List-Id: linux-iio@vger.kernel.org

Eliminate the non-standard attributes in_voltage_range and
in_voltage_range_available. Implement in_voltage_scale_available in place
of these attributes and update the SCALE accordingly. The array
scale_avail is introduced to hold the available scale values.

Signed-off-by: Eva Rachel Retuya <eraretuya@gmail.com>
---
Changes in v4:
* Drop the patch regarding move out of staging.
* Store the precomputed scales instead of computing them everytime.
* Switch from 9 digits accuracy to 6 digits, eliminates use of
  write_raw_get_fmt().

 drivers/staging/iio/adc/ad7606.c | 79 ++++++++++++++++++++--------------------
 1 file changed, 39 insertions(+), 40 deletions(-)

diff --git a/drivers/staging/iio/adc/ad7606.c b/drivers/staging/iio/adc/ad7606.c
index 4531908..9dbfa64 100644
--- a/drivers/staging/iio/adc/ad7606.c
+++ b/drivers/staging/iio/adc/ad7606.c
@@ -26,6 +26,11 @@
 
 #include "ad7606.h"
 
+/* Scales are computed as 2.5/2**16 and 5/2**16 respectively */
+static const unsigned int scale_avail[2][2] = {
+	{0, 38147}, {0, 76294}
+};
+
 static int ad7606_reset(struct ad7606_state *st)
 {
 	if (st->gpio_reset) {
@@ -151,9 +156,9 @@ static int ad7606_read_raw(struct iio_dev *indio_dev,
 		*val = (short)ret;
 		return IIO_VAL_INT;
 	case IIO_CHAN_INFO_SCALE:
-		*val = st->range * 2;
-		*val2 = st->chip_info->channels[0].scan_type.realbits;
-		return IIO_VAL_FRACTIONAL_LOG2;
+		*val = scale_avail[st->range][0];
+		*val2 = scale_avail[st->range][1];
+		return IIO_VAL_INT_PLUS_MICRO;
 	case IIO_CHAN_INFO_OVERSAMPLING_RATIO:
 		*val = st->oversampling;
 		return IIO_VAL_INT;
@@ -161,42 +166,22 @@ static int ad7606_read_raw(struct iio_dev *indio_dev,
 	return -EINVAL;
 }
 
-static ssize_t ad7606_show_range(struct device *dev,
-				 struct device_attribute *attr, char *buf)
-{
-	struct iio_dev *indio_dev = dev_to_iio_dev(dev);
-	struct ad7606_state *st = iio_priv(indio_dev);
-
-	return sprintf(buf, "%u\n", st->range);
-}
-
-static ssize_t ad7606_store_range(struct device *dev,
-				  struct device_attribute *attr,
-				  const char *buf, size_t count)
+static ssize_t in_voltage_scale_available_show(struct device *dev,
+					       struct device_attribute *attr,
+					       char *buf)
 {
-	struct iio_dev *indio_dev = dev_to_iio_dev(dev);
-	struct ad7606_state *st = iio_priv(indio_dev);
-	unsigned long lval;
-	int ret;
-
-	ret = kstrtoul(buf, 10, &lval);
-	if (ret)
-		return ret;
+	int i, len = 0;
 
-	if (!(lval == 5000 || lval == 10000))
-		return -EINVAL;
+	for (i = 0; i < ARRAY_SIZE(scale_avail); i++)
+		len += scnprintf(buf + len, PAGE_SIZE - len, "%d.%06u ",
+				 scale_avail[i][0], scale_avail[i][1]);
 
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
@@ -218,9 +203,23 @@ static int ad7606_write_raw(struct iio_dev *indio_dev,
 {
 	struct ad7606_state *st = iio_priv(indio_dev);
 	int values[3];
-	int ret;
+	int ret, i;
 
 	switch (mask) {
+	case IIO_CHAN_INFO_SCALE:
+		ret = -EINVAL;
+		mutex_lock(&indio_dev->mlock);
+		for (i = 0; i < ARRAY_SIZE(scale_avail); i++)
+			if (val2 == scale_avail[i][1]) {
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
@@ -247,8 +246,7 @@ static int ad7606_write_raw(struct iio_dev *indio_dev,
 static IIO_CONST_ATTR(oversampling_ratio_available, "1 2 4 8 16 32 64");
 
 static struct attribute *ad7606_attributes_os_and_range[] = {
-	&iio_dev_attr_in_voltage_range.dev_attr.attr,
-	&iio_const_attr_in_voltage_range_available.dev_attr.attr,
+	&iio_dev_attr_in_voltage_scale_available.dev_attr.attr,
 	&iio_const_attr_oversampling_ratio_available.dev_attr.attr,
 	NULL,
 };
@@ -267,8 +265,7 @@ static const struct attribute_group ad7606_attribute_group_os = {
 };
 
 static struct attribute *ad7606_attributes_range[] = {
-	&iio_dev_attr_in_voltage_range.dev_attr.attr,
-	&iio_const_attr_in_voltage_range_available.dev_attr.attr,
+	&iio_dev_attr_in_voltage_scale_available.dev_attr.attr,
 	NULL,
 };
 
@@ -397,6 +394,7 @@ static const struct iio_info ad7606_info_os = {
 static const struct iio_info ad7606_info_range = {
 	.driver_module = THIS_MODULE,
 	.read_raw = &ad7606_read_raw,
+	.write_raw = &ad7606_write_raw,
 	.attrs = &ad7606_attribute_group_range,
 };
 
@@ -417,7 +415,8 @@ int ad7606_probe(struct device *dev, int irq, void __iomem *base_address,
 	st->dev = dev;
 	st->bops = bops;
 	st->base_address = base_address;
-	st->range = 5000;
+	/* tied to logic low, analog input range is +/- 5V */
+	st->range = 0;
 	st->oversampling = 1;
 	INIT_WORK(&st->poll_work, &ad7606_poll_bh_to_ring);
 
@@ -525,7 +524,7 @@ static int ad7606_resume(struct device *dev)
 	struct ad7606_state *st = iio_priv(indio_dev);
 
 	if (st->gpio_standby) {
-		gpiod_set_value(st->gpio_range, st->range == 10000);
+		gpiod_set_value(st->gpio_range, st->range);
 		gpiod_set_value(st->gpio_standby, 1);
 		ad7606_reset(st);
 	}
-- 
2.7.4

