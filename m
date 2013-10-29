Return-Path: <linux-iio-owner@vger.kernel.org>
Received: from mail-pa0-f47.google.com ([209.85.220.47]:48208 "EHLO
	mail-pa0-f47.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751804Ab3J2Lma (ORCPT
	<rfc822;linux-iio@vger.kernel.org>); Tue, 29 Oct 2013 07:42:30 -0400
Received: by mail-pa0-f47.google.com with SMTP id lf10so8612953pab.20
        for <linux-iio@vger.kernel.org>; Tue, 29 Oct 2013 04:42:30 -0700 (PDT)
From: Sachin Kamat <sachin.kamat@linaro.org>
To: linux-iio@vger.kernel.org
Cc: jic23@kernel.org, lars@metafoo.de, sachin.kamat@linaro.org
Subject: [PATCH 29/33] staging: iio: tsl2x7x_core: Use devm_iio_device_register
Date: Tue, 29 Oct 2013 17:09:52 +0530
Message-Id: <1383046796-329-30-git-send-email-sachin.kamat@linaro.org>
In-Reply-To: <1383046796-329-1-git-send-email-sachin.kamat@linaro.org>
References: <1383046796-329-1-git-send-email-sachin.kamat@linaro.org>
Sender: linux-iio-owner@vger.kernel.org
List-Id: linux-iio@vger.kernel.org

devm_iio_device_register simplifies the code.

Signed-off-by: Sachin Kamat <sachin.kamat@linaro.org>
---
 drivers/staging/iio/light/tsl2x7x_core.c |    4 +---
 1 file changed, 1 insertion(+), 3 deletions(-)

diff --git a/drivers/staging/iio/light/tsl2x7x_core.c b/drivers/staging/iio/light/tsl2x7x_core.c
index 1880502..cec7595 100644
--- a/drivers/staging/iio/light/tsl2x7x_core.c
+++ b/drivers/staging/iio/light/tsl2x7x_core.c
@@ -1935,7 +1935,7 @@ static int tsl2x7x_probe(struct i2c_client *clientp,
 	/* Make sure the chip is on */
 	tsl2x7x_chip_on(indio_dev);
 
-	ret = iio_device_register(indio_dev);
+	ret = devm_iio_device_register(&clientp->dev, indio_dev);
 	if (ret) {
 		dev_err(&clientp->dev,
 			"%s: iio registration failed\n", __func__);
@@ -1989,8 +1989,6 @@ static int tsl2x7x_remove(struct i2c_client *client)
 
 	tsl2x7x_chip_off(indio_dev);
 
-	iio_device_unregister(indio_dev);
-
 	return 0;
 }
 
-- 
1.7.9.5

