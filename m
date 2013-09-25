Return-Path: <sachin.kamat@linaro.org>
From: Sachin Kamat <sachin.kamat@linaro.org>
To: linux-iio@vger.kernel.org
Cc: jic23@kernel.org,
	lars@metafoo.de,
	sachin.kamat@linaro.org
Subject: [PATCH 27/32] staging: iio: tsl2583: Use devm_iio_device_register
Date: Wed, 25 Sep 2013 16:20:03 +0530
Message-Id: <1380106208-6948-28-git-send-email-sachin.kamat@linaro.org>
In-Reply-To: <1380106208-6948-1-git-send-email-sachin.kamat@linaro.org>
References: <1380106208-6948-1-git-send-email-sachin.kamat@linaro.org>
List-ID: <linux-iio@vger.kernel.org>

devm_iio_device_register simplifies the code.

Signed-off-by: Sachin Kamat <sachin.kamat@linaro.org>
---
 drivers/staging/iio/light/tsl2583.c |   10 +---------
 1 file changed, 1 insertion(+), 9 deletions(-)

diff --git a/drivers/staging/iio/light/tsl2583.c b/drivers/staging/iio/light/tsl2583.c
index f8c6595..aa5a437 100644
--- a/drivers/staging/iio/light/tsl2583.c
+++ b/drivers/staging/iio/light/tsl2583.c
@@ -861,7 +861,7 @@ static int taos_probe(struct i2c_client *clientp,
 	indio_dev->dev.parent = &clientp->dev;
 	indio_dev->modes = INDIO_DIRECT_MODE;
 	indio_dev->name = chip->client->name;
-	ret = iio_device_register(indio_dev);
+	ret = devm_iio_device_register(&clientp->dev, indio_dev);
 	if (ret) {
 		dev_err(&clientp->dev, "iio registration failed\n");
 		return ret;
@@ -916,13 +916,6 @@ static SIMPLE_DEV_PM_OPS(taos_pm_ops, taos_suspend, taos_resume);
 #define TAOS_PM_OPS NULL
 #endif
 
-static int taos_remove(struct i2c_client *client)
-{
-	iio_device_unregister(i2c_get_clientdata(client));
-
-	return 0;
-}
-
 static struct i2c_device_id taos_idtable[] = {
 	{ "tsl2580", 0 },
 	{ "tsl2581", 1 },
@@ -939,7 +932,6 @@ static struct i2c_driver taos_driver = {
 	},
 	.id_table = taos_idtable,
 	.probe = taos_probe,
-	.remove = taos_remove,
 };
 module_i2c_driver(taos_driver);
 
-- 
1.7.9.5
