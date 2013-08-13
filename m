Return-Path: <sachin.kamat@linaro.org>
From: Sachin Kamat <sachin.kamat@linaro.org>
To: linux-iio@vger.kernel.org
Cc: jic23@kernel.org,
	jic23@cam.ac.uk,
	sachin.kamat@linaro.org,
	Christian Strobel <christian.strobel@iis.fraunhofer.de>
Subject: [PATCH 7/9] iio: gyro: itg3200_core: Use devm_iio_device_alloc
Date: Tue, 13 Aug 2013 12:04:33 +0530
Message-Id: <1376375675-11595-7-git-send-email-sachin.kamat@linaro.org>
In-Reply-To: <1376375675-11595-1-git-send-email-sachin.kamat@linaro.org>
References: <1376375675-11595-1-git-send-email-sachin.kamat@linaro.org>
List-ID: <linux-iio@vger.kernel.org>

Using devm_iio_device_alloc makes code simpler.

Signed-off-by: Sachin Kamat <sachin.kamat@linaro.org>
Cc: Christian Strobel <christian.strobel@iis.fraunhofer.de>
---
 drivers/iio/gyro/itg3200_core.c |   15 ++++-----------
 1 file changed, 4 insertions(+), 11 deletions(-)

diff --git a/drivers/iio/gyro/itg3200_core.c b/drivers/iio/gyro/itg3200_core.c
index d66605d2..4d3f3b9 100644
--- a/drivers/iio/gyro/itg3200_core.c
+++ b/drivers/iio/gyro/itg3200_core.c
@@ -309,11 +309,9 @@ static int itg3200_probe(struct i2c_client *client,
 
 	dev_dbg(&client->dev, "probe I2C dev with IRQ %i", client->irq);
 
-	indio_dev = iio_device_alloc(sizeof(*st));
-	if (indio_dev == NULL) {
-		ret =  -ENOMEM;
-		goto error_ret;
-	}
+	indio_dev = devm_iio_device_alloc(&client->dev, sizeof(*st));
+	if (!indio_dev)
+		return -ENOMEM;
 
 	st = iio_priv(indio_dev);
 
@@ -330,7 +328,7 @@ static int itg3200_probe(struct i2c_client *client,
 
 	ret = itg3200_buffer_configure(indio_dev);
 	if (ret)
-		goto error_free_dev;
+		return ret;
 
 	if (client->irq) {
 		ret = itg3200_probe_trigger(indio_dev);
@@ -353,9 +351,6 @@ error_remove_trigger:
 		itg3200_remove_trigger(indio_dev);
 error_unconfigure_buffer:
 	itg3200_buffer_unconfigure(indio_dev);
-error_free_dev:
-	iio_device_free(indio_dev);
-error_ret:
 	return ret;
 }
 
@@ -370,8 +365,6 @@ static int itg3200_remove(struct i2c_client *client)
 
 	itg3200_buffer_unconfigure(indio_dev);
 
-	iio_device_free(indio_dev);
-
 	return 0;
 }
 
-- 
1.7.9.5
