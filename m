Return-Path: <eraretuya@gmail.com>
From: Eva Rachel Retuya <eraretuya@gmail.com>
To: linux-iio@vger.kernel.org,
	devel@driverdev.usuosl.org,
	linux-kernel@vger.kernel.org
Cc: lars@metafoo.de,
	Michael.Hennerich@analog.com,
	jic23@kernel.org,
	knaack.h@gmx.de,
	pmeerw@pmeerw.net,
	gregkh@linuxfoundation.org,
	Eva Rachel Retuya <eraretuya@gmail.com>
Subject: [PATCH 1/2] staging: iio: ad7606: replace range/range_available with corresponding scale
Date: Fri, 11 Nov 2016 14:34:37 +0800
Message-Id: <1478846078-22207-2-git-send-email-eraretuya@gmail.com>
In-Reply-To: <1478846078-22207-1-git-send-email-eraretuya@gmail.com>
References: <1478846078-22207-1-git-send-email-eraretuya@gmail.com>
List-ID: <linux-iio@vger.kernel.org>

Eliminate the non-standard attribute in_voltage_range and move its
functionality under the scale attribute. read_raw() has been taken care
of previously so only write_raw() is handled here.

Additionally, rename the attribute in_voltage_range_available into
in_voltage_scale_available.

Suggested-by: Lars-Peter Clausen <lars@metafoo.de>
Signed-off-by: Eva Rachel Retuya <eraretuya@gmail.com>
---
 drivers/staging/iio/adc/ad7606.c | 56 ++++++++++++----------------------------
 1 file changed, 16 insertions(+), 40 deletions(-)

diff --git a/drivers/staging/iio/adc/ad7606.c b/drivers/staging/iio/adc/ad7606.c
index 4531908..cceb18c 100644
--- a/drivers/staging/iio/adc/ad7606.c
+++ b/drivers/staging/iio/adc/ad7606.c
@@ -161,42 +161,7 @@ static int ad7606_read_raw(struct iio_dev *indio_dev,
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
-
-	mutex_lock(&indio_dev->mlock);
-	gpiod_set_value(st->gpio_range, lval == 10000);
-	st->range = lval;
-	mutex_unlock(&indio_dev->mlock);
-
-	return count;
-}
-
-static IIO_DEVICE_ATTR(in_voltage_range, S_IRUGO | S_IWUSR,
-		       ad7606_show_range, ad7606_store_range, 0);
-static IIO_CONST_ATTR(in_voltage_range_available, "5000 10000");
+static IIO_CONST_ATTR(in_voltage_scale_available, "5000 10000");
 
 static int ad7606_oversampling_get_index(unsigned int val)
 {
@@ -221,6 +186,19 @@ static int ad7606_write_raw(struct iio_dev *indio_dev,
 	int ret;
 
 	switch (mask) {
+	case IIO_CHAN_INFO_SCALE:
+		if (val2)
+			return -EINVAL;
+
+		if (!(val == 5000 || val == 10000))
+			return -EINVAL;
+
+		mutex_lock(&indio_dev->mlock);
+		gpiod_set_value(st->gpio_range, val == 10000);
+		st->range = val;
+		mutex_unlock(&indio_dev->mlock);
+
+		return 0;
 	case IIO_CHAN_INFO_OVERSAMPLING_RATIO:
 		if (val2)
 			return -EINVAL;
@@ -247,8 +225,7 @@ static int ad7606_write_raw(struct iio_dev *indio_dev,
 static IIO_CONST_ATTR(oversampling_ratio_available, "1 2 4 8 16 32 64");
 
 static struct attribute *ad7606_attributes_os_and_range[] = {
-	&iio_dev_attr_in_voltage_range.dev_attr.attr,
-	&iio_const_attr_in_voltage_range_available.dev_attr.attr,
+	&iio_const_attr_in_voltage_scale_available.dev_attr.attr,
 	&iio_const_attr_oversampling_ratio_available.dev_attr.attr,
 	NULL,
 };
@@ -267,8 +244,7 @@ static const struct attribute_group ad7606_attribute_group_os = {
 };
 
 static struct attribute *ad7606_attributes_range[] = {
-	&iio_dev_attr_in_voltage_range.dev_attr.attr,
-	&iio_const_attr_in_voltage_range_available.dev_attr.attr,
+	&iio_const_attr_in_voltage_scale_available.dev_attr.attr,
 	NULL,
 };
 
-- 
2.7.4
