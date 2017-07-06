Return-Path: <linux-iio-owner@vger.kernel.org>
Received: from onstation.org ([52.200.56.107]:58508 "EHLO onstation.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1752708AbdGFW4h (ORCPT <rfc822;linux-iio@vger.kernel.org>);
        Thu, 6 Jul 2017 18:56:37 -0400
From: Brian Masney <masneyb@onstation.org>
To: jic23@kernel.org, linux-iio@vger.kernel.org
Cc: gregkh@linuxfoundation.org, devel@driverdev.osuosl.org,
        knaack.h@gmx.de, lars@metafoo.de, pmeerw@pmeerw.net,
        linux-kernel@vger.kernel.org, Jon.Brenner@ams.com
Subject: [PATCH v2 4/9] staging: iio: tsl2x7x: remove tsl2x7x_i2c_read()
Date: Thu,  6 Jul 2017 18:56:21 -0400
Message-Id: <20170706225626.6716-5-masneyb@onstation.org>
In-Reply-To: <20170706225626.6716-1-masneyb@onstation.org>
References: <20170706225626.6716-1-masneyb@onstation.org>
Sender: linux-iio-owner@vger.kernel.org
List-Id: linux-iio@vger.kernel.org

tsl2x7x_i2c_read() would call i2c_smbus_write_byte() and
i2c_smbus_read_byte(). These two i2c functions can be replaced with a
single call to i2c_smbus_read_byte_data(). This patch removes the
tsl2x7x_i2c_read() function and replaces all occurrences with a call to
i2c_smbus_read_byte_data().

Signed-off-by: Brian Masney <masneyb@onstation.org>
---
 drivers/staging/iio/light/tsl2x7x.c | 71 ++++++++++++-------------------------
 1 file changed, 22 insertions(+), 49 deletions(-)

diff --git a/drivers/staging/iio/light/tsl2x7x.c b/drivers/staging/iio/light/tsl2x7x.c
index 95ed7cc6..6c9f06b 100644
--- a/drivers/staging/iio/light/tsl2x7x.c
+++ b/drivers/staging/iio/light/tsl2x7x.c
@@ -285,35 +285,6 @@ static const u8 device_channel_config[] = {
 };
 
 /**
- * tsl2x7x_i2c_read() - Read a byte from a register.
- * @client:	i2c client
- * @reg:	device register to read from
- * @*val:	pointer to location to store register contents.
- *
- */
-static int
-tsl2x7x_i2c_read(struct i2c_client *client, u8 reg, u8 *val)
-{
-	int ret;
-
-	/* select register to write */
-	ret = i2c_smbus_write_byte(client, (TSL2X7X_CMD_REG | reg));
-	if (ret < 0) {
-		dev_err(&client->dev, "failed to write register %x\n", reg);
-		return ret;
-	}
-
-	/* read the data */
-	ret = i2c_smbus_read_byte(client);
-	if (ret >= 0)
-		*val = (u8)ret;
-	else
-		dev_err(&client->dev, "failed to read register %x\n", reg);
-
-	return ret;
-}
-
-/**
  * tsl2x7x_get_lux() - Reads and calculates current lux value.
  * @indio_dev:	pointer to IIO device
  *
@@ -352,15 +323,15 @@ static int tsl2x7x_get_lux(struct iio_dev *indio_dev)
 		goto out_unlock;
 	}
 
-	ret = tsl2x7x_i2c_read(chip->client,
-			       (TSL2X7X_CMD_REG | TSL2X7X_STATUS), &buf[0]);
+	ret = i2c_smbus_read_byte_data(chip->client,
+				       TSL2X7X_CMD_REG | TSL2X7X_STATUS);
 	if (ret < 0) {
 		dev_err(&chip->client->dev,
 			"%s: Failed to read STATUS Reg\n", __func__);
 		goto out_unlock;
 	}
 	/* is data new & valid */
-	if (!(buf[0] & TSL2X7X_STA_ADC_VALID)) {
+	if (!(ret & TSL2X7X_STA_ADC_VALID)) {
 		dev_err(&chip->client->dev,
 			"%s: data not valid yet\n", __func__);
 		ret = chip->als_cur_info.lux; /* return LAST VALUE */
@@ -368,14 +339,16 @@ static int tsl2x7x_get_lux(struct iio_dev *indio_dev)
 	}
 
 	for (i = 0; i < 4; i++) {
-		ret = tsl2x7x_i2c_read(chip->client,
-				       (TSL2X7X_CMD_REG |
-				       (TSL2X7X_ALS_CHAN0LO + i)), &buf[i]);
+		int reg = TSL2X7X_CMD_REG | (TSL2X7X_ALS_CHAN0LO + i);
+
+		ret = i2c_smbus_read_byte_data(chip->client, reg);
 		if (ret < 0) {
 			dev_err(&chip->client->dev,
 				"failed to read. err=%x\n", ret);
 			goto out_unlock;
 		}
+
+		buf[i] = ret;
 	}
 
 	/* clear any existing interrupt status */
@@ -475,7 +448,6 @@ static int tsl2x7x_get_prox(struct iio_dev *indio_dev)
 {
 	int i;
 	int ret;
-	u8 status;
 	u8 chdata[2];
 	struct tsl2X7X_chip *chip = iio_priv(indio_dev);
 
@@ -485,8 +457,8 @@ static int tsl2x7x_get_prox(struct iio_dev *indio_dev)
 		return -EBUSY;
 	}
 
-	ret = tsl2x7x_i2c_read(chip->client,
-			       (TSL2X7X_CMD_REG | TSL2X7X_STATUS), &status);
+	ret = i2c_smbus_read_byte_data(chip->client,
+				       TSL2X7X_CMD_REG | TSL2X7X_STATUS);
 	if (ret < 0) {
 		dev_err(&chip->client->dev, "i2c err=%d\n", ret);
 		goto prox_poll_err;
@@ -498,7 +470,7 @@ static int tsl2x7x_get_prox(struct iio_dev *indio_dev)
 	case tmd2671:
 	case tsl2771:
 	case tmd2771:
-		if (!(status & TSL2X7X_STA_ADC_VALID))
+		if (!(ret & TSL2X7X_STA_ADC_VALID))
 			goto prox_poll_err;
 	break;
 	case tsl2572:
@@ -506,17 +478,19 @@ static int tsl2x7x_get_prox(struct iio_dev *indio_dev)
 	case tmd2672:
 	case tsl2772:
 	case tmd2772:
-		if (!(status & TSL2X7X_STA_PRX_VALID))
+		if (!(ret & TSL2X7X_STA_PRX_VALID))
 			goto prox_poll_err;
 	break;
 	}
 
 	for (i = 0; i < 2; i++) {
-		ret = tsl2x7x_i2c_read(chip->client,
-				       (TSL2X7X_CMD_REG |
-				       (TSL2X7X_PRX_LO + i)), &chdata[i]);
+		int reg = TSL2X7X_CMD_REG | (TSL2X7X_PRX_LO + i);
+
+		ret = i2c_smbus_read_byte_data(chip->client, reg);
 		if (ret < 0)
 			goto prox_poll_err;
+
+		chdata[i] = ret;
 	}
 
 	chip->prox_data =
@@ -1486,7 +1460,7 @@ static DEVICE_ATTR_RW(in_intensity0_thresh_period);
 static DEVICE_ATTR_RW(in_proximity0_thresh_period);
 
 /* Use the default register values to identify the Taos device */
-static int tsl2x7x_device_id(unsigned char *id, int target)
+static int tsl2x7x_device_id(int *id, int target)
 {
 	switch (target) {
 	case tsl2571:
@@ -1843,7 +1817,6 @@ static int tsl2x7x_probe(struct i2c_client *clientp,
 			 const struct i2c_device_id *id)
 {
 	int ret;
-	unsigned char device_id;
 	struct iio_dev *indio_dev;
 	struct tsl2X7X_chip *chip;
 
@@ -1855,13 +1828,13 @@ static int tsl2x7x_probe(struct i2c_client *clientp,
 	chip->client = clientp;
 	i2c_set_clientdata(clientp, indio_dev);
 
-	ret = tsl2x7x_i2c_read(chip->client,
-			       TSL2X7X_CHIPID, &device_id);
+	ret = i2c_smbus_read_byte_data(chip->client,
+				       TSL2X7X_CMD_REG | TSL2X7X_CHIPID);
 	if (ret < 0)
 		return ret;
 
-	if ((!tsl2x7x_device_id(&device_id, id->driver_data)) ||
-	    (tsl2x7x_device_id(&device_id, id->driver_data) == -EINVAL)) {
+	if ((!tsl2x7x_device_id(&ret, id->driver_data)) ||
+	    (tsl2x7x_device_id(&ret, id->driver_data) == -EINVAL)) {
 		dev_info(&chip->client->dev,
 			 "%s: i2c device found does not match expected id\n",
 				__func__);
-- 
2.9.4

