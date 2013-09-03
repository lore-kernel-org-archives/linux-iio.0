Return-Path: <linux-iio-owner@vger.kernel.org>
Received: from ns.pmeerw.net ([87.118.82.44]:33382 "EHLO pmeerw.net"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1759225Ab3ICBFe (ORCPT <rfc822;linux-iio@vger.kernel.org>);
	Mon, 2 Sep 2013 21:05:34 -0400
From: Peter Meerwald <pmeerw@pmeerw.net>
To: linux-iio@vger.kernel.org
Cc: Peter Meerwald <pmeerw@pmeerw.net>
Subject: [PATCH 15/18] staging:iio:hmc5843: Reorganize _set_meas_conf()
Date: Tue,  3 Sep 2013 03:05:17 +0200
Message-Id: <1378170320-27538-16-git-send-email-pmeerw@pmeerw.net>
In-Reply-To: <1378170320-27538-1-git-send-email-pmeerw@pmeerw.net>
References: <1378170320-27538-1-git-send-email-pmeerw@pmeerw.net>
Sender: linux-iio-owner@vger.kernel.org
List-Id: linux-iio@vger.kernel.org

move locking inside _set() function

Signed-off-by: Peter Meerwald <pmeerw@pmeerw.net>
---
 drivers/staging/iio/magnetometer/hmc5843.c |   42 +++++++++++++---------------
 1 file changed, 19 insertions(+), 23 deletions(-)

diff --git a/drivers/staging/iio/magnetometer/hmc5843.c b/drivers/staging/iio/magnetometer/hmc5843.c
index a88473b..00e2225 100644
--- a/drivers/staging/iio/magnetometer/hmc5843.c
+++ b/drivers/staging/iio/magnetometer/hmc5843.c
@@ -264,19 +264,24 @@ static int hmc5843_read_measurement(struct hmc5843_data *data,
  */
 static s32 hmc5843_set_meas_conf(struct hmc5843_data *data, u8 meas_conf)
 {
-	u8 reg_val;
-	reg_val = (meas_conf & HMC5843_MEAS_CONF_MASK) |
-		(data->rate << HMC5843_RATE_OFFSET);
-	return i2c_smbus_write_byte_data(data->client, HMC5843_CONFIG_REG_A,
-		reg_val);
+	int ret;
+
+	mutex_lock(&data->lock);
+	ret = i2c_smbus_write_byte_data(data->client, HMC5843_CONFIG_REG_A,
+		(meas_conf & HMC5843_MEAS_CONF_MASK) |
+		(data->rate << HMC5843_RATE_OFFSET));
+	if (ret >= 0)
+		data->meas_conf = meas_conf;
+	mutex_unlock(&data->lock);
+
+	return ret;
 }
 
 static ssize_t hmc5843_show_measurement_configuration(struct device *dev,
 						struct device_attribute *attr,
 						char *buf)
 {
-	struct iio_dev *indio_dev = dev_to_iio_dev(dev);
-	struct hmc5843_data *data = iio_priv(indio_dev);
+	struct hmc5843_data *data = iio_priv(dev_to_iio_dev(dev));
 	return sprintf(buf, "%d\n", data->meas_conf);
 }
 
@@ -285,28 +290,19 @@ static ssize_t hmc5843_set_measurement_configuration(struct device *dev,
 						const char *buf,
 						size_t count)
 {
-	struct iio_dev *indio_dev = dev_to_iio_dev(dev);
-	struct hmc5843_data *data = iio_priv(indio_dev);
+	struct hmc5843_data *data = iio_priv(dev_to_iio_dev(dev));
 	unsigned long meas_conf = 0;
-	int error;
+	int ret;
 
-	error = kstrtoul(buf, 10, &meas_conf);
-	if (error)
-		return error;
+	ret = kstrtoul(buf, 10, &meas_conf);
+	if (ret)
+		return ret;
 	if (meas_conf >= HMC5843_MEAS_CONF_NOT_USED)
 		return -EINVAL;
 
-	mutex_lock(&data->lock);
-	dev_dbg(dev, "set measurement configuration to %lu\n", meas_conf);
-	if (hmc5843_set_meas_conf(data, meas_conf)) {
-		count = -EINVAL;
-		goto exit;
-	}
-	data->meas_conf = meas_conf;
+	ret = hmc5843_set_meas_conf(data, meas_conf);
 
-exit:
-	mutex_unlock(&data->lock);
-	return count;
+	return (ret < 0) ? ret : count;
 }
 
 static IIO_DEVICE_ATTR(meas_conf,
-- 
1.7.9.5

