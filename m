Return-Path: <linux-iio-owner@vger.kernel.org>
Received: from mail-pd0-f179.google.com ([209.85.192.179]:57223 "EHLO
	mail-pd0-f179.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1754697Ab3J2Lml (ORCPT
	<rfc822;linux-iio@vger.kernel.org>); Tue, 29 Oct 2013 07:42:41 -0400
Received: by mail-pd0-f179.google.com with SMTP id y10so8439313pdj.38
        for <linux-iio@vger.kernel.org>; Tue, 29 Oct 2013 04:42:41 -0700 (PDT)
From: Sachin Kamat <sachin.kamat@linaro.org>
To: linux-iio@vger.kernel.org
Cc: jic23@kernel.org, lars@metafoo.de, sachin.kamat@linaro.org
Subject: [PATCH 33/33] staging: iio: ad7152: Use devm_iio_device_register
Date: Tue, 29 Oct 2013 17:09:56 +0530
Message-Id: <1383046796-329-34-git-send-email-sachin.kamat@linaro.org>
In-Reply-To: <1383046796-329-1-git-send-email-sachin.kamat@linaro.org>
References: <1383046796-329-1-git-send-email-sachin.kamat@linaro.org>
Sender: linux-iio-owner@vger.kernel.org
List-Id: linux-iio@vger.kernel.org

devm_iio_device_register simplifies the code.

Signed-off-by: Sachin Kamat <sachin.kamat@linaro.org>
---
 drivers/staging/iio/cdc/ad7152.c |   12 +-----------
 1 file changed, 1 insertion(+), 11 deletions(-)

diff --git a/drivers/staging/iio/cdc/ad7152.c b/drivers/staging/iio/cdc/ad7152.c
index f2c309d..f925ecb 100644
--- a/drivers/staging/iio/cdc/ad7152.c
+++ b/drivers/staging/iio/cdc/ad7152.c
@@ -502,7 +502,7 @@ static int ad7152_probe(struct i2c_client *client,
 	indio_dev->num_channels = ARRAY_SIZE(ad7152_channels);
 	indio_dev->modes = INDIO_DIRECT_MODE;
 
-	ret = iio_device_register(indio_dev);
+	ret = devm_iio_device_register(&client->dev, indio_dev);
 	if (ret)
 		return ret;
 
@@ -511,15 +511,6 @@ static int ad7152_probe(struct i2c_client *client,
 	return 0;
 }
 
-static int ad7152_remove(struct i2c_client *client)
-{
-	struct iio_dev *indio_dev = i2c_get_clientdata(client);
-
-	iio_device_unregister(indio_dev);
-
-	return 0;
-}
-
 static const struct i2c_device_id ad7152_id[] = {
 	{ "ad7152", 0 },
 	{ "ad7153", 1 },
@@ -533,7 +524,6 @@ static struct i2c_driver ad7152_driver = {
 		.name = KBUILD_MODNAME,
 	},
 	.probe = ad7152_probe,
-	.remove = ad7152_remove,
 	.id_table = ad7152_id,
 };
 module_i2c_driver(ad7152_driver);
-- 
1.7.9.5

