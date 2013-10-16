Return-Path: <linux-iio-owner@vger.kernel.org>
Received: from ns.pmeerw.net ([87.118.82.44]:49254 "EHLO pmeerw.net"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1758716Ab3JPWTU (ORCPT <rfc822;linux-iio@vger.kernel.org>);
	Wed, 16 Oct 2013 18:19:20 -0400
From: Peter Meerwald <pmeerw@pmeerw.net>
To: linux-iio@vger.kernel.org
Cc: Peter Meerwald <pmeerw@pmeerw.net>
Subject: [PATCH v4 08/11] staging:iio:hmc5843: Rename _set_rate() to _set_samp_freq()
Date: Thu, 17 Oct 2013 00:19:11 +0200
Message-Id: <1381961954-25596-9-git-send-email-pmeerw@pmeerw.net>
In-Reply-To: <1381961954-25596-1-git-send-email-pmeerw@pmeerw.net>
References: <1381961954-25596-1-git-send-email-pmeerw@pmeerw.net>
Sender: linux-iio-owner@vger.kernel.org
List-Id: linux-iio@vger.kernel.org

move locking inside _set() function

Signed-off-by: Peter Meerwald <pmeerw@pmeerw.net>
---
 drivers/staging/iio/magnetometer/hmc5843.c | 31 +++++++++++++++---------------
 1 file changed, 15 insertions(+), 16 deletions(-)

diff --git a/drivers/staging/iio/magnetometer/hmc5843.c b/drivers/staging/iio/magnetometer/hmc5843.c
index bd13984..a91d302 100644
--- a/drivers/staging/iio/magnetometer/hmc5843.c
+++ b/drivers/staging/iio/magnetometer/hmc5843.c
@@ -66,8 +66,7 @@ enum hmc5843_ids {
  */
 #define HMC5843_RATE_OFFSET			0x02
 #define HMC5843_RATE_DEFAULT			0x04
-#define HMC5843_RATE_BITMASK			0x1C
-#define HMC5843_RATE_NOT_USED			0x07
+#define HMC5843_RATES				7
 
 /* Device measurement configuration */
 #define HMC5843_MEAS_CONF_NORMAL		0x00
@@ -264,7 +263,7 @@ static ssize_t hmc5843_show_samp_freq_avail(struct device *dev,
 	size_t len = 0;
 	int i;
 
-	for (i = 0; i < HMC5843_RATE_NOT_USED; i++)
+	for (i = 0; i < HMC5843_RATES; i++)
 		len += scnprintf(buf + len, PAGE_SIZE - len,
 			"%d.%d ", data->variant->regval_to_samp_freq[i][0],
 			data->variant->regval_to_samp_freq[i][1]);
@@ -277,12 +276,18 @@ static ssize_t hmc5843_show_samp_freq_avail(struct device *dev,
 
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
 
 static int hmc5843_get_samp_freq_index(struct hmc5843_data *data,
@@ -290,7 +295,7 @@ static int hmc5843_get_samp_freq_index(struct hmc5843_data *data,
 {
 	int i;
 
-	for (i = 0; i < HMC5843_RATE_NOT_USED; i++)
+	for (i = 0; i < HMC5843_RATES; i++)
 		if (val == data->variant->regval_to_samp_freq[i][0] &&
 			val2 == data->variant->regval_to_samp_freq[i][1])
 			return i;
@@ -367,13 +372,7 @@ static int hmc5843_write_raw(struct iio_dev *indio_dev,
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
 	case IIO_CHAN_INFO_SCALE:
 		range = hmc5843_get_scale_index(data, val, val2);
 		if (range < 0)
@@ -495,7 +494,7 @@ static const struct hmc5843_chip_info hmc5843_chip_info_tbl[] = {
 static void hmc5843_init(struct hmc5843_data *data)
 {
 	hmc5843_set_meas_conf(data, HMC5843_MEAS_CONF_NORMAL);
-	hmc5843_set_rate(data, HMC5843_RATE_DEFAULT);
+	hmc5843_set_samp_freq(data, HMC5843_RATE_DEFAULT);
 	hmc5843_set_mode(data, HMC5843_MODE_CONVERSION_CONTINUOUS);
 	i2c_smbus_write_byte_data(data->client, HMC5843_CONFIG_REG_B,
 		HMC5843_RANGE_GAIN_DEFAULT);
-- 
1.8.4

