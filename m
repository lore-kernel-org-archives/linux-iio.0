Return-Path: <linux-iio-owner@vger.kernel.org>
Received: from mail-ig0-f182.google.com ([209.85.213.182]:64104 "EHLO
	mail-ig0-f182.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S934543AbaDJC1I (ORCPT
	<rfc822;linux-iio@vger.kernel.org>); Wed, 9 Apr 2014 22:27:08 -0400
Received: by mail-ig0-f182.google.com with SMTP id uy17so3222688igb.9
        for <linux-iio@vger.kernel.org>; Wed, 09 Apr 2014 19:27:08 -0700 (PDT)
From: Michael Welling <mwelling@ieee.org>
To: linux-iio@vger.kernel.org, jic23@kernel.org,
	gregkh@linuxfoundation.org
Cc: Michael Welling <mwelling@ieee.org>
Subject: [PATCH 2/3] Staging: iio: Remove quoted string split across lines warnings
Date: Wed,  9 Apr 2014 21:26:44 -0500
Message-Id: <1397096805-25168-3-git-send-email-mwelling@ieee.org>
In-Reply-To: <1397096805-25168-1-git-send-email-mwelling@ieee.org>
References: <1397096805-25168-1-git-send-email-mwelling@ieee.org>
Sender: linux-iio-owner@vger.kernel.org
List-Id: linux-iio@vger.kernel.org

Signed-off-by: Michael Welling <mwelling@ieee.org>
---
 drivers/staging/iio/light/tsl2583.c |   34 ++++++++++++++++++----------------
 1 file changed, 18 insertions(+), 16 deletions(-)

diff --git a/drivers/staging/iio/light/tsl2583.c b/drivers/staging/iio/light/tsl2583.c
index 77c7f65..f015fb4 100644
--- a/drivers/staging/iio/light/tsl2583.c
+++ b/drivers/staging/iio/light/tsl2583.c
@@ -165,8 +165,9 @@ taos_i2c_read(struct i2c_client *client, u8 reg, u8 *val, unsigned int len)
 		/* select register to write */
 		ret = i2c_smbus_write_byte(client, (TSL258X_CMD_REG | reg));
 		if (ret < 0) {
-			dev_err(&client->dev, "taos_i2c_read failed to write"
-				" register %x\n", reg);
+			dev_err(&client->dev,
+				"taos_i2c_read failed to write register %x\n",
+				reg);
 			return ret;
 		}
 		/* read the data */
@@ -231,8 +232,9 @@ static int taos_get_lux(struct iio_dev *indio_dev)
 		int reg = TSL258X_CMD_REG | (TSL258X_ALS_CHAN0LO + i);
 		ret = taos_i2c_read(chip->client, reg, &buf[i], 1);
 		if (ret < 0) {
-			dev_err(&chip->client->dev, "taos_get_lux failed to read"
-				" register %x\n", reg);
+			dev_err(&chip->client->dev,
+				"taos_get_lux failed to read register %x\n",
+				reg);
 			goto out_unlock;
 		}
 	}
@@ -809,9 +811,7 @@ static int taos_probe(struct i2c_client *clientp,
 
 	if (!i2c_check_functionality(clientp->adapter,
 		I2C_FUNC_SMBUS_BYTE_DATA)) {
-		dev_err(&clientp->dev,
-			"taos_probe() - i2c smbus byte data "
-			"functions unsupported\n");
+		dev_err(&clientp->dev, "taos_probe() - i2c smbus byte data func unsupported\n");
 		return -EOPNOTSUPP;
 	}
 
@@ -830,30 +830,32 @@ static int taos_probe(struct i2c_client *clientp,
 		ret = i2c_smbus_write_byte(clientp,
 				(TSL258X_CMD_REG | (TSL258X_CNTRL + i)));
 		if (ret < 0) {
-			dev_err(&clientp->dev, "i2c_smbus_write_bytes() to cmd "
-				"reg failed in taos_probe(), err = %d\n", ret);
+			dev_err(&clientp->dev,
+				"i2c_smbus_write_byte to cmd reg failed in taos_probe(), err = %d\n",
+				ret);
 			return ret;
 		}
 		ret = i2c_smbus_read_byte(clientp);
 		if (ret < 0) {
-			dev_err(&clientp->dev, "i2c_smbus_read_byte from "
-				"reg failed in taos_probe(), err = %d\n", ret);
-
+			dev_err(&clientp->dev,
+				"i2c_smbus_read_byte from reg failed in taos_probe(), err = %d\n",
+				ret);
 			return ret;
 		}
 		buf[i] = ret;
 	}
 
 	if (!taos_tsl258x_device(buf)) {
-		dev_info(&clientp->dev, "i2c device found but does not match "
-			"expected id in taos_probe()\n");
+		dev_info(&clientp->dev,
+			"i2c device found but does not match expected id in taos_probe()\n");
 		return -EINVAL;
 	}
 
 	ret = i2c_smbus_write_byte(clientp, (TSL258X_CMD_REG | TSL258X_CNTRL));
 	if (ret < 0) {
-		dev_err(&clientp->dev, "i2c_smbus_write_byte() to cmd reg "
-			"failed in taos_probe(), err = %d\n", ret);
+		dev_err(&clientp->dev,
+			"i2c_smbus_write_byte() to cmd reg failed in taos_probe(), err = %d\n",
+			ret);
 		return ret;
 	}
 
-- 
1.7.9.5

