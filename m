Return-Path: <linux-iio-owner@vger.kernel.org>
Received: from mail-bl2nam02on0063.outbound.protection.outlook.com ([104.47.38.63]:42684
        "EHLO NAM02-BL2-obe.outbound.protection.outlook.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1751163AbeC3OZx (ORCPT <rfc822;linux-iio@vger.kernel.org>);
        Fri, 30 Mar 2018 10:25:53 -0400
From: Jean-Baptiste Maneyrol <JManeyrol@invensense.com>
To: linux-iio <linux-iio@vger.kernel.org>
Subject: [PATCH 1/2] iio: imu: inv_mpu6050: clean set_power_itg and fix usage
Date: Fri, 30 Mar 2018 14:25:50 +0000
Message-ID: <CY4PR1201MB0184E53EA4D1632786ED4CE8C4A10@CY4PR1201MB0184.namprd12.prod.outlook.com>
Content-Type: text/plain; charset="iso-8859-1"
MIME-Version: 1.0
Sender: linux-iio-owner@vger.kernel.org
List-Id: linux-iio@vger.kernel.org

Rewrite set_power_itg. Failing when turning power off is
no more decreasing the counter now and sleeping only happens
when effectively turning the chip on. Fix also usage in init
function (setting power on one time is sufficient to ensure
chip is effectively on).

Signed-off-by: Jean-Baptiste Maneyrol <jmaneyrol@invensense.com>
---
 drivers/iio/imu/inv_mpu6050/inv_mpu_core.c | 44 ++++++++++++++++----------=
----
 1 file changed, 24 insertions(+), 20 deletions(-)

diff --git a/drivers/iio/imu/inv_mpu6050/inv_mpu_core.c b/drivers/iio/imu/i=
nv_mpu6050/inv_mpu_core.c
index 7d64be3..f17fbfa 100644
--- a/drivers/iio/imu/inv_mpu6050/inv_mpu_core.c
+++ b/drivers/iio/imu/inv_mpu6050/inv_mpu_core.c
@@ -185,26 +185,29 @@ int inv_mpu6050_switch_engine(struct inv_mpu6050_stat=
e *st, bool en, u32 mask)
=20
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
+	dev_dbg(regmap_get_device(st->map), "set power %d, count=3D%u\n",
+		power_on, st->powerup_count);
=20
 	return 0;
 }
@@ -850,14 +853,11 @@ static int inv_check_and_setup_chip(struct inv_mpu605=
0_state *st)
 	msleep(INV_MPU6050_POWER_UP_TIME);
=20
 	/*
-	 * toggle power state. After reset, the sleep bit could be on
-	 * or off depending on the OTP settings. Toggling power would
+	 * Turn power on. After reset, the sleep bit could be on
+	 * or off depending on the OTP settings. Turning power on
 	 * make it in a definite state as well as making the hardware
 	 * state align with the software state
 	 */
-	result =3D inv_mpu6050_set_power_itg(st, false);
-	if (result)
-		return result;
 	result =3D inv_mpu6050_set_power_itg(st, true);
 	if (result)
 		return result;
@@ -865,13 +865,17 @@ static int inv_check_and_setup_chip(struct inv_mpu605=
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
+	return inv_mpu6050_set_power_itg(st, false);
+
+error_power_off:
+	inv_mpu6050_set_power_itg(st, false);
+	return result;
 }
=20
 int inv_mpu_core_probe(struct regmap *regmap, int irq, const char *name,
--=20
2.7.4
