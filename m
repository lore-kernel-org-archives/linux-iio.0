Return-Path: <linux-iio-owner@vger.kernel.org>
Received: from ns.pmeerw.net ([87.118.82.44]:43364 "EHLO pmeerw.net"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1752838Ab3ISTgK (ORCPT <rfc822;linux-iio@vger.kernel.org>);
	Thu, 19 Sep 2013 15:36:10 -0400
From: Peter Meerwald <pmeerw@pmeerw.net>
To: linux-iio@vger.kernel.org
Cc: Peter Meerwald <pmeerw@pmeerw.net>
Subject: [PATCH v2 15/15] staging:iio:hmc5843: Check initialization and chip identifier
Date: Thu, 19 Sep 2013 21:36:00 +0200
Message-Id: <1379619360-8150-16-git-send-email-pmeerw@pmeerw.net>
In-Reply-To: <1379619360-8150-1-git-send-email-pmeerw@pmeerw.net>
References: <1379619360-8150-1-git-send-email-pmeerw@pmeerw.net>
Sender: linux-iio-owner@vger.kernel.org
List-Id: linux-iio@vger.kernel.org

Signed-off-by: Peter Meerwald <pmeerw@pmeerw.net>
---
 drivers/staging/iio/magnetometer/hmc5843.c | 33 ++++++++++++++++++++++++------
 1 file changed, 27 insertions(+), 6 deletions(-)

diff --git a/drivers/staging/iio/magnetometer/hmc5843.c b/drivers/staging/iio/magnetometer/hmc5843.c
index 9f4571f..4b4b2e2 100644
--- a/drivers/staging/iio/magnetometer/hmc5843.c
+++ b/drivers/staging/iio/magnetometer/hmc5843.c
@@ -33,6 +33,7 @@
 #define HMC5843_MODE_REG			0x02
 #define HMC5843_DATA_OUT_MSB_REGS		0x03
 #define HMC5843_STATUS_REG			0x09
+#define HMC5843_ID_REG				0x0a
 
 enum hmc5843_ids {
 	HMC5843_ID,
@@ -545,12 +546,30 @@ static const struct hmc5843_chip_info hmc5843_chip_info_tbl[] = {
 	},
 };
 
-static void hmc5843_init(struct hmc5843_data *data)
+static int hmc5843_init(struct hmc5843_data *data)
 {
-	hmc5843_set_meas_conf(data, HMC5843_MEAS_CONF_NORMAL);
-	hmc5843_set_samp_freq(data, HMC5843_RATE_DEFAULT);
-	hmc5843_set_range_gain(data, HMC5843_RANGE_GAIN_DEFAULT);
-	hmc5843_set_mode(data, HMC5843_MODE_CONVERSION_CONTINUOUS);
+	int ret;
+	u8 id[3];
+
+	ret = i2c_smbus_read_i2c_block_data(data->client, HMC5843_ID_REG,
+		sizeof(id), id);
+	if (ret < 0)
+		return ret;
+	if (id[0] != 'H' || id[1] != '4' || id[2] != '3') {
+		dev_err(&data->client->dev, "no HMC5843/5883/5883L sensor\n");
+		return -ENODEV;
+	}
+
+	ret = hmc5843_set_meas_conf(data, HMC5843_MEAS_CONF_NORMAL);
+	if (ret < 0)
+		return ret;
+	ret = hmc5843_set_samp_freq(data, HMC5843_RATE_DEFAULT);
+	if (ret < 0)
+		return ret;
+	ret = hmc5843_set_range_gain(data, HMC5843_RANGE_GAIN_DEFAULT);
+	if (ret < 0)
+		return ret;
+	return hmc5843_set_mode(data, HMC5843_MODE_CONVERSION_CONTINUOUS);
 }
 
 static const struct iio_info hmc5843_info = {
@@ -588,7 +607,9 @@ static int hmc5843_probe(struct i2c_client *client,
 	indio_dev->num_channels = 4;
 	indio_dev->available_scan_masks = hmc5843_scan_masks;
 
-	hmc5843_init(data);
+	ret = hmc5843_init(data);
+	if (ret < 0)
+		return ret;
 
 	ret = iio_triggered_buffer_setup(indio_dev, NULL,
 		hmc5843_trigger_handler, NULL);
-- 
1.8.4

