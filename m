Return-Path: <jg1.han@samsung.com>
From: Jingoo Han <jg1.han@samsung.com>
To: 'Jonathan Cameron' <jic23@kernel.org>
Cc: linux-iio@vger.kernel.org, 'Ge Gao' <ggao@invensense.com>,
 'Jingoo Han' <jg1.han@samsung.com>
Subject: [PATCH] iio: imu: inv_mpu6050: Remove casting the return value which
 is a void pointer
Date: Fri, 29 Aug 2014 12:56:56 +0900
Message-id: <005901cfc33d$46e99bd0$d4bcd370$%han@samsung.com>
MIME-version: 1.0
Content-type: text/plain; charset=us-ascii
List-ID: <linux-iio@vger.kernel.org>

Casting the return value which is a void pointer is redundant.
The conversion from void pointer to any other pointer type is
guaranteed by the C programming language.

Signed-off-by: Jingoo Han <jg1.han@samsung.com>
---
 drivers/iio/imu/inv_mpu6050/inv_mpu_core.c | 3 +--
 1 file changed, 1 insertion(+), 2 deletions(-)

diff --git a/drivers/iio/imu/inv_mpu6050/inv_mpu_core.c b/drivers/iio/imu/inv_mpu6050/inv_mpu_core.c
index 0c6517c94a9d..b75519deac1a 100644
--- a/drivers/iio/imu/inv_mpu6050/inv_mpu_core.c
+++ b/drivers/iio/imu/inv_mpu6050/inv_mpu_core.c
@@ -673,8 +673,7 @@ static int inv_mpu_probe(struct i2c_client *client,
 
 	st = iio_priv(indio_dev);
 	st->client = client;
-	pdata = (struct inv_mpu6050_platform_data
-			*)dev_get_platdata(&client->dev);
+	pdata = dev_get_platdata(&client->dev);
 	if (pdata)
 		st->plat_data = *pdata;
 	/* power is turned on inside check chip type*/
-- 
2.0.0
