Return-Path: <linux-iio-owner@vger.kernel.org>
Received: from saturn.retrosnub.co.uk ([178.18.118.26]:59136 "EHLO
	saturn.retrosnub.co.uk" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1758913Ab3B0UkT (ORCPT
	<rfc822;linux-iio@vger.kernel.org>); Wed, 27 Feb 2013 15:40:19 -0500
From: Jonathan Cameron <jic23@kernel.org>
To: linux-iio@vger.kernel.org
Cc: Jonathan Cameron <jic23@kernel.org>, Ge Gao <ggao@invensense.com>
Subject: [PATCH 39/67] iio:imu:mpu6050 move to info_mask_(shared_by_type/separate)
Date: Wed, 27 Feb 2013 20:38:45 +0000
Message-Id: <1361997553-31058-40-git-send-email-jic23@kernel.org>
In-Reply-To: <1361997553-31058-1-git-send-email-jic23@kernel.org>
References: <1361997553-31058-1-git-send-email-jic23@kernel.org>
Sender: linux-iio-owner@vger.kernel.org
List-Id: linux-iio@vger.kernel.org

The original info_mask is going away in favour of the broken out versions.

Signed-off-by: Jonathan Cameron <jic23@kernel.org>
cc: Ge Gao <ggao@invensense.com>
---
 drivers/iio/imu/inv_mpu6050/inv_mpu_core.c | 10 +++++-----
 1 file changed, 5 insertions(+), 5 deletions(-)

diff --git a/drivers/iio/imu/inv_mpu6050/inv_mpu_core.c b/drivers/iio/imu/inv_mpu6050/inv_mpu_core.c
index 37ca05b..d05d01c 100644
--- a/drivers/iio/imu/inv_mpu6050/inv_mpu_core.c
+++ b/drivers/iio/imu/inv_mpu6050/inv_mpu_core.c
@@ -544,8 +544,8 @@ static int inv_mpu6050_validate_trigger(struct iio_dev *indio_dev,
 		.type = _type,                                        \
 		.modified = 1,                                        \
 		.channel2 = _channel2,                                \
-		.info_mask =  IIO_CHAN_INFO_SCALE_SHARED_BIT          \
-				| IIO_CHAN_INFO_RAW_SEPARATE_BIT,     \
+		.info_mask_shared_by_type =  IIO_CHAN_INFO_SCALE,     \
+		.info_mask_separate = IIO_CHAN_INFO_RAW,              \
 		.scan_index = _index,                                 \
 		.scan_type = {                                        \
 				.sign = 's',                          \
@@ -564,9 +564,9 @@ static const struct iio_chan_spec inv_mpu_channels[] = {
 	 */
 	{
 		.type = IIO_TEMP,
-		.info_mask =  IIO_CHAN_INFO_RAW_SEPARATE_BIT
-				| IIO_CHAN_INFO_OFFSET_SEPARATE_BIT
-				| IIO_CHAN_INFO_SCALE_SEPARATE_BIT,
+		.info_mask_separate =  IIO_CHAN_INFO_RAW
+				| IIO_CHAN_INFO_OFFSET
+				| IIO_CHAN_INFO_SCALE,
 		.scan_index = -1,
 	},
 	INV_MPU6050_CHAN(IIO_ANGL_VEL, IIO_MOD_X, INV_MPU6050_SCAN_GYRO_X),
-- 
1.8.1.1

