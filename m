Return-Path: <linux-iio-owner@vger.kernel.org>
Received: from mail-pd0-f176.google.com ([209.85.192.176]:41212 "EHLO
	mail-pd0-f176.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1754723Ab3IYKvY (ORCPT
	<rfc822;linux-iio@vger.kernel.org>); Wed, 25 Sep 2013 06:51:24 -0400
Received: by mail-pd0-f176.google.com with SMTP id q10so5917935pdj.35
        for <linux-iio@vger.kernel.org>; Wed, 25 Sep 2013 03:51:23 -0700 (PDT)
From: Sachin Kamat <sachin.kamat@linaro.org>
To: linux-iio@vger.kernel.org
Cc: jic23@kernel.org, lars@metafoo.de, sachin.kamat@linaro.org
Subject: [PATCH 28/32] staging: iio: tsl2x7x_core: Use devm_iio_device_register
Date: Wed, 25 Sep 2013 16:20:04 +0530
Message-Id: <1380106208-6948-29-git-send-email-sachin.kamat@linaro.org>
In-Reply-To: <1380106208-6948-1-git-send-email-sachin.kamat@linaro.org>
References: <1380106208-6948-1-git-send-email-sachin.kamat@linaro.org>
Sender: linux-iio-owner@vger.kernel.org
List-Id: linux-iio@vger.kernel.org

devm_iio_device_register simplifies the code.

Signed-off-by: Sachin Kamat <sachin.kamat@linaro.org>
---
 drivers/staging/iio/light/tsl2x7x_core.c |    4 +---
 1 file changed, 1 insertion(+), 3 deletions(-)

diff --git a/drivers/staging/iio/light/tsl2x7x_core.c b/drivers/staging/iio/light/tsl2x7x_core.c
index 9c43dcf..ba2079e 100644
--- a/drivers/staging/iio/light/tsl2x7x_core.c
+++ b/drivers/staging/iio/light/tsl2x7x_core.c
@@ -1909,7 +1909,7 @@ static int tsl2x7x_probe(struct i2c_client *clientp,
 	/* Make sure the chip is on */
 	tsl2x7x_chip_on(indio_dev);
 
-	ret = iio_device_register(indio_dev);
+	ret = devm_iio_device_register(&clientp->dev, indio_dev);
 	if (ret) {
 		dev_err(&clientp->dev,
 			"%s: iio registration failed\n", __func__);
@@ -1963,8 +1963,6 @@ static int tsl2x7x_remove(struct i2c_client *client)
 
 	tsl2x7x_chip_off(indio_dev);
 
-	iio_device_unregister(indio_dev);
-
 	return 0;
 }
 
-- 
1.7.9.5

