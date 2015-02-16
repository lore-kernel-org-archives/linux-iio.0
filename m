Return-Path: <viorel.suman@gmail.com>
From: Viorel Suman <viorel.suman@gmail.com>
To: Jonathan Cameron <jic23@kernel.org>,
	linux-iio@vger.kernel.org
Cc: linux-kernel@vger.kernel.org,
	Viorel Suman <viorel.suman@gmail.com>
Subject: [PATCH] Clear timestamp kfifo on trigger enabling
Date: Mon, 16 Feb 2015 23:09:43 +0200
Message-Id: <1424120983-21399-1-git-send-email-viorel.suman@gmail.com>
List-ID: <linux-iio@vger.kernel.org>

The timestamp kfifo must be cleared once the
hardware fifo is reset, thus are removed
timestamps related to unprocessed events from
hardware fifo - see "inv_mpu6050_read_fifo"
method implementation.

Signed-off-by: Viorel Suman <viorel.suman@gmail.com>
---
 drivers/iio/imu/inv_mpu6050/inv_mpu_trigger.c | 28 +++++++++++++++------------
 1 file changed, 16 insertions(+), 12 deletions(-)

diff --git a/drivers/iio/imu/inv_mpu6050/inv_mpu_trigger.c b/drivers/iio/imu/inv_mpu6050/inv_mpu_trigger.c
index 926fcce..b617920 100644
--- a/drivers/iio/imu/inv_mpu6050/inv_mpu_trigger.c
+++ b/drivers/iio/imu/inv_mpu6050/inv_mpu_trigger.c
@@ -42,57 +42,61 @@ static void inv_scan_query(struct iio_dev *indio_dev)
 static int inv_mpu6050_set_enable(struct iio_dev *indio_dev, bool enable)
 {
 	struct inv_mpu6050_state *st = iio_priv(indio_dev);
-	int result;
+	int result = 0;
 
+	mutex_lock(&indio_dev->mlock);
 	if (enable) {
 		result = inv_mpu6050_set_power_itg(st, true);
 		if (result)
-			return result;
+			goto write_error;
 		inv_scan_query(indio_dev);
 		if (st->chip_config.gyro_fifo_enable) {
 			result = inv_mpu6050_switch_engine(st, true,
 					INV_MPU6050_BIT_PWR_GYRO_STBY);
 			if (result)
-				return result;
+				goto write_error;
 		}
 		if (st->chip_config.accl_fifo_enable) {
 			result = inv_mpu6050_switch_engine(st, true,
 					INV_MPU6050_BIT_PWR_ACCL_STBY);
 			if (result)
-				return result;
+				goto write_error;
 		}
+		inv_clear_kfifo(st);
 		result = inv_reset_fifo(indio_dev);
 		if (result)
-			return result;
+			goto write_error;
 	} else {
 		result = inv_mpu6050_write_reg(st, st->reg->fifo_en, 0);
 		if (result)
-			return result;
+			goto write_error;
 
 		result = inv_mpu6050_write_reg(st, st->reg->int_enable, 0);
 		if (result)
-			return result;
+			goto write_error;
 
 		result = inv_mpu6050_write_reg(st, st->reg->user_ctrl, 0);
 		if (result)
-			return result;
+			goto write_error;
 
 		result = inv_mpu6050_switch_engine(st, false,
 					INV_MPU6050_BIT_PWR_GYRO_STBY);
 		if (result)
-			return result;
+			goto write_error;
 
 		result = inv_mpu6050_switch_engine(st, false,
 					INV_MPU6050_BIT_PWR_ACCL_STBY);
 		if (result)
-			return result;
+			goto write_error;
 		result = inv_mpu6050_set_power_itg(st, false);
 		if (result)
-			return result;
+			goto write_error;
 	}
 	st->chip_config.enable = enable;
+write_error:
+	mutex_unlock(&indio_dev->mlock);
 
-	return 0;
+	return result;
 }
 
 /**
-- 
2.3.0
