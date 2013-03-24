Return-Path: <linux-iio-owner@vger.kernel.org>
Received: from saturn.retrosnub.co.uk ([178.18.118.26]:45952 "EHLO
	saturn.retrosnub.co.uk" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1754086Ab3CXQ6k (ORCPT
	<rfc822;linux-iio@vger.kernel.org>); Sun, 24 Mar 2013 12:58:40 -0400
From: Jonathan Cameron <jic23@kernel.org>
To: linux-iio@vger.kernel.org
Cc: Lars-Peter Clausen <lars@metafoo.de>,
	Laxman Dewangan <ldewangan@nvidia.com>,
	Jonathan Cameron <jic23@kernel.org>
Subject: [PATCH 3/4] staging:iio:magnetometer:ak8975 use standard i2c_smbus read functions.
Date: Sun, 24 Mar 2013 16:58:29 +0000
Message-Id: <1364144310-32251-4-git-send-email-jic23@kernel.org>
In-Reply-To: <1364144310-32251-1-git-send-email-jic23@kernel.org>
References: <1364144310-32251-1-git-send-email-jic23@kernel.org>
Sender: linux-iio-owner@vger.kernel.org
List-Id: linux-iio@vger.kernel.org

Now the mysterious NOSTART flag is gone from the read, we can use the
i2c_smbus_read_byte/word/i2c_block_data functions instead of the
local reimplementation of these standard functions.

Signed-off-by: Jonathan Cameron <jic23@kernel.org>
---
 drivers/staging/iio/magnetometer/ak8975.c | 66 ++++++++-----------------------
 1 file changed, 17 insertions(+), 49 deletions(-)

diff --git a/drivers/staging/iio/magnetometer/ak8975.c b/drivers/staging/iio/magnetometer/ak8975.c
index 1428849..af6c320 100644
--- a/drivers/staging/iio/magnetometer/ak8975.c
+++ b/drivers/staging/iio/magnetometer/ak8975.c
@@ -123,35 +123,6 @@ static int ak8975_write_data(struct i2c_client *client,
 }
 
 /*
- * Helper function to read a contiguous set of the I2C device's registers.
- */
-static int ak8975_read_data(struct i2c_client *client,
-			    u8 reg, u8 length, u8 *buffer)
-{
-	int ret;
-	struct i2c_msg msg[2] = {
-		{
-			.addr = client->addr,
-			.len = 1,
-			.buf = &reg,
-		}, {
-			.addr = client->addr,
-			.flags = I2C_M_RD,
-			.len = length,
-			.buf = buffer,
-		}
-	};
-
-	ret = i2c_transfer(client->adapter, msg, 2);
-	if (ret < 0) {
-		dev_err(&client->dev, "Read from device fails\n");
-		return ret;
-	}
-
-	return 0;
-}
-
-/*
  * Perform some start-of-day setup, including reading the asa calibration
  * values and caching them.
  */
@@ -163,11 +134,12 @@ static int ak8975_setup(struct i2c_client *client)
 	int ret;
 
 	/* Confirm that the device we're talking to is really an AK8975. */
-	ret = ak8975_read_data(client, AK8975_REG_WIA, 1, &device_id);
+	ret = i2c_smbus_read_byte_data(client, AK8975_REG_WIA);
 	if (ret < 0) {
 		dev_err(&client->dev, "Error reading WIA\n");
 		return ret;
 	}
+	device_id = ret;
 	if (device_id != AK8975_DEVICE_ID) {
 		dev_err(&client->dev, "Device ak8975 not found\n");
 		return -ENODEV;
@@ -185,7 +157,8 @@ static int ak8975_setup(struct i2c_client *client)
 	}
 
 	/* Get asa data and store in the device data. */
-	ret = ak8975_read_data(client, AK8975_REG_ASAX, 3, data->asa);
+	ret = i2c_smbus_read_i2c_block_data(client, AK8975_REG_ASAX,
+					    3, data->asa);
 	if (ret < 0) {
 		dev_err(&client->dev, "Not able to read asa data\n");
 		return ret;
@@ -247,7 +220,6 @@ static int ak8975_setup(struct i2c_client *client)
 static int wait_conversion_complete_gpio(struct ak8975_data *data)
 {
 	struct i2c_client *client = data->client;
-	u8 read_status;
 	u32 timeout_ms = AK8975_MAX_CONVERSION_TIMEOUT;
 	int ret;
 
@@ -263,12 +235,11 @@ static int wait_conversion_complete_gpio(struct ak8975_data *data)
 		return -EINVAL;
 	}
 
-	ret = ak8975_read_data(client, AK8975_REG_ST1, 1, &read_status);
-	if (ret < 0) {
+	ret = i2c_smbus_read_byte_data(client, AK8975_REG_ST1);
+	if (ret < 0)
 		dev_err(&client->dev, "Error in reading ST1\n");
-		return ret;
-	}
-	return read_status;
+
+	return ret;
 }
 
 static int wait_conversion_complete_polled(struct ak8975_data *data)
@@ -281,11 +252,12 @@ static int wait_conversion_complete_polled(struct ak8975_data *data)
 	/* Wait for the conversion to complete. */
 	while (timeout_ms) {
 		msleep(AK8975_CONVERSION_DONE_POLL_TIME);
-		ret = ak8975_read_data(client, AK8975_REG_ST1, 1, &read_status);
+		ret = i2c_smbus_read_byte_data(client, AK8975_REG_ST1);
 		if (ret < 0) {
 			dev_err(&client->dev, "Error in reading ST1\n");
 			return ret;
 		}
+		read_status = ret;
 		if (read_status)
 			break;
 		timeout_ms -= AK8975_CONVERSION_DONE_POLL_TIME;
@@ -306,7 +278,6 @@ static int ak8975_read_axis(struct iio_dev *indio_dev, int index, int *val)
 	struct i2c_client *client = data->client;
 	u16 meas_reg;
 	s16 raw;
-	u8 read_status;
 	int ret;
 
 	mutex_lock(&data->lock);
@@ -330,18 +301,15 @@ static int ak8975_read_axis(struct iio_dev *indio_dev, int index, int *val)
 	if (ret < 0)
 		goto exit;
 
-	read_status = ret;
-
-	if (read_status & AK8975_REG_ST1_DRDY_MASK) {
-		ret = ak8975_read_data(client, AK8975_REG_ST2, 1, &read_status);
+	if (ret & AK8975_REG_ST1_DRDY_MASK) {
+		ret = i2c_smbus_read_byte_data(client, AK8975_REG_ST2);
 		if (ret < 0) {
 			dev_err(&client->dev, "Error in reading ST2\n");
 			goto exit;
 		}
-		if (read_status & (AK8975_REG_ST2_DERR_MASK |
-				   AK8975_REG_ST2_HOFL_MASK)) {
-			dev_err(&client->dev, "ST2 status error 0x%x\n",
-				read_status);
+		if (ret & (AK8975_REG_ST2_DERR_MASK |
+			   AK8975_REG_ST2_HOFL_MASK)) {
+			dev_err(&client->dev, "ST2 status error 0x%x\n", ret);
 			ret = -EINVAL;
 			goto exit;
 		}
@@ -349,12 +317,12 @@ static int ak8975_read_axis(struct iio_dev *indio_dev, int index, int *val)
 
 	/* Read the flux value from the appropriate register
 	   (the register is specified in the iio device attributes). */
-	ret = ak8975_read_data(client, ak8975_index_to_reg[index],
-			       2, (u8 *)&meas_reg);
+	ret = i2c_smbus_read_word_data(client, ak8975_index_to_reg[index]);
 	if (ret < 0) {
 		dev_err(&client->dev, "Read axis data fails\n");
 		goto exit;
 	}
+	meas_reg = ret;
 
 	mutex_unlock(&data->lock);
 
-- 
1.8.1.4

