Return-Path: <linux-iio-owner@vger.kernel.org>
Received: from ns.pmeerw.net ([87.118.82.44]:49253 "EHLO pmeerw.net"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1760658Ab3JPWTU (ORCPT <rfc822;linux-iio@vger.kernel.org>);
	Wed, 16 Oct 2013 18:19:20 -0400
From: Peter Meerwald <pmeerw@pmeerw.net>
To: linux-iio@vger.kernel.org
Cc: Peter Meerwald <pmeerw@pmeerw.net>
Subject: [PATCH v4 07/11] staging:iio:hmc5843: Reorganize _set_meas_conf()
Date: Thu, 17 Oct 2013 00:19:10 +0200
Message-Id: <1381961954-25596-8-git-send-email-pmeerw@pmeerw.net>
In-Reply-To: <1381961954-25596-1-git-send-email-pmeerw@pmeerw.net>
References: <1381961954-25596-1-git-send-email-pmeerw@pmeerw.net>
Sender: linux-iio-owner@vger.kernel.org
List-Id: linux-iio@vger.kernel.org

move locking inside _set() function

Signed-off-by: Peter Meerwald <pmeerw@pmeerw.net>
---
 drivers/staging/iio/magnetometer/hmc5843.c | 45 +++++++++++++-----------------
 1 file changed, 20 insertions(+), 25 deletions(-)

diff --git a/drivers/staging/iio/magnetometer/hmc5843.c b/drivers/staging/iio/magnetometer/hmc5843.c
index d7ace70..bd13984 100644
--- a/drivers/staging/iio/magnetometer/hmc5843.c
+++ b/drivers/staging/iio/magnetometer/hmc5843.c
@@ -73,7 +73,6 @@ enum hmc5843_ids {
 #define HMC5843_MEAS_CONF_NORMAL		0x00
 #define HMC5843_MEAS_CONF_POSITIVE_BIAS		0x01
 #define HMC5843_MEAS_CONF_NEGATIVE_BIAS		0x02
-#define HMC5843_MEAS_CONF_NOT_USED		0x03
 #define HMC5843_MEAS_CONF_MASK			0x03
 
 /* Scaling factors: 10000000/Gain */
@@ -211,19 +210,24 @@ static int hmc5843_read_measurement(struct hmc5843_data *data,
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
 
@@ -232,28 +236,19 @@ static ssize_t hmc5843_set_measurement_configuration(struct device *dev,
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
-	if (meas_conf >= HMC5843_MEAS_CONF_NOT_USED)
+	ret = kstrtoul(buf, 10, &meas_conf);
+	if (ret)
+		return ret;
+	if (meas_conf >= HMC5843_MEAS_CONF_MASK)
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
1.8.4

