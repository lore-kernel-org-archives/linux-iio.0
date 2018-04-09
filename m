Return-Path: <linux-iio-owner@vger.kernel.org>
Received: from mail-by2nam01on0062.outbound.protection.outlook.com ([104.47.34.62]:28384
        "EHLO NAM01-BY2-obe.outbound.protection.outlook.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1752830AbeDIO5S (ORCPT <rfc822;linux-iio@vger.kernel.org>);
        Mon, 9 Apr 2018 10:57:18 -0400
To: linux-iio <linux-iio@vger.kernel.org>
From: Jean-Baptiste Maneyrol <jmaneyrol@invensense.com>
Subject: [PATCH v2 1/4] iio: imu: inv_mpu6050: fix error path not turning chip
 back off
Message-ID: <832c7d77-898b-bf25-bc20-12a79a598b12@invensense.com>
Date: Mon, 9 Apr 2018 16:57:05 +0200
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8; format=flowed
Sender: linux-iio-owner@vger.kernel.org
List-Id: linux-iio@vger.kernel.org

Some functions are turning the chip on and not back off in error
path. With set_power function using a reference counter that
would keep the chip on forever.

Signed-off-by: Jean-Baptiste Maneyrol <jmaneyrol@invensense.com>
---
  drivers/iio/imu/inv_mpu6050/inv_mpu_core.c    | 12 ++++++---
  drivers/iio/imu/inv_mpu6050/inv_mpu_trigger.c | 35 
++++++++++++++++++---------
  2 files changed, 32 insertions(+), 15 deletions(-)

diff --git a/drivers/iio/imu/inv_mpu6050/inv_mpu_core.c 
b/drivers/iio/imu/inv_mpu6050/inv_mpu_core.c
index 7d64be3..18c8866 100644
--- a/drivers/iio/imu/inv_mpu6050/inv_mpu_core.c
+++ b/drivers/iio/imu/inv_mpu6050/inv_mpu_core.c
@@ -262,27 +262,31 @@ static int inv_mpu6050_init_config(struct iio_dev 
*indio_dev)
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
diff --git a/drivers/iio/imu/inv_mpu6050/inv_mpu_trigger.c 
b/drivers/iio/imu/inv_mpu6050/inv_mpu_trigger.c
index f963f9f..27aa976 100644
--- a/drivers/iio/imu/inv_mpu6050/inv_mpu_trigger.c
+++ b/drivers/iio/imu/inv_mpu6050/inv_mpu_trigger.c
@@ -53,45 +53,58 @@ static int inv_mpu6050_set_enable(struct iio_dev 
*indio_dev, bool enable)
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
