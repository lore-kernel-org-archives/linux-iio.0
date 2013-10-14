Return-Path: <linux-iio-owner@vger.kernel.org>
Received: from ns.pmeerw.net ([87.118.82.44]:34186 "EHLO pmeerw.net"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S932263Ab3JNVfD (ORCPT <rfc822;linux-iio@vger.kernel.org>);
	Mon, 14 Oct 2013 17:35:03 -0400
From: Peter Meerwald <pmeerw@pmeerw.net>
To: linux-iio@vger.kernel.org
Cc: Peter Meerwald <pmeerw@pmeerw.net>
Subject: [PATCH v3 01/10] staging:iio:hmc5843: Use SCALE instead of magn_range
Date: Mon, 14 Oct 2013 23:34:49 +0200
Message-Id: <1381786498-25954-2-git-send-email-pmeerw@pmeerw.net>
In-Reply-To: <1381786498-25954-1-git-send-email-pmeerw@pmeerw.net>
References: <1381786498-25954-1-git-send-email-pmeerw@pmeerw.net>
Sender: linux-iio-owner@vger.kernel.org
List-Id: linux-iio@vger.kernel.org

v2:
* use SCALE instead of CALIBSCALE to control the range/gain
  of measurements

Signed-off-by: Peter Meerwald <pmeerw@pmeerw.net>
---
 drivers/staging/iio/magnetometer/hmc5843.c | 160 +++++++++++------------------
 1 file changed, 59 insertions(+), 101 deletions(-)

diff --git a/drivers/staging/iio/magnetometer/hmc5843.c b/drivers/staging/iio/magnetometer/hmc5843.c
index b29622c..e577740 100644
--- a/drivers/staging/iio/magnetometer/hmc5843.c
+++ b/drivers/staging/iio/magnetometer/hmc5843.c
@@ -49,7 +49,7 @@ enum hmc5843_ids {
  */
 #define HMC5843_RANGE_GAIN_OFFSET		0x05
 #define HMC5843_RANGE_GAIN_DEFAULT		0x01
-#define HMC5843_RANGE_GAIN_MAX			0x07
+#define HMC5843_RANGE_GAINS			8
 
 /* Device status */
 #define HMC5843_DATA_READY			0x01
@@ -79,65 +79,19 @@ enum hmc5843_ids {
 #define HMC5843_MEAS_CONF_MASK			0x03
 
 /* Scaling factors: 10000000/Gain */
-static const int hmc5843_regval_to_nanoscale[] = {
+static const int hmc5843_regval_to_nanoscale[HMC5843_RANGE_GAINS] = {
 	6173, 7692, 10309, 12821, 18868, 21739, 25641, 35714
 };
 
-static const int hmc5883_regval_to_nanoscale[] = {
+static const int hmc5883_regval_to_nanoscale[HMC5843_RANGE_GAINS] = {
 	7812, 9766, 13021, 16287, 24096, 27701, 32573, 45662
 };
 
-static const int hmc5883l_regval_to_nanoscale[] = {
+static const int hmc5883l_regval_to_nanoscale[HMC5843_RANGE_GAINS] = {
 	7299, 9174, 12195, 15152, 22727, 25641, 30303, 43478
 };
 
 /*
- * From the HMC5843 datasheet:
- * Value	| Sensor input field range (Ga)	| Gain (counts/milli-Gauss)
- * 0		| (+-)0.7			| 1620
- * 1		| (+-)1.0			| 1300
- * 2		| (+-)1.5			| 970
- * 3		| (+-)2.0			| 780
- * 4		| (+-)3.2			| 530
- * 5		| (+-)3.8			| 460
- * 6		| (+-)4.5			| 390
- * 7		| (+-)6.5			| 280
- *
- * From the HMC5883 datasheet:
- * Value	| Recommended sensor field range (Ga)	| Gain (counts/Gauss)
- * 0		| (+-)0.9				| 1280
- * 1		| (+-)1.2				| 1024
- * 2		| (+-)1.9				| 768
- * 3		| (+-)2.5				| 614
- * 4		| (+-)4.0				| 415
- * 5		| (+-)4.6				| 361
- * 6		| (+-)5.5				| 307
- * 7		| (+-)7.9				| 219
- *
- * From the HMC5883L datasheet:
- * Value	| Recommended sensor field range (Ga)	| Gain (LSB/Gauss)
- * 0		| (+-)0.88				| 1370
- * 1		| (+-)1.3				| 1090
- * 2		| (+-)1.9				| 820
- * 3		| (+-)2.5				| 660
- * 4		| (+-)4.0				| 440
- * 5		| (+-)4.7				| 390
- * 6		| (+-)5.6				| 330
- * 7		| (+-)8.1				| 230
- */
-static const int hmc5843_regval_to_input_field_mga[] = {
-	700, 1000, 1500, 2000, 3200, 3800, 4500, 6500
-};
-
-static const int hmc5883_regval_to_input_field_mga[] = {
-	900, 1200, 1900, 2500, 4000, 4600, 5500, 7900
-};
-
-static const int hmc5883l_regval_to_input_field_mga[] = {
-	880, 1300, 1900, 2500, 4000, 4700, 5600, 8100
-};
-
-/*
  * From the datasheet:
  * Value	| HMC5843		| HMC5883/HMC5883L
  *		| Data output rate (Hz)	| Data output rate (Hz)
@@ -163,7 +117,6 @@ static const int hmc5883_regval_to_samp_freq[7][2] = {
 struct hmc5843_chip_info {
 	const struct iio_chan_spec *channels;
 	const int (*regval_to_samp_freq)[2];
-	const int *regval_to_input_field_mga;
 	const int *regval_to_nanoscale;
 };
 
@@ -412,58 +365,41 @@ static int hmc5843_check_samp_freq(struct hmc5843_data *data,
 		val, val2);
 }
 
-static ssize_t hmc5843_show_range_gain(struct device *dev,
-				struct device_attribute *attr,
-				char *buf)
+static ssize_t hmc5843_show_scale_avail(struct device *dev,
+				struct device_attribute *attr, char *buf)
 {
-	u8 range;
-	struct iio_dev *indio_dev = dev_to_iio_dev(dev);
-	struct hmc5843_data *data = iio_priv(indio_dev);
+	struct hmc5843_data *data = iio_priv(dev_to_iio_dev(dev));
+
+	size_t len = 0;
+	int i;
 
-	range = data->range;
-	return sprintf(buf, "%d\n", data->variant->regval_to_input_field_mga[range]);
+	for (i = 0; i < HMC5843_RANGE_GAINS; i++)
+		len += scnprintf(buf + len, PAGE_SIZE - len,
+			"0.%09d ", data->variant->regval_to_nanoscale[i]);
+
+	/* replace trailing space by newline */
+	buf[len - 1] = '\n';
+
+	return len;
 }
 
-static ssize_t hmc5843_set_range_gain(struct device *dev,
-			struct device_attribute *attr,
-			const char *buf,
-			size_t count)
-{
-	struct iio_dev *indio_dev = dev_to_iio_dev(dev);
-	struct iio_dev_attr *this_attr = to_iio_dev_attr(attr);
-	struct hmc5843_data *data = iio_priv(indio_dev);
-	unsigned long range = 0;
-	int error;
+static IIO_DEVICE_ATTR(scale_available, S_IRUGO,
+	hmc5843_show_scale_avail, NULL, 0);
 
-	mutex_lock(&data->lock);
-	error = kstrtoul(buf, 10, &range);
-	if (error) {
-		count = error;
-		goto exit;
-	}
-	dev_dbg(dev, "set range to %lu\n", range);
+static int hmc5843_check_scale(struct hmc5843_data *data, int val, int val2)
+{
+	int i;
 
-	if (range > HMC5843_RANGE_GAIN_MAX) {
-		count = -EINVAL;
-		goto exit;
-	}
+	if (val != 0)
+		return -EINVAL;
 
-	data->range = range;
-	range = range << HMC5843_RANGE_GAIN_OFFSET;
-	if (i2c_smbus_write_byte_data(data->client, this_attr->address, range))
-		count = -EINVAL;
+	for (i = 0; i < HMC5843_RANGE_GAINS; i++)
+		if (val2 == data->variant->regval_to_nanoscale[i])
+			return i;
 
-exit:
-	mutex_unlock(&data->lock);
-	return count;
+	return -EINVAL;
 }
 
-static IIO_DEVICE_ATTR(in_magn_range,
-			S_IWUSR | S_IRUGO,
-			hmc5843_show_range_gain,
-			hmc5843_set_range_gain,
-			HMC5843_CONFIG_REG_B);
-
 static int hmc5843_read_raw(struct iio_dev *indio_dev,
 			    struct iio_chan_spec const *chan,
 			    int *val, int *val2, long mask)
@@ -490,7 +426,7 @@ static int hmc5843_write_raw(struct iio_dev *indio_dev,
 			     int val, int val2, long mask)
 {
 	struct hmc5843_data *data = iio_priv(indio_dev);
-	int ret, rate;
+	int ret, rate, range;
 
 	switch (mask) {
 	case IIO_CHAN_INFO_SAMP_FREQ:
@@ -505,6 +441,33 @@ static int hmc5843_write_raw(struct iio_dev *indio_dev,
 		mutex_unlock(&data->lock);
 
 		return ret;
+	case IIO_CHAN_INFO_SCALE:
+		range = hmc5843_check_scale(data, val, val2);
+		if (range < 0)
+			return -EINVAL;
+
+		range <<= HMC5843_RANGE_GAIN_OFFSET;
+		mutex_lock(&data->lock);
+		ret = i2c_smbus_write_byte_data(data->client,
+			HMC5843_CONFIG_REG_B, range);
+		if (ret >= 0)
+			data->range = range;
+		mutex_unlock(&data->lock);
+
+		return ret;
+	default:
+		return -EINVAL;
+	}
+}
+
+static int hmc5843_write_raw_get_fmt(struct iio_dev *indio_dev,
+			       struct iio_chan_spec const *chan, long mask)
+{
+	switch (mask) {
+	case IIO_CHAN_INFO_SAMP_FREQ:
+		return IIO_VAL_INT_PLUS_MICRO;
+	case IIO_CHAN_INFO_SCALE:
+		return IIO_VAL_INT_PLUS_NANO;
 	default:
 		return -EINVAL;
 	}
@@ -536,7 +499,7 @@ static const struct iio_chan_spec hmc5883_channels[] = {
 static struct attribute *hmc5843_attributes[] = {
 	&iio_dev_attr_meas_conf.dev_attr.attr,
 	&iio_dev_attr_operating_mode.dev_attr.attr,
-	&iio_dev_attr_in_magn_range.dev_attr.attr,
+	&iio_dev_attr_scale_available.dev_attr.attr,
 	&iio_dev_attr_sampling_frequency_available.dev_attr.attr,
 	NULL
 };
@@ -549,22 +512,16 @@ static const struct hmc5843_chip_info hmc5843_chip_info_tbl[] = {
 	[HMC5843_ID] = {
 		.channels = hmc5843_channels,
 		.regval_to_samp_freq = hmc5843_regval_to_samp_freq,
-		.regval_to_input_field_mga =
-			hmc5843_regval_to_input_field_mga,
 		.regval_to_nanoscale = hmc5843_regval_to_nanoscale,
 	},
 	[HMC5883_ID] = {
 		.channels = hmc5883_channels,
 		.regval_to_samp_freq = hmc5883_regval_to_samp_freq,
-		.regval_to_input_field_mga =
-			hmc5883_regval_to_input_field_mga,
 		.regval_to_nanoscale = hmc5883_regval_to_nanoscale,
 	},
 	[HMC5883L_ID] = {
 		.channels = hmc5883_channels,
 		.regval_to_samp_freq = hmc5883_regval_to_samp_freq,
-		.regval_to_input_field_mga =
-			hmc5883l_regval_to_input_field_mga,
 		.regval_to_nanoscale = hmc5883l_regval_to_nanoscale,
 	},
 };
@@ -582,6 +539,7 @@ static const struct iio_info hmc5843_info = {
 	.attrs = &hmc5843_group,
 	.read_raw = &hmc5843_read_raw,
 	.write_raw = &hmc5843_write_raw,
+	.write_raw_get_fmt = &hmc5843_write_raw_get_fmt,
 	.driver_module = THIS_MODULE,
 };
 
-- 
1.8.4

