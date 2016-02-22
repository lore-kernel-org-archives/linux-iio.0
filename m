Return-Path: <linux-iio-owner@vger.kernel.org>
Received: from mga01.intel.com ([192.55.52.88]:43013 "EHLO mga01.intel.com"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1755716AbcBVVjK (ORCPT <rfc822;linux-iio@vger.kernel.org>);
	Mon, 22 Feb 2016 16:39:10 -0500
From: Matt Ranostay <matt.ranostay@intel.com>
To: jic23@kernel.org
Cc: linux-iio@vger.kernel.org, daniel.baluta@intel.com,
	adriana.reus@intel.com, Matt Ranostay <matt.ranostay@intel.com>
Subject: [PATCH 4/5] iio: imu: mpu6050: add calibration offset support
Date: Mon, 22 Feb 2016 13:39:10 -0800
Message-Id: <1456177151-15881-5-git-send-email-matt.ranostay@intel.com>
In-Reply-To: <1456177151-15881-1-git-send-email-matt.ranostay@intel.com>
References: <1456177151-15881-1-git-send-email-matt.ranostay@intel.com>
Sender: linux-iio-owner@vger.kernel.org
List-Id: linux-iio@vger.kernel.org

Allow setting of the x/y/z axes calibration offsets for the gyroscope
and accelerometer.

Signed-off-by: Matt Ranostay <matt.ranostay@intel.com>
---
 drivers/iio/imu/inv_mpu6050/inv_mpu_core.c | 51 ++++++++++++++++++++++++++++--
 drivers/iio/imu/inv_mpu6050/inv_mpu_iio.h  | 10 ++++++
 2 files changed, 59 insertions(+), 2 deletions(-)

diff --git a/drivers/iio/imu/inv_mpu6050/inv_mpu_core.c b/drivers/iio/imu/inv_mpu6050/inv_mpu_core.c
index 6d4b19dd16f8..3acf0863e558 100644
--- a/drivers/iio/imu/inv_mpu6050/inv_mpu_core.c
+++ b/drivers/iio/imu/inv_mpu6050/inv_mpu_core.c
@@ -55,6 +55,8 @@ static const struct inv_mpu6050_reg_map reg_set_6050 = {
 	.pwr_mgmt_1             = INV_MPU6050_REG_PWR_MGMT_1,
 	.pwr_mgmt_2             = INV_MPU6050_REG_PWR_MGMT_2,
 	.int_pin_cfg		= INV_MPU6050_REG_INT_PIN_CFG,
+	.accl_offset		= INV_MPU6050_REG_ACCEL_OFFSET,
+	.gyro_offset		= INV_MPU6050_REG_GYRO_OFFSET,
 };
 
 static const struct inv_mpu6050_chip_config chip_config_6050 = {
@@ -200,6 +202,20 @@ static int inv_mpu6050_init_config(struct iio_dev *indio_dev)
 	return result;
 }
 
+static int inv_mpu6050_sensor_set(struct inv_mpu6050_state  *st, int reg,
+				int axis, int val)
+{
+	int ind, result;
+	__be16 d = cpu_to_be16(val);
+
+	ind = (axis - IIO_MOD_X) * 2;
+	result = regmap_bulk_write(st->map, reg + ind, (u8 *)&d, 2);
+	if (result)
+		return -EINVAL;
+
+	return 0;
+}
+
 static int inv_mpu6050_sensor_show(struct inv_mpu6050_state  *st, int reg,
 				int axis, int *val)
 {
@@ -221,11 +237,12 @@ static int inv_mpu6050_read_raw(struct iio_dev *indio_dev,
 			      int *val2,
 			      long mask) {
 	struct inv_mpu6050_state  *st = iio_priv(indio_dev);
+	int ret = 0;
 
 	switch (mask) {
 	case IIO_CHAN_INFO_RAW:
 	{
-		int ret, result;
+		int result;
 
 		ret = IIO_VAL_INT;
 		result = 0;
@@ -321,6 +338,20 @@ error_read_raw:
 		default:
 			return -EINVAL;
 		}
+	case IIO_CHAN_INFO_CALIBBIAS:
+		switch (chan->type) {
+		case IIO_ANGL_VEL:
+			ret = inv_mpu6050_sensor_show(st, st->reg->gyro_offset,
+						chan->channel2, val);
+			return IIO_VAL_INT;
+		case IIO_ACCEL:
+			ret = inv_mpu6050_sensor_show(st, st->reg->accl_offset,
+						chan->channel2, val);
+			return IIO_VAL_INT;
+
+		default:
+			return -EINVAL;
+		}
 	default:
 		return -EINVAL;
 	}
@@ -416,6 +447,21 @@ static int inv_mpu6050_write_raw(struct iio_dev *indio_dev,
 			break;
 		}
 		break;
+	case IIO_CHAN_INFO_CALIBBIAS:
+		switch (chan->type) {
+		case IIO_ANGL_VEL:
+			result = inv_mpu6050_sensor_set(st,
+							st->reg->gyro_offset,
+							chan->channel2, val);
+			break;
+		case IIO_ACCEL:
+			result = inv_mpu6050_sensor_set(st,
+							st->reg->accl_offset,
+							chan->channel2, val);
+			break;
+		default:
+			result = -EINVAL;
+		}
 	default:
 		result = -EINVAL;
 		break;
@@ -569,7 +615,8 @@ static int inv_mpu6050_validate_trigger(struct iio_dev *indio_dev,
 		.modified = 1,                                        \
 		.channel2 = _channel2,                                \
 		.info_mask_shared_by_type =  BIT(IIO_CHAN_INFO_SCALE), \
-		.info_mask_separate = BIT(IIO_CHAN_INFO_RAW),         \
+		.info_mask_separate = BIT(IIO_CHAN_INFO_RAW) |        \
+				      BIT(IIO_CHAN_INFO_CALIBBIAS),   \
 		.scan_index = _index,                                 \
 		.scan_type = {                                        \
 				.sign = 's',                          \
diff --git a/drivers/iio/imu/inv_mpu6050/inv_mpu_iio.h b/drivers/iio/imu/inv_mpu6050/inv_mpu_iio.h
index a6c45ce459ee..c4e24148c733 100644
--- a/drivers/iio/imu/inv_mpu6050/inv_mpu_iio.h
+++ b/drivers/iio/imu/inv_mpu6050/inv_mpu_iio.h
@@ -40,6 +40,8 @@
  *  @pwr_mgmt_1:	Controls chip's power state and clock source.
  *  @pwr_mgmt_2:	Controls power state of individual sensors.
  *  @int_pin_cfg;	Controls interrupt pin configuration.
+ *  @accl_offset:	Controls the accelerometer calibration offset.
+ *  @gyro_offset:	Controls the gyroscope calibration offset.
  */
 struct inv_mpu6050_reg_map {
 	u8 sample_rate_div;
@@ -57,6 +59,8 @@ struct inv_mpu6050_reg_map {
 	u8 pwr_mgmt_1;
 	u8 pwr_mgmt_2;
 	u8 int_pin_cfg;
+	u8 accl_offset;
+	u8 gyro_offset;
 };
 
 /*device enum */
@@ -133,6 +137,9 @@ struct inv_mpu6050_state {
 };
 
 /*register and associated bit definition*/
+#define INV_MPU6050_REG_ACCEL_OFFSET        0x06
+#define INV_MPU6050_REG_GYRO_OFFSET         0x13
+
 #define INV_MPU6050_REG_SAMPLE_RATE_DIV     0x19
 #define INV_MPU6050_REG_CONFIG              0x1A
 #define INV_MPU6050_REG_GYRO_CONFIG         0x1B
@@ -174,6 +181,9 @@ struct inv_mpu6050_state {
 #define INV_MPU6050_FIFO_COUNT_BYTE          2
 #define INV_MPU6050_FIFO_THRESHOLD           500
 
+/* mpu6500 registers */
+#define INV_MPU6500_REG_ACCEL_OFFSET        0x77
+
 /* delay time in milliseconds */
 #define INV_MPU6050_POWER_UP_TIME            100
 #define INV_MPU6050_TEMP_UP_TIME             100
-- 
1.9.1

