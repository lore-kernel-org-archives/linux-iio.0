Return-Path: <sachin.kamat@linaro.org>
From: Sachin Kamat <sachin.kamat@linaro.org>
To: linux-iio@vger.kernel.org
Cc: jic23@kernel.org,
	lars@metafoo.de,
	sachin.kamat@linaro.org
Subject: [PATCH 17/32] staging: iio: ad7150: Use devm_iio_device_register
Date: Wed, 25 Sep 2013 16:19:53 +0530
Message-Id: <1380106208-6948-18-git-send-email-sachin.kamat@linaro.org>
In-Reply-To: <1380106208-6948-1-git-send-email-sachin.kamat@linaro.org>
References: <1380106208-6948-1-git-send-email-sachin.kamat@linaro.org>
List-ID: <linux-iio@vger.kernel.org>

devm_iio_device_register simplifies the code.

Signed-off-by: Sachin Kamat <sachin.kamat@linaro.org>
---
 drivers/staging/iio/cdc/ad7150.c |   12 +-----------
 1 file changed, 1 insertion(+), 11 deletions(-)

diff --git a/drivers/staging/iio/cdc/ad7150.c b/drivers/staging/iio/cdc/ad7150.c
index f4a0341..36e0921 100644
--- a/drivers/staging/iio/cdc/ad7150.c
+++ b/drivers/staging/iio/cdc/ad7150.c
@@ -605,7 +605,7 @@ static int ad7150_probe(struct i2c_client *client,
 			return ret;
 	}
 
-	ret = iio_device_register(indio_dev);
+	ret = devm_iio_device_register(&client->dev, indio_dev);
 	if (ret)
 		return ret;
 
@@ -615,15 +615,6 @@ static int ad7150_probe(struct i2c_client *client,
 	return 0;
 }
 
-static int ad7150_remove(struct i2c_client *client)
-{
-	struct iio_dev *indio_dev = i2c_get_clientdata(client);
-
-	iio_device_unregister(indio_dev);
-
-	return 0;
-}
-
 static const struct i2c_device_id ad7150_id[] = {
 	{ "ad7150", 0 },
 	{ "ad7151", 0 },
@@ -638,7 +629,6 @@ static struct i2c_driver ad7150_driver = {
 		.name = "ad7150",
 	},
 	.probe = ad7150_probe,
-	.remove = ad7150_remove,
 	.id_table = ad7150_id,
 };
 module_i2c_driver(ad7150_driver);
-- 
1.7.9.5
