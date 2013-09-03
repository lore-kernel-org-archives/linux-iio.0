Return-Path: <linux-iio-owner@vger.kernel.org>
Received: from ns.pmeerw.net ([87.118.82.44]:33378 "EHLO pmeerw.net"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1759137Ab3ICBFc (ORCPT <rfc822;linux-iio@vger.kernel.org>);
	Mon, 2 Sep 2013 21:05:32 -0400
From: Peter Meerwald <pmeerw@pmeerw.net>
To: linux-iio@vger.kernel.org
Cc: Peter Meerwald <pmeerw@pmeerw.net>
Subject: [PATCH 03/18] staging:iio:hmc5843: Add pointer to i2c client to data struct
Date: Tue,  3 Sep 2013 03:05:05 +0200
Message-Id: <1378170320-27538-4-git-send-email-pmeerw@pmeerw.net>
In-Reply-To: <1378170320-27538-1-git-send-email-pmeerw@pmeerw.net>
References: <1378170320-27538-1-git-send-email-pmeerw@pmeerw.net>
Sender: linux-iio-owner@vger.kernel.org
List-Id: linux-iio@vger.kernel.org

and use it to simplify code

Signed-off-by: Peter Meerwald <pmeerw@pmeerw.net>
---
 drivers/staging/iio/magnetometer/hmc5843.c |   60 +++++++++++-----------------
 1 file changed, 24 insertions(+), 36 deletions(-)

diff --git a/drivers/staging/iio/magnetometer/hmc5843.c b/drivers/staging/iio/magnetometer/hmc5843.c
index 3e72121..7aa767a 100644
--- a/drivers/staging/iio/magnetometer/hmc5843.c
+++ b/drivers/staging/iio/magnetometer/hmc5843.c
@@ -182,6 +182,7 @@ struct hmc5843_chip_info {
 
 /* Each client has this additional data */
 struct hmc5843_data {
+	struct i2c_client *client;
 	struct mutex lock;
 	u8 rate;
 	u8 meas_conf;
@@ -200,18 +201,15 @@ static s32 hmc5843_configure(struct i2c_client *client,
 }
 
 /* Return the measurement value from the specified channel */
-static int hmc5843_read_measurement(struct iio_dev *indio_dev,
-				    int address,
-				    int *val)
+static int hmc5843_read_measurement(struct hmc5843_data *data,
+				    int address, int *val)
 {
-	struct i2c_client *client = to_i2c_client(indio_dev->dev.parent);
-	struct hmc5843_data *data = iio_priv(indio_dev);
 	s32 result;
 	int tries = 150;
 
 	mutex_lock(&data->lock);
 	while (tries-- > 0) {
-		result = i2c_smbus_read_byte_data(client,
+		result = i2c_smbus_read_byte_data(data->client,
 			HMC5843_STATUS_REG);
 		if (result & HMC5843_DATA_READY)
 			break;
@@ -219,12 +217,12 @@ static int hmc5843_read_measurement(struct iio_dev *indio_dev,
 	}
 
 	if (tries < 0) {
-		dev_err(&client->dev, "data not ready\n");
+		dev_err(&data->client->dev, "data not ready\n");
 		mutex_unlock(&data->lock);
 		return -EIO;
 	}
 
-	result = i2c_smbus_read_word_swapped(client, address);
+	result = i2c_smbus_read_word_swapped(data->client, address);
 	mutex_unlock(&data->lock);
 	if (result < 0)
 		return -EINVAL;
@@ -318,15 +316,13 @@ static IIO_DEVICE_ATTR(operating_mode,
  *     and BN.
  *
  */
-static s32 hmc5843_set_meas_conf(struct i2c_client *client,
-				      u8 meas_conf)
+static s32 hmc5843_set_meas_conf(struct hmc5843_data *data, u8 meas_conf)
 {
-	struct iio_dev *indio_dev = i2c_get_clientdata(client);
-	struct hmc5843_data *data = iio_priv(indio_dev);
 	u8 reg_val;
 	reg_val = (meas_conf & HMC5843_MEAS_CONF_MASK) |
 		(data->rate << HMC5843_RATE_OFFSET);
-	return i2c_smbus_write_byte_data(client, HMC5843_CONFIG_REG_A, reg_val);
+	return i2c_smbus_write_byte_data(data->client, HMC5843_CONFIG_REG_A,
+		reg_val);
 }
 
 static ssize_t hmc5843_show_measurement_configuration(struct device *dev,
@@ -344,7 +340,6 @@ static ssize_t hmc5843_set_measurement_configuration(struct device *dev,
 						size_t count)
 {
 	struct iio_dev *indio_dev = dev_to_iio_dev(dev);
-	struct i2c_client *client = to_i2c_client(indio_dev->dev.parent);
 	struct hmc5843_data *data = iio_priv(indio_dev);
 	unsigned long meas_conf = 0;
 	int error;
@@ -357,7 +352,7 @@ static ssize_t hmc5843_set_measurement_configuration(struct device *dev,
 
 	mutex_lock(&data->lock);
 	dev_dbg(dev, "set measurement configuration to %lu\n", meas_conf);
-	if (hmc5843_set_meas_conf(client, meas_conf)) {
+	if (hmc5843_set_meas_conf(data, meas_conf)) {
 		count = -EINVAL;
 		goto exit;
 	}
@@ -396,21 +391,19 @@ static ssize_t hmc5843_show_sampling_frequencies_available(struct device *dev,
 
 static IIO_DEV_ATTR_SAMP_FREQ_AVAIL(hmc5843_show_sampling_frequencies_available);
 
-static s32 hmc5843_set_rate(struct i2c_client *client,
-				u8 rate)
+static s32 hmc5843_set_rate(struct hmc5843_data *data, u8 rate)
 {
-	struct iio_dev *indio_dev = i2c_get_clientdata(client);
-	struct hmc5843_data *data = iio_priv(indio_dev);
 	u8 reg_val;
 
 	if (rate >= HMC5843_RATE_NOT_USED) {
-		dev_err(&client->dev,
+		dev_err(&data->client->dev,
 			"data output rate is not supported\n");
 		return -EINVAL;
 	}
 
 	reg_val = data->meas_conf | (rate << HMC5843_RATE_OFFSET);
-	return i2c_smbus_write_byte_data(client, HMC5843_CONFIG_REG_A, reg_val);
+	return i2c_smbus_write_byte_data(data->client, HMC5843_CONFIG_REG_A,
+		reg_val);
 }
 
 static int hmc5843_check_sampling_frequency(struct hmc5843_data *data,
@@ -433,20 +426,19 @@ static ssize_t hmc5843_set_sampling_frequency(struct device *dev,
 {
 
 	struct iio_dev *indio_dev = dev_to_iio_dev(dev);
-	struct i2c_client *client = to_i2c_client(indio_dev->dev.parent);
 	struct hmc5843_data *data = iio_priv(indio_dev);
 	int rate;
 
 	rate = hmc5843_check_sampling_frequency(data, buf);
 	if (rate < 0) {
-		dev_err(&client->dev,
+		dev_err(&data->client->dev,
 			"sampling frequency is not supported\n");
 		return rate;
 	}
 
 	mutex_lock(&data->lock);
 	dev_dbg(dev, "set rate to %d\n", rate);
-	if (hmc5843_set_rate(client, rate)) {
+	if (hmc5843_set_rate(data->client, rate)) {
 		count = -EINVAL;
 		goto exit;
 	}
@@ -461,12 +453,11 @@ static ssize_t hmc5843_show_sampling_frequency(struct device *dev,
 			struct device_attribute *attr, char *buf)
 {
 	struct iio_dev *indio_dev = dev_to_iio_dev(dev);
-	struct i2c_client *client = to_i2c_client(indio_dev->dev.parent);
 	struct iio_dev_attr *this_attr = to_iio_dev_attr(attr);
 	struct hmc5843_data *data = iio_priv(indio_dev);
 	s32 rate;
 
-	rate = i2c_smbus_read_byte_data(client, this_attr->address);
+	rate = i2c_smbus_read_byte_data(data->client, this_attr->address);
 	if (rate < 0)
 		return rate;
 	rate = (rate & HMC5843_RATE_BITMASK) >> HMC5843_RATE_OFFSET;
@@ -497,7 +488,6 @@ static ssize_t hmc5843_set_range_gain(struct device *dev,
 			size_t count)
 {
 	struct iio_dev *indio_dev = dev_to_iio_dev(dev);
-	struct i2c_client *client = to_i2c_client(indio_dev->dev.parent);
 	struct iio_dev_attr *this_attr = to_iio_dev_attr(attr);
 	struct hmc5843_data *data = iio_priv(indio_dev);
 	unsigned long range = 0;
@@ -518,7 +508,7 @@ static ssize_t hmc5843_set_range_gain(struct device *dev,
 
 	data->range = range;
 	range = range << HMC5843_RANGE_GAIN_OFFSET;
-	if (i2c_smbus_write_byte_data(client, this_attr->address, range))
+	if (i2c_smbus_write_byte_data(data->client, this_attr->address, range))
 		count = -EINVAL;
 
 exit:
@@ -541,9 +531,7 @@ static int hmc5843_read_raw(struct iio_dev *indio_dev,
 
 	switch (mask) {
 	case IIO_CHAN_INFO_RAW:
-		return hmc5843_read_measurement(indio_dev,
-						chan->address,
-						val);
+		return hmc5843_read_measurement(data, chan->address, val);
 	case IIO_CHAN_INFO_SCALE:
 		*val = 0;
 		*val2 = data->variant->regval_to_nanoscale[data->range];
@@ -621,8 +609,8 @@ static void hmc5843_init_client(struct i2c_client *client,
 	data->variant = &hmc5843_chip_info_tbl[id->driver_data];
 	indio_dev->channels = data->variant->channels;
 	indio_dev->num_channels = 3;
-	hmc5843_set_meas_conf(client, data->meas_conf);
-	hmc5843_set_rate(client, data->rate);
+	hmc5843_set_meas_conf(data, data->meas_conf);
+	hmc5843_set_rate(data, data->rate);
 	hmc5843_configure(client, data->operating_mode);
 	i2c_smbus_write_byte_data(client, HMC5843_CONFIG_REG_B, data->range);
 	mutex_init(&data->lock);
@@ -649,6 +637,7 @@ static int hmc5843_probe(struct i2c_client *client,
 
 	/* default settings at probe */
 	data = iio_priv(indio_dev);
+	data->client = client;
 	data->meas_conf = HMC5843_MEAS_CONF_NORMAL;
 	data->range = HMC5843_RANGE_GAIN_DEFAULT;
 	data->operating_mode = HMC5843_MODE_CONVERSION_CONTINUOUS;
@@ -687,10 +676,9 @@ static int hmc5843_suspend(struct device *dev)
 
 static int hmc5843_resume(struct device *dev)
 {
-	struct i2c_client *client = to_i2c_client(dev);
-	struct hmc5843_data *data = iio_priv(i2c_get_clientdata(client));
+	struct hmc5843_data *data = iio_priv(dev_to_iio_dev(dev));
 
-	hmc5843_configure(client, data->operating_mode);
+	hmc5843_configure(data->client, data->operating_mode);
 
 	return 0;
 }
-- 
1.7.9.5

