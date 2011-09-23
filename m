Return-Path: <jic23@cam.ac.uk>
From: Jonathan Cameron <jic23@cam.ac.uk>
To: Michael.Hennerich@analog.com
Cc: linux-iio@vger.kernel.org,
	Jonathan Cameron <jic23@cam.ac.uk>
Subject: [PATCH 07/16] staging:iio:adc:ad799x use the core handling for as much of the events as possible.
Date: Fri, 23 Sep 2011 13:01:33 +0100
Message-Id: <1316779302-12357-8-git-send-email-jic23@cam.ac.uk>
In-Reply-To: <1316779302-12357-1-git-send-email-jic23@cam.ac.uk>
References: <1316779302-12357-1-git-send-email-jic23@cam.ac.uk>
List-ID: <linux-iio@vger.kernel.org>

Signed-off-by: Jonathan Cameron <jic23@cam.ac.uk>
---
 drivers/staging/iio/adc/ad799x_core.c |  142 +++++++++++++++++++--------------
 1 files changed, 82 insertions(+), 60 deletions(-)

diff --git a/drivers/staging/iio/adc/ad799x_core.c b/drivers/staging/iio/adc/ad799x_core.c
index a24d695..304d9ae 100644
--- a/drivers/staging/iio/adc/ad799x_core.c
+++ b/drivers/staging/iio/adc/ad799x_core.c
@@ -236,6 +236,61 @@ error_ret_mutex:
 	return ret ? ret : len;
 }
 
+static int ad799x_read_event_config(struct iio_dev *dev_info,
+				    u64 event_code)
+{
+	return 1;
+}
+
+static const u8 ad799x_threshold_addresses[][2] = {
+	{ AD7998_DATALOW_CH1_REG, AD7998_DATAHIGH_CH1_REG },
+	{ AD7998_DATALOW_CH2_REG, AD7998_DATAHIGH_CH2_REG },
+	{ AD7998_DATALOW_CH3_REG, AD7998_DATAHIGH_CH3_REG },
+	{ AD7998_DATALOW_CH4_REG, AD7998_DATAHIGH_CH4_REG },
+};
+
+static int ad799x_write_event_value(struct iio_dev *indio_dev,
+				    u64 event_code,
+				    int val)
+{
+	int ret;
+	struct ad799x_state *st = iio_priv(indio_dev);
+	int direction = !!(IIO_EVENT_CODE_EXTRACT_DIR(event_code) ==
+			   IIO_EV_DIR_FALLING);
+	int number = IIO_EVENT_CODE_EXTRACT_NUM(event_code);
+
+	mutex_lock(&indio_dev->mlock);
+	ret = ad799x_i2c_write16(st,
+				 ad799x_threshold_addresses[number][direction],
+				 val);
+	mutex_unlock(&indio_dev->mlock);
+
+	return ret;
+}
+
+static int ad799x_read_event_value(struct iio_dev *indio_dev,
+				    u64 event_code,
+				    int *val)
+{
+	int ret;
+	struct ad799x_state *st = iio_priv(indio_dev);
+	int direction = !!(IIO_EVENT_CODE_EXTRACT_DIR(event_code) ==
+			   IIO_EV_DIR_FALLING);
+	int number = IIO_EVENT_CODE_EXTRACT_NUM(event_code);
+	u16 valin;
+
+	mutex_lock(&indio_dev->mlock);
+	ret = ad799x_i2c_read16(st,
+				ad799x_threshold_addresses[number][direction],
+				&valin);
+	mutex_unlock(&indio_dev->mlock);
+	if (ret < 0)
+		return ret;
+	*val = valin;
+
+	return 0;
+}
+
 static ssize_t ad799x_read_channel_config(struct device *dev,
 					struct device_attribute *attr,
 					char *buf)
@@ -310,72 +365,24 @@ static irqreturn_t ad799x_event_handler(int irq, void *private)
 	return IRQ_HANDLED;
 }
 
-static IIO_DEVICE_ATTR(in_voltage0_thresh_low_value,
-		       S_IRUGO | S_IWUSR,
-		       ad799x_read_channel_config,
-		       ad799x_write_channel_config,
-		       AD7998_DATALOW_CH1_REG);
-
-static IIO_DEVICE_ATTR(in_voltage0_thresh_high_value,
-		       S_IRUGO | S_IWUSR,
-		       ad799x_read_channel_config,
-		       ad799x_write_channel_config,
-		       AD7998_DATAHIGH_CH1_REG);
-
 static IIO_DEVICE_ATTR(in_voltage0_thresh_both_hyst_raw,
 		       S_IRUGO | S_IWUSR,
 		       ad799x_read_channel_config,
 		       ad799x_write_channel_config,
 		       AD7998_HYST_CH1_REG);
 
-static IIO_DEVICE_ATTR(in_voltage1_thresh_low_value,
-		       S_IRUGO | S_IWUSR,
-		       ad799x_read_channel_config,
-		       ad799x_write_channel_config,
-		       AD7998_DATALOW_CH2_REG);
-
-static IIO_DEVICE_ATTR(in_voltage1_thresh_high_value,
-		       S_IRUGO | S_IWUSR,
-		       ad799x_read_channel_config,
-		       ad799x_write_channel_config,
-		       AD7998_DATAHIGH_CH2_REG);
-
 static IIO_DEVICE_ATTR(in_voltage1_thresh_both_hyst_raw,
 		       S_IRUGO | S_IWUSR,
 		       ad799x_read_channel_config,
 		       ad799x_write_channel_config,
 		       AD7998_HYST_CH2_REG);
 
-static IIO_DEVICE_ATTR(in_voltage2_thresh_low_value,
-		       S_IRUGO | S_IWUSR,
-		       ad799x_read_channel_config,
-		       ad799x_write_channel_config,
-		       AD7998_DATALOW_CH3_REG);
-
-static IIO_DEVICE_ATTR(in_voltage2_thresh_high_value,
-		       S_IRUGO | S_IWUSR,
-		       ad799x_read_channel_config,
-		       ad799x_write_channel_config,
-		       AD7998_DATAHIGH_CH3_REG);
-
 static IIO_DEVICE_ATTR(in_voltage2_thresh_both_hyst_raw,
 		       S_IRUGO | S_IWUSR,
 		       ad799x_read_channel_config,
 		       ad799x_write_channel_config,
 		       AD7998_HYST_CH3_REG);
 
-static IIO_DEVICE_ATTR(in_voltage3_thresh_low_value,
-		       S_IRUGO | S_IWUSR,
-		       ad799x_read_channel_config,
-		       ad799x_write_channel_config,
-		       AD7998_DATALOW_CH4_REG);
-
-static IIO_DEVICE_ATTR(in_voltage3_thresh_high_value,
-		       S_IRUGO | S_IWUSR,
-		       ad799x_read_channel_config,
-		       ad799x_write_channel_config,
-		       AD7998_DATAHIGH_CH4_REG);
-
 static IIO_DEVICE_ATTR(in_voltage3_thresh_both_hyst_raw,
 		       S_IRUGO | S_IWUSR,
 		       ad799x_read_channel_config,
@@ -388,17 +395,9 @@ static IIO_DEV_ATTR_SAMP_FREQ(S_IWUSR | S_IRUGO,
 static IIO_CONST_ATTR_SAMP_FREQ_AVAIL("15625 7812 3906 1953 976 488 244 0");
 
 static struct attribute *ad7993_4_7_8_event_attributes[] = {
-	&iio_dev_attr_in_voltage0_thresh_low_value.dev_attr.attr,
-	&iio_dev_attr_in_voltage0_thresh_high_value.dev_attr.attr,
 	&iio_dev_attr_in_voltage0_thresh_both_hyst_raw.dev_attr.attr,
-	&iio_dev_attr_in_voltage1_thresh_low_value.dev_attr.attr,
-	&iio_dev_attr_in_voltage1_thresh_high_value.dev_attr.attr,
 	&iio_dev_attr_in_voltage1_thresh_both_hyst_raw.dev_attr.attr,
-	&iio_dev_attr_in_voltage2_thresh_low_value.dev_attr.attr,
-	&iio_dev_attr_in_voltage2_thresh_high_value.dev_attr.attr,
 	&iio_dev_attr_in_voltage2_thresh_both_hyst_raw.dev_attr.attr,
-	&iio_dev_attr_in_voltage3_thresh_low_value.dev_attr.attr,
-	&iio_dev_attr_in_voltage3_thresh_high_value.dev_attr.attr,
 	&iio_dev_attr_in_voltage3_thresh_both_hyst_raw.dev_attr.attr,
 	&iio_dev_attr_sampling_frequency.dev_attr.attr,
 	&iio_const_attr_sampling_frequency_available.dev_attr.attr,
@@ -411,11 +410,7 @@ static struct attribute_group ad7993_4_7_8_event_attrs_group = {
 };
 
 static struct attribute *ad7992_event_attributes[] = {
-	&iio_dev_attr_in_voltage0_thresh_low_value.dev_attr.attr,
-	&iio_dev_attr_in_voltage0_thresh_high_value.dev_attr.attr,
 	&iio_dev_attr_in_voltage0_thresh_both_hyst_raw.dev_attr.attr,
-	&iio_dev_attr_in_voltage1_thresh_low_value.dev_attr.attr,
-	&iio_dev_attr_in_voltage1_thresh_high_value.dev_attr.attr,
 	&iio_dev_attr_in_voltage1_thresh_both_hyst_raw.dev_attr.attr,
 	&iio_dev_attr_sampling_frequency.dev_attr.attr,
 	&iio_const_attr_sampling_frequency_available.dev_attr.attr,
@@ -435,15 +430,24 @@ static const struct iio_info ad7991_info = {
 static const struct iio_info ad7992_info = {
 	.read_raw = &ad799x_read_raw,
 	.event_attrs = &ad7992_event_attrs_group,
+	.read_event_config = &ad799x_read_event_config,
+	.read_event_value = &ad799x_read_event_value,
+	.write_event_value = &ad799x_write_event_value,
 	.driver_module = THIS_MODULE,
 };
 
 static const struct iio_info ad7993_4_7_8_info = {
 	.read_raw = &ad799x_read_raw,
 	.event_attrs = &ad7993_4_7_8_event_attrs_group,
+	.read_event_config = &ad799x_read_event_config,
+	.read_event_value = &ad799x_read_event_value,
+	.write_event_value = &ad799x_write_event_value,
 	.driver_module = THIS_MODULE,
 };
 
+#define AD799X_EV_MASK (IIO_EV_BIT(IIO_EV_TYPE_THRESH, IIO_EV_DIR_RISING) | \
+			IIO_EV_BIT(IIO_EV_TYPE_THRESH, IIO_EV_DIR_FALLING))
+
 static const struct ad799x_chip_info ad799x_chip_info_tbl[] = {
 	[ad7991] = {
 		.channel = {
@@ -574,6 +578,7 @@ static const struct ad799x_chip_info ad799x_chip_info_tbl[] = {
 				.address = 0,
 				.scan_index = 0,
 				.scan_type = IIO_ST('u', 12, 16, 0),
+				.event_mask = AD799X_EV_MASK,
 			},
 			[1] = {
 				.type = IIO_VOLTAGE,
@@ -582,6 +587,7 @@ static const struct ad799x_chip_info ad799x_chip_info_tbl[] = {
 				.address = 1,
 				.scan_index = 1,
 				.scan_type = IIO_ST('u', 12, 16, 0),
+				.event_mask = AD799X_EV_MASK,
 			},
 			[2] = IIO_CHAN_SOFT_TIMESTAMP(2),
 		},
@@ -599,6 +605,7 @@ static const struct ad799x_chip_info ad799x_chip_info_tbl[] = {
 				.address = 0,
 				.scan_index = 0,
 				.scan_type = IIO_ST('u', 10, 16, 2),
+				.event_mask = AD799X_EV_MASK,
 			},
 			[1] = {
 				.type = IIO_VOLTAGE,
@@ -607,6 +614,7 @@ static const struct ad799x_chip_info ad799x_chip_info_tbl[] = {
 				.address = 1,
 				.scan_index = 1,
 				.scan_type = IIO_ST('u', 10, 16, 2),
+				.event_mask = AD799X_EV_MASK,
 			},
 			[2] = {
 				.type = IIO_VOLTAGE,
@@ -615,6 +623,7 @@ static const struct ad799x_chip_info ad799x_chip_info_tbl[] = {
 				.address = 2,
 				.scan_index = 2,
 				.scan_type = IIO_ST('u', 10, 16, 2),
+				.event_mask = AD799X_EV_MASK,
 			},
 			[3] = {
 				.type = IIO_VOLTAGE,
@@ -623,6 +632,7 @@ static const struct ad799x_chip_info ad799x_chip_info_tbl[] = {
 				.address = 3,
 				.scan_index = 3,
 				.scan_type = IIO_ST('u', 10, 16, 2),
+				.event_mask = AD799X_EV_MASK,
 			},
 			[4] = IIO_CHAN_SOFT_TIMESTAMP(4),
 		},
@@ -640,6 +650,7 @@ static const struct ad799x_chip_info ad799x_chip_info_tbl[] = {
 				.address = 0,
 				.scan_index = 0,
 				.scan_type = IIO_ST('u', 12, 16, 0),
+				.event_mask = AD799X_EV_MASK,
 			},
 			[1] = {
 				.type = IIO_VOLTAGE,
@@ -648,6 +659,7 @@ static const struct ad799x_chip_info ad799x_chip_info_tbl[] = {
 				.address = 1,
 				.scan_index = 1,
 				.scan_type = IIO_ST('u', 12, 16, 0),
+				.event_mask = AD799X_EV_MASK,
 			},
 			[2] = {
 				.type = IIO_VOLTAGE,
@@ -656,6 +668,7 @@ static const struct ad799x_chip_info ad799x_chip_info_tbl[] = {
 				.address = 2,
 				.scan_index = 2,
 				.scan_type = IIO_ST('u', 12, 16, 0),
+				.event_mask = AD799X_EV_MASK,
 			},
 			[3] = {
 				.type = IIO_VOLTAGE,
@@ -664,6 +677,7 @@ static const struct ad799x_chip_info ad799x_chip_info_tbl[] = {
 				.address = 3,
 				.scan_index = 3,
 				.scan_type = IIO_ST('u', 12, 16, 0),
+				.event_mask = AD799X_EV_MASK,
 			},
 			[4] = IIO_CHAN_SOFT_TIMESTAMP(4),
 		},
@@ -681,6 +695,7 @@ static const struct ad799x_chip_info ad799x_chip_info_tbl[] = {
 				.address = 0,
 				.scan_index = 0,
 				.scan_type = IIO_ST('u', 10, 16, 2),
+				.event_mask = AD799X_EV_MASK,
 			},
 			[1] = {
 				.type = IIO_VOLTAGE,
@@ -689,6 +704,7 @@ static const struct ad799x_chip_info ad799x_chip_info_tbl[] = {
 				.address = 1,
 				.scan_index = 1,
 				.scan_type = IIO_ST('u', 10, 16, 2),
+				.event_mask = AD799X_EV_MASK,
 			},
 			[2] = {
 				.type = IIO_VOLTAGE,
@@ -697,6 +713,7 @@ static const struct ad799x_chip_info ad799x_chip_info_tbl[] = {
 				.address = 2,
 				.scan_index = 2,
 				.scan_type = IIO_ST('u', 10, 16, 2),
+				.event_mask = AD799X_EV_MASK,
 			},
 			[3] = {
 				.type = IIO_VOLTAGE,
@@ -705,6 +722,7 @@ static const struct ad799x_chip_info ad799x_chip_info_tbl[] = {
 				.address = 3,
 				.scan_index = 3,
 				.scan_type = IIO_ST('u', 10, 16, 2),
+				.event_mask = AD799X_EV_MASK,
 			},
 			[4] = {
 				.type = IIO_VOLTAGE,
@@ -754,6 +772,7 @@ static const struct ad799x_chip_info ad799x_chip_info_tbl[] = {
 				.address = 0,
 				.scan_index = 0,
 				.scan_type = IIO_ST('u', 12, 16, 0),
+				.event_mask = AD799X_EV_MASK,
 			},
 			[1] = {
 				.type = IIO_VOLTAGE,
@@ -762,6 +781,7 @@ static const struct ad799x_chip_info ad799x_chip_info_tbl[] = {
 				.address = 1,
 				.scan_index = 1,
 				.scan_type = IIO_ST('u', 12, 16, 0),
+				.event_mask = AD799X_EV_MASK,
 			},
 			[2] = {
 				.type = IIO_VOLTAGE,
@@ -770,6 +790,7 @@ static const struct ad799x_chip_info ad799x_chip_info_tbl[] = {
 				.address = 2,
 				.scan_index = 2,
 				.scan_type = IIO_ST('u', 12, 16, 0),
+				.event_mask = AD799X_EV_MASK,
 			},
 			[3] = {
 				.type = IIO_VOLTAGE,
@@ -778,6 +799,7 @@ static const struct ad799x_chip_info ad799x_chip_info_tbl[] = {
 				.address = 3,
 				.scan_index = 3,
 				.scan_type = IIO_ST('u', 12, 16, 0),
+				.event_mask = AD799X_EV_MASK,
 			},
 			[4] = {
 				.type = IIO_VOLTAGE,
-- 
1.7.3.4
