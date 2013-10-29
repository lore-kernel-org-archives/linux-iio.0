Return-Path: <linux-iio-owner@vger.kernel.org>
Received: from mail-pb0-f44.google.com ([209.85.160.44]:48401 "EHLO
	mail-pb0-f44.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751804Ab3J2LmZ (ORCPT
	<rfc822;linux-iio@vger.kernel.org>); Tue, 29 Oct 2013 07:42:25 -0400
Received: by mail-pb0-f44.google.com with SMTP id rp16so3126336pbb.17
        for <linux-iio@vger.kernel.org>; Tue, 29 Oct 2013 04:42:25 -0700 (PDT)
From: Sachin Kamat <sachin.kamat@linaro.org>
To: linux-iio@vger.kernel.org
Cc: jic23@kernel.org, lars@metafoo.de, sachin.kamat@linaro.org
Subject: [PATCH 27/33] staging: iio: isl29028: Use devm_iio_device_register
Date: Tue, 29 Oct 2013 17:09:50 +0530
Message-Id: <1383046796-329-28-git-send-email-sachin.kamat@linaro.org>
In-Reply-To: <1383046796-329-1-git-send-email-sachin.kamat@linaro.org>
References: <1383046796-329-1-git-send-email-sachin.kamat@linaro.org>
Sender: linux-iio-owner@vger.kernel.org
List-Id: linux-iio@vger.kernel.org

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

