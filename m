Return-Path: <linux-iio-owner@vger.kernel.org>
Received: from mail-co1nam03on0061.outbound.protection.outlook.com ([104.47.40.61]:14023
        "EHLO NAM03-CO1-obe.outbound.protection.outlook.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1751358AbeDQIH5 (ORCPT <rfc822;linux-iio@vger.kernel.org>);
        Tue, 17 Apr 2018 04:07:57 -0400
From: Jean-Baptiste Maneyrol <jmaneyrol@invensense.com>
To: linux-iio@vger.kernel.org
Cc: Jean-Baptiste Maneyrol <jmaneyrol@invensense.com>
Subject: [PATCH v3 4/4] iio: imu: inv_mpu6050: clean read channel data error path
Date: Tue, 17 Apr 2018 10:07:22 +0200
Message-Id: <1523952442-20104-4-git-send-email-jmaneyrol@invensense.com>
In-Reply-To: <1523952442-20104-1-git-send-email-jmaneyrol@invensense.com>
References: <1523952442-20104-1-git-send-email-jmaneyrol@invensense.com>
MIME-Version: 1.0
Content-Type: text/plain
Sender: linux-iio-owner@vger.kernel.org
List-Id: linux-iio@vger.kernel.org

---
 drivers/iio/imu/inv_mpu6050/inv_mpu_core.c | 16 ++++++++++------
 1 file changed, 10 insertions(+), 6 deletions(-)

diff --git a/drivers/iio/imu/inv_mpu6050/inv_mpu_core.c b/drivers/iio/imu/inv_mpu6050/inv_mpu_core.c
index a0cecd9..b842caf 100644
--- a/drivers/iio/imu/inv_mpu6050/inv_mpu_core.c
+++ b/drivers/iio/imu/inv_mpu6050/inv_mpu_core.c
@@ -330,7 +330,7 @@ static int inv_mpu6050_read_channel_data(struct iio_dev *indio_dev,
 {
 	struct inv_mpu6050_state *st = iio_priv(indio_dev);
 	int result;
-	int ret = IIO_VAL_INT;
+	int ret;
 
 	result = iio_device_claim_direct_mode(indio_dev);
 	if (result)
@@ -375,14 +375,18 @@ static int inv_mpu6050_read_channel_data(struct iio_dev *indio_dev,
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

