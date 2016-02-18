Return-Path: <matt.ranostay@intel.com>
From: Matt Ranostay <matt.ranostay@intel.com>
To: adriana.reus@intel.com,
	jic23@kernel.org
Cc: linux-iio@vger.kernel.org,
	Matt Ranostay <matt.ranostay@intel.com>
Subject: [PATCH] iio: imu: mpu6050: remove trailing whitespaces
Date: Wed, 17 Feb 2016 21:58:23 -0800
Message-Id: <1455775103-18130-1-git-send-email-matt.ranostay@intel.com>
List-ID: <linux-iio@vger.kernel.org>

removed several trailing whitespaces before assignment operations

Signed-off-by: Matt Ranostay <matt.ranostay@intel.com>
---
 drivers/iio/imu/inv_mpu6050/inv_mpu_core.c | 6 +++---
 1 file changed, 3 insertions(+), 3 deletions(-)

diff --git a/drivers/iio/imu/inv_mpu6050/inv_mpu_core.c b/drivers/iio/imu/inv_mpu6050/inv_mpu_core.c
index 225860016fed..cbc8c74d4692 100644
--- a/drivers/iio/imu/inv_mpu6050/inv_mpu_core.c
+++ b/drivers/iio/imu/inv_mpu6050/inv_mpu_core.c
@@ -244,7 +244,7 @@ static int inv_mpu6050_read_raw(struct iio_dev *indio_dev,
 				if (result)
 					goto error_read_raw;
 			}
-			ret =  inv_mpu6050_sensor_show(st, st->reg->raw_gyro,
+			ret = inv_mpu6050_sensor_show(st, st->reg->raw_gyro,
 						chan->channel2, val);
 			if (!st->chip_config.gyro_fifo_enable ||
 					!st->chip_config.enable) {
@@ -567,7 +567,7 @@ static int inv_mpu6050_validate_trigger(struct iio_dev *indio_dev,
 		.type = _type,                                        \
 		.modified = 1,                                        \
 		.channel2 = _channel2,                                \
-		.info_mask_shared_by_type =  BIT(IIO_CHAN_INFO_SCALE), \
+		.info_mask_shared_by_type = BIT(IIO_CHAN_INFO_SCALE), \
 		.info_mask_separate = BIT(IIO_CHAN_INFO_RAW),         \
 		.scan_index = _index,                                 \
 		.scan_type = {                                        \
@@ -587,7 +587,7 @@ static const struct iio_chan_spec inv_mpu_channels[] = {
 	 */
 	{
 		.type = IIO_TEMP,
-		.info_mask_separate =  BIT(IIO_CHAN_INFO_RAW)
+		.info_mask_separate = BIT(IIO_CHAN_INFO_RAW)
 				| BIT(IIO_CHAN_INFO_OFFSET)
 				| BIT(IIO_CHAN_INFO_SCALE),
 		.scan_index = -1,
-- 
1.9.1
