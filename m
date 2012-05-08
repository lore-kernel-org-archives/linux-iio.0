Return-Path: <linux-iio-owner@vger.kernel.org>
Received: from ns.pmeerw.net ([87.118.82.44]:54480 "EHLO pmeerw.net"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1756972Ab2EHWVR (ORCPT <rfc822;linux-iio@vger.kernel.org>);
	Tue, 8 May 2012 18:21:17 -0400
From: Peter Meerwald <pmeerw@pmeerw.net>
To: linux-iio@vger.kernel.org
Cc: jic23@kernel.org, lars@metafoo.de,
	Peter Meerwald <pmeerw@pmeerw.net>
Subject: [PATCH 1/8] iio: fix access to hmc5843 private data
Date: Wed,  9 May 2012 00:19:59 +0200
Message-Id: <1336515606-12364-2-git-send-email-pmeerw@pmeerw.net>
In-Reply-To: <1336515606-12364-1-git-send-email-pmeerw@pmeerw.net>
References: <1336515606-12364-1-git-send-email-pmeerw@pmeerw.net>
Sender: linux-iio-owner@vger.kernel.org
List-Id: linux-iio@vger.kernel.org

From: Peter Meerwald <p.meerwald@bct-electronic.com>

i2c_get_clientdata(client) points to iio_dev, not hmc5843_data; fixes
issue similar to 62d2feb9803f18c4e3c8a1a2c7e30a54df8a1d72

Signed-off-by: Peter Meerwald <pmeerw@pmeerw.net>
---
 drivers/staging/iio/magnetometer/hmc5843.c |   14 +++++++++-----
 1 files changed, 9 insertions(+), 5 deletions(-)

diff --git a/drivers/staging/iio/magnetometer/hmc5843.c b/drivers/staging/iio/magnetometer/hmc5843.c
index 3ec6518..9725cf8 100644
--- a/drivers/staging/iio/magnetometer/hmc5843.c
+++ b/drivers/staging/iio/magnetometer/hmc5843.c
@@ -250,7 +250,8 @@ static IIO_DEVICE_ATTR(operating_mode,
 static s32 hmc5843_set_meas_conf(struct i2c_client *client,
 				      u8 meas_conf)
 {
-	struct hmc5843_data *data = i2c_get_clientdata(client);
+	struct iio_dev *indio_dev = i2c_get_clientdata(client);
+	struct hmc5843_data *data = iio_priv(indio_dev);
 	u8 reg_val;
 	reg_val = (meas_conf & MEAS_CONF_MASK) |  (data->rate << RATE_OFFSET);
 	return i2c_smbus_write_byte_data(client, HMC5843_CONFIG_REG_A, reg_val);
@@ -272,7 +273,7 @@ static ssize_t hmc5843_set_measurement_configuration(struct device *dev,
 {
 	struct iio_dev *indio_dev = dev_get_drvdata(dev);
 	struct i2c_client *client = to_i2c_client(indio_dev->dev.parent);
-	struct hmc5843_data *data = i2c_get_clientdata(client);
+	struct hmc5843_data *data = iio_priv(indio_dev);
 	unsigned long meas_conf = 0;
 	int error = strict_strtoul(buf, 10, &meas_conf);
 	if (error)
@@ -314,7 +315,8 @@ static IIO_CONST_ATTR_SAMP_FREQ_AVAIL("0.5 1 2 5 10 20 50");
 static s32 hmc5843_set_rate(struct i2c_client *client,
 				u8 rate)
 {
-	struct hmc5843_data *data = i2c_get_clientdata(client);
+	struct iio_dev *indio_dev = i2c_get_clientdata(client);
+	struct hmc5843_data *data = iio_priv(indio_dev);
 	u8 reg_val;
 
 	reg_val = (data->meas_conf) |  (rate << RATE_OFFSET);
@@ -600,8 +602,10 @@ static int hmc5843_suspend(struct device *dev)
 
 static int hmc5843_resume(struct device *dev)
 {
-	struct hmc5843_data *data = i2c_get_clientdata(to_i2c_client(dev));
-	hmc5843_configure(to_i2c_client(dev), data->operating_mode);
+	struct i2c_client *client = to_i2c_client(dev);
+	struct iio_dev *indio_dev = i2c_get_clientdata(client);
+	struct hmc5843_data *data = iio_priv(indio_dev);
+	hmc5843_configure(client, data->operating_mode);
 	return 0;
 }
 
-- 
1.7.5.4

