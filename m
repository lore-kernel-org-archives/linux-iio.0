Return-Path: <linux-iio-owner@vger.kernel.org>
Received: from mail-bl2nam02on0087.outbound.protection.outlook.com ([104.47.38.87]:19392
        "EHLO NAM02-BL2-obe.outbound.protection.outlook.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1751560AbdFGNpV (ORCPT <rfc822;linux-iio@vger.kernel.org>);
        Wed, 7 Jun 2017 09:45:21 -0400
From: Jean-Baptiste Maneyrol <JManeyrol@invensense.com>
To: linux-iio <linux-iio@vger.kernel.org>
Subject: [PATCH v2 4/7] iio: imu: inv_mpu6050: clean set_power_itg
 implementation and usage
Date: Wed, 7 Jun 2017 13:45:17 +0000
Message-ID: <BLUPR12MB0657D27B0C745164B770DE47C4C80@BLUPR12MB0657.namprd12.prod.outlook.com>
Content-Type: text/plain; charset="iso-8859-1"
MIME-Version: 1.0
Sender: linux-iio-owner@vger.kernel.org
List-Id: linux-iio@vger.kernel.org

Rewrite set_power_itg in a more clean way (failing now don't update
the reference counter). Fix usage in init function, use it inside
i2c mux bypass, and delete double declaration in header file.

Signed-off-by: Jean-Baptiste Maneyrol <jmaneyrol@invensense.com>
---
 drivers/iio/imu/inv_mpu6050/inv_mpu_core.c | 59 +++++++++++++++++++-------=
----
 drivers/iio/imu/inv_mpu6050/inv_mpu_i2c.c  | 30 +++++----------
 drivers/iio/imu/inv_mpu6050/inv_mpu_iio.h  |  1 -
 3 files changed, 46 insertions(+), 44 deletions(-)

diff --git a/drivers/iio/imu/inv_mpu6050/inv_mpu_core.c b/drivers/iio/imu/i=
nv_mpu6050/inv_mpu_core.c
index 4db6ed5..4ea4431 100644
--- a/drivers/iio/imu/inv_mpu6050/inv_mpu_core.c
+++ b/drivers/iio/imu/inv_mpu6050/inv_mpu_core.c
@@ -183,28 +183,41 @@ int inv_mpu6050_switch_engine(struct inv_mpu6050_stat=
e *st, bool en, u32 mask)
 	return 0;
 }
=20
+/**
+ *  inv_mpu6050_set_power_itg() - Power on/off chip using a reference coun=
ter.
+ *  @st: chip state
+ *  @power_on: turn chip on if true, off if false
+ *
+ *  Return error code or 0 if success.
+ *
+ *  powerup_count is not updated if the function fails.
+ */
 int inv_mpu6050_set_power_itg(struct inv_mpu6050_state *st, bool power_on)
 {
-	int result =3D 0;
+	int result;
=20
 	if (power_on) {
-		if (!st->powerup_count)
+		if (!st->powerup_count) {
 			result =3D regmap_write(st->map, st->reg->pwr_mgmt_1, 0);
-		if (!result)
-			st->powerup_count++;
+			if (result)
+				return result;
+			usleep_range(INV_MPU6050_REG_UP_TIME_MIN,
+				     INV_MPU6050_REG_UP_TIME_MAX);
+		}
+		st->powerup_count++;
 	} else {
-		st->powerup_count--;
-		if (!st->powerup_count)
+		/* turn chip off if there is only 1 power up demand remaining */
+		if (st->powerup_count =3D=3D 1) {
 			result =3D regmap_write(st->map, st->reg->pwr_mgmt_1,
 					      INV_MPU6050_BIT_SLEEP);
+			if (result)
+				return result;
+		}
+		st->powerup_count--;
 	}
=20
-	if (result)
-		return result;
-
-	if (power_on)
-		usleep_range(INV_MPU6050_REG_UP_TIME_MIN,
-			     INV_MPU6050_REG_UP_TIME_MAX);
+	dev_dbg(regmap_get_device(st->map), "power-up count: %u\n",
+		st->powerup_count);
=20
 	return 0;
 }
@@ -836,14 +849,10 @@ static int inv_check_and_setup_chip(struct inv_mpu605=
0_state *st)
 	}
=20
 	/*
-	 * toggle power state. After reset, the sleep bit could be on
-	 * or off depending on the OTP settings. Toggling power would
-	 * make it in a definite state as well as making the hardware
-	 * state align with the software state
+	 * After reset, the sleep bit could be on or off depending on the OTP
+	 * settings. Turning power on make the chip in a definite state as well
+	 * as making the hardware state align with the software state.
 	 */
-	result =3D inv_mpu6050_set_power_itg(st, false);
-	if (result)
-		return result;
 	result =3D inv_mpu6050_set_power_itg(st, true);
 	if (result)
 		return result;
@@ -851,13 +860,19 @@ static int inv_check_and_setup_chip(struct inv_mpu605=
0_state *st)
 	result =3D inv_mpu6050_switch_engine(st, false,
 					   INV_MPU6050_BIT_PWR_ACCL_STBY);
 	if (result)
-		return result;
+		goto error_power_off;
 	result =3D inv_mpu6050_switch_engine(st, false,
 					   INV_MPU6050_BIT_PWR_GYRO_STBY);
 	if (result)
-		return result;
+		goto error_power_off;
=20
-	return 0;
+	result =3D inv_mpu6050_set_power_itg(st, false);
+
+	return result;
+
+error_power_off:
+	inv_mpu6050_set_power_itg(st, false);
+	return result;
 }
=20
 int inv_mpu_core_probe(struct regmap *regmap, int irq, const char *name,
diff --git a/drivers/iio/imu/inv_mpu6050/inv_mpu_i2c.c b/drivers/iio/imu/in=
v_mpu6050/inv_mpu_i2c.c
index fcd7a92..6ac5375 100644
--- a/drivers/iio/imu/inv_mpu6050/inv_mpu_i2c.c
+++ b/drivers/iio/imu/inv_mpu6050/inv_mpu_i2c.c
@@ -29,25 +29,16 @@ static int inv_mpu6050_select_bypass(struct i2c_mux_cor=
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
-
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
+	ret =3D regmap_write(st->map, st->reg->int_pin_cfg,
+			   INV_MPU6050_INT_PIN_CFG |
+			   INV_MPU6050_BIT_BYPASS_EN);
+error_unlock:
 	mutex_unlock(&st->lock);
=20
 	return ret;
@@ -61,10 +52,7 @@ static int inv_mpu6050_deselect_bypass(struct i2c_mux_co=
re *muxc, u32 chan_id)
 	mutex_lock(&st->lock);
 	/* It doesn't really mattter, if any of the calls fails */
 	regmap_write(st->map, st->reg->int_pin_cfg, INV_MPU6050_INT_PIN_CFG);
-	st->powerup_count--;
-	if (!st->powerup_count)
-		regmap_write(st->map, st->reg->pwr_mgmt_1,
-			     INV_MPU6050_BIT_SLEEP);
+	inv_mpu6050_set_power_itg(st, false);
 	mutex_unlock(&st->lock);
=20
 	return 0;
diff --git a/drivers/iio/imu/inv_mpu6050/inv_mpu_iio.h b/drivers/iio/imu/in=
v_mpu6050/inv_mpu_iio.h
index 0657941..c3d6225 100644
--- a/drivers/iio/imu/inv_mpu6050/inv_mpu_iio.h
+++ b/drivers/iio/imu/inv_mpu6050/inv_mpu_iio.h
@@ -298,5 +298,4 @@ enum inv_mpu6050_clock_sel_e {
 int inv_mpu_core_probe(struct regmap *regmap, int irq, const char *name,
 		int (*inv_mpu_bus_setup)(struct iio_dev *), int chip_type);
 int inv_mpu_core_remove(struct device *dev);
-int inv_mpu6050_set_power_itg(struct inv_mpu6050_state *st, bool power_on)=
;
 extern const struct dev_pm_ops inv_mpu_pmops;
--=20
1.9.1
