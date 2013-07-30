Return-Path: <sachin.kamat@linaro.org>
From: Sachin Kamat <sachin.kamat@linaro.org>
To: linux-iio@vger.kernel.org
Cc: jic23@cam.ac.uk,
	jic23@kernel.org,
	sachin.kamat@linaro.org
Subject: [PATCH 3/6] iio: imu: inv_mpu6050: Use devm_iio_device_alloc
Date: Tue, 30 Jul 2013 14:14:25 +0530
Message-Id: <1375173868-13235-3-git-send-email-sachin.kamat@linaro.org>
In-Reply-To: <1375173868-13235-1-git-send-email-sachin.kamat@linaro.org>
References: <1375173868-13235-1-git-send-email-sachin.kamat@linaro.org>
List-ID: <linux-iio@vger.kernel.org>

Using devm_iio_device_alloc makes code simpler. While at
it include missing iio.h header file and do some cleanup.

Signed-off-by: Sachin Kamat <sachin.kamat@linaro.org>
---
 drivers/iio/imu/inv_mpu6050/inv_mpu_core.c |   27 ++++++++++-----------------
 1 file changed, 10 insertions(+), 17 deletions(-)

diff --git a/drivers/iio/imu/inv_mpu6050/inv_mpu_core.c b/drivers/iio/imu/inv_mpu6050/inv_mpu_core.c
index 6a1ff80..df7f1e1 100644
--- a/drivers/iio/imu/inv_mpu6050/inv_mpu_core.c
+++ b/drivers/iio/imu/inv_mpu6050/inv_mpu_core.c
@@ -23,6 +23,7 @@
 #include <linux/interrupt.h>
 #include <linux/kfifo.h>
 #include <linux/spinlock.h>
+#include <linux/iio/iio.h>
 #include "inv_mpu_iio.h"
 
 /*
@@ -663,16 +664,13 @@ static int inv_mpu_probe(struct i2c_client *client,
 	int result;
 
 	if (!i2c_check_functionality(client->adapter,
-		I2C_FUNC_SMBUS_I2C_BLOCK)) {
+		I2C_FUNC_SMBUS_I2C_BLOCK))
+		return -ENOSYS;
+
+	indio_dev = devm_iio_device_alloc(&client->dev, sizeof(*st));
+	if (!indio_dev)
+		return -ENOMEM;
 
-		result = -ENOSYS;
-		goto out_no_free;
-	}
-	indio_dev = iio_device_alloc(sizeof(*st));
-	if (indio_dev == NULL) {
-		result =  -ENOMEM;
-		goto out_no_free;
-	}
 	st = iio_priv(indio_dev);
 	st->client = client;
 	st->plat_data = *(struct inv_mpu6050_platform_data
@@ -680,13 +678,13 @@ static int inv_mpu_probe(struct i2c_client *client,
 	/* power is turned on inside check chip type*/
 	result = inv_check_and_setup_chip(st, id);
 	if (result)
-		goto out_free;
+		return result;
 
 	result = inv_mpu6050_init_config(indio_dev);
 	if (result) {
 		dev_err(&client->dev,
 			"Could not initialize device.\n");
-		goto out_free;
+		return result;
 	}
 
 	i2c_set_clientdata(client, indio_dev);
@@ -705,7 +703,7 @@ static int inv_mpu_probe(struct i2c_client *client,
 	if (result) {
 		dev_err(&st->client->dev, "configure buffer fail %d\n",
 				result);
-		goto out_free;
+		return result;
 	}
 	result = inv_mpu6050_probe_trigger(indio_dev);
 	if (result) {
@@ -727,10 +725,6 @@ out_remove_trigger:
 	inv_mpu6050_remove_trigger(st);
 out_unreg_ring:
 	iio_triggered_buffer_cleanup(indio_dev);
-out_free:
-	iio_device_free(indio_dev);
-out_no_free:
-
 	return result;
 }
 
@@ -742,7 +736,6 @@ static int inv_mpu_remove(struct i2c_client *client)
 	iio_device_unregister(indio_dev);
 	inv_mpu6050_remove_trigger(st);
 	iio_triggered_buffer_cleanup(indio_dev);
-	iio_device_free(indio_dev);
 
 	return 0;
 }
-- 
1.7.9.5
