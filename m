Return-Path: <linux-iio-owner@vger.kernel.org>
Received: from ns.pmeerw.net ([87.118.82.44]:43365 "EHLO pmeerw.net"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1752662Ab3ISTgJ (ORCPT <rfc822;linux-iio@vger.kernel.org>);
	Thu, 19 Sep 2013 15:36:09 -0400
From: Peter Meerwald <pmeerw@pmeerw.net>
To: linux-iio@vger.kernel.org
Cc: Peter Meerwald <pmeerw@pmeerw.net>
Subject: [PATCH v2 11/15] staging:iio:hmc5843: Rename _configure() to _set_mode()
Date: Thu, 19 Sep 2013 21:35:56 +0200
Message-Id: <1379619360-8150-12-git-send-email-pmeerw@pmeerw.net>
In-Reply-To: <1379619360-8150-1-git-send-email-pmeerw@pmeerw.net>
References: <1379619360-8150-1-git-send-email-pmeerw@pmeerw.net>
Sender: linux-iio-owner@vger.kernel.org
List-Id: linux-iio@vger.kernel.org

and be consistent with other setter functions in that first argument
is hmc5843_data

Signed-off-by: Peter Meerwald <pmeerw@pmeerw.net>
---
 drivers/staging/iio/magnetometer/hmc5843.c | 27 ++++++++++++++++-----------
 1 file changed, 16 insertions(+), 11 deletions(-)

diff --git a/drivers/staging/iio/magnetometer/hmc5843.c b/drivers/staging/iio/magnetometer/hmc5843.c
index f8e6b38..2bbaea1 100644
--- a/drivers/staging/iio/magnetometer/hmc5843.c
+++ b/drivers/staging/iio/magnetometer/hmc5843.c
@@ -181,12 +181,18 @@ struct hmc5843_data {
 };
 
 /* The lower two bits contain the current conversion mode */
-static s32 hmc5843_configure(struct i2c_client *client,
-				       u8 operating_mode)
+static s32 hmc5843_set_mode(struct hmc5843_data *data, u8 operating_mode)
 {
-	return i2c_smbus_write_byte_data(client,
-					HMC5843_MODE_REG,
+	int ret;
+
+	mutex_lock(&data->lock);
+	ret = i2c_smbus_write_byte_data(data->client, HMC5843_MODE_REG,
 					operating_mode & HMC5843_MODE_MASK);
+	if (ret >= 0)
+		data->operating_mode = operating_mode;
+	mutex_unlock(&data->lock);
+
+	return ret;
 }
 
 static int hmc5843_wait_measurement(struct hmc5843_data *data)
@@ -541,7 +547,7 @@ static void hmc5843_init(struct hmc5843_data *data)
 {
 	hmc5843_set_meas_conf(data, HMC5843_MEAS_CONF_NORMAL);
 	hmc5843_set_rate(data, HMC5843_RATE_DEFAULT);
-	hmc5843_configure(data->client, HMC5843_MODE_CONVERSION_CONTINUOUS);
+	hmc5843_set_mode(data, HMC5843_MODE_CONVERSION_CONTINUOUS);
 	i2c_smbus_write_byte_data(data->client, HMC5843_CONFIG_REG_B,
 		HMC5843_RANGE_GAIN_DEFAULT);
 }
@@ -607,7 +613,7 @@ static int hmc5843_remove(struct i2c_client *client)
 	iio_triggered_buffer_cleanup(indio_dev);
 
 	 /*  sleep mode to save power */
-	hmc5843_configure(client, HMC5843_MODE_SLEEP);
+	hmc5843_set_mode(iio_priv(indio_dev), HMC5843_MODE_SLEEP);
 
 	return 0;
 }
@@ -615,9 +621,10 @@ static int hmc5843_remove(struct i2c_client *client)
 #ifdef CONFIG_PM_SLEEP
 static int hmc5843_suspend(struct device *dev)
 {
-	hmc5843_configure(to_i2c_client(dev), HMC5843_MODE_SLEEP);
+	struct hmc5843_data *data = iio_priv(i2c_get_clientdata(
+		to_i2c_client(dev)));
 
-	return 0;
+	return hmc5843_set_mode(data, HMC5843_MODE_SLEEP);
 }
 
 static int hmc5843_resume(struct device *dev)
@@ -625,9 +632,7 @@ static int hmc5843_resume(struct device *dev)
 	struct hmc5843_data *data = iio_priv(i2c_get_clientdata(
 		to_i2c_client(dev)));
 
-	hmc5843_configure(data->client, data->operating_mode);
-
-	return 0;
+	return hmc5843_set_mode(data, HMC5843_MODE_CONVERSION_CONTINUOUS);
 }
 
 static SIMPLE_DEV_PM_OPS(hmc5843_pm_ops, hmc5843_suspend, hmc5843_resume);
-- 
1.8.4

