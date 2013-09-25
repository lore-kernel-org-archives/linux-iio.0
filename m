Return-Path: <sachin.kamat@linaro.org>
From: Sachin Kamat <sachin.kamat@linaro.org>
To: linux-iio@vger.kernel.org
Cc: jic23@kernel.org,
	lars@metafoo.de,
	sachin.kamat@linaro.org
Subject: [PATCH 18/32] staging: iio: ad7746: Use devm_iio_device_register
Date: Wed, 25 Sep 2013 16:19:54 +0530
Message-Id: <1380106208-6948-19-git-send-email-sachin.kamat@linaro.org>
In-Reply-To: <1380106208-6948-1-git-send-email-sachin.kamat@linaro.org>
References: <1380106208-6948-1-git-send-email-sachin.kamat@linaro.org>
List-ID: <linux-iio@vger.kernel.org>

devm_iio_device_register simplifies the code.

Signed-off-by: Sachin Kamat <sachin.kamat@linaro.org>
---
 drivers/staging/iio/cdc/ad7746.c |   12 +-----------
 1 file changed, 1 insertion(+), 11 deletions(-)

diff --git a/drivers/staging/iio/cdc/ad7746.c b/drivers/staging/iio/cdc/ad7746.c
index 75a533b..023284d 100644
--- a/drivers/staging/iio/cdc/ad7746.c
+++ b/drivers/staging/iio/cdc/ad7746.c
@@ -748,7 +748,7 @@ static int ad7746_probe(struct i2c_client *client,
 	if (ret < 0)
 		return ret;
 
-	ret = iio_device_register(indio_dev);
+	ret = devm_iio_device_register(&client->dev, indio_dev);
 	if (ret)
 		return ret;
 
@@ -757,15 +757,6 @@ static int ad7746_probe(struct i2c_client *client,
 	return 0;
 }
 
-static int ad7746_remove(struct i2c_client *client)
-{
-	struct iio_dev *indio_dev = i2c_get_clientdata(client);
-
-	iio_device_unregister(indio_dev);
-
-	return 0;
-}
-
 static const struct i2c_device_id ad7746_id[] = {
 	{ "ad7745", 7745 },
 	{ "ad7746", 7746 },
@@ -780,7 +771,6 @@ static struct i2c_driver ad7746_driver = {
 		.name = KBUILD_MODNAME,
 	},
 	.probe = ad7746_probe,
-	.remove = ad7746_remove,
 	.id_table = ad7746_id,
 };
 module_i2c_driver(ad7746_driver);
-- 
1.7.9.5
