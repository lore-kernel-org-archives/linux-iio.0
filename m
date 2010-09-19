Return-Path: <jic23@cam.ac.uk>
From: Jonathan Cameron <jic23@cam.ac.uk>
To: manuel.stahl@iis.fraunhofer.de,
	linux-iio@vger.kernel.org
Cc: drivers@analog.com,
	Jonathan Cameron <jic23@cam.ac.uk>
Subject: [PATCH 02/10] staging:iio:max1363 add _type attributes for all scan elements
Date: Sun, 19 Sep 2010 18:04:26 +0100
Message-Id: <1284915874-24911-3-git-send-email-jic23@cam.ac.uk>
In-Reply-To: <1284915874-24911-1-git-send-email-jic23@cam.ac.uk>
References: <1284915874-24911-1-git-send-email-jic23@cam.ac.uk>
List-ID: <linux-iio@vger.kernel.org>

As both signed and unsigned in attributes exist, each element must
be fully specified.

Signed-off-by: Jonathan Cameron <jic23@cam.ac.uk>
---
 drivers/staging/iio/adc/max1363_core.c |  147 ++++++++++++++++++++------------
 1 files changed, 92 insertions(+), 55 deletions(-)

diff --git a/drivers/staging/iio/adc/max1363_core.c b/drivers/staging/iio/adc/max1363_core.c
index 1dc428f..40039e6 100644
--- a/drivers/staging/iio/adc/max1363_core.c
+++ b/drivers/staging/iio/adc/max1363_core.c
@@ -148,17 +148,57 @@ const struct max1363_mode
 	return NULL;
 }
 
-static ssize_t max1363_show_precision(struct device *dev,
+static ssize_t max1363_show_precision_u(struct device *dev,
 				struct device_attribute *attr,
 				char *buf)
 {
 	struct iio_dev *dev_info = dev_get_drvdata(dev);
 	struct max1363_state *st = iio_dev_get_devdata(dev_info);
-	return sprintf(buf, "%d\n", st->chip_info->bits);
+	return sprintf(buf, "u%d/16\n", st->chip_info->bits);
 }
 
-static IIO_DEVICE_ATTR(in_precision, S_IRUGO, max1363_show_precision,
-		       NULL, 0);
+static ssize_t max1363_show_precision_s(struct device *dev,
+				struct device_attribute *attr,
+				char *buf)
+{
+	struct iio_dev *dev_info = dev_get_drvdata(dev);
+	struct max1363_state *st = iio_dev_get_devdata(dev_info);
+	return sprintf(buf, "s%d/16\n", st->chip_info->bits);
+}
+
+#define MAX1363_SCAN_TYPE(n)						\
+	DEVICE_ATTR(in##n##_type, S_IRUGO,				\
+		    max1363_show_precision_u, NULL);
+#define MAX1363_SCAN_TYPE_D(p, n)					\
+	struct device_attribute dev_attr_in##p##m##in##n##_type =	\
+		__ATTR(in##p-in##n##_type, S_IRUGO,			\
+		       max1363_show_precision_s, NULL);
+
+static MAX1363_SCAN_TYPE(0);
+static MAX1363_SCAN_TYPE(1);
+static MAX1363_SCAN_TYPE(2);
+static MAX1363_SCAN_TYPE(3);
+static MAX1363_SCAN_TYPE(4);
+static MAX1363_SCAN_TYPE(5);
+static MAX1363_SCAN_TYPE(6);
+static MAX1363_SCAN_TYPE(7);
+static MAX1363_SCAN_TYPE(8);
+static MAX1363_SCAN_TYPE(9);
+static MAX1363_SCAN_TYPE(10);
+static MAX1363_SCAN_TYPE(11);
+
+static MAX1363_SCAN_TYPE_D(0, 1);
+static MAX1363_SCAN_TYPE_D(2, 3);
+static MAX1363_SCAN_TYPE_D(4, 5);
+static MAX1363_SCAN_TYPE_D(6, 7);
+static MAX1363_SCAN_TYPE_D(8, 9);
+static MAX1363_SCAN_TYPE_D(10, 11);
+static MAX1363_SCAN_TYPE_D(1, 0);
+static MAX1363_SCAN_TYPE_D(3, 2);
+static MAX1363_SCAN_TYPE_D(5, 4);
+static MAX1363_SCAN_TYPE_D(7, 6);
+static MAX1363_SCAN_TYPE_D(9, 8);
+static MAX1363_SCAN_TYPE_D(11, 10);
 
 static int max1363_write_basic_config(struct i2c_client *client,
 				      unsigned char d1,
@@ -345,15 +385,14 @@ static struct attribute_group max1363_dev_attr_group = {
 };
 
 static struct attribute *max1363_scan_el_attrs[] = {
-	&iio_scan_el_in0.dev_attr.attr,
-	&iio_scan_el_in1.dev_attr.attr,
-	&iio_scan_el_in2.dev_attr.attr,
-	&iio_scan_el_in3.dev_attr.attr,
-	&iio_scan_el_in0min1.dev_attr.attr,
-	&iio_scan_el_in2min3.dev_attr.attr,
-	&iio_scan_el_in1min0.dev_attr.attr,
-	&iio_scan_el_in3min2.dev_attr.attr,
-	&iio_dev_attr_in_precision.dev_attr.attr,
+	&iio_scan_el_in0.dev_attr.attr,	&dev_attr_in0_type.attr,
+	&iio_scan_el_in1.dev_attr.attr,	&dev_attr_in1_type.attr,
+	&iio_scan_el_in2.dev_attr.attr,	&dev_attr_in2_type.attr,
+	&iio_scan_el_in3.dev_attr.attr,	&dev_attr_in3_type.attr,
+	&iio_scan_el_in0min1.dev_attr.attr,	&dev_attr_in0min1_type.attr,
+	&iio_scan_el_in2min3.dev_attr.attr,	&dev_attr_in2min3_type.attr,
+	&iio_scan_el_in1min0.dev_attr.attr,	&dev_attr_in1min0_type.attr,
+	&iio_scan_el_in3min2.dev_attr.attr,	&dev_attr_in3min2_type.attr,
 	NULL,
 };
 
@@ -419,31 +458,30 @@ static struct attribute_group max1238_dev_attr_group = {
 };
 
 static struct attribute *max1238_scan_el_attrs[] = {
-	&iio_scan_el_in0.dev_attr.attr,
-	&iio_scan_el_in1.dev_attr.attr,
-	&iio_scan_el_in2.dev_attr.attr,
-	&iio_scan_el_in3.dev_attr.attr,
-	&iio_scan_el_in4.dev_attr.attr,
-	&iio_scan_el_in5.dev_attr.attr,
-	&iio_scan_el_in6.dev_attr.attr,
-	&iio_scan_el_in7.dev_attr.attr,
-	&iio_scan_el_in8.dev_attr.attr,
-	&iio_scan_el_in9.dev_attr.attr,
-	&iio_scan_el_in10.dev_attr.attr,
-	&iio_scan_el_in11.dev_attr.attr,
-	&iio_scan_el_in0min1.dev_attr.attr,
-	&iio_scan_el_in2min3.dev_attr.attr,
-	&iio_scan_el_in4min5.dev_attr.attr,
-	&iio_scan_el_in6min7.dev_attr.attr,
-	&iio_scan_el_in8min9.dev_attr.attr,
-	&iio_scan_el_in10min11.dev_attr.attr,
-	&iio_scan_el_in1min0.dev_attr.attr,
-	&iio_scan_el_in3min2.dev_attr.attr,
-	&iio_scan_el_in5min4.dev_attr.attr,
-	&iio_scan_el_in7min6.dev_attr.attr,
-	&iio_scan_el_in9min8.dev_attr.attr,
-	&iio_scan_el_in11min10.dev_attr.attr,
-	&iio_dev_attr_in_precision.dev_attr.attr,
+	&iio_scan_el_in0.dev_attr.attr,	&dev_attr_in0_type.attr,
+	&iio_scan_el_in1.dev_attr.attr,	&dev_attr_in1_type.attr,
+	&iio_scan_el_in2.dev_attr.attr,	&dev_attr_in2_type.attr,
+	&iio_scan_el_in3.dev_attr.attr,	&dev_attr_in3_type.attr,
+	&iio_scan_el_in4.dev_attr.attr,	&dev_attr_in4_type.attr,
+	&iio_scan_el_in5.dev_attr.attr,	&dev_attr_in5_type.attr,
+	&iio_scan_el_in6.dev_attr.attr,	&dev_attr_in6_type.attr,
+	&iio_scan_el_in7.dev_attr.attr,	&dev_attr_in7_type.attr,
+	&iio_scan_el_in8.dev_attr.attr,	&dev_attr_in8_type.attr,
+	&iio_scan_el_in9.dev_attr.attr,	&dev_attr_in9_type.attr,
+	&iio_scan_el_in10.dev_attr.attr,	&dev_attr_in10_type.attr,
+	&iio_scan_el_in11.dev_attr.attr,	&dev_attr_in11_type.attr,
+	&iio_scan_el_in0min1.dev_attr.attr,	&dev_attr_in0min1_type.attr,
+	&iio_scan_el_in2min3.dev_attr.attr,	&dev_attr_in2min3_type.attr,
+	&iio_scan_el_in4min5.dev_attr.attr,	&dev_attr_in4min5_type.attr,
+	&iio_scan_el_in6min7.dev_attr.attr,	&dev_attr_in6min7_type.attr,
+	&iio_scan_el_in8min9.dev_attr.attr,	&dev_attr_in8min9_type.attr,
+	&iio_scan_el_in10min11.dev_attr.attr,	&dev_attr_in10min11_type.attr,
+	&iio_scan_el_in1min0.dev_attr.attr,	&dev_attr_in1min0_type.attr,
+	&iio_scan_el_in3min2.dev_attr.attr,	&dev_attr_in3min2_type.attr,
+	&iio_scan_el_in5min4.dev_attr.attr,	&dev_attr_in5min4_type.attr,
+	&iio_scan_el_in7min6.dev_attr.attr,	&dev_attr_in7min6_type.attr,
+	&iio_scan_el_in9min8.dev_attr.attr,	&dev_attr_in9min8_type.attr,
+	&iio_scan_el_in11min10.dev_attr.attr,	&dev_attr_in11min10_type.attr,
 	NULL,
 };
 
@@ -498,23 +536,22 @@ static struct attribute_group max11608_dev_attr_group = {
 };
 
 static struct attribute *max11608_scan_el_attrs[] = {
-	&iio_scan_el_in0.dev_attr.attr,
-	&iio_scan_el_in1.dev_attr.attr,
-	&iio_scan_el_in2.dev_attr.attr,
-	&iio_scan_el_in3.dev_attr.attr,
-	&iio_scan_el_in4.dev_attr.attr,
-	&iio_scan_el_in5.dev_attr.attr,
-	&iio_scan_el_in6.dev_attr.attr,
-	&iio_scan_el_in7.dev_attr.attr,
-	&iio_scan_el_in0min1.dev_attr.attr,
-	&iio_scan_el_in2min3.dev_attr.attr,
-	&iio_scan_el_in4min5.dev_attr.attr,
-	&iio_scan_el_in6min7.dev_attr.attr,
-	&iio_scan_el_in1min0.dev_attr.attr,
-	&iio_scan_el_in3min2.dev_attr.attr,
-	&iio_scan_el_in5min4.dev_attr.attr,
-	&iio_scan_el_in7min6.dev_attr.attr,
-	&iio_dev_attr_in_precision.dev_attr.attr,
+	&iio_scan_el_in0.dev_attr.attr,	&dev_attr_in0_type.attr,
+	&iio_scan_el_in1.dev_attr.attr,	&dev_attr_in1_type.attr,
+	&iio_scan_el_in2.dev_attr.attr,	&dev_attr_in2_type.attr,
+	&iio_scan_el_in3.dev_attr.attr,	&dev_attr_in3_type.attr,
+	&iio_scan_el_in4.dev_attr.attr,	&dev_attr_in4_type.attr,
+	&iio_scan_el_in5.dev_attr.attr,	&dev_attr_in5_type.attr,
+	&iio_scan_el_in6.dev_attr.attr,	&dev_attr_in6_type.attr,
+	&iio_scan_el_in7.dev_attr.attr,	&dev_attr_in7_type.attr,
+	&iio_scan_el_in0min1.dev_attr.attr,	&dev_attr_in0min1_type.attr,
+	&iio_scan_el_in2min3.dev_attr.attr,	&dev_attr_in2min3_type.attr,
+	&iio_scan_el_in4min5.dev_attr.attr,	&dev_attr_in4min5_type.attr,
+	&iio_scan_el_in6min7.dev_attr.attr,	&dev_attr_in6min7_type.attr,
+	&iio_scan_el_in1min0.dev_attr.attr,	&dev_attr_in1min0_type.attr,
+	&iio_scan_el_in3min2.dev_attr.attr,	&dev_attr_in3min2_type.attr,
+	&iio_scan_el_in5min4.dev_attr.attr,	&dev_attr_in5min4_type.attr,
+	&iio_scan_el_in7min6.dev_attr.attr,	&dev_attr_in7min6_type.attr,
 };
 
 static struct attribute_group max11608_scan_el_group = {
-- 
1.7.2.2
