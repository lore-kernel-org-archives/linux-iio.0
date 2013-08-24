Return-Path: <sachin.kamat@linaro.org>
From: Sachin Kamat <sachin.kamat@linaro.org>
To: linux-iio@vger.kernel.org
Cc: jic23@cam.ac.uk,
	jic23@kernel.org,
	sachin.kamat@linaro.org,
	lars@metafoo.de
Subject: [PATCH 1/3] staging: iio: ad7150: Use devm_* APIs
Date: Sun, 25 Aug 2013 00:54:27 +0530
Message-Id: <1377372269-4978-1-git-send-email-sachin.kamat@linaro.org>
List-ID: <linux-iio@vger.kernel.org>

devm_* APIs are device managed and make code simpler.

Signed-off-by: Sachin Kamat <sachin.kamat@linaro.org>
---
Series compile tested on togreg branch of
git://git.kernel.org/pub/scm/linux/kernel/git/jic23/iio.git
---
 drivers/staging/iio/cdc/ad7150.c |   36 ++++++++----------------------------
 1 files changed, 8 insertions(+), 28 deletions(-)

diff --git a/drivers/staging/iio/cdc/ad7150.c b/drivers/staging/iio/cdc/ad7150.c
index 687dd2c..f4a0341 100644
--- a/drivers/staging/iio/cdc/ad7150.c
+++ b/drivers/staging/iio/cdc/ad7150.c
@@ -558,11 +558,9 @@ static int ad7150_probe(struct i2c_client *client,
 	struct ad7150_chip_info *chip;
 	struct iio_dev *indio_dev;
 
-	indio_dev = iio_device_alloc(sizeof(*chip));
-	if (indio_dev == NULL) {
-		ret = -ENOMEM;
-		goto error_ret;
-	}
+	indio_dev = devm_iio_device_alloc(&client->dev, sizeof(*chip));
+	if (!indio_dev)
+		return -ENOMEM;
 	chip = iio_priv(indio_dev);
 	mutex_init(&chip->state_lock);
 	/* this is only used for device removal purposes */
@@ -581,7 +579,7 @@ static int ad7150_probe(struct i2c_client *client,
 	indio_dev->modes = INDIO_DIRECT_MODE;
 
 	if (client->irq) {
-		ret = request_threaded_irq(client->irq,
+		ret = devm_request_threaded_irq(&client->dev, client->irq,
 					   NULL,
 					   &ad7150_event_handler,
 					   IRQF_TRIGGER_RISING |
@@ -590,11 +588,11 @@ static int ad7150_probe(struct i2c_client *client,
 					   "ad7150_irq1",
 					   indio_dev);
 		if (ret)
-			goto error_free_dev;
+			return ret;
 	}
 
 	if (client->dev.platform_data) {
-		ret = request_threaded_irq(*(unsigned int *)
+		ret = devm_request_threaded_irq(&client->dev, *(unsigned int *)
 					   client->dev.platform_data,
 					   NULL,
 					   &ad7150_event_handler,
@@ -604,28 +602,17 @@ static int ad7150_probe(struct i2c_client *client,
 					   "ad7150_irq2",
 					   indio_dev);
 		if (ret)
-			goto error_free_irq;
+			return ret;
 	}
 
 	ret = iio_device_register(indio_dev);
 	if (ret)
-		goto error_free_irq2;
+		return ret;
 
 	dev_info(&client->dev, "%s capacitive sensor registered,irq: %d\n",
 		 id->name, client->irq);
 
 	return 0;
-error_free_irq2:
-	if (client->dev.platform_data)
-		free_irq(*(unsigned int *)client->dev.platform_data,
-			 indio_dev);
-error_free_irq:
-	if (client->irq)
-		free_irq(client->irq, indio_dev);
-error_free_dev:
-	iio_device_free(indio_dev);
-error_ret:
-	return ret;
 }
 
 static int ad7150_remove(struct i2c_client *client)
@@ -633,13 +620,6 @@ static int ad7150_remove(struct i2c_client *client)
 	struct iio_dev *indio_dev = i2c_get_clientdata(client);
 
 	iio_device_unregister(indio_dev);
-	if (client->irq)
-		free_irq(client->irq, indio_dev);
-
-	if (client->dev.platform_data)
-		free_irq(*(unsigned int *)client->dev.platform_data, indio_dev);
-
-	iio_device_free(indio_dev);
 
 	return 0;
 }
-- 
1.7.4.1
