Return-Path: <linux-iio-owner@vger.kernel.org>
Received: from mail-pd0-f175.google.com ([209.85.192.175]:59119 "EHLO
	mail-pd0-f175.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1753286Ab3HaRM4 (ORCPT
	<rfc822;linux-iio@vger.kernel.org>); Sat, 31 Aug 2013 13:12:56 -0400
Received: by mail-pd0-f175.google.com with SMTP id q10so3101672pdj.34
        for <linux-iio@vger.kernel.org>; Sat, 31 Aug 2013 10:12:56 -0700 (PDT)
From: Sachin Kamat <sachin.kamat@linaro.org>
To: linux-iio@vger.kernel.org
Cc: jic23@kernel.org, lars@metafoo.de, sachin.kamat@linaro.org
Subject: [PATCH 3/9] staging: iio: ad7291: Use devm_* APIs
Date: Sat, 31 Aug 2013 22:42:33 +0530
Message-Id: <1377969159-2491-3-git-send-email-sachin.kamat@linaro.org>
In-Reply-To: <1377969159-2491-1-git-send-email-sachin.kamat@linaro.org>
References: <1377969159-2491-1-git-send-email-sachin.kamat@linaro.org>
Sender: linux-iio-owner@vger.kernel.org
List-Id: linux-iio@vger.kernel.org

devm_* APIs are device managed and make code simpler.

Signed-off-by: Sachin Kamat <sachin.kamat@linaro.org>
---
 drivers/staging/iio/adc/ad7291.c |   27 ++++++++-------------------
 1 files changed, 8 insertions(+), 19 deletions(-)

diff --git a/drivers/staging/iio/adc/ad7291.c b/drivers/staging/iio/adc/ad7291.c
index a2e61c2..1dae1ef 100644
--- a/drivers/staging/iio/adc/ad7291.c
+++ b/drivers/staging/iio/adc/ad7291.c
@@ -528,21 +528,19 @@ static int ad7291_probe(struct i2c_client *client,
 	struct iio_dev *indio_dev;
 	int ret = 0;
 
-	indio_dev = iio_device_alloc(sizeof(*chip));
-	if (indio_dev == NULL) {
-		ret = -ENOMEM;
-		goto error_ret;
-	}
+	indio_dev = devm_iio_device_alloc(&client->dev, sizeof(*chip));
+	if (!indio_dev)
+		return -ENOMEM;
 	chip = iio_priv(indio_dev);
 
 	if (pdata && pdata->use_external_ref) {
-		chip->reg = regulator_get(&client->dev, "vref");
+		chip->reg = devm_regulator_get(&client->dev, "vref");
 		if (IS_ERR(chip->reg))
-			goto error_free;
+			return ret;
 
 		ret = regulator_enable(chip->reg);
 		if (ret)
-			goto error_put_reg;
+			return ret;
 	}
 
 	mutex_init(&chip->state_lock);
@@ -601,12 +599,7 @@ error_unreg_irq:
 error_disable_reg:
 	if (chip->reg)
 		regulator_disable(chip->reg);
-error_put_reg:
-	if (chip->reg)
-		regulator_put(chip->reg);
-error_free:
-	iio_device_free(indio_dev);
-error_ret:
+
 	return ret;
 }
 
@@ -620,12 +613,8 @@ static int ad7291_remove(struct i2c_client *client)
 	if (client->irq)
 		free_irq(client->irq, indio_dev);
 
-	if (chip->reg) {
+	if (chip->reg)
 		regulator_disable(chip->reg);
-		regulator_put(chip->reg);
-	}
-
-	iio_device_free(indio_dev);
 
 	return 0;
 }
-- 
1.7.4.1

