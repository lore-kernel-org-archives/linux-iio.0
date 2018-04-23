Return-Path: <linux-iio-owner@vger.kernel.org>
Received: from mail-bn3nam01on0084.outbound.protection.outlook.com ([104.47.33.84]:4272
        "EHLO NAM01-BN3-obe.outbound.protection.outlook.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1754442AbeDWKeQ (ORCPT <rfc822;linux-iio@vger.kernel.org>);
        Mon, 23 Apr 2018 06:34:16 -0400
From: Jean-Baptiste Maneyrol <jmaneyrol@invensense.com>
To: linux-iio@vger.kernel.org
Cc: Jean-Baptiste Maneyrol <jmaneyrol@invensense.com>
Subject: [PATCH v4 3/4] iio: imu: inv_mpu6050: clean read raw by factorizing out raw data
Date: Mon, 23 Apr 2018 12:33:32 +0200
Message-Id: <1524479613-23954-3-git-send-email-jmaneyrol@invensense.com>
In-Reply-To: <1524479613-23954-1-git-send-email-jmaneyrol@invensense.com>
References: <1524479613-23954-1-git-send-email-jmaneyrol@invensense.com>
MIME-Version: 1.0
Content-Type: text/plain
Sender: linux-iio-owner@vger.kernel.org
List-Id: linux-iio@vger.kernel.org

Factorize reading channel data in its own function.

Signed-off-by: Jean-Baptiste Maneyrol <jmaneyrol@invensense.com>
---
 drivers/iio/imu/inv_mpu6050/inv_mpu_core.c | 116 +++++++++++++++--------------
 1 file changed, 62 insertions(+), 54 deletions(-)

diff --git a/drivers/iio/imu/inv_mpu6050/inv_mpu_core.c b/drivers/iio/imu/inv_mpu6050/inv_mpu_core.c
index 45f57f7..79b44fd 100644
--- a/drivers/iio/imu/inv_mpu6050/inv_mpu_core.c
+++ b/drivers/iio/imu/inv_mpu6050/inv_mpu_core.c
@@ -332,6 +332,67 @@ static int inv_mpu6050_sensor_show(struct inv_mpu6050_state  *st, int reg,
 	return IIO_VAL_INT;
 }
 
+static int inv_mpu6050_read_channel_data(struct iio_dev *indio_dev,
+					 struct iio_chan_spec const *chan,
+					 int *val)
+{
+	struct inv_mpu6050_state *st = iio_priv(indio_dev);
+	int result;
+	int ret = IIO_VAL_INT;
+
+	result = iio_device_claim_direct_mode(indio_dev);
+	if (result)
+		return result;
+	result = inv_mpu6050_set_power_itg(st, true);
+	if (result)
+		goto error_release;
+
+	switch (chan->type) {
+	case IIO_ANGL_VEL:
+		result = inv_mpu6050_switch_engine(st, true,
+				INV_MPU6050_BIT_PWR_GYRO_STBY);
+		if (result)
+			goto error_power_off;
+		ret = inv_mpu6050_sensor_show(st, st->reg->raw_gyro,
+					      chan->channel2, val);
+		result = inv_mpu6050_switch_engine(st, false,
+				INV_MPU6050_BIT_PWR_GYRO_STBY);
+		if (result)
+			goto error_power_off;
+		break;
+	case IIO_ACCEL:
+		result = inv_mpu6050_switch_engine(st, true,
+				INV_MPU6050_BIT_PWR_ACCL_STBY);
+		if (result)
+			goto error_power_off;
+		ret = inv_mpu6050_sensor_show(st, st->reg->raw_accl,
+					      chan->channel2, val);
+		result = inv_mpu6050_switch_engine(st, false,
+				INV_MPU6050_BIT_PWR_ACCL_STBY);
+		if (result)
+			goto error_power_off;
+		break;
+	case IIO_TEMP:
+		/* wait for stablization */
+		msleep(INV_MPU6050_SENSOR_UP_TIME);
+		ret = inv_mpu6050_sensor_show(st, st->reg->temperature,
+					      IIO_MOD_X, val);
+		break;
+	default:
+		ret = -EINVAL;
+		break;
+	}
+
+error_power_off:
+	result |= inv_mpu6050_set_power_itg(st, false);
+error_release:
+	iio_device_release_direct_mode(indio_dev);
+	if (result)
+		return result;
+
+	return ret;
+}
+
 static int
 inv_mpu6050_read_raw(struct iio_dev *indio_dev,
 		     struct iio_chan_spec const *chan,
@@ -342,63 +403,10 @@ inv_mpu6050_read_raw(struct iio_dev *indio_dev,
 
 	switch (mask) {
 	case IIO_CHAN_INFO_RAW:
-	{
-		int result;
-
-		ret = IIO_VAL_INT;
 		mutex_lock(&st->lock);
-		result = iio_device_claim_direct_mode(indio_dev);
-		if (result)
-			goto error_read_raw_unlock;
-		result = inv_mpu6050_set_power_itg(st, true);
-		if (result)
-			goto error_read_raw_release;
-		switch (chan->type) {
-		case IIO_ANGL_VEL:
-			result = inv_mpu6050_switch_engine(st, true,
-					INV_MPU6050_BIT_PWR_GYRO_STBY);
-			if (result)
-				goto error_read_raw_power_off;
-			ret = inv_mpu6050_sensor_show(st, st->reg->raw_gyro,
-						      chan->channel2, val);
-			result = inv_mpu6050_switch_engine(st, false,
-					INV_MPU6050_BIT_PWR_GYRO_STBY);
-			if (result)
-				goto error_read_raw_power_off;
-			break;
-		case IIO_ACCEL:
-			result = inv_mpu6050_switch_engine(st, true,
-					INV_MPU6050_BIT_PWR_ACCL_STBY);
-			if (result)
-				goto error_read_raw_power_off;
-			ret = inv_mpu6050_sensor_show(st, st->reg->raw_accl,
-						      chan->channel2, val);
-			result = inv_mpu6050_switch_engine(st, false,
-					INV_MPU6050_BIT_PWR_ACCL_STBY);
-			if (result)
-				goto error_read_raw_power_off;
-			break;
-		case IIO_TEMP:
-			/* wait for stablization */
-			msleep(INV_MPU6050_SENSOR_UP_TIME);
-			ret = inv_mpu6050_sensor_show(st, st->reg->temperature,
-						IIO_MOD_X, val);
-			break;
-		default:
-			ret = -EINVAL;
-			break;
-		}
-error_read_raw_power_off:
-		result |= inv_mpu6050_set_power_itg(st, false);
-error_read_raw_release:
-		iio_device_release_direct_mode(indio_dev);
-error_read_raw_unlock:
+		ret = inv_mpu6050_read_channel_data(indio_dev, chan, val);
 		mutex_unlock(&st->lock);
-		if (result)
-			return result;
-
 		return ret;
-	}
 	case IIO_CHAN_INFO_SCALE:
 		switch (chan->type) {
 		case IIO_ANGL_VEL:
-- 
2.7.4

