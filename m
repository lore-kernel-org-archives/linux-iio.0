Return-Path: <linux-iio-owner@vger.kernel.org>
Received: from mga14.intel.com ([192.55.52.115]:54927 "EHLO mga14.intel.com"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1752157AbbBWOlJ (ORCPT <rfc822;linux-iio@vger.kernel.org>);
	Mon, 23 Feb 2015 09:41:09 -0500
From: Adriana Reus <adriana.reus@intel.com>
To: jic23@kernel.org, linux-iio@vger.kernel.org
Cc: linux-kernel@vger.kernel.org, srinivas.pandruvada@intel.com,
	Adriana Reus <adriana.reus@intel.com>
Subject: [PATCH] iio:inv-mpu6050: Fix inconsistency for the scale channel
Date: Mon, 23 Feb 2015 16:40:51 +0200
Message-Id: <1424702451-1299-1-git-send-email-adriana.reus@intel.com>
Sender: linux-iio-owner@vger.kernel.org
List-Id: linux-iio@vger.kernel.org

Fix inconsistency in the semantics of the scale attribute.
For scale the write_raw function was considering the scale table index
and writing the appropriate value into the range register, while
for read_raw it was outputting the actual scale.
Fix this behaviour and adhere to the iio ABI specification.

Signed-off-by: Adriana Reus <adriana.reus@intel.com>
---
 drivers/iio/imu/inv_mpu6050/inv_mpu_core.c | 56 ++++++++++++++++--------------
 1 file changed, 30 insertions(+), 26 deletions(-)

diff --git a/drivers/iio/imu/inv_mpu6050/inv_mpu_core.c b/drivers/iio/imu/inv_mpu6050/inv_mpu_core.c
index 9be9b20..4cf056d 100644
--- a/drivers/iio/imu/inv_mpu6050/inv_mpu_core.c
+++ b/drivers/iio/imu/inv_mpu6050/inv_mpu_core.c
@@ -401,42 +401,46 @@ error_read_raw:
 	}
 }
 
-static int inv_mpu6050_write_fsr(struct inv_mpu6050_state *st, int fsr)
+static int inv_mpu6050_write_gyro_scale(struct inv_mpu6050_state *st, int val)
 {
-	int result;
+	int result, i;
 	u8 d;
 
-	if (fsr < 0 || fsr > INV_MPU6050_MAX_GYRO_FS_PARAM)
-		return -EINVAL;
-	if (fsr == st->chip_config.fsr)
-		return 0;
+	for (i = 0; i < ARRAY_SIZE(gyro_scale_6050); ++i) {
+		if (gyro_scale_6050[i] == val) {
+			d = (i << INV_MPU6050_GYRO_CONFIG_FSR_SHIFT);
+			result = inv_mpu6050_write_reg(st,
+					st->reg->gyro_config, d);
+			if (result)
+				return result;
 
-	d = (fsr << INV_MPU6050_GYRO_CONFIG_FSR_SHIFT);
-	result = inv_mpu6050_write_reg(st, st->reg->gyro_config, d);
-	if (result)
-		return result;
-	st->chip_config.fsr = fsr;
+			st->chip_config.fsr = i;
+			return 0;
+		}
+	}
 
-	return 0;
+	return -EINVAL;
 }
 
-static int inv_mpu6050_write_accel_fs(struct inv_mpu6050_state *st, int fs)
+static int inv_mpu6050_write_accel_scale(struct inv_mpu6050_state *st, int val)
 {
-	int result;
+	int result, i;
 	u8 d;
 
-	if (fs < 0 || fs > INV_MPU6050_MAX_ACCL_FS_PARAM)
-		return -EINVAL;
-	if (fs == st->chip_config.accl_fs)
-		return 0;
+	for (i = 0; i < ARRAY_SIZE(accel_scale); ++i) {
+		if (accel_scale[i] == val) {
+			d = (i << INV_MPU6050_ACCL_CONFIG_FSR_SHIFT);
+			result = inv_mpu6050_write_reg(st,
+					st->reg->accl_config, d);
+			if (result)
+				return result;
 
-	d = (fs << INV_MPU6050_ACCL_CONFIG_FSR_SHIFT);
-	result = inv_mpu6050_write_reg(st, st->reg->accl_config, d);
-	if (result)
-		return result;
-	st->chip_config.accl_fs = fs;
+			st->chip_config.accl_fs = i;
+			return 0;
+		}
+	}
 
-	return 0;
+	return -EINVAL;
 }
 
 static int inv_mpu6050_write_raw(struct iio_dev *indio_dev,
@@ -463,10 +467,10 @@ static int inv_mpu6050_write_raw(struct iio_dev *indio_dev,
 	case IIO_CHAN_INFO_SCALE:
 		switch (chan->type) {
 		case IIO_ANGL_VEL:
-			result = inv_mpu6050_write_fsr(st, val);
+			result = inv_mpu6050_write_gyro_scale(st, val2);
 			break;
 		case IIO_ACCEL:
-			result = inv_mpu6050_write_accel_fs(st, val);
+			result = inv_mpu6050_write_accel_scale(st, val2);
 			break;
 		default:
 			result = -EINVAL;
-- 
1.9.1

