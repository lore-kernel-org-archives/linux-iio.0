Return-Path: <sachin.kamat@linaro.org>
From: Sachin Kamat <sachin.kamat@linaro.org>
To: linux-iio@vger.kernel.org
Cc: lars@metafoo.de,
	jic23@cam.ac.uk,
	jic23@kernel.org,
	sachin.kamat@linaro.org,
	Roland Stigge <stigge@antcom.de>
Subject: [PATCH 14/14] iio: dac: max517: Use devm_iio_device_alloc
Date: Mon, 19 Aug 2013 17:08:25 +0530
Message-Id: <1376912305-6423-14-git-send-email-sachin.kamat@linaro.org>
In-Reply-To: <1376912305-6423-1-git-send-email-sachin.kamat@linaro.org>
References: <1376912305-6423-1-git-send-email-sachin.kamat@linaro.org>
List-ID: <linux-iio@vger.kernel.org>

Using devm_iio_device_alloc makes code simpler.

Signed-off-by: Sachin Kamat <sachin.kamat@linaro.org>
Cc: Roland Stigge <stigge@antcom.de>
---
 drivers/iio/dac/max517.c |   17 ++++-------------
 1 file changed, 4 insertions(+), 13 deletions(-)

diff --git a/drivers/iio/dac/max517.c b/drivers/iio/dac/max517.c
index ebfaa41..83adcbf 100644
--- a/drivers/iio/dac/max517.c
+++ b/drivers/iio/dac/max517.c
@@ -164,11 +164,9 @@ static int max517_probe(struct i2c_client *client,
 	struct max517_platform_data *platform_data = client->dev.platform_data;
 	int err;
 
-	indio_dev = iio_device_alloc(sizeof(*data));
-	if (indio_dev == NULL) {
-		err = -ENOMEM;
-		goto exit;
-	}
+	indio_dev = devm_iio_device_alloc(&client->dev, sizeof(*data));
+	if (!indio_dev)
+		return -ENOMEM;
 	data = iio_priv(indio_dev);
 	i2c_set_clientdata(client, indio_dev);
 	data->client = client;
@@ -198,23 +196,16 @@ static int max517_probe(struct i2c_client *client,
 
 	err = iio_device_register(indio_dev);
 	if (err)
-		goto exit_free_device;
+		return err;
 
 	dev_info(&client->dev, "DAC registered\n");
 
 	return 0;
-
-exit_free_device:
-	iio_device_free(indio_dev);
-exit:
-	return err;
 }
 
 static int max517_remove(struct i2c_client *client)
 {
 	iio_device_unregister(i2c_get_clientdata(client));
-	iio_device_free(i2c_get_clientdata(client));
-
 	return 0;
 }
 
-- 
1.7.9.5
