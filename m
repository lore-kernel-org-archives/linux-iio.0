Return-Path: <jic23@cam.ac.uk>
From: Jonathan Cameron <jic23@cam.ac.uk>
To: linux-iio@vger.kernel.org
Cc: Jonathan Cameron <jic23@cam.ac.uk>
Subject: [PATCH] staging:iio:adc:ad7606 add channel type specification to range attributes.
Date: Fri,  9 Sep 2011 13:23:38 +0100
Message-Id: <1315571018-10471-1-git-send-email-jic23@cam.ac.uk>
In-Reply-To: <544AC56F16B56944AEC3BD4E3D59177146E7118ECC@LIMKCMBX1.ad.analog.com>
References: <544AC56F16B56944AEC3BD4E3D59177146E7118ECC@LIMKCMBX1.ad.analog.com>
List-ID: <linux-iio@vger.kernel.org>

Cleaner and more consistent naming + makes one abi element we don't need
go away.

Signed-off-by: Jonathan Cameron <jic23@cam.ac.uk>
---
 drivers/staging/iio/adc/ad7606_core.c |   12 ++++++------
 1 files changed, 6 insertions(+), 6 deletions(-)

diff --git a/drivers/staging/iio/adc/ad7606_core.c b/drivers/staging/iio/adc/ad7606_core.c
index bea663d..36f0ffd 100644
--- a/drivers/staging/iio/adc/ad7606_core.c
+++ b/drivers/staging/iio/adc/ad7606_core.c
@@ -140,9 +140,9 @@ static ssize_t ad7606_store_range(struct device *dev,
 	return count;
 }
 
-static IIO_DEVICE_ATTR(range, S_IRUGO | S_IWUSR, \
+static IIO_DEVICE_ATTR(in_voltage_range, S_IRUGO | S_IWUSR, \
 		       ad7606_show_range, ad7606_store_range, 0);
-static IIO_CONST_ATTR(range_available, "5000 10000");
+static IIO_CONST_ATTR(in_voltage_range_available, "5000 10000");
 
 static ssize_t ad7606_show_oversampling_ratio(struct device *dev,
 			struct device_attribute *attr, char *buf)
@@ -198,8 +198,8 @@ static IIO_DEVICE_ATTR(oversampling_ratio, S_IRUGO | S_IWUSR,
 static IIO_CONST_ATTR(oversampling_ratio_available, "0 2 4 8 16 32 64");
 
 static struct attribute *ad7606_attributes[] = {
-	&iio_dev_attr_range.dev_attr.attr,
-	&iio_const_attr_range_available.dev_attr.attr,
+	&iio_dev_attr_in_voltage_range.dev_attr.attr,
+	&iio_const_attr_in_voltage_range_available.dev_attr.attr,
 	&iio_dev_attr_oversampling_ratio.dev_attr.attr,
 	&iio_const_attr_oversampling_ratio_available.dev_attr.attr,
 	NULL,
@@ -220,8 +220,8 @@ static mode_t ad7606_attr_is_visible(struct kobject *kobj,
 		&iio_const_attr_oversampling_ratio_available.dev_attr.attr))
 		mode = 0;
 	else if (!st->have_range &&
-		(attr == &iio_dev_attr_range.dev_attr.attr ||
-		attr == &iio_const_attr_range_available.dev_attr.attr))
+		(attr == &iio_dev_attr_in_voltage_range.dev_attr.attr ||
+		attr == &iio_const_attr_in_voltage_range_available.dev_attr.attr))
 			mode = 0;
 
 	return mode;
-- 
1.7.3.4
