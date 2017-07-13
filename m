Return-Path: <linux-iio-owner@vger.kernel.org>
Received: from mail-by2nam01on0065.outbound.protection.outlook.com ([104.47.34.65]:33983
        "EHLO NAM01-BY2-obe.outbound.protection.outlook.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1751334AbdGMNaH (ORCPT <rfc822;linux-iio@vger.kernel.org>);
        Thu, 13 Jul 2017 09:30:07 -0400
From: Jean-Baptiste Maneyrol <JManeyrol@invensense.com>
To: linux-iio <linux-iio@vger.kernel.org>
Subject: [PATCH 1/5] iio: imu: inv_mpu6050: fix error path not turning chip
 back off
Date: Thu, 13 Jul 2017 13:30:04 +0000
Message-ID: <CY4PR1201MB01846D4381783299959BFB64C4AC0@CY4PR1201MB0184.namprd12.prod.outlook.com>
Content-Type: text/plain; charset="iso-8859-1"
MIME-Version: 1.0
Sender: linux-iio-owner@vger.kernel.org
List-Id: linux-iio@vger.kernel.org

Some functions are turning the chip on and not back off in error
path. With set_power function using a reference counter this is
keeping the chip on forever.

Signed-off-by: Jean-Baptiste Maneyrol <jmaneyrol@invensense.com>
---
 drivers/iio/imu/inv_mpu6050/inv_mpu_core.c    | 12 ++++++++----
 drivers/iio/imu/inv_mpu6050/inv_mpu_trigger.c | 23 +++++++++++++++--------
 2 files changed, 23 insertions(+), 12 deletions(-)

diff --git a/drivers/iio/imu/inv_mpu6050/inv_mpu_core.c b/drivers/iio/imu/i=
nv_mpu6050/inv_mpu_core.c
index 44830bc..b1a8159 100644
--- a/drivers/iio/imu/inv_mpu6050/inv_mpu_core.c
+++ b/drivers/iio/imu/inv_mpu6050/inv_mpu_core.c
@@ -262,27 +262,31 @@ static int inv_mpu6050_init_config(struct iio_dev *in=
dio_dev)
 	d =3D (INV_MPU6050_FSR_2000DPS << INV_MPU6050_GYRO_CONFIG_FSR_SHIFT);
 	result =3D regmap_write(st->map, st->reg->gyro_config, d);
 	if (result)
-		return result;
+		goto error_power_off;
=20
 	result =3D inv_mpu6050_set_lpf_regs(st, INV_MPU6050_FILTER_20HZ);
 	if (result)
-		return result;
+		goto error_power_off;
=20
 	d =3D INV_MPU6050_ONE_K_HZ / INV_MPU6050_INIT_FIFO_RATE - 1;
 	result =3D regmap_write(st->map, st->reg->sample_rate_div, d);
 	if (result)
-		return result;
+		goto error_power_off;
=20
 	d =3D (INV_MPU6050_FS_02G << INV_MPU6050_ACCL_CONFIG_FSR_SHIFT);
 	result =3D regmap_write(st->map, st->reg->accl_config, d);
 	if (result)
-		return result;
+		goto error_power_off;
=20
 	memcpy(&st->chip_config, hw_info[st->chip_type].config,
 	       sizeof(struct inv_mpu6050_chip_config));
 	result =3D inv_mpu6050_set_power_itg(st, false);
=20
 	return result;
+
+error_power_off:
+	inv_mpu6050_set_power_itg(st, false);
+	return result;
 }
=20
 static int inv_mpu6050_sensor_set(struct inv_mpu6050_state  *st, int reg,
diff --git a/drivers/iio/imu/inv_mpu6050/inv_mpu_trigger.c b/drivers/iio/im=
u/inv_mpu6050/inv_mpu_trigger.c
index 540070f..85c2732 100644
--- a/drivers/iio/imu/inv_mpu6050/inv_mpu_trigger.c
+++ b/drivers/iio/imu/inv_mpu6050/inv_mpu_trigger.c
@@ -53,45 +53,52 @@ static int inv_mpu6050_set_enable(struct iio_dev *indio=
_dev, bool enable)
 			result =3D inv_mpu6050_switch_engine(st, true,
 					INV_MPU6050_BIT_PWR_GYRO_STBY);
 			if (result)
-				return result;
+				goto error_power_off;
 		}
 		if (st->chip_config.accl_fifo_enable) {
 			result =3D inv_mpu6050_switch_engine(st, true,
 					INV_MPU6050_BIT_PWR_ACCL_STBY);
 			if (result)
-				return result;
+				goto error_power_off;
 		}
 		result =3D inv_reset_fifo(indio_dev);
 		if (result)
-			return result;
+			goto error_power_off;
 	} else {
 		result =3D regmap_write(st->map, st->reg->fifo_en, 0);
 		if (result)
-			return result;
+			goto error_power_off;
=20
 		result =3D regmap_write(st->map, st->reg->int_enable, 0);
 		if (result)
-			return result;
+			goto error_power_off;
=20
 		result =3D regmap_write(st->map, st->reg->user_ctrl, 0);
 		if (result)
-			return result;
+			goto error_power_off;
=20
 		result =3D inv_mpu6050_switch_engine(st, false,
 					INV_MPU6050_BIT_PWR_GYRO_STBY);
 		if (result)
-			return result;
+			goto error_power_off;
+		st->chip_config.gyro_fifo_enable =3D false;
=20
 		result =3D inv_mpu6050_switch_engine(st, false,
 					INV_MPU6050_BIT_PWR_ACCL_STBY);
 		if (result)
-			return result;
+			goto error_power_off;
+		st->chip_config.accl_fifo_enable =3D false;
+
 		result =3D inv_mpu6050_set_power_itg(st, false);
 		if (result)
 			return result;
 	}
=20
 	return 0;
+
+error_power_off:
+	inv_mpu6050_set_power_itg(st, false);
+	return result;
 }
=20
 /**
--=20
1.9.1
