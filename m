Return-Path: <linux-iio-owner@vger.kernel.org>
Received: from ppsw-52.csi.cam.ac.uk ([131.111.8.152]:49996 "EHLO
	ppsw-52.csi.cam.ac.uk" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752099Ab2A2LGZ (ORCPT
	<rfc822;linux-iio@vger.kernel.org>); Sun, 29 Jan 2012 06:06:25 -0500
From: Jonathan Cameron <jic23@kernel.org>
To: greg@kroah.com
Cc: linux-iio@vger.kernel.org, Jonathan Cameron <jic23@kernel.org>
Subject: [PATCH 4/5] staging:iio:adc:ad7606 unwind use of is_visible for attrs.
Date: Sun, 29 Jan 2012 11:07:03 +0000
Message-Id: <1327835224-20956-4-git-send-email-jic23@kernel.org>
In-Reply-To: <1327835224-20956-1-git-send-email-jic23@kernel.org>
References: <1327835145-20886-1-git-send-email-jic23@kernel.org>
 <1327835224-20956-1-git-send-email-jic23@kernel.org>
Sender: linux-iio-owner@vger.kernel.org
List-Id: linux-iio@vger.kernel.org

This is the most controversial of this set of is_visible removals.
There are two conditions controlling availability of attrs resulting
in 4 different attribute groups.

Still for a few more lines things are clearer to read to my mind.

Signed-off-by: Jonathan Cameron <jic23@kernel.org>
Acked-by: Lars-Peter Clausen <lars@metafoo.de>
---
 drivers/staging/iio/adc/ad7606_core.c |   83 +++++++++++++++++++++------------
 1 files changed, 53 insertions(+), 30 deletions(-)

diff --git a/drivers/staging/iio/adc/ad7606_core.c b/drivers/staging/iio/adc/ad7606_core.c
index ddb7ef9..97e8d3d 100644
--- a/drivers/staging/iio/adc/ad7606_core.c
+++ b/drivers/staging/iio/adc/ad7606_core.c
@@ -197,7 +197,7 @@ static IIO_DEVICE_ATTR(oversampling_ratio, S_IRUGO | S_IWUSR,
 		       ad7606_store_oversampling_ratio, 0);
 static IIO_CONST_ATTR(oversampling_ratio_available, "0 2 4 8 16 32 64");
 
-static struct attribute *ad7606_attributes[] = {
+static struct attribute *ad7606_attributes_os_and_range[] = {
 	&iio_dev_attr_in_voltage_range.dev_attr.attr,
 	&iio_const_attr_in_voltage_range_available.dev_attr.attr,
 	&iio_dev_attr_oversampling_ratio.dev_attr.attr,
@@ -205,34 +205,28 @@ static struct attribute *ad7606_attributes[] = {
 	NULL,
 };
 
-static umode_t ad7606_attr_is_visible(struct kobject *kobj,
-				     struct attribute *attr, int n)
-{
-	struct device *dev = container_of(kobj, struct device, kobj);
-	struct iio_dev *indio_dev = dev_get_drvdata(dev);
-	struct ad7606_state *st = iio_priv(indio_dev);
+static const struct attribute_group ad7606_attribute_group_os_and_range = {
+	.attrs = ad7606_attributes_os_and_range,
+};
 
-	umode_t mode = attr->mode;
-
-	if (!(gpio_is_valid(st->pdata->gpio_os0) &&
-	      gpio_is_valid(st->pdata->gpio_os1) &&
-	      gpio_is_valid(st->pdata->gpio_os2)) &&
-	    (attr == &iio_dev_attr_oversampling_ratio.dev_attr.attr ||
-	     attr ==
-	     &iio_const_attr_oversampling_ratio_available.dev_attr.attr))
-		mode = 0;
-	else if (!gpio_is_valid(st->pdata->gpio_range) &&
-		 (attr == &iio_dev_attr_in_voltage_range.dev_attr.attr ||
-		  attr ==
-		  &iio_const_attr_in_voltage_range_available.dev_attr.attr))
-		mode = 0;
-
-	return mode;
-}
+static struct attribute *ad7606_attributes_os[] = {
+	&iio_dev_attr_oversampling_ratio.dev_attr.attr,
+	&iio_const_attr_oversampling_ratio_available.dev_attr.attr,
+	NULL,
+};
 
-static const struct attribute_group ad7606_attribute_group = {
-	.attrs = ad7606_attributes,
-	.is_visible = ad7606_attr_is_visible,
+static const struct attribute_group ad7606_attribute_group_os = {
+	.attrs = ad7606_attributes_os,
+};
+
+static struct attribute *ad7606_attributes_range[] = {
+	&iio_dev_attr_in_voltage_range.dev_attr.attr,
+	&iio_const_attr_in_voltage_range_available.dev_attr.attr,
+	NULL,
+};
+
+static const struct attribute_group ad7606_attribute_group_range = {
+	.attrs = ad7606_attributes_range,
 };
 
 #define AD7606_CHANNEL(num)				\
@@ -435,10 +429,27 @@ static irqreturn_t ad7606_interrupt(int irq, void *dev_id)
 	return IRQ_HANDLED;
 };
 
-static const struct iio_info ad7606_info = {
+static const struct iio_info ad7606_info_no_os_or_range = {
 	.driver_module = THIS_MODULE,
 	.read_raw = &ad7606_read_raw,
-	.attrs = &ad7606_attribute_group,
+};
+
+static const struct iio_info ad7606_info_os_and_range = {
+	.driver_module = THIS_MODULE,
+	.read_raw = &ad7606_read_raw,
+	.attrs = &ad7606_attribute_group_os_and_range,
+};
+
+static const struct iio_info ad7606_info_os = {
+	.driver_module = THIS_MODULE,
+	.read_raw = &ad7606_read_raw,
+	.attrs = &ad7606_attribute_group_os,
+};
+
+static const struct iio_info ad7606_info_range = {
+	.driver_module = THIS_MODULE,
+	.read_raw = &ad7606_read_raw,
+	.attrs = &ad7606_attribute_group_range,
 };
 
 struct iio_dev *ad7606_probe(struct device *dev, int irq,
@@ -483,7 +494,19 @@ struct iio_dev *ad7606_probe(struct device *dev, int irq,
 	st->chip_info = &ad7606_chip_info_tbl[id];
 
 	indio_dev->dev.parent = dev;
-	indio_dev->info = &ad7606_info;
+	if (gpio_is_valid(st->pdata->gpio_os0) &&
+	    gpio_is_valid(st->pdata->gpio_os1) &&
+	    gpio_is_valid(st->pdata->gpio_os2)) {
+		if (gpio_is_valid(st->pdata->gpio_range))
+			indio_dev->info = &ad7606_info_os_and_range;
+		else
+			indio_dev->info = &ad7606_info_os;
+	} else {
+		if (gpio_is_valid(st->pdata->gpio_range))
+			indio_dev->info = &ad7606_info_range;
+		else
+			indio_dev->info = &ad7606_info_no_os_or_range;
+	}
 	indio_dev->modes = INDIO_DIRECT_MODE;
 	indio_dev->name = st->chip_info->name;
 	indio_dev->channels = st->chip_info->channels;
-- 
1.7.8.4

