Return-Path: <linux-iio-owner@vger.kernel.org>
Received: from ns.pmeerw.net ([87.118.82.44]:33379 "EHLO pmeerw.net"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1759143Ab3ICBFc (ORCPT <rfc822;linux-iio@vger.kernel.org>);
	Mon, 2 Sep 2013 21:05:32 -0400
From: Peter Meerwald <pmeerw@pmeerw.net>
To: linux-iio@vger.kernel.org
Cc: Peter Meerwald <pmeerw@pmeerw.net>
Subject: [PATCH 04/18] staging:iio:hmc5843: Rewrite init function
Date: Tue,  3 Sep 2013 03:05:06 +0200
Message-Id: <1378170320-27538-5-git-send-email-pmeerw@pmeerw.net>
In-Reply-To: <1378170320-27538-1-git-send-email-pmeerw@pmeerw.net>
References: <1378170320-27538-1-git-send-email-pmeerw@pmeerw.net>
Sender: linux-iio-owner@vger.kernel.org
List-Id: linux-iio@vger.kernel.org

Signed-off-by: Peter Meerwald <pmeerw@pmeerw.net>
---
 drivers/staging/iio/magnetometer/hmc5843.c |   34 +++++++++++-----------------
 1 file changed, 13 insertions(+), 21 deletions(-)

diff --git a/drivers/staging/iio/magnetometer/hmc5843.c b/drivers/staging/iio/magnetometer/hmc5843.c
index 7aa767a..5327e5f 100644
--- a/drivers/staging/iio/magnetometer/hmc5843.c
+++ b/drivers/staging/iio/magnetometer/hmc5843.c
@@ -78,6 +78,7 @@ enum hmc5843_ids {
  * HMC5883: Typical data output rate
  */
 #define HMC5843_RATE_OFFSET			0x02
+#define HMC5843_RATE_DEFAULT			0x04
 #define HMC5843_RATE_BITMASK			0x1C
 #define HMC5843_RATE_NOT_USED			0x07
 
@@ -599,23 +600,13 @@ static const struct hmc5843_chip_info hmc5843_chip_info_tbl[] = {
 	},
 };
 
-/* Called when we have found a new HMC58X3 */
-static void hmc5843_init_client(struct i2c_client *client,
-				const struct i2c_device_id *id)
+static void hmc5843_init(struct hmc5843_data *data)
 {
-	struct iio_dev *indio_dev = i2c_get_clientdata(client);
-	struct hmc5843_data *data = iio_priv(indio_dev);
-
-	data->variant = &hmc5843_chip_info_tbl[id->driver_data];
-	indio_dev->channels = data->variant->channels;
-	indio_dev->num_channels = 3;
-	hmc5843_set_meas_conf(data, data->meas_conf);
-	hmc5843_set_rate(data, data->rate);
-	hmc5843_configure(client, data->operating_mode);
-	i2c_smbus_write_byte_data(client, HMC5843_CONFIG_REG_B, data->range);
-	mutex_init(&data->lock);
-
-	pr_info("%s initialized\n", id->name);
+	hmc5843_set_meas_conf(data, HMC5843_MEAS_CONF_NORMAL);
+	hmc5843_set_rate(data, HMC5843_RATE_DEFAULT);
+	hmc5843_configure(data->client, HMC5843_MODE_CONVERSION_CONTINUOUS);
+	i2c_smbus_write_byte_data(data->client, HMC5843_CONFIG_REG_B,
+		HMC5843_RANGE_GAIN_DEFAULT);
 }
 
 static const struct iio_info hmc5843_info = {
@@ -638,17 +629,18 @@ static int hmc5843_probe(struct i2c_client *client,
 	/* default settings at probe */
 	data = iio_priv(indio_dev);
 	data->client = client;
-	data->meas_conf = HMC5843_MEAS_CONF_NORMAL;
-	data->range = HMC5843_RANGE_GAIN_DEFAULT;
-	data->operating_mode = HMC5843_MODE_CONVERSION_CONTINUOUS;
+	data->variant = &hmc5843_chip_info_tbl[id->driver_data];
+	mutex_init(&data->lock);
 
 	i2c_set_clientdata(client, indio_dev);
-	hmc5843_init_client(client, id);
-
 	indio_dev->info = &hmc5843_info;
 	indio_dev->name = id->name;
 	indio_dev->dev.parent = &client->dev;
 	indio_dev->modes = INDIO_DIRECT_MODE;
+	indio_dev->channels = data->variant->channels;
+	indio_dev->num_channels = 3;
+
+	hmc5843_init(data);
 
 	err = iio_device_register(indio_dev);
 	if (err)
-- 
1.7.9.5

