Return-Path: <linux-iio-owner@vger.kernel.org>
Received: from mail-sn1nam01on0053.outbound.protection.outlook.com ([104.47.32.53]:14688
        "EHLO NAM01-SN1-obe.outbound.protection.outlook.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1751994AbeD3KOn (ORCPT <rfc822;linux-iio@vger.kernel.org>);
        Mon, 30 Apr 2018 06:14:43 -0400
From: Jean-Baptiste Maneyrol <jmaneyrol@invensense.com>
To: linux-iio@vger.kernel.org
Cc: Jean-Baptiste Maneyrol <jmaneyrol@invensense.com>
Subject: [PATCH 1/4] iio: imu: inv_mpu6050: use i2c mux only for chip with i2c aux bus
Date: Mon, 30 Apr 2018 12:14:08 +0200
Message-Id: <1525083251-8368-1-git-send-email-jmaneyrol@invensense.com>
MIME-Version: 1.0
Content-Type: text/plain
Sender: linux-iio-owner@vger.kernel.org
List-Id: linux-iio@vger.kernel.org

icm20608 does not have i2c aux bus, so it does not make sense to
allocate an i2c mux for this chip.

Signed-off-by: Jean-Baptiste Maneyrol <jmaneyrol@invensense.com>
---
 drivers/iio/imu/inv_mpu6050/inv_mpu_i2c.c | 41 +++++++++++++++++++------------
 1 file changed, 25 insertions(+), 16 deletions(-)

diff --git a/drivers/iio/imu/inv_mpu6050/inv_mpu_i2c.c b/drivers/iio/imu/inv_mpu6050/inv_mpu_i2c.c
index 90fdc5e..f11ae29 100644
--- a/drivers/iio/imu/inv_mpu6050/inv_mpu_i2c.c
+++ b/drivers/iio/imu/inv_mpu6050/inv_mpu_i2c.c
@@ -125,20 +125,27 @@ static int inv_mpu_probe(struct i2c_client *client,
 		return result;
 
 	st = iio_priv(dev_get_drvdata(&client->dev));
-	st->muxc = i2c_mux_alloc(client->adapter, &client->dev,
-				 1, 0, I2C_MUX_LOCKED | I2C_MUX_GATE,
-				 inv_mpu6050_select_bypass,
-				 inv_mpu6050_deselect_bypass);
-	if (!st->muxc)
-		return -ENOMEM;
-	st->muxc->priv = dev_get_drvdata(&client->dev);
-	result = i2c_mux_add_adapter(st->muxc, 0, 0, 0);
-	if (result)
-		return result;
-
-	result = inv_mpu_acpi_create_mux_client(client);
-	if (result)
-		goto out_del_mux;
+	switch (st->chip_type) {
+	case INV_ICM20608:
+		/* no i2c auxiliary bus on the chip */
+		break;
+	default:
+		/* declare i2c auxiliary bus */
+		st->muxc = i2c_mux_alloc(client->adapter, &client->dev,
+					 1, 0, I2C_MUX_LOCKED | I2C_MUX_GATE,
+					 inv_mpu6050_select_bypass,
+					 inv_mpu6050_deselect_bypass);
+		if (!st->muxc)
+			return -ENOMEM;
+		st->muxc->priv = dev_get_drvdata(&client->dev);
+		result = i2c_mux_add_adapter(st->muxc, 0, 0, 0);
+		if (result)
+			return result;
+		result = inv_mpu_acpi_create_mux_client(client);
+		if (result)
+			goto out_del_mux;
+		break;
+	}
 
 	return 0;
 
@@ -152,8 +159,10 @@ static int inv_mpu_remove(struct i2c_client *client)
 	struct iio_dev *indio_dev = i2c_get_clientdata(client);
 	struct inv_mpu6050_state *st = iio_priv(indio_dev);
 
-	inv_mpu_acpi_delete_mux_client(client);
-	i2c_mux_del_adapters(st->muxc);
+	if (st->muxc) {
+		inv_mpu_acpi_delete_mux_client(client);
+		i2c_mux_del_adapters(st->muxc);
+	}
 
 	return 0;
 }
-- 
2.7.4

