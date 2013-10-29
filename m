Return-Path: <linux-iio-owner@vger.kernel.org>
Received: from mail-pa0-f45.google.com ([209.85.220.45]:57102 "EHLO
	mail-pa0-f45.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1754576Ab3J2Llt (ORCPT
	<rfc822;linux-iio@vger.kernel.org>); Tue, 29 Oct 2013 07:41:49 -0400
Received: by mail-pa0-f45.google.com with SMTP id kp14so8393070pab.18
        for <linux-iio@vger.kernel.org>; Tue, 29 Oct 2013 04:41:48 -0700 (PDT)
From: Sachin Kamat <sachin.kamat@linaro.org>
To: linux-iio@vger.kernel.org
Cc: jic23@kernel.org, lars@metafoo.de, sachin.kamat@linaro.org
Subject: [PATCH 13/33] iio: light: vcnl4000: Use devm_iio_device_register
Date: Tue, 29 Oct 2013 17:09:36 +0530
Message-Id: <1383046796-329-14-git-send-email-sachin.kamat@linaro.org>
In-Reply-To: <1383046796-329-1-git-send-email-sachin.kamat@linaro.org>
References: <1383046796-329-1-git-send-email-sachin.kamat@linaro.org>
Sender: linux-iio-owner@vger.kernel.org
List-Id: linux-iio@vger.kernel.org

devm_iio_device_register simplifies the code.

Signed-off-by: Sachin Kamat <sachin.kamat@linaro.org>
---
 drivers/iio/light/vcnl4000.c |    9 +--------
 1 file changed, 1 insertion(+), 8 deletions(-)

diff --git a/drivers/iio/light/vcnl4000.c b/drivers/iio/light/vcnl4000.c
index ecb3341..384ac23 100644
--- a/drivers/iio/light/vcnl4000.c
+++ b/drivers/iio/light/vcnl4000.c
@@ -179,13 +179,7 @@ static int vcnl4000_probe(struct i2c_client *client,
 	indio_dev->name = VCNL4000_DRV_NAME;
 	indio_dev->modes = INDIO_DIRECT_MODE;
 
-	return iio_device_register(indio_dev);
-}
-
-static int vcnl4000_remove(struct i2c_client *client)
-{
-	iio_device_unregister(i2c_get_clientdata(client));
-	return 0;
+	return devm_iio_device_register(&client->dev, indio_dev);
 }
 
 static struct i2c_driver vcnl4000_driver = {
@@ -194,7 +188,6 @@ static struct i2c_driver vcnl4000_driver = {
 		.owner  = THIS_MODULE,
 	},
 	.probe  = vcnl4000_probe,
-	.remove = vcnl4000_remove,
 	.id_table = vcnl4000_id,
 };
 
-- 
1.7.9.5

