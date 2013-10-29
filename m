Return-Path: <linux-iio-owner@vger.kernel.org>
Received: from mail-pd0-f173.google.com ([209.85.192.173]:40596 "EHLO
	mail-pd0-f173.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1754781Ab3J2LmX (ORCPT
	<rfc822;linux-iio@vger.kernel.org>); Tue, 29 Oct 2013 07:42:23 -0400
Received: by mail-pd0-f173.google.com with SMTP id r10so8409484pdi.4
        for <linux-iio@vger.kernel.org>; Tue, 29 Oct 2013 04:42:22 -0700 (PDT)
From: Sachin Kamat <sachin.kamat@linaro.org>
To: linux-iio@vger.kernel.org
Cc: jic23@kernel.org, lars@metafoo.de, sachin.kamat@linaro.org
Subject: [PATCH 26/33] staging: iio: isl29018: Use devm_iio_device_register
Date: Tue, 29 Oct 2013 17:09:49 +0530
Message-Id: <1383046796-329-27-git-send-email-sachin.kamat@linaro.org>
In-Reply-To: <1383046796-329-1-git-send-email-sachin.kamat@linaro.org>
References: <1383046796-329-1-git-send-email-sachin.kamat@linaro.org>
Sender: linux-iio-owner@vger.kernel.org
List-Id: linux-iio@vger.kernel.org

devm_iio_device_register simplifies the code.

Signed-off-by: Sachin Kamat <sachin.kamat@linaro.org>
---
 drivers/staging/iio/light/isl29018.c |   13 +------------
 1 file changed, 1 insertion(+), 12 deletions(-)

diff --git a/drivers/staging/iio/light/isl29018.c b/drivers/staging/iio/light/isl29018.c
index 488e690..3660a43 100644
--- a/drivers/staging/iio/light/isl29018.c
+++ b/drivers/staging/iio/light/isl29018.c
@@ -585,7 +585,7 @@ static int isl29018_probe(struct i2c_client *client,
 	indio_dev->name = id->name;
 	indio_dev->dev.parent = &client->dev;
 	indio_dev->modes = INDIO_DIRECT_MODE;
-	err = iio_device_register(indio_dev);
+	err = devm_iio_device_register(&client->dev, indio_dev);
 	if (err) {
 		dev_err(&client->dev, "iio registration fails\n");
 		return err;
@@ -594,16 +594,6 @@ static int isl29018_probe(struct i2c_client *client,
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
@@ -664,7 +654,6 @@ static struct i2c_driver isl29018_driver = {
 			.of_match_table = isl29018_of_match,
 		    },
 	.probe	 = isl29018_probe,
-	.remove	 = isl29018_remove,
 	.id_table = isl29018_id,
 };
 module_i2c_driver(isl29018_driver);
-- 
1.7.9.5

