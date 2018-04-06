Return-Path: <linux-iio-owner@vger.kernel.org>
Received: from mail-by2nam01on0088.outbound.protection.outlook.com ([104.47.34.88]:18752
        "EHLO NAM01-BY2-obe.outbound.protection.outlook.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1751389AbeDFIWq (ORCPT <rfc822;linux-iio@vger.kernel.org>);
        Fri, 6 Apr 2018 04:22:46 -0400
From: Jean-Baptiste Maneyrol <JManeyrol@invensense.com>
To: linux-iio <linux-iio@vger.kernel.org>
Subject: [PATCH] iio: imu: inv_mpu6050: rewrite and clean read raw for channel
 data
Date: Fri, 6 Apr 2018 08:22:43 +0000
Message-ID: <CY4PR1201MB0184D044234A1EFE66849546C4BA0@CY4PR1201MB0184.namprd12.prod.outlook.com>
Content-Type: text/plain; charset="iso-8859-1"
MIME-Version: 1.0
Sender: linux-iio-owner@vger.kernel.org
List-Id: linux-iio@vger.kernel.org

Factorize reading channel data in its own function and use a single
return path at the end of the global read_raw function.

Signed-off-by: Jean-Baptiste Maneyrol <jmaneyrol@invensense.com>
---
 drivers/iio/imu/inv_mpu6050/inv_mpu_core.c | 158 ++++++++++++++++---------=
----
 1 file changed, 87 insertions(+), 71 deletions(-)

diff --git a/drivers/iio/imu/inv_mpu6050/inv_mpu_core.c b/drivers/iio/imu/i=
nv_mpu6050/inv_mpu_core.c
index 7d64be3..27fe86c 100644
--- a/drivers/iio/imu/inv_mpu6050/inv_mpu_core.c
+++ b/drivers/iio/imu/inv_mpu6050/inv_mpu_core.c
@@ -314,73 +314,81 @@ static int inv_mpu6050_sensor_show(struct inv_mpu6050=
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
 static int
 inv_mpu6050_read_raw(struct iio_dev *indio_dev,
 		     struct iio_chan_spec const *chan,
 		     int *val, int *val2, long mask)
 {
 	struct inv_mpu6050_state  *st =3D iio_priv(indio_dev);
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
@@ -388,32 +396,36 @@ inv_mpu6050_read_raw(struct iio_dev *indio_dev,
 			*val  =3D 0;
 			*val2 =3D gyro_scale_6050[st->chip_config.fsr];
 			mutex_unlock(&st->lock);
-
-			return IIO_VAL_INT_PLUS_NANO;
+			ret =3D IIO_VAL_INT_PLUS_NANO;
+			break;
 		case IIO_ACCEL:
 			mutex_lock(&st->lock);
 			*val =3D 0;
 			*val2 =3D accel_scale[st->chip_config.accl_fs];
 			mutex_unlock(&st->lock);
-
-			return IIO_VAL_INT_PLUS_MICRO;
+			ret =3D IIO_VAL_INT_PLUS_MICRO;
+			break;
 		case IIO_TEMP:
 			*val =3D 0;
 			*val2 =3D INV_MPU6050_TEMP_SCALE;
-
-			return IIO_VAL_INT_PLUS_MICRO;
+			ret =3D IIO_VAL_INT_PLUS_MICRO;
+			break;
 		default:
-			return -EINVAL;
+			ret =3D -EINVAL;
+			break;
 		}
+		break;
 	case IIO_CHAN_INFO_OFFSET:
 		switch (chan->type) {
 		case IIO_TEMP:
 			*val =3D INV_MPU6050_TEMP_OFFSET;
-
-			return IIO_VAL_INT;
+			ret =3D IIO_VAL_INT;
+			break;
 		default:
-			return -EINVAL;
+			ret =3D -EINVAL;
+			break;
 		}
+		break;
 	case IIO_CHAN_INFO_CALIBBIAS:
 		switch (chan->type) {
 		case IIO_ANGL_VEL:
@@ -421,20 +433,24 @@ inv_mpu6050_read_raw(struct iio_dev *indio_dev,
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
-
+			break;
 		default:
-			return -EINVAL;
+			ret =3D -EINVAL;
+			break;
 		}
+		break;
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
2.7.4
