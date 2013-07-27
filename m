Return-Path: <linux-iio-owner@vger.kernel.org>
Received: from ns.pmeerw.net ([87.118.82.44]:60616 "EHLO pmeerw.net"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1752151Ab3G0PcF (ORCPT <rfc822;linux-iio@vger.kernel.org>);
	Sat, 27 Jul 2013 11:32:05 -0400
From: Peter Meerwald <pmeerw@pmeerw.net>
To: linux-iio@vger.kernel.org
Cc: Peter Meerwald <pmeerw@pmeerw.net>,
	Shubhrajyoti Datta <shubhrajyoti@ti.com>
Subject: [PATCH 7/9] staging:iio:hmc5843: Split and join lines to make checkpatch happy
Date: Sat, 27 Jul 2013 17:31:50 +0200
Message-Id: <1374939112-18237-8-git-send-email-pmeerw@pmeerw.net>
In-Reply-To: <1374939112-18237-1-git-send-email-pmeerw@pmeerw.net>
References: <1374939112-18237-1-git-send-email-pmeerw@pmeerw.net>
Sender: linux-iio-owner@vger.kernel.org
List-Id: linux-iio@vger.kernel.org

Signed-off-by: Peter Meerwald <pmeerw@pmeerw.net>
Cc: Shubhrajyoti Datta <shubhrajyoti@ti.com>
---
 drivers/staging/iio/magnetometer/hmc5843.c | 38 ++++++++++++------------------
 1 file changed, 15 insertions(+), 23 deletions(-)

diff --git a/drivers/staging/iio/magnetometer/hmc5843.c b/drivers/staging/iio/magnetometer/hmc5843.c
index 1ebb8f8..52d6340 100644
--- a/drivers/staging/iio/magnetometer/hmc5843.c
+++ b/drivers/staging/iio/magnetometer/hmc5843.c
@@ -194,18 +194,15 @@ struct hmc5843_data {
 };
 
 /* The lower two bits contain the current conversion mode */
-static s32 hmc5843_configure(struct i2c_client *client,
-				       u8 operating_mode)
+static s32 hmc5843_configure(struct i2c_client *client, u8 operating_mode)
 {
-	return i2c_smbus_write_byte_data(client,
-					HMC5843_MODE_REG,
+	return i2c_smbus_write_byte_data(client, HMC5843_MODE_REG,
 					operating_mode & HMC5843_MODE_MASK);
 }
 
 /* Return the measurement value from the specified channel */
 static int hmc5843_read_measurement(struct iio_dev *indio_dev,
-				    int address,
-				    int *val)
+				    int address, int *val)
 {
 	struct i2c_client *client = to_i2c_client(indio_dev->dev.parent);
 	struct hmc5843_data *data = iio_priv(indio_dev);
@@ -321,8 +318,7 @@ static IIO_DEVICE_ATTR(operating_mode,
  *     and BN.
  *
  */
-static s32 hmc5843_set_meas_conf(struct i2c_client *client,
-				      u8 meas_conf)
+static s32 hmc5843_set_meas_conf(struct i2c_client *client, u8 meas_conf)
 {
 	struct iio_dev *indio_dev = i2c_get_clientdata(client);
 	struct hmc5843_data *data = iio_priv(indio_dev);
@@ -332,7 +328,7 @@ static s32 hmc5843_set_meas_conf(struct i2c_client *client,
 	return i2c_smbus_write_byte_data(client, HMC5843_CONFIG_REG_A, reg_val);
 }
 
-static ssize_t hmc5843_show_measurement_configuration(struct device *dev,
+static ssize_t hmc5843_show_measurement_conf(struct device *dev,
 						struct device_attribute *attr,
 						char *buf)
 {
@@ -341,10 +337,9 @@ static ssize_t hmc5843_show_measurement_configuration(struct device *dev,
 	return sprintf(buf, "%d\n", data->meas_conf);
 }
 
-static ssize_t hmc5843_set_measurement_configuration(struct device *dev,
+static ssize_t hmc5843_set_measurement_conf(struct device *dev,
 						struct device_attribute *attr,
-						const char *buf,
-						size_t count)
+						const char *buf, size_t count)
 {
 	struct iio_dev *indio_dev = dev_to_iio_dev(dev);
 	struct i2c_client *client = to_i2c_client(indio_dev->dev.parent);
@@ -398,8 +393,7 @@ static ssize_t hmc5843_show_sampling_freq_available(struct device *dev,
 
 static IIO_DEV_ATTR_SAMP_FREQ_AVAIL(hmc5843_show_sampling_freq_available);
 
-static s32 hmc5843_set_rate(struct i2c_client *client,
-				u8 rate)
+static s32 hmc5843_set_rate(struct i2c_client *client, u8 rate)
 {
 	struct iio_dev *indio_dev = i2c_get_clientdata(client);
 	struct hmc5843_data *data = iio_priv(indio_dev);
@@ -475,9 +469,8 @@ static ssize_t hmc5843_show_sampling_freq(struct device *dev,
 	return sprintf(buf, "%s\n", data->variant->regval_to_sample_freq[rate]);
 }
 
-static IIO_DEVICE_ATTR(sampling_freq, S_IWUSR | S_IRUGO,
-			hmc5843_show_sampling_freq,
-			hmc5843_set_sampling_freq,
+static IIO_DEVICE_ATTR(sampling_frequency, S_IWUSR | S_IRUGO,
+			hmc5843_show_sampling_freq, hmc5843_set_sampling_freq,
 			HMC5843_CONFIG_REG_A);
 
 static ssize_t hmc5843_show_range_gain(struct device *dev,
@@ -489,7 +482,8 @@ static ssize_t hmc5843_show_range_gain(struct device *dev,
 	struct hmc5843_data *data = iio_priv(indio_dev);
 
 	range = data->range;
-	return sprintf(buf, "%d\n", data->variant->regval_to_input_field_mga[range]);
+	return sprintf(buf, "%d\n",
+		data->variant->regval_to_input_field_mga[range]);
 }
 
 static ssize_t hmc5843_set_range_gain(struct device *dev,
@@ -527,10 +521,8 @@ exit:
 	return count;
 }
 
-static IIO_DEVICE_ATTR(in_magn_range,
-			S_IWUSR | S_IRUGO,
-			hmc5843_show_range_gain,
-			hmc5843_set_range_gain,
+static IIO_DEVICE_ATTR(in_magn_range, S_IWUSR | S_IRUGO,
+			hmc5843_show_range_gain, hmc5843_set_range_gain,
 			HMC5843_CONFIG_REG_B);
 
 static int hmc5843_read_raw(struct iio_dev *indio_dev,
@@ -578,7 +570,7 @@ static const struct iio_chan_spec hmc5883_channels[] = {
 static struct attribute *hmc5843_attributes[] = {
 	&iio_dev_attr_measurement_configuration.dev_attr.attr,
 	&iio_dev_attr_operating_mode.dev_attr.attr,
-	&iio_dev_attr_sampling_freq.dev_attr.attr,
+	&iio_dev_attr_sampling_frequency.dev_attr.attr,
 	&iio_dev_attr_in_magn_range.dev_attr.attr,
 	&iio_dev_attr_sampling_frequency_available.dev_attr.attr,
 	NULL
-- 
1.8.3.4

