Return-Path: <linux-iio-owner@vger.kernel.org>
Received: from ns.pmeerw.net ([87.118.82.44]:43368 "EHLO pmeerw.net"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1752740Ab3ISTgK (ORCPT <rfc822;linux-iio@vger.kernel.org>);
	Thu, 19 Sep 2013 15:36:10 -0400
From: Peter Meerwald <pmeerw@pmeerw.net>
To: linux-iio@vger.kernel.org
Cc: Peter Meerwald <pmeerw@pmeerw.net>
Subject: [PATCH v2 14/15] staging:iio:hmc5843: Introduce _set_range_gain()
Date: Thu, 19 Sep 2013 21:35:59 +0200
Message-Id: <1379619360-8150-15-git-send-email-pmeerw@pmeerw.net>
In-Reply-To: <1379619360-8150-1-git-send-email-pmeerw@pmeerw.net>
References: <1379619360-8150-1-git-send-email-pmeerw@pmeerw.net>
Sender: linux-iio-owner@vger.kernel.org
List-Id: linux-iio@vger.kernel.org

Signed-off-by: Peter Meerwald <pmeerw@pmeerw.net>
---
 drivers/staging/iio/magnetometer/hmc5843.c | 33 +++++++++++++++++-------------
 1 file changed, 19 insertions(+), 14 deletions(-)

diff --git a/drivers/staging/iio/magnetometer/hmc5843.c b/drivers/staging/iio/magnetometer/hmc5843.c
index 3c3a3dd..9f4571f 100644
--- a/drivers/staging/iio/magnetometer/hmc5843.c
+++ b/drivers/staging/iio/magnetometer/hmc5843.c
@@ -370,6 +370,20 @@ static int hmc5843_check_samp_freq(struct hmc5843_data *data,
 		val, val2);
 }
 
+static int hmc5843_set_range_gain(struct hmc5843_data *data, u8 range)
+{
+	int ret;
+
+	mutex_lock(&data->lock);
+	ret = i2c_smbus_write_byte_data(data->client, HMC5843_CONFIG_REG_B,
+		range << HMC5843_RANGE_GAIN_OFFSET);
+	if (ret >= 0)
+		data->range = range;
+	mutex_unlock(&data->lock);
+
+	return ret;
+}
+
 static ssize_t hmc5843_show_calibscale_avail(struct device *dev,
 				struct device_attribute *attr, char *buf)
 {
@@ -382,7 +396,7 @@ static ssize_t hmc5843_show_calibscale_avail(struct device *dev,
 static IIO_DEVICE_ATTR(calibscale_available, S_IRUGO,
 	hmc5843_show_calibscale_avail, NULL, 0);
 
-static int hmc5843_check_range(struct hmc5843_data *data,
+static int hmc5843_check_range_gain(struct hmc5843_data *data,
 	int val, int val2)
 {
 	return hmc5843_check_int_plus_micros(data->variant->regval_to_range_ga,
@@ -419,7 +433,7 @@ static int hmc5843_write_raw(struct iio_dev *indio_dev,
 			     int val, int val2, long mask)
 {
 	struct hmc5843_data *data = iio_priv(indio_dev);
-	int ret, rate, range;
+	int rate, range;
 
 	switch (mask) {
 	case IIO_CHAN_INFO_SAMP_FREQ:
@@ -429,19 +443,11 @@ static int hmc5843_write_raw(struct iio_dev *indio_dev,
 
 		return hmc5843_set_samp_freq(data, rate);
 	case IIO_CHAN_INFO_CALIBSCALE:
-		range = hmc5843_check_range(data, val, val2);
+		range = hmc5843_check_range_gain(data, val, val2);
 		if (range < 0)
 			return -EINVAL;
 
-		range <<= HMC5843_RANGE_GAIN_OFFSET;
-		mutex_lock(&data->lock);
-		ret = i2c_smbus_write_byte_data(data->client,
-			HMC5843_CONFIG_REG_B, range);
-		if (ret >= 0)
-			data->range = range;
-		mutex_unlock(&data->lock);
-
-		return ret;
+		return hmc5843_set_range_gain(data, range);
 	default:
 		return -EINVAL;
 	}
@@ -543,9 +549,8 @@ static void hmc5843_init(struct hmc5843_data *data)
 {
 	hmc5843_set_meas_conf(data, HMC5843_MEAS_CONF_NORMAL);
 	hmc5843_set_samp_freq(data, HMC5843_RATE_DEFAULT);
+	hmc5843_set_range_gain(data, HMC5843_RANGE_GAIN_DEFAULT);
 	hmc5843_set_mode(data, HMC5843_MODE_CONVERSION_CONTINUOUS);
-	i2c_smbus_write_byte_data(data->client, HMC5843_CONFIG_REG_B,
-		HMC5843_RANGE_GAIN_DEFAULT);
 }
 
 static const struct iio_info hmc5843_info = {
-- 
1.8.4

