Return-Path: <linux-iio-owner@vger.kernel.org>
Received: from mail-bn3nam01on0087.outbound.protection.outlook.com ([104.47.33.87]:13568
        "EHLO NAM01-BN3-obe.outbound.protection.outlook.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1754442AbeDWKeS (ORCPT <rfc822;linux-iio@vger.kernel.org>);
        Mon, 23 Apr 2018 06:34:18 -0400
From: Jean-Baptiste Maneyrol <jmaneyrol@invensense.com>
To: linux-iio@vger.kernel.org
Cc: Jean-Baptiste Maneyrol <jmaneyrol@invensense.com>
Subject: [PATCH v4 4/4] iio: imu: inv_mpu6050: clean read channel data error path
Date: Mon, 23 Apr 2018 12:33:33 +0200
Message-Id: <1524479613-23954-4-git-send-email-jmaneyrol@invensense.com>
In-Reply-To: <1524479613-23954-1-git-send-email-jmaneyrol@invensense.com>
References: <1524479613-23954-1-git-send-email-jmaneyrol@invensense.com>
MIME-Version: 1.0
Content-Type: text/plain
Sender: linux-iio-owner@vger.kernel.org
List-Id: linux-iio@vger.kernel.org

Delete the useless ored result and give a second chance to turn
the chip back off at the end.

Signed-off-by: Jean-Baptiste Maneyrol <jmaneyrol@invensense.com>
---
 drivers/iio/imu/inv_mpu6050/inv_mpu_core.c | 16 ++++++++++------
 1 file changed, 10 insertions(+), 6 deletions(-)

diff --git a/drivers/iio/imu/inv_mpu6050/inv_mpu_core.c b/drivers/iio/imu/inv_mpu6050/inv_mpu_core.c
index 79b44fd..aafa777 100644
--- a/drivers/iio/imu/inv_mpu6050/inv_mpu_core.c
+++ b/drivers/iio/imu/inv_mpu6050/inv_mpu_core.c
@@ -338,7 +338,7 @@ static int inv_mpu6050_read_channel_data(struct iio_dev *indio_dev,
 {
 	struct inv_mpu6050_state *st = iio_priv(indio_dev);
 	int result;
-	int ret = IIO_VAL_INT;
+	int ret;
 
 	result = iio_device_claim_direct_mode(indio_dev);
 	if (result)
@@ -383,14 +383,18 @@ static int inv_mpu6050_read_channel_data(struct iio_dev *indio_dev,
 		break;
 	}
 
-error_power_off:
-	result |= inv_mpu6050_set_power_itg(st, false);
-error_release:
-	iio_device_release_direct_mode(indio_dev);
+	result = inv_mpu6050_set_power_itg(st, false);
 	if (result)
-		return result;
+		goto error_power_off;
+	iio_device_release_direct_mode(indio_dev);
 
 	return ret;
+
+error_power_off:
+	inv_mpu6050_set_power_itg(st, false);
+error_release:
+	iio_device_release_direct_mode(indio_dev);
+	return result;
 }
 
 static int
-- 
2.7.4

