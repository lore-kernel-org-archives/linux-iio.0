Return-Path: <linux-iio-owner@vger.kernel.org>
Received: from mail-co1nam03on0080.outbound.protection.outlook.com ([104.47.40.80]:2209
        "EHLO NAM03-CO1-obe.outbound.protection.outlook.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1751183AbeDQIHp (ORCPT <rfc822;linux-iio@vger.kernel.org>);
        Tue, 17 Apr 2018 04:07:45 -0400
From: Jean-Baptiste Maneyrol <jmaneyrol@invensense.com>
To: linux-iio@vger.kernel.org
Cc: Jean-Baptiste Maneyrol <jmaneyrol@invensense.com>
Subject: [PATCH v3 1/4] iio: imu: inv_mpu6050: fix error path not turning chip back off
Date: Tue, 17 Apr 2018 10:07:19 +0200
Message-Id: <1523952442-20104-1-git-send-email-jmaneyrol@invensense.com>
MIME-Version: 1.0
Content-Type: text/plain
Sender: linux-iio-owner@vger.kernel.org
List-Id: linux-iio@vger.kernel.org

Some functions are turning the chip on and not back off in error
path. With set_power function using a reference counter that
would keep the chip on forever.
---
 drivers/iio/imu/inv_mpu6050/inv_mpu_core.c    | 12 ++++++---
 drivers/iio/imu/inv_mpu6050/inv_mpu_trigger.c | 35 ++++++++++++++++++---------
 2 files changed, 32 insertions(+), 15 deletions(-)

diff --git a/drivers/iio/imu/inv_mpu6050/inv_mpu_core.c b/drivers/iio/imu/inv_mpu6050/inv_mpu_core.c
index 20b94d9..ba2f08e 100644
--- a/drivers/iio/imu/inv_mpu6050/inv_mpu_core.c
+++ b/drivers/iio/imu/inv_mpu6050/inv_mpu_core.c
@@ -268,27 +268,31 @@ static int inv_mpu6050_init_config(struct iio_dev *indio_dev)
 	d = (INV_MPU6050_FSR_2000DPS << INV_MPU6050_GYRO_CONFIG_FSR_SHIFT);
 	result = regmap_write(st->map, st->reg->gyro_config, d);
 	if (result)
-		return result;
+		goto error_power_off;
 
 	result = inv_mpu6050_set_lpf_regs(st, INV_MPU6050_FILTER_20HZ);
 	if (result)
-		return result;
+		goto error_power_off;
 
 	d = INV_MPU6050_ONE_K_HZ / INV_MPU6050_INIT_FIFO_RATE - 1;
 	result = regmap_write(st->map, st->reg->sample_rate_div, d);
 	if (result)
-		return result;
+		goto error_power_off;
 
 	d = (INV_MPU6050_FS_02G << INV_MPU6050_ACCL_CONFIG_FSR_SHIFT);
 	result = regmap_write(st->map, st->reg->accl_config, d);
 	if (result)
-		return result;
+		goto error_power_off;
 
 	memcpy(&st->chip_config, hw_info[st->chip_type].config,
 	       sizeof(struct inv_mpu6050_chip_config));
 	result = inv_mpu6050_set_power_itg(st, false);
 
 	return result;
+
+error_power_off:
+	inv_mpu6050_set_power_itg(st, false);
+	return result;
 }
 
 static int inv_mpu6050_sensor_set(struct inv_mpu6050_state  *st, int reg,
diff --git a/drivers/iio/imu/inv_mpu6050/inv_mpu_trigger.c b/drivers/iio/imu/inv_mpu6050/inv_mpu_trigger.c
index f963f9f..27aa976 100644
--- a/drivers/iio/imu/inv_mpu6050/inv_mpu_trigger.c
+++ b/drivers/iio/imu/inv_mpu6050/inv_mpu_trigger.c
@@ -53,45 +53,58 @@ static int inv_mpu6050_set_enable(struct iio_dev *indio_dev, bool enable)
 			result = inv_mpu6050_switch_engine(st, true,
 					INV_MPU6050_BIT_PWR_GYRO_STBY);
 			if (result)
-				return result;
+				goto error_power_off;
 		}
 		if (st->chip_config.accl_fifo_enable) {
 			result = inv_mpu6050_switch_engine(st, true,
 					INV_MPU6050_BIT_PWR_ACCL_STBY);
 			if (result)
-				return result;
+				goto error_gyro_off;
 		}
 		result = inv_reset_fifo(indio_dev);
 		if (result)
-			return result;
+			goto error_accl_off;
 	} else {
 		result = regmap_write(st->map, st->reg->fifo_en, 0);
 		if (result)
-			return result;
+			goto error_accl_off;
 
 		result = regmap_write(st->map, st->reg->int_enable, 0);
 		if (result)
-			return result;
+			goto error_accl_off;
 
 		result = regmap_write(st->map, st->reg->user_ctrl, 0);
 		if (result)
-			return result;
+			goto error_accl_off;
 
 		result = inv_mpu6050_switch_engine(st, false,
-					INV_MPU6050_BIT_PWR_GYRO_STBY);
+					INV_MPU6050_BIT_PWR_ACCL_STBY);
 		if (result)
-			return result;
+			goto error_accl_off;
 
 		result = inv_mpu6050_switch_engine(st, false,
-					INV_MPU6050_BIT_PWR_ACCL_STBY);
+					INV_MPU6050_BIT_PWR_GYRO_STBY);
 		if (result)
-			return result;
+			goto error_gyro_off;
+
 		result = inv_mpu6050_set_power_itg(st, false);
 		if (result)
-			return result;
+			goto error_power_off;
 	}
 
 	return 0;
+
+error_accl_off:
+	if (st->chip_config.accl_fifo_enable)
+		inv_mpu6050_switch_engine(st, false,
+					  INV_MPU6050_BIT_PWR_ACCL_STBY);
+error_gyro_off:
+	if (st->chip_config.gyro_fifo_enable)
+		inv_mpu6050_switch_engine(st, false,
+					  INV_MPU6050_BIT_PWR_GYRO_STBY);
+error_power_off:
+	inv_mpu6050_set_power_itg(st, false);
+	return result;
 }
 
 /**
-- 
2.7.4

