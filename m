Return-Path: <linux-iio-owner@vger.kernel.org>
Received: from mail-by2nam01on0088.outbound.protection.outlook.com ([104.47.34.88]:13257
        "EHLO NAM01-BY2-obe.outbound.protection.outlook.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1751099AbeCZOAT (ORCPT <rfc822;linux-iio@vger.kernel.org>);
        Mon, 26 Mar 2018 10:00:19 -0400
From: Jean-Baptiste Maneyrol <JManeyrol@invensense.com>
To: linux-iio <linux-iio@vger.kernel.org>
Subject: [PATCH 2/3] iio: imu: inv_mpu6050: use set_power_itg function in i2c
 mux
Date: Mon, 26 Mar 2018 14:00:17 +0000
Message-ID: <CY4PR1201MB018412CC56073D8F1F70CFEAC4AD0@CY4PR1201MB0184.namprd12.prod.outlook.com>
Content-Type: text/plain; charset="iso-8859-1"
MIME-Version: 1.0
Sender: linux-iio-owner@vger.kernel.org
List-Id: linux-iio@vger.kernel.org

Set power function is rewritten manually inside i2c mux select.
Better use the already identical existing function.

Signed-off-by: Jean-Baptiste Maneyrol <jmaneyrol@invensense.com>
---
 drivers/iio/imu/inv_mpu6050/inv_mpu_i2c.c | 33 ++++++++++++---------------=
----
 1 file changed, 13 insertions(+), 20 deletions(-)

diff --git a/drivers/iio/imu/inv_mpu6050/inv_mpu_i2c.c b/drivers/iio/imu/in=
v_mpu6050/inv_mpu_i2c.c
index fcd7a92..8a8a5bd 100644
--- a/drivers/iio/imu/inv_mpu6050/inv_mpu_i2c.c
+++ b/drivers/iio/imu/inv_mpu6050/inv_mpu_i2c.c
@@ -29,25 +29,19 @@ static int inv_mpu6050_select_bypass(struct i2c_mux_cor=
e *muxc, u32 chan_id)
 {
 	struct iio_dev *indio_dev =3D i2c_mux_priv(muxc);
 	struct inv_mpu6050_state *st =3D iio_priv(indio_dev);
-	int ret =3D 0;
+	int ret;
=20
-	/* Use the same mutex which was used everywhere to protect power-op */
 	mutex_lock(&st->lock);
-	if (!st->powerup_count) {
-		ret =3D regmap_write(st->map, st->reg->pwr_mgmt_1, 0);
-		if (ret)
-			goto write_error;
=20
-		usleep_range(INV_MPU6050_REG_UP_TIME_MIN,
-			     INV_MPU6050_REG_UP_TIME_MAX);
-	}
-	if (!ret) {
-		st->powerup_count++;
-		ret =3D regmap_write(st->map, st->reg->int_pin_cfg,
-				   INV_MPU6050_INT_PIN_CFG |
-				   INV_MPU6050_BIT_BYPASS_EN);
-	}
-write_error:
+	ret =3D inv_mpu6050_set_power_itg(st, true);
+	if (ret)
+		goto error_unlock;
+
+	ret =3D regmap_write(st->map, st->reg->int_pin_cfg,
+			   INV_MPU6050_INT_PIN_CFG |
+			   INV_MPU6050_BIT_BYPASS_EN);
+
+error_unlock:
 	mutex_unlock(&st->lock);
=20
 	return ret;
@@ -59,12 +53,11 @@ static int inv_mpu6050_deselect_bypass(struct i2c_mux_c=
ore *muxc, u32 chan_id)
 	struct inv_mpu6050_state *st =3D iio_priv(indio_dev);
=20
 	mutex_lock(&st->lock);
+
 	/* It doesn't really mattter, if any of the calls fails */
 	regmap_write(st->map, st->reg->int_pin_cfg, INV_MPU6050_INT_PIN_CFG);
-	st->powerup_count--;
-	if (!st->powerup_count)
-		regmap_write(st->map, st->reg->pwr_mgmt_1,
-			     INV_MPU6050_BIT_SLEEP);
+	inv_mpu6050_set_power_itg(st, false);
+
 	mutex_unlock(&st->lock);
=20
 	return 0;
--=20
2.7.4
