Return-Path: <linux-iio-owner@vger.kernel.org>
Received: from mail-pd0-f180.google.com ([209.85.192.180]:52638 "EHLO
	mail-pd0-f180.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1754576Ab3J2Llj (ORCPT
	<rfc822;linux-iio@vger.kernel.org>); Tue, 29 Oct 2013 07:41:39 -0400
Received: by mail-pd0-f180.google.com with SMTP id p10so8409921pdj.11
        for <linux-iio@vger.kernel.org>; Tue, 29 Oct 2013 04:41:39 -0700 (PDT)
From: Sachin Kamat <sachin.kamat@linaro.org>
To: linux-iio@vger.kernel.org
Cc: jic23@kernel.org, lars@metafoo.de, sachin.kamat@linaro.org
Subject: [PATCH 09/33] iio: dac: max517: Use devm_iio_device_register
Date: Tue, 29 Oct 2013 17:09:32 +0530
Message-Id: <1383046796-329-10-git-send-email-sachin.kamat@linaro.org>
In-Reply-To: <1383046796-329-1-git-send-email-sachin.kamat@linaro.org>
References: <1383046796-329-1-git-send-email-sachin.kamat@linaro.org>
Sender: linux-iio-owner@vger.kernel.org
List-Id: linux-iio@vger.kernel.org

devm_iio_device_register simplifies the code.

Signed-off-by: Sachin Kamat <sachin.kamat@linaro.org>
---
 drivers/iio/dac/max517.c |    9 +--------
 1 file changed, 1 insertion(+), 8 deletions(-)

diff --git a/drivers/iio/dac/max517.c b/drivers/iio/dac/max517.c
index 6e19035..073b705 100644
--- a/drivers/iio/dac/max517.c
+++ b/drivers/iio/dac/max517.c
@@ -191,13 +191,7 @@ static int max517_probe(struct i2c_client *client,
 		data->vref_mv[1] = platform_data->vref_mv[1];
 	}
 
-	return iio_device_register(indio_dev);
-}
-
-static int max517_remove(struct i2c_client *client)
-{
-	iio_device_unregister(i2c_get_clientdata(client));
-	return 0;
+	return devm_iio_device_register(&client->dev, indio_dev);
 }
 
 static const struct i2c_device_id max517_id[] = {
@@ -214,7 +208,6 @@ static struct i2c_driver max517_driver = {
 		.pm		= MAX517_PM_OPS,
 	},
 	.probe		= max517_probe,
-	.remove		= max517_remove,
 	.id_table	= max517_id,
 };
 module_i2c_driver(max517_driver);
-- 
1.7.9.5

