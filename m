Return-Path: <sachin.kamat@linaro.org>
From: Sachin Kamat <sachin.kamat@linaro.org>
To: linux-iio@vger.kernel.org
Cc: jic23@kernel.org,
	lars@metafoo.de,
	sachin.kamat@linaro.org
Subject: [PATCH 08/32] iio: dac: max517: Use devm_iio_device_register
Date: Wed, 25 Sep 2013 16:19:44 +0530
Message-Id: <1380106208-6948-9-git-send-email-sachin.kamat@linaro.org>
In-Reply-To: <1380106208-6948-1-git-send-email-sachin.kamat@linaro.org>
References: <1380106208-6948-1-git-send-email-sachin.kamat@linaro.org>
List-ID: <linux-iio@vger.kernel.org>

devm_iio_device_register simplifies the code.

Signed-off-by: Sachin Kamat <sachin.kamat@linaro.org>
---
 drivers/iio/dac/max517.c |    9 +--------
 1 file changed, 1 insertion(+), 8 deletions(-)

diff --git a/drivers/iio/dac/max517.c b/drivers/iio/dac/max517.c
index 83adcbf..959207f 100644
--- a/drivers/iio/dac/max517.c
+++ b/drivers/iio/dac/max517.c
@@ -194,7 +194,7 @@ static int max517_probe(struct i2c_client *client,
 		data->vref_mv[1] = platform_data->vref_mv[1];
 	}
 
-	err = iio_device_register(indio_dev);
+	err = devm_iio_device_register(&client->dev, indio_dev);
 	if (err)
 		return err;
 
@@ -203,12 +203,6 @@ static int max517_probe(struct i2c_client *client,
 	return 0;
 }
 
-static int max517_remove(struct i2c_client *client)
-{
-	iio_device_unregister(i2c_get_clientdata(client));
-	return 0;
-}
-
 static const struct i2c_device_id max517_id[] = {
 	{ "max517", ID_MAX517 },
 	{ "max518", ID_MAX518 },
@@ -223,7 +217,6 @@ static struct i2c_driver max517_driver = {
 		.pm		= MAX517_PM_OPS,
 	},
 	.probe		= max517_probe,
-	.remove		= max517_remove,
 	.id_table	= max517_id,
 };
 module_i2c_driver(max517_driver);
-- 
1.7.9.5
