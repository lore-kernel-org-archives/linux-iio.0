Return-Path: <sachin.kamat@linaro.org>
From: Sachin Kamat <sachin.kamat@linaro.org>
To: linux-iio@vger.kernel.org
Cc: lars@metafoo.de,
	sachin.kamat@linaro.org,
	jic23@kernel.org
Subject: [PATCH 01/12] staging: iio: ad5933: Use devm_* APIs
Date: Thu,  5 Sep 2013 14:59:46 +0530
Message-Id: <1378373397-22919-1-git-send-email-sachin.kamat@linaro.org>
List-ID: <linux-iio@vger.kernel.org>

devm_* APIs are device managed and make code simpler.

Signed-off-by: Sachin Kamat <sachin.kamat@linaro.org>
---
This series is compile tested.
---
 drivers/staging/iio/impedance-analyzer/ad5933.c |   18 ++++++------------
 1 file changed, 6 insertions(+), 12 deletions(-)

diff --git a/drivers/staging/iio/impedance-analyzer/ad5933.c b/drivers/staging/iio/impedance-analyzer/ad5933.c
index 6330af6..23a0d71 100644
--- a/drivers/staging/iio/impedance-analyzer/ad5933.c
+++ b/drivers/staging/iio/impedance-analyzer/ad5933.c
@@ -703,7 +703,9 @@ static int ad5933_probe(struct i2c_client *client,
 	int ret, voltage_uv = 0;
 	struct ad5933_platform_data *pdata = client->dev.platform_data;
 	struct ad5933_state *st;
-	struct iio_dev *indio_dev = iio_device_alloc(sizeof(*st));
+	struct iio_dev *indio_dev;
+
+	indio_dev = devm_iio_device_alloc(&client->dev, sizeof(*st));
 	if (indio_dev == NULL)
 		return -ENOMEM;
 
@@ -716,11 +718,11 @@ static int ad5933_probe(struct i2c_client *client,
 	else
 		st->pdata = pdata;
 
-	st->reg = regulator_get(&client->dev, "vcc");
+	st->reg = devm_regulator_get(&client->dev, "vcc");
 	if (!IS_ERR(st->reg)) {
 		ret = regulator_enable(st->reg);
 		if (ret)
-			goto error_put_reg;
+			return ret;
 		voltage_uv = regulator_get_voltage(st->reg);
 	}
 
@@ -778,11 +780,6 @@ error_unreg_ring:
 error_disable_reg:
 	if (!IS_ERR(st->reg))
 		regulator_disable(st->reg);
-error_put_reg:
-	if (!IS_ERR(st->reg))
-		regulator_put(st->reg);
-
-	iio_device_free(indio_dev);
 
 	return ret;
 }
@@ -795,11 +792,8 @@ static int ad5933_remove(struct i2c_client *client)
 	iio_device_unregister(indio_dev);
 	iio_buffer_unregister(indio_dev);
 	iio_kfifo_free(indio_dev->buffer);
-	if (!IS_ERR(st->reg)) {
+	if (!IS_ERR(st->reg))
 		regulator_disable(st->reg);
-		regulator_put(st->reg);
-	}
-	iio_device_free(indio_dev);
 
 	return 0;
 }
-- 
1.7.9.5
