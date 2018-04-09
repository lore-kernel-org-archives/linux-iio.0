Return-Path: <linux-iio-owner@vger.kernel.org>
Received: from mail-by2nam01on0056.outbound.protection.outlook.com ([104.47.34.56]:12983
        "EHLO NAM01-BY2-obe.outbound.protection.outlook.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1751623AbeDIO7z (ORCPT <rfc822;linux-iio@vger.kernel.org>);
        Mon, 9 Apr 2018 10:59:55 -0400
To: linux-iio <linux-iio@vger.kernel.org>
From: Jean-Baptiste Maneyrol <jmaneyrol@invensense.com>
Subject: [PATCH v2 4/4] iio: imu: inv_mpu6050: clean read channel data error
 path
Message-ID: <557d892a-b796-32df-3db0-e64c6487c6e8@invensense.com>
Date: Mon, 9 Apr 2018 16:59:34 +0200
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8; format=flowed
Sender: linux-iio-owner@vger.kernel.org
List-Id: linux-iio@vger.kernel.org

Signed-off-by: Jean-Baptiste Maneyrol <jmaneyrol@invensense.com>
---
  drivers/iio/imu/inv_mpu6050/inv_mpu_core.c | 16 ++++++++++------
  1 file changed, 10 insertions(+), 6 deletions(-)

diff --git a/drivers/iio/imu/inv_mpu6050/inv_mpu_core.c 
b/drivers/iio/imu/inv_mpu6050/inv_mpu_core.c
index 50d352f..02437ed 100644
--- a/drivers/iio/imu/inv_mpu6050/inv_mpu_core.c
+++ b/drivers/iio/imu/inv_mpu6050/inv_mpu_core.c
@@ -324,7 +324,7 @@ static int inv_mpu6050_read_channel_data(struct 
iio_dev *indio_dev,
  {
  	struct inv_mpu6050_state *st = iio_priv(indio_dev);
  	int result;
-	int ret = IIO_VAL_INT;
+	int ret;

  	result = iio_device_claim_direct_mode(indio_dev);
  	if (result)
@@ -369,14 +369,18 @@ static int inv_mpu6050_read_channel_data(struct 
iio_dev *indio_dev,
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
