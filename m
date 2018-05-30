Return-Path: <linux-iio-owner@vger.kernel.org>
Received: from mail-co1nam03on0045.outbound.protection.outlook.com ([104.47.40.45]:34577
        "EHLO NAM03-CO1-obe.outbound.protection.outlook.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S937206AbeE3Gwo (ORCPT <rfc822;linux-iio@vger.kernel.org>);
        Wed, 30 May 2018 02:52:44 -0400
From: Jean-Baptiste Maneyrol <jmaneyrol@invensense.com>
To: linux-iio@vger.kernel.org
Cc: Jean-Baptiste Maneyrol <jmaneyrol@invensense.com>
Subject: [PATCH] iio: imu: inv_mpu6050: clean return value for read_raw function
Date: Wed, 30 May 2018 08:52:18 +0200
Message-Id: <20180530065218.2922-1-jmaneyrol@invensense.com>
MIME-Version: 1.0
Content-Type: text/plain
Sender: linux-iio-owner@vger.kernel.org
List-Id: linux-iio@vger.kernel.org

Use only a single return at the end of the function and return
sensor_show value for calibbias reading including possible error.

Signed-off-by: Jean-Baptiste Maneyrol <jmaneyrol@invensense.com>
---
 drivers/iio/imu/inv_mpu6050/inv_mpu_core.c | 46 ++++++++++++----------
 1 file changed, 25 insertions(+), 21 deletions(-)

diff --git a/drivers/iio/imu/inv_mpu6050/inv_mpu_core.c b/drivers/iio/imu/inv_mpu6050/inv_mpu_core.c
index de68e83fc52d..1f0c71f338ae 100644
--- a/drivers/iio/imu/inv_mpu6050/inv_mpu_core.c
+++ b/drivers/iio/imu/inv_mpu6050/inv_mpu_core.c
@@ -397,13 +397,12 @@ static int inv_mpu6050_read_channel_data(struct iio_dev *indio_dev,
 	return result;
 }
 
-static int
-inv_mpu6050_read_raw(struct iio_dev *indio_dev,
-		     struct iio_chan_spec const *chan,
-		     int *val, int *val2, long mask)
+static int inv_mpu6050_read_raw(struct iio_dev *indio_dev,
+				struct iio_chan_spec const *chan,
+				int *val, int *val2, long mask)
 {
 	struct inv_mpu6050_state  *st = iio_priv(indio_dev);
-	int ret = 0;
+	int ret;
 
 	switch (mask) {
 	case IIO_CHAN_INFO_RAW:
@@ -414,7 +413,7 @@ inv_mpu6050_read_raw(struct iio_dev *indio_dev,
 		ret = inv_mpu6050_read_channel_data(indio_dev, chan, val);
 		mutex_unlock(&st->lock);
 		iio_device_release_direct_mode(indio_dev);
-		return ret;
+		break;
 	case IIO_CHAN_INFO_SCALE:
 		switch (chan->type) {
 		case IIO_ANGL_VEL:
@@ -422,31 +421,33 @@ inv_mpu6050_read_raw(struct iio_dev *indio_dev,
 			*val  = 0;
 			*val2 = gyro_scale_6050[st->chip_config.fsr];
 			mutex_unlock(&st->lock);
-
-			return IIO_VAL_INT_PLUS_NANO;
+			ret = IIO_VAL_INT_PLUS_NANO;
+			break;
 		case IIO_ACCEL:
 			mutex_lock(&st->lock);
 			*val = 0;
 			*val2 = accel_scale[st->chip_config.accl_fs];
 			mutex_unlock(&st->lock);
-
-			return IIO_VAL_INT_PLUS_MICRO;
+			ret = IIO_VAL_INT_PLUS_MICRO;
+			break;
 		case IIO_TEMP:
 			*val = 0;
 			*val2 = INV_MPU6050_TEMP_SCALE;
-
-			return IIO_VAL_INT_PLUS_MICRO;
+			ret = IIO_VAL_INT_PLUS_MICRO;
+			break;
 		default:
-			return -EINVAL;
+			ret = -EINVAL;
+			break;
 		}
 	case IIO_CHAN_INFO_OFFSET:
 		switch (chan->type) {
 		case IIO_TEMP:
 			*val = INV_MPU6050_TEMP_OFFSET;
-
-			return IIO_VAL_INT;
+			ret = IIO_VAL_INT;
+			break;
 		default:
-			return -EINVAL;
+			ret = -EINVAL;
+			break;
 		}
 	case IIO_CHAN_INFO_CALIBBIAS:
 		switch (chan->type) {
@@ -455,20 +456,23 @@ inv_mpu6050_read_raw(struct iio_dev *indio_dev,
 			ret = inv_mpu6050_sensor_show(st, st->reg->gyro_offset,
 						chan->channel2, val);
 			mutex_unlock(&st->lock);
-			return IIO_VAL_INT;
+			break;
 		case IIO_ACCEL:
 			mutex_lock(&st->lock);
 			ret = inv_mpu6050_sensor_show(st, st->reg->accl_offset,
 						chan->channel2, val);
 			mutex_unlock(&st->lock);
-			return IIO_VAL_INT;
-
+			break;
 		default:
-			return -EINVAL;
+			ret = -EINVAL;
+			break;
 		}
 	default:
-		return -EINVAL;
+		ret = -EINVAL;
+		break;
 	}
+
+	return ret;
 }
 
 static int inv_mpu6050_write_gyro_scale(struct inv_mpu6050_state *st, int val)
-- 
2.17.0

