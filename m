Return-Path: <linux-iio-owner@vger.kernel.org>
Received: from ns.pmeerw.net ([87.118.82.44]:33383 "EHLO pmeerw.net"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1759231Ab3ICBFe (ORCPT <rfc822;linux-iio@vger.kernel.org>);
	Mon, 2 Sep 2013 21:05:34 -0400
From: Peter Meerwald <pmeerw@pmeerw.net>
To: linux-iio@vger.kernel.org
Cc: Peter Meerwald <pmeerw@pmeerw.net>
Subject: [PATCH 16/18] staging:iio:hmc5843: Rename _set_rate() to _set_samp_freq()
Date: Tue,  3 Sep 2013 03:05:18 +0200
Message-Id: <1378170320-27538-17-git-send-email-pmeerw@pmeerw.net>
In-Reply-To: <1378170320-27538-1-git-send-email-pmeerw@pmeerw.net>
References: <1378170320-27538-1-git-send-email-pmeerw@pmeerw.net>
Sender: linux-iio-owner@vger.kernel.org
List-Id: linux-iio@vger.kernel.org

move locking inside _set() function

Signed-off-by: Peter Meerwald <pmeerw@pmeerw.net>
---
 drivers/staging/iio/magnetometer/hmc5843.c |   24 ++++++++++++------------
 1 file changed, 12 insertions(+), 12 deletions(-)

diff --git a/drivers/staging/iio/magnetometer/hmc5843.c b/drivers/staging/iio/magnetometer/hmc5843.c
index 00e2225..f37794d 100644
--- a/drivers/staging/iio/magnetometer/hmc5843.c
+++ b/drivers/staging/iio/magnetometer/hmc5843.c
@@ -352,12 +352,18 @@ static ssize_t hmc5843_show_samp_freq_avail(struct device *dev,
 
 static IIO_DEV_ATTR_SAMP_FREQ_AVAIL(hmc5843_show_samp_freq_avail);
 
-static s32 hmc5843_set_rate(struct hmc5843_data *data, u8 rate)
+static int hmc5843_set_samp_freq(struct hmc5843_data *data, u8 rate)
 {
-	u8 reg_val = data->meas_conf | (rate << HMC5843_RATE_OFFSET);
+	int ret;
+
+	mutex_lock(&data->lock);
+	ret = i2c_smbus_write_byte_data(data->client, HMC5843_CONFIG_REG_A,
+		data->meas_conf | (rate << HMC5843_RATE_OFFSET));
+	if (ret >= 0)
+		data->rate = rate;
+	mutex_unlock(&data->lock);
 
-	return i2c_smbus_write_byte_data(data->client, HMC5843_CONFIG_REG_A,
-		reg_val);
+	return ret;
 }
 
 static int hmc5843_check_samp_freq(struct hmc5843_data *data,
@@ -425,13 +431,7 @@ static int hmc5843_write_raw(struct iio_dev *indio_dev,
 		if (rate < 0)
 			return -EINVAL;
 
-		mutex_lock(&data->lock);
-		ret = hmc5843_set_rate(data, rate);
-		if (ret >= 0)
-			data->rate = rate;
-		mutex_unlock(&data->lock);
-
-		return ret;
+		return hmc5843_set_samp_freq(data, rate);
 	case IIO_CHAN_INFO_CALIBSCALE:
 		range = hmc5843_check_range(data, val, val2);
 		if (range < 0)
@@ -555,7 +555,7 @@ static const struct hmc5843_chip_info hmc5843_chip_info_tbl[] = {
 static void hmc5843_init(struct hmc5843_data *data)
 {
 	hmc5843_set_meas_conf(data, HMC5843_MEAS_CONF_NORMAL);
-	hmc5843_set_rate(data, HMC5843_RATE_DEFAULT);
+	hmc5843_set_samp_freq(data, HMC5843_RATE_DEFAULT);
 	hmc5843_set_mode(data, HMC5843_MODE_CONVERSION_CONTINUOUS);
 	i2c_smbus_write_byte_data(data->client, HMC5843_CONFIG_REG_B,
 		HMC5843_RANGE_GAIN_DEFAULT);
-- 
1.7.9.5

