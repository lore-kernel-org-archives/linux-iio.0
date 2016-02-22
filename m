Return-Path: <linux-iio-owner@vger.kernel.org>
Received: from mga01.intel.com ([192.55.52.88]:9254 "EHLO mga01.intel.com"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1755555AbcBVVjK (ORCPT <rfc822;linux-iio@vger.kernel.org>);
	Mon, 22 Feb 2016 16:39:10 -0500
From: Matt Ranostay <matt.ranostay@intel.com>
To: jic23@kernel.org
Cc: linux-iio@vger.kernel.org, daniel.baluta@intel.com,
	adriana.reus@intel.com, Matt Ranostay <matt.ranostay@intel.com>
Subject: [PATCH 1/5] iio: imu: mpu6050: use inv_mpu6050_sensor_show return code
Date: Mon, 22 Feb 2016 13:39:07 -0800
Message-Id: <1456177151-15881-2-git-send-email-matt.ranostay@intel.com>
In-Reply-To: <1456177151-15881-1-git-send-email-matt.ranostay@intel.com>
References: <1456177151-15881-1-git-send-email-matt.ranostay@intel.com>
Sender: linux-iio-owner@vger.kernel.org
List-Id: linux-iio@vger.kernel.org

Signed-off-by: Matt Ranostay <matt.ranostay@intel.com>
---
 drivers/iio/imu/inv_mpu6050/inv_mpu_core.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/iio/imu/inv_mpu6050/inv_mpu_core.c b/drivers/iio/imu/inv_mpu6050/inv_mpu_core.c
index 225860016fed..4324328fd304 100644
--- a/drivers/iio/imu/inv_mpu6050/inv_mpu_core.c
+++ b/drivers/iio/imu/inv_mpu6050/inv_mpu_core.c
@@ -275,7 +275,7 @@ static int inv_mpu6050_read_raw(struct iio_dev *indio_dev,
 		case IIO_TEMP:
 			/* wait for stablization */
 			msleep(INV_MPU6050_SENSOR_UP_TIME);
-			inv_mpu6050_sensor_show(st, st->reg->temperature,
+			ret = inv_mpu6050_sensor_show(st, st->reg->temperature,
 							IIO_MOD_X, val);
 			break;
 		default:
-- 
1.9.1

