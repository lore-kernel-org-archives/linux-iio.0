Return-Path: <linux-iio-owner@vger.kernel.org>
Received: from ns.pmeerw.net ([87.118.82.44]:60613 "EHLO pmeerw.net"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1752070Ab3G0PcF (ORCPT <rfc822;linux-iio@vger.kernel.org>);
	Sat, 27 Jul 2013 11:32:05 -0400
From: Peter Meerwald <pmeerw@pmeerw.net>
To: linux-iio@vger.kernel.org
Cc: Peter Meerwald <pmeerw@pmeerw.net>,
	Shubhrajyoti Datta <shubhrajyoti@ti.com>
Subject: [PATCH 6/9] staging:iio:hmc5843: Trim sampling_frequencies to sampling_freq
Date: Sat, 27 Jul 2013 17:31:49 +0200
Message-Id: <1374939112-18237-7-git-send-email-pmeerw@pmeerw.net>
In-Reply-To: <1374939112-18237-1-git-send-email-pmeerw@pmeerw.net>
References: <1374939112-18237-1-git-send-email-pmeerw@pmeerw.net>
Sender: linux-iio-owner@vger.kernel.org
List-Id: linux-iio@vger.kernel.org

Signed-off-by: Peter Meerwald <pmeerw@pmeerw.net>
Cc: Shubhrajyoti Datta <shubhrajyoti@ti.com>
---
 drivers/staging/iio/magnetometer/hmc5843.c | 38 ++++++++++++++----------------
 1 file changed, 18 insertions(+), 20 deletions(-)

diff --git a/drivers/staging/iio/magnetometer/hmc5843.c b/drivers/staging/iio/magnetometer/hmc5843.c
index 042467d..1ebb8f8 100644
--- a/drivers/staging/iio/magnetometer/hmc5843.c
+++ b/drivers/staging/iio/magnetometer/hmc5843.c
@@ -371,15 +371,13 @@ exit:
 	return count;
 }
 
-static IIO_DEVICE_ATTR(meas_conf,
-			S_IWUSR | S_IRUGO,
-			hmc5843_show_measurement_configuration,
-			hmc5843_set_measurement_configuration,
-			0);
+static IIO_DEVICE_ATTR(measurement_configuration, S_IWUSR | S_IRUGO,
+			hmc5843_show_measurement_conf,
+			hmc5843_set_measurement_conf, 0);
 
-static ssize_t hmc5843_show_sampling_frequencies_available(struct device *dev,
-						struct device_attribute *attr,
-						char *buf)
+static ssize_t hmc5843_show_sampling_freq_available(struct device *dev,
+					struct device_attribute *attr,
+					char *buf)
 {
 	struct iio_dev *indio_dev = dev_to_iio_dev(dev);
 	struct hmc5843_data *data = iio_priv(indio_dev);
@@ -387,7 +385,8 @@ static ssize_t hmc5843_show_sampling_frequencies_available(struct device *dev,
 	int i;
 
 	for (i = 0; i < HMC5843_RATE_NOT_USED; i++) {
-		ssize_t n = sprintf(buf, "%s ", data->variant->regval_to_sample_freq[i]);
+		ssize_t n = sprintf(buf, "%s ",
+			data->variant->regval_to_sample_freq[i]);
 		buf += n;
 		total_n += n;
 	}
@@ -397,7 +396,7 @@ static ssize_t hmc5843_show_sampling_frequencies_available(struct device *dev,
 	return total_n;
 }
 
-static IIO_DEV_ATTR_SAMP_FREQ_AVAIL(hmc5843_show_sampling_frequencies_available);
+static IIO_DEV_ATTR_SAMP_FREQ_AVAIL(hmc5843_show_sampling_freq_available);
 
 static s32 hmc5843_set_rate(struct i2c_client *client,
 				u8 rate)
@@ -416,7 +415,7 @@ static s32 hmc5843_set_rate(struct i2c_client *client,
 	return i2c_smbus_write_byte_data(client, HMC5843_CONFIG_REG_A, reg_val);
 }
 
-static int hmc5843_check_sampling_frequency(struct hmc5843_data *data,
+static int hmc5843_check_sampling_freq(struct hmc5843_data *data,
 						const char *buf)
 {
 	const char * const *samp_freq = data->variant->regval_to_sample_freq;
@@ -430,7 +429,7 @@ static int hmc5843_check_sampling_frequency(struct hmc5843_data *data,
 	return -EINVAL;
 }
 
-static ssize_t hmc5843_set_sampling_frequency(struct device *dev,
+static ssize_t hmc5843_set_sampling_freq(struct device *dev,
 					struct device_attribute *attr,
 					const char *buf, size_t count)
 {
@@ -440,7 +439,7 @@ static ssize_t hmc5843_set_sampling_frequency(struct device *dev,
 	struct hmc5843_data *data = iio_priv(indio_dev);
 	int rate;
 
-	rate = hmc5843_check_sampling_frequency(data, buf);
+	rate = hmc5843_check_sampling_freq(data, buf);
 	if (rate < 0) {
 		dev_err(&client->dev,
 			"sampling frequency is not supported\n");
@@ -460,7 +459,7 @@ exit:
 	return count;
 }
 
-static ssize_t hmc5843_show_sampling_frequency(struct device *dev,
+static ssize_t hmc5843_show_sampling_freq(struct device *dev,
 			struct device_attribute *attr, char *buf)
 {
 	struct iio_dev *indio_dev = dev_to_iio_dev(dev);
@@ -476,10 +475,9 @@ static ssize_t hmc5843_show_sampling_frequency(struct device *dev,
 	return sprintf(buf, "%s\n", data->variant->regval_to_sample_freq[rate]);
 }
 
-static IIO_DEVICE_ATTR(sampling_frequency,
-			S_IWUSR | S_IRUGO,
-			hmc5843_show_sampling_frequency,
-			hmc5843_set_sampling_frequency,
+static IIO_DEVICE_ATTR(sampling_freq, S_IWUSR | S_IRUGO,
+			hmc5843_show_sampling_freq,
+			hmc5843_set_sampling_freq,
 			HMC5843_CONFIG_REG_A);
 
 static ssize_t hmc5843_show_range_gain(struct device *dev,
@@ -578,9 +576,9 @@ static const struct iio_chan_spec hmc5883_channels[] = {
 };
 
 static struct attribute *hmc5843_attributes[] = {
-	&iio_dev_attr_meas_conf.dev_attr.attr,
+	&iio_dev_attr_measurement_configuration.dev_attr.attr,
 	&iio_dev_attr_operating_mode.dev_attr.attr,
-	&iio_dev_attr_sampling_frequency.dev_attr.attr,
+	&iio_dev_attr_sampling_freq.dev_attr.attr,
 	&iio_dev_attr_in_magn_range.dev_attr.attr,
 	&iio_dev_attr_sampling_frequency_available.dev_attr.attr,
 	NULL
-- 
1.8.3.4

