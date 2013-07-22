Return-Path: <sachin.kamat@linaro.org>
From: Sachin Kamat <sachin.kamat@linaro.org>
To: linux-iio@vger.kernel.org
Cc: jic23@cam.ac.uk,
	jic23@kernel.org,
	sachin.kamat@linaro.org,
	patches@linaro.org
Subject: [PATCH 3/8] iio: max1363: Use devm_iio_device_alloc
Date: Mon, 22 Jul 2013 16:32:56 +0530
Message-Id: <1374490981-24373-4-git-send-email-sachin.kamat@linaro.org>
In-Reply-To: <1374490981-24373-1-git-send-email-sachin.kamat@linaro.org>
References: <1374490981-24373-1-git-send-email-sachin.kamat@linaro.org>
List-ID: <linux-iio@vger.kernel.org>

Using devm_iio_device_alloc makes code simpler.

Signed-off-by: Sachin Kamat <sachin.kamat@linaro.org>
---
 drivers/iio/adc/max1363.c |   15 +++++----------
 1 file changed, 5 insertions(+), 10 deletions(-)

diff --git a/drivers/iio/adc/max1363.c b/drivers/iio/adc/max1363.c
index f148d00..4fb35d1 100644
--- a/drivers/iio/adc/max1363.c
+++ b/drivers/iio/adc/max1363.c
@@ -1498,16 +1498,15 @@ static int max1363_probe(struct i2c_client *client,
 	struct iio_dev *indio_dev;
 	struct regulator *vref;
 
-	indio_dev = iio_device_alloc(sizeof(struct max1363_state));
-	if (indio_dev == NULL) {
-		ret = -ENOMEM;
-		goto error_out;
-	}
+	indio_dev = devm_iio_device_alloc(&client->dev,
+					  sizeof(struct max1363_state));
+	if (!indio_dev)
+		return -ENOMEM;
 
 	indio_dev->dev.of_node = client->dev.of_node;
 	ret = iio_map_array_register(indio_dev, client->dev.platform_data);
 	if (ret < 0)
-		goto error_free_device;
+		return ret;
 
 	st = iio_priv(indio_dev);
 
@@ -1590,9 +1589,6 @@ error_disable_reg:
 	regulator_disable(st->reg);
 error_unregister_map:
 	iio_map_array_unregister(indio_dev);
-error_free_device:
-	iio_device_free(indio_dev);
-error_out:
 	return ret;
 }
 
@@ -1607,7 +1603,6 @@ static int max1363_remove(struct i2c_client *client)
 		regulator_disable(st->vref);
 	regulator_disable(st->reg);
 	iio_map_array_unregister(indio_dev);
-	iio_device_free(indio_dev);
 
 	return 0;
 }
-- 
1.7.9.5
