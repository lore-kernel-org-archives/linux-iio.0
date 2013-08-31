Return-Path: <linux-iio-owner@vger.kernel.org>
Received: from mail-pb0-f47.google.com ([209.85.160.47]:34932 "EHLO
	mail-pb0-f47.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1753286Ab3HaRNI (ORCPT
	<rfc822;linux-iio@vger.kernel.org>); Sat, 31 Aug 2013 13:13:08 -0400
Received: by mail-pb0-f47.google.com with SMTP id rr4so3094007pbb.34
        for <linux-iio@vger.kernel.org>; Sat, 31 Aug 2013 10:13:07 -0700 (PDT)
From: Sachin Kamat <sachin.kamat@linaro.org>
To: linux-iio@vger.kernel.org
Cc: jic23@kernel.org, lars@metafoo.de, sachin.kamat@linaro.org
Subject: [PATCH 7/9] staging: iio: ad799x_core: Use devm_* APIs
Date: Sat, 31 Aug 2013 22:42:37 +0530
Message-Id: <1377969159-2491-7-git-send-email-sachin.kamat@linaro.org>
In-Reply-To: <1377969159-2491-1-git-send-email-sachin.kamat@linaro.org>
References: <1377969159-2491-1-git-send-email-sachin.kamat@linaro.org>
Sender: linux-iio-owner@vger.kernel.org
List-Id: linux-iio@vger.kernel.org

devm_* APIs are device managed and make code simpler.

Signed-off-by: Sachin Kamat <sachin.kamat@linaro.org>
---
 drivers/staging/iio/adc/ad799x_core.c |   16 +++++-----------
 1 files changed, 5 insertions(+), 11 deletions(-)

diff --git a/drivers/staging/iio/adc/ad799x_core.c b/drivers/staging/iio/adc/ad799x_core.c
index 2b2049c..3f5142b 100644
--- a/drivers/staging/iio/adc/ad799x_core.c
+++ b/drivers/staging/iio/adc/ad799x_core.c
@@ -586,8 +586,9 @@ static int ad799x_probe(struct i2c_client *client,
 	int ret;
 	struct ad799x_platform_data *pdata = client->dev.platform_data;
 	struct ad799x_state *st;
-	struct iio_dev *indio_dev = iio_device_alloc(sizeof(*st));
+	struct iio_dev *indio_dev;
 
+	indio_dev = devm_iio_device_alloc(&client->dev, sizeof(*st));
 	if (indio_dev == NULL)
 		return -ENOMEM;
 
@@ -606,11 +607,11 @@ static int ad799x_probe(struct i2c_client *client,
 
 	st->int_vref_mv = pdata->vref_mv;
 
-	st->reg = regulator_get(&client->dev, "vcc");
+	st->reg = devm_regulator_get(&client->dev, "vcc");
 	if (!IS_ERR(st->reg)) {
 		ret = regulator_enable(st->reg);
 		if (ret)
-			goto error_put_reg;
+			return ret;
 	}
 	st->client = client;
 
@@ -650,10 +651,6 @@ error_cleanup_ring:
 error_disable_reg:
 	if (!IS_ERR(st->reg))
 		regulator_disable(st->reg);
-error_put_reg:
-	if (!IS_ERR(st->reg))
-		regulator_put(st->reg);
-	iio_device_free(indio_dev);
 
 	return ret;
 }
@@ -668,12 +665,9 @@ static int ad799x_remove(struct i2c_client *client)
 		free_irq(client->irq, indio_dev);
 
 	ad799x_ring_cleanup(indio_dev);
-	if (!IS_ERR(st->reg)) {
+	if (!IS_ERR(st->reg))
 		regulator_disable(st->reg);
-		regulator_put(st->reg);
-	}
 	kfree(st->rx_buf);
-	iio_device_free(indio_dev);
 
 	return 0;
 }
-- 
1.7.4.1

