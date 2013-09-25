Return-Path: <sachin.kamat@linaro.org>
From: Sachin Kamat <sachin.kamat@linaro.org>
To: linux-iio@vger.kernel.org
Cc: jic23@kernel.org,
	lars@metafoo.de,
	sachin.kamat@linaro.org
Subject: [PATCH 25/32] staging: iio: isl29018: Use devm_iio_device_register
Date: Wed, 25 Sep 2013 16:20:01 +0530
Message-Id: <1380106208-6948-26-git-send-email-sachin.kamat@linaro.org>
In-Reply-To: <1380106208-6948-1-git-send-email-sachin.kamat@linaro.org>
References: <1380106208-6948-1-git-send-email-sachin.kamat@linaro.org>
List-ID: <linux-iio@vger.kernel.org>

devm_iio_device_register simplifies the code.

Signed-off-by: Sachin Kamat <sachin.kamat@linaro.org>
---
 drivers/staging/iio/light/isl29018.c |   13 +------------
 1 file changed, 1 insertion(+), 12 deletions(-)

diff --git a/drivers/staging/iio/light/isl29018.c b/drivers/staging/iio/light/isl29018.c
index e314d7e..6459178 100644
--- a/drivers/staging/iio/light/isl29018.c
+++ b/drivers/staging/iio/light/isl29018.c
@@ -584,7 +584,7 @@ static int isl29018_probe(struct i2c_client *client,
 	indio_dev->name = id->name;
 	indio_dev->dev.parent = &client->dev;
 	indio_dev->modes = INDIO_DIRECT_MODE;
-	err = iio_device_register(indio_dev);
+	err = devm_iio_device_register(&client->dev, indio_dev);
 	if (err) {
 		dev_err(&client->dev, "iio registration fails\n");
 		return err;
@@ -593,16 +593,6 @@ static int isl29018_probe(struct i2c_client *client,
 	return 0;
 }
 
-static int isl29018_remove(struct i2c_client *client)
-{
-	struct iio_dev *indio_dev = i2c_get_clientdata(client);
-
-	dev_dbg(&client->dev, "%s()\n", __func__);
-	iio_device_unregister(indio_dev);
-
-	return 0;
-}
-
 #ifdef CONFIG_PM_SLEEP
 static int isl29018_suspend(struct device *dev)
 {
@@ -663,7 +653,6 @@ static struct i2c_driver isl29018_driver = {
 			.of_match_table = isl29018_of_match,
 		    },
 	.probe	 = isl29018_probe,
-	.remove	 = isl29018_remove,
 	.id_table = isl29018_id,
 };
 module_i2c_driver(isl29018_driver);
-- 
1.7.9.5
