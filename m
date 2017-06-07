Return-Path: <linux-iio-owner@vger.kernel.org>
Received: from mail-bl2nam02on0062.outbound.protection.outlook.com ([104.47.38.62]:2513
        "EHLO NAM02-BL2-obe.outbound.protection.outlook.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1751580AbdFGNsJ (ORCPT <rfc822;linux-iio@vger.kernel.org>);
        Wed, 7 Jun 2017 09:48:09 -0400
From: Jean-Baptiste Maneyrol <JManeyrol@invensense.com>
To: linux-iio <linux-iio@vger.kernel.org>
Subject: [PATCH 7/7] iio: imu: inv_mpu6050: rewrite and clean read raw for
 channel data
Date: Wed, 7 Jun 2017 13:48:07 +0000
Message-ID: <BLUPR12MB0657E6DC37E3249950F5B6CFC4C80@BLUPR12MB0657.namprd12.prod.outlook.com>
Content-Type: text/plain; charset="iso-8859-1"
MIME-Version: 1.0
Sender: linux-iio-owner@vger.kernel.org
List-Id: linux-iio@vger.kernel.org

Factorize reading channel data in its own function and use a single
return path at the end of the global read_raw function.

Signed-off-by: Jean-Baptiste Maneyrol <jmaneyrol@invensense.com>
---
 drivers/iio/imu/inv_mpu6050/inv_mpu_core.c | 150 ++++++++++++++++---------=
----
 1 file changed, 84 insertions(+), 66 deletions(-)

diff --git a/drivers/iio/imu/inv_mpu6050/inv_mpu_core.c b/drivers/iio/imu/i=
nv_mpu6050/inv_mpu_core.c
index 65d134a..c207c1a 100644
--- a/drivers/iio/imu/inv_mpu6050/inv_mpu_core.c
+++ b/drivers/iio/imu/inv_mpu6050/inv_mpu_core.c
@@ -332,72 +332,80 @@ static int inv_mpu6050_sensor_show(struct inv_mpu6050=
_state  *st, int reg,
 	return IIO_VAL_INT;
 }
=20
+static int inv_mpu6050_read_channel_data(struct iio_dev *indio_dev,
+					 struct iio_chan_spec const *chan,
+					 int *val)
+{
+	struct inv_mpu6050_state *st =3D iio_priv(indio_dev);
+	int result;
+	int ret =3D IIO_VAL_INT;
+
+	result =3D iio_device_claim_direct_mode(indio_dev);
+	if (result)
+		return result;
+	result =3D inv_mpu6050_set_power_itg(st, true);
+	if (result)
+		goto error_release;
+
+	switch (chan->type) {
+	case IIO_ANGL_VEL:
+		result =3D inv_mpu6050_switch_engine(st, true,
+				INV_MPU6050_BIT_PWR_GYRO_STBY);
+		if (result)
+			goto error_power_off;
+		ret =3D inv_mpu6050_sensor_show(st, st->reg->raw_gyro,
+					      chan->channel2, val);
+		result =3D inv_mpu6050_switch_engine(st, false,
+				INV_MPU6050_BIT_PWR_GYRO_STBY);
+		if (result)
+			goto error_power_off;
+		break;
+	case IIO_ACCEL:
+		result =3D inv_mpu6050_switch_engine(st, true,
+				INV_MPU6050_BIT_PWR_ACCL_STBY);
+		if (result)
+			goto error_power_off;
+		ret =3D inv_mpu6050_sensor_show(st, st->reg->raw_accl,
+					      chan->channel2, val);
+		result =3D inv_mpu6050_switch_engine(st, false,
+				INV_MPU6050_BIT_PWR_ACCL_STBY);
+		if (result)
+			goto error_power_off;
+		break;
+	case IIO_TEMP:
+		/* wait for stablization */
+		msleep(INV_MPU6050_SENSOR_UP_TIME);
+		ret =3D inv_mpu6050_sensor_show(st, st->reg->temperature,
+					      IIO_MOD_X, val);
+		break;
+	default:
+		ret =3D -EINVAL;
+		break;
+	}
+
+error_power_off:
+	result |=3D inv_mpu6050_set_power_itg(st, false);
+error_release:
+	iio_device_release_direct_mode(indio_dev);
+	if (result)
+		return result;
+
+	return ret;
+}
+
 static int inv_mpu6050_read_raw(struct iio_dev *indio_dev,
 				struct iio_chan_spec const *chan,
 				int *val, int *val2, long mask)
 {
 	struct inv_mpu6050_state *st =3D iio_priv(indio_dev);
-	int ret =3D 0;
+	int ret;
=20
 	switch (mask) {
 	case IIO_CHAN_INFO_RAW:
-	{
-		int result;
-
-		ret =3D IIO_VAL_INT;
 		mutex_lock(&st->lock);
-		result =3D iio_device_claim_direct_mode(indio_dev);
-		if (result)
-			goto error_read_raw_unlock;
-		result =3D inv_mpu6050_set_power_itg(st, true);
-		if (result)
-			goto error_read_raw_release;
-		switch (chan->type) {
-		case IIO_ANGL_VEL:
-			result =3D inv_mpu6050_switch_engine(st, true,
-					INV_MPU6050_BIT_PWR_GYRO_STBY);
-			if (result)
-				goto error_read_raw_power_off;
-			ret =3D inv_mpu6050_sensor_show(st, st->reg->raw_gyro,
-						      chan->channel2, val);
-			result =3D inv_mpu6050_switch_engine(st, false,
-					INV_MPU6050_BIT_PWR_GYRO_STBY);
-			if (result)
-				goto error_read_raw_power_off;
-			break;
-		case IIO_ACCEL:
-			result =3D inv_mpu6050_switch_engine(st, true,
-					INV_MPU6050_BIT_PWR_ACCL_STBY);
-			if (result)
-				goto error_read_raw_power_off;
-			ret =3D inv_mpu6050_sensor_show(st, st->reg->raw_accl,
-						      chan->channel2, val);
-			result =3D inv_mpu6050_switch_engine(st, false,
-					INV_MPU6050_BIT_PWR_ACCL_STBY);
-			if (result)
-				goto error_read_raw_power_off;
-			break;
-		case IIO_TEMP:
-			/* wait for stablization */
-			msleep(INV_MPU6050_SENSOR_UP_TIME);
-			ret =3D inv_mpu6050_sensor_show(st, st->reg->temperature,
-						IIO_MOD_X, val);
-			break;
-		default:
-			ret =3D -EINVAL;
-			break;
-		}
-error_read_raw_power_off:
-		result |=3D inv_mpu6050_set_power_itg(st, false);
-error_read_raw_release:
-		iio_device_release_direct_mode(indio_dev);
-error_read_raw_unlock:
+		ret =3D inv_mpu6050_read_channel_data(indio_dev, chan, val);
 		mutex_unlock(&st->lock);
-		if (result)
-			return result;
-
-		return ret;
-	}
+		break;
 	case IIO_CHAN_INFO_SCALE:
 		switch (chan->type) {
 		case IIO_ANGL_VEL:
@@ -405,27 +413,33 @@ static int inv_mpu6050_read_raw(struct iio_dev *indio=
_dev,
 			*val  =3D 0;
 			*val2 =3D gyro_scale_6050[st->chip_config.fsr];
 			mutex_unlock(&st->lock);
-			return IIO_VAL_INT_PLUS_NANO;
+			ret =3D IIO_VAL_INT_PLUS_NANO;
+			break;
 		case IIO_ACCEL:
 			mutex_lock(&st->lock);
 			*val =3D 0;
 			*val2 =3D accel_scale[st->chip_config.accl_fs];
 			mutex_unlock(&st->lock);
-			return IIO_VAL_INT_PLUS_MICRO;
+			ret =3D IIO_VAL_INT_PLUS_MICRO;
+			break;
 		case IIO_TEMP:
 			*val =3D 0;
 			*val2 =3D INV_MPU6050_TEMP_SCALE;
-			return IIO_VAL_INT_PLUS_MICRO;
+			ret =3D IIO_VAL_INT_PLUS_MICRO;
+			break;
 		default:
-			return -EINVAL;
+			ret =3D -EINVAL;
+			break;
 		}
 	case IIO_CHAN_INFO_OFFSET:
 		switch (chan->type) {
 		case IIO_TEMP:
 			*val =3D INV_MPU6050_TEMP_OFFSET;
-			return IIO_VAL_INT;
+			ret =3D IIO_VAL_INT;
+			break;
 		default:
-			return -EINVAL;
+			ret =3D -EINVAL;
+			break;
 		}
 	case IIO_CHAN_INFO_CALIBBIAS:
 		switch (chan->type) {
@@ -434,19 +448,23 @@ static int inv_mpu6050_read_raw(struct iio_dev *indio=
_dev,
 			ret =3D inv_mpu6050_sensor_show(st, st->reg->gyro_offset,
 						chan->channel2, val);
 			mutex_unlock(&st->lock);
-			return IIO_VAL_INT;
+			break;
 		case IIO_ACCEL:
 			mutex_lock(&st->lock);
 			ret =3D inv_mpu6050_sensor_show(st, st->reg->accl_offset,
 						chan->channel2, val);
 			mutex_unlock(&st->lock);
-			return IIO_VAL_INT;
+			break;
 		default:
-			return -EINVAL;
+			ret =3D -EINVAL;
+			break;
 		}
 	default:
-		return -EINVAL;
+		ret =3D -EINVAL;
+		break;
 	}
+
+	return ret;
 }
=20
 static int inv_mpu6050_write_gyro_scale(struct inv_mpu6050_state *st, int =
val)
--=20
1.9.1
