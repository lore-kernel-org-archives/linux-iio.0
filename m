Return-Path: <linux-iio-owner@vger.kernel.org>
Received: from mail-pd0-f169.google.com ([209.85.192.169]:62264 "EHLO
	mail-pd0-f169.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751911Ab3J2LmD (ORCPT
	<rfc822;linux-iio@vger.kernel.org>); Tue, 29 Oct 2013 07:42:03 -0400
Received: by mail-pd0-f169.google.com with SMTP id q10so8470549pdj.28
        for <linux-iio@vger.kernel.org>; Tue, 29 Oct 2013 04:42:02 -0700 (PDT)
From: Sachin Kamat <sachin.kamat@linaro.org>
To: linux-iio@vger.kernel.org
Cc: jic23@kernel.org, lars@metafoo.de, sachin.kamat@linaro.org
Subject: [PATCH 18/33] staging: iio: ad7150: Use devm_iio_device_register
Date: Tue, 29 Oct 2013 17:09:41 +0530
Message-Id: <1383046796-329-19-git-send-email-sachin.kamat@linaro.org>
In-Reply-To: <1383046796-329-1-git-send-email-sachin.kamat@linaro.org>
References: <1383046796-329-1-git-send-email-sachin.kamat@linaro.org>
Sender: linux-iio-owner@vger.kernel.org
List-Id: linux-iio@vger.kernel.org

devm_iio_device_register simplifies the code.

Signed-off-by: Sachin Kamat <sachin.kamat@linaro.org>
---
 drivers/staging/iio/cdc/ad7150.c |   12 +-----------
 1 file changed, 1 insertion(+), 11 deletions(-)

diff --git a/drivers/staging/iio/cdc/ad7150.c b/drivers/staging/iio/cdc/ad7150.c
index 7e7f989..d9f2191 100644
--- a/drivers/staging/iio/cdc/ad7150.c
+++ b/drivers/staging/iio/cdc/ad7150.c
@@ -640,7 +640,7 @@ static int ad7150_probe(struct i2c_client *client,
 			return ret;
 	}
 
-	ret = iio_device_register(indio_dev);
+	ret = devm_iio_device_register(&client->dev, indio_dev);
 	if (ret)
 		return ret;
 
@@ -650,15 +650,6 @@ static int ad7150_probe(struct i2c_client *client,
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
@@ -673,7 +664,6 @@ static struct i2c_driver ad7150_driver = {
 		.name = "ad7150",
 	},
 	.probe = ad7150_probe,
-	.remove = ad7150_remove,
 	.id_table = ad7150_id,
 };
 module_i2c_driver(ad7150_driver);
-- 
1.7.9.5

