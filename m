Return-Path: <jic23@cam.ac.uk>
From: Jonathan Cameron <jic23@cam.ac.uk>
To: linux-iio@vger.kernel.org
Cc: Michael Hennerich <michael.hennerich@analog.com>,
	Jonathan Cameron <jic23@cam.ac.uk>
Subject: [PATCH 12/16] staging:iio:adc:ad7152: Update sample rate, conversion time, digital filter handling
Date: Fri, 26 Aug 2011 11:19:29 +0100
Message-Id: <1314353973-7662-13-git-send-email-jic23@cam.ac.uk>
In-Reply-To: <1314353973-7662-1-git-send-email-jic23@cam.ac.uk>
References: <1314353973-7662-1-git-send-email-jic23@cam.ac.uk>
List-ID: <linux-iio@vger.kernel.org>

From: Michael Hennerich <michael.hennerich@analog.com>

Rename attribute, use sampling_frequency instead.
Attribute now accepts values in Hz.
Delay readout accordingly.

Signed-off-by: Michael Hennerich <michael.hennerich@analog.com>
Signed-off-by: Jonathan Cameron <jic23@cam.ac.uk>
---
 drivers/staging/iio/adc/ad7152.c |   39 ++++++++++++++++++++++++++++---------
 1 files changed, 29 insertions(+), 10 deletions(-)

diff --git a/drivers/staging/iio/adc/ad7152.c b/drivers/staging/iio/adc/ad7152.c
index bf26d38..41c3102 100644
--- a/drivers/staging/iio/adc/ad7152.c
+++ b/drivers/staging/iio/adc/ad7152.c
@@ -66,6 +66,9 @@
 #define AD7152_CAPDAC_DACEN		(1 << 7)
 #define AD7152_CAPDAC_DACP(x)		((x) & 0x1F)
 
+/* CFG2 Register Bit Designations (AD7152_REG_CFG2) */
+#define AD7152_CFG2_OSR(x)		(((x) & 0x3) << 4)
+
 enum {
 	AD7152_DATA,
 	AD7152_OFFS,
@@ -156,8 +159,10 @@ static IIO_DEVICE_ATTR(in_capacitance0_calibscale_calibration,
 static IIO_DEVICE_ATTR(in_capacitance1_calibscale_calibration,
 		       S_IWUSR, NULL, ad7152_start_gain_calib, 1);
 
-#define IIO_DEV_ATTR_FILTER_RATE_SETUP(_mode, _show, _store)              \
-	IIO_DEVICE_ATTR(filter_rate_setup, _mode, _show, _store, 0)
+/* Values are Update Rate (Hz), Conversion Time (ms) */
+static const unsigned char ad7152_filter_rate_table[][2] = {
+	{200, 5}, {50, 20}, {20, 50}, {17, 60},
+};
 
 static ssize_t ad7152_show_filter_rate_setup(struct device *dev,
 		struct device_attribute *attr,
@@ -166,7 +171,8 @@ static ssize_t ad7152_show_filter_rate_setup(struct device *dev,
 	struct iio_dev *indio_dev = dev_get_drvdata(dev);
 	struct ad7152_chip_info *chip = iio_priv(indio_dev);
 
-	return sprintf(buf, "0x%02x\n", chip->filter_rate_setup);
+	return sprintf(buf, "%d\n",
+		       ad7152_filter_rate_table[chip->filter_rate_setup][0]);
 }
 
 static ssize_t ad7152_store_filter_rate_setup(struct device *dev,
@@ -177,37 +183,50 @@ static ssize_t ad7152_store_filter_rate_setup(struct device *dev,
 	struct iio_dev *indio_dev = dev_get_drvdata(dev);
 	struct ad7152_chip_info *chip = iio_priv(indio_dev);
 	u8 data;
-	int ret;
+	int ret, i;
 
 	ret = kstrtou8(buf, 10, &data);
 	if (ret < 0)
 		return ret;
 
+	for (i = 0; i < ARRAY_SIZE(ad7152_filter_rate_table); i++)
+		if (data >= ad7152_filter_rate_table[i][0])
+			break;
+
+	if (i >= ARRAY_SIZE(ad7152_filter_rate_table))
+		i = ARRAY_SIZE(ad7152_filter_rate_table) - 1;
+
 	mutex_lock(&indio_dev->mlock);
-	ret = i2c_smbus_write_byte_data(chip->client, AD7152_REG_CFG2, data);
-	if (ret < 0)
+	ret = i2c_smbus_write_byte_data(chip->client,
+			AD7152_REG_CFG2, AD7152_CFG2_OSR(i));
+	if (ret < 0) {
+		mutex_unlock(&indio_dev->mlock);
 		return ret;
+	}
 
-	chip->filter_rate_setup = data;
+	chip->filter_rate_setup = i;
 	mutex_unlock(&indio_dev->mlock);
 
 	return len;
 }
 
-static IIO_DEV_ATTR_FILTER_RATE_SETUP(S_IRUGO | S_IWUSR,
+static IIO_DEV_ATTR_SAMP_FREQ(S_IRUGO | S_IWUSR,
 		ad7152_show_filter_rate_setup,
 		ad7152_store_filter_rate_setup);
 
+static IIO_CONST_ATTR_SAMP_FREQ_AVAIL("200 50 20 17");
+
 static IIO_CONST_ATTR(in_capacitance_scale_available,
 		      "0.000061050 0.000030525 0.000015263 0.000007631");
 
 static struct attribute *ad7152_attributes[] = {
-	&iio_dev_attr_filter_rate_setup.dev_attr.attr,
+	&iio_dev_attr_sampling_frequency.dev_attr.attr,
 	&iio_dev_attr_in_capacitance0_calibbias_calibration.dev_attr.attr,
 	&iio_dev_attr_in_capacitance1_calibbias_calibration.dev_attr.attr,
 	&iio_dev_attr_in_capacitance0_calibscale_calibration.dev_attr.attr,
 	&iio_dev_attr_in_capacitance1_calibscale_calibration.dev_attr.attr,
 	&iio_const_attr_in_capacitance_scale_available.dev_attr.attr,
+	&iio_const_attr_sampling_frequency_available.dev_attr.attr,
 	NULL,
 };
 
@@ -339,7 +358,7 @@ static int ad7152_read_raw(struct iio_dev *indio_dev,
 		if (ret < 0)
 			goto out;
 
-		msleep(60); /* Slowest conversion time */
+		msleep(ad7152_filter_rate_table[chip->filter_rate_setup][1]);
 		/* Now read the actual register */
 		ret = i2c_smbus_read_word_data(chip->client,
 				ad7152_addresses[chan->channel][AD7152_DATA]);
-- 
1.7.3.4
