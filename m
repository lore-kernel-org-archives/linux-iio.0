Return-Path: <linux-iio-owner@vger.kernel.org>
Received: from slow1-d.mail.gandi.net ([217.70.178.86]:37378 "EHLO
	slow1-d.mail.gandi.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1754052AbbGWPuS (ORCPT
	<rfc822;linux-iio@vger.kernel.org>); Thu, 23 Jul 2015 11:50:18 -0400
Received: from mrelay2-d.mail.gandi.net (relay2-d.mail.gandi.net [217.70.183.194])
	by slow1-d.mail.gandi.net (Postfix) with ESMTP id 2A49B496508
	for <linux-iio@vger.kernel.org>; Thu, 23 Jul 2015 17:22:27 +0200 (CEST)
Received: from mfilter42-d.gandi.net (mfilter42-d.gandi.net [217.70.178.172])
	by mrelay2-d.mail.gandi.net (Postfix) with ESMTP id B4AF3C5A44
	for <linux-iio@vger.kernel.org>; Thu, 23 Jul 2015 17:22:25 +0200 (CEST)
Received: from mrelay2-d.mail.gandi.net ([IPv6:::ffff:217.70.183.194])
	by mfilter42-d.gandi.net (mfilter42-d.gandi.net [::ffff:10.0.15.180]) (amavisd-new, port 10024)
	with ESMTP id 8mmed5q6BLQR for <linux-iio@vger.kernel.org>;
	Thu, 23 Jul 2015 17:22:24 +0200 (CEST)
Received: from nuvo (mon69-7-83-155-44-161.fbx.proxad.net [83.155.44.161])
	(Authenticated sender: hadess@hadess.net)
	by mrelay2-d.mail.gandi.net (Postfix) with ESMTPSA id 3CF01C5A61
	for <linux-iio@vger.kernel.org>; Thu, 23 Jul 2015 17:22:23 +0200 (CEST)
Message-ID: <1437664859.2863.12.camel@hadess.net>
Subject: [PATCH 1/2] iio:accel:bmc150-accel: Move bmc150_accel_chip_init()
From: Bastien Nocera <hadess@hadess.net>
To: "linux-iio@vger.kernel.org" <linux-iio@vger.kernel.org>
Date: Thu, 23 Jul 2015 17:20:59 +0200
Content-Type: text/plain; charset="UTF-8"
Mime-Version: 1.0
Sender: linux-iio-owner@vger.kernel.org
List-Id: linux-iio@vger.kernel.org

Move bmc150_accel_chip_init() so that we can use
bmc150_accel_chip_info_tbl[] in it.

Signed-off-by: Bastien Nocera <hadess@hadess.net>
---
 drivers/iio/accel/bmc150-accel.c | 118 +++++++++++++++++++--------------------
 1 file changed, 59 insertions(+), 59 deletions(-)

diff --git a/drivers/iio/accel/bmc150-accel.c b/drivers/iio/accel/bmc150-accel.c
index cc5a357..2ec9b56 100644
--- a/drivers/iio/accel/bmc150-accel.c
+++ b/drivers/iio/accel/bmc150-accel.c
@@ -345,65 +345,6 @@ static int bmc150_accel_any_motion_setup(struct bmc150_accel_trigger *t,
 	return 0;
 }
 
-static int bmc150_accel_chip_init(struct bmc150_accel_data *data)
-{
-	int ret;
-
-	ret = i2c_smbus_read_byte_data(data->client, BMC150_ACCEL_REG_CHIP_ID);
-	if (ret < 0) {
-		dev_err(&data->client->dev,
-			"Error: Reading chip id\n");
-		return ret;
-	}
-
-	dev_dbg(&data->client->dev, "Chip Id %x\n", ret);
-	if (ret != data->chip_info->chip_id) {
-		dev_err(&data->client->dev, "Invalid chip %x\n", ret);
-		return -ENODEV;
-	}
-
-	ret = bmc150_accel_set_mode(data, BMC150_ACCEL_SLEEP_MODE_NORMAL, 0);
-	if (ret < 0)
-		return ret;
-
-	/* Set Bandwidth */
-	ret = bmc150_accel_set_bw(data, BMC150_ACCEL_DEF_BW, 0);
-	if (ret < 0)
-		return ret;
-
-	/* Set Default Range */
-	ret = i2c_smbus_write_byte_data(data->client,
-					BMC150_ACCEL_REG_PMU_RANGE,
-					BMC150_ACCEL_DEF_RANGE_4G);
-	if (ret < 0) {
-		dev_err(&data->client->dev,
-					"Error writing reg_pmu_range\n");
-		return ret;
-	}
-
-	data->range = BMC150_ACCEL_DEF_RANGE_4G;
-
-	/* Set default slope duration and thresholds */
-	data->slope_thres = BMC150_ACCEL_DEF_SLOPE_THRESHOLD;
-	data->slope_dur = BMC150_ACCEL_DEF_SLOPE_DURATION;
-	ret = bmc150_accel_update_slope(data);
-	if (ret < 0)
-		return ret;
-
-	/* Set default as latched interrupts */
-	ret = i2c_smbus_write_byte_data(data->client,
-					BMC150_ACCEL_REG_INT_RST_LATCH,
-					BMC150_ACCEL_INT_MODE_LATCH_INT |
-					BMC150_ACCEL_INT_MODE_LATCH_RESET);
-	if (ret < 0) {
-		dev_err(&data->client->dev,
-			"Error writing reg_int_rst_latch\n");
-		return ret;
-	}
-
-	return 0;
-}
-
 static int bmc150_accel_get_bw(struct bmc150_accel_data *data, int *val,
 			       int *val2)
 {
@@ -1611,6 +1552,65 @@ static const struct iio_buffer_setup_ops bmc150_accel_buffer_ops = {
 	.postdisable = bmc150_accel_buffer_postdisable,
 };
 
+static int bmc150_accel_chip_init(struct bmc150_accel_data *data)
+{
+	int ret;
+
+	ret = i2c_smbus_read_byte_data(data->client, BMC150_ACCEL_REG_CHIP_ID);
+	if (ret < 0) {
+		dev_err(&data->client->dev,
+			"Error: Reading chip id\n");
+		return ret;
+	}
+
+	dev_dbg(&data->client->dev, "Chip Id %x\n", ret);
+	if (ret != data->chip_info->chip_id) {
+		dev_err(&data->client->dev, "Invalid chip %x\n", ret);
+		return -ENODEV;
+	}
+
+	ret = bmc150_accel_set_mode(data, BMC150_ACCEL_SLEEP_MODE_NORMAL, 0);
+	if (ret < 0)
+		return ret;
+
+	/* Set Bandwidth */
+	ret = bmc150_accel_set_bw(data, BMC150_ACCEL_DEF_BW, 0);
+	if (ret < 0)
+		return ret;
+
+	/* Set Default Range */
+	ret = i2c_smbus_write_byte_data(data->client,
+					BMC150_ACCEL_REG_PMU_RANGE,
+					BMC150_ACCEL_DEF_RANGE_4G);
+	if (ret < 0) {
+		dev_err(&data->client->dev,
+					"Error writing reg_pmu_range\n");
+		return ret;
+	}
+
+	data->range = BMC150_ACCEL_DEF_RANGE_4G;
+
+	/* Set default slope duration and thresholds */
+	data->slope_thres = BMC150_ACCEL_DEF_SLOPE_THRESHOLD;
+	data->slope_dur = BMC150_ACCEL_DEF_SLOPE_DURATION;
+	ret = bmc150_accel_update_slope(data);
+	if (ret < 0)
+		return ret;
+
+	/* Set default as latched interrupts */
+	ret = i2c_smbus_write_byte_data(data->client,
+					BMC150_ACCEL_REG_INT_RST_LATCH,
+					BMC150_ACCEL_INT_MODE_LATCH_INT |
+					BMC150_ACCEL_INT_MODE_LATCH_RESET);
+	if (ret < 0) {
+		dev_err(&data->client->dev,
+			"Error writing reg_int_rst_latch\n");
+		return ret;
+	}
+
+	return 0;
+}
+
 static int bmc150_accel_probe(struct i2c_client *client,
 			      const struct i2c_device_id *id)
 {
-- 
2.4.3
