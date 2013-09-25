Return-Path: <sachin.kamat@linaro.org>
From: Sachin Kamat <sachin.kamat@linaro.org>
To: linux-iio@vger.kernel.org
Cc: jic23@kernel.org,
	lars@metafoo.de,
	sachin.kamat@linaro.org
Subject: [PATCH 26/32] staging: iio: isl29028: Use devm_iio_device_register
Date: Wed, 25 Sep 2013 16:20:02 +0530
Message-Id: <1380106208-6948-27-git-send-email-sachin.kamat@linaro.org>
In-Reply-To: <1380106208-6948-1-git-send-email-sachin.kamat@linaro.org>
References: <1380106208-6948-1-git-send-email-sachin.kamat@linaro.org>
List-ID: <linux-iio@vger.kernel.org>

devm_iio_device_register simplifies the code.

Signed-off-by: Sachin Kamat <sachin.kamat@linaro.org>
---
 drivers/staging/iio/light/isl29028.c |   11 +----------
 1 file changed, 1 insertion(+), 10 deletions(-)

diff --git a/drivers/staging/iio/light/isl29028.c b/drivers/staging/iio/light/isl29028.c
index 6014625..aeb830b 100644
--- a/drivers/staging/iio/light/isl29028.c
+++ b/drivers/staging/iio/light/isl29028.c
@@ -513,7 +513,7 @@ static int isl29028_probe(struct i2c_client *client,
 	indio_dev->name = id->name;
 	indio_dev->dev.parent = &client->dev;
 	indio_dev->modes = INDIO_DIRECT_MODE;
-	ret = iio_device_register(indio_dev);
+	ret = devm_iio_device_register(&client->dev, indio_dev);
 	if (ret < 0) {
 		dev_err(chip->dev, "iio registration fails with error %d\n",
 			ret);
@@ -522,14 +522,6 @@ static int isl29028_probe(struct i2c_client *client,
 	return 0;
 }
 
-static int isl29028_remove(struct i2c_client *client)
-{
-	struct iio_dev *indio_dev = i2c_get_clientdata(client);
-
-	iio_device_unregister(indio_dev);
-	return 0;
-}
-
 static const struct i2c_device_id isl29028_id[] = {
 	{"isl29028", 0},
 	{}
@@ -550,7 +542,6 @@ static struct i2c_driver isl29028_driver = {
 		.of_match_table = isl29028_of_match,
 	},
 	.probe	 = isl29028_probe,
-	.remove  = isl29028_remove,
 	.id_table = isl29028_id,
 };
 
-- 
1.7.9.5
