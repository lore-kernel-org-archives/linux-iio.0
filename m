Return-Path: <linux-iio-owner@vger.kernel.org>
Received: from mail-pa0-f51.google.com ([209.85.220.51]:48724 "EHLO
	mail-pa0-f51.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1753286Ab3HaRM7 (ORCPT
	<rfc822;linux-iio@vger.kernel.org>); Sat, 31 Aug 2013 13:12:59 -0400
Received: by mail-pa0-f51.google.com with SMTP id lf1so3539448pab.38
        for <linux-iio@vger.kernel.org>; Sat, 31 Aug 2013 10:12:59 -0700 (PDT)
From: Sachin Kamat <sachin.kamat@linaro.org>
To: linux-iio@vger.kernel.org
Cc: jic23@kernel.org, lars@metafoo.de, sachin.kamat@linaro.org
Subject: [PATCH 4/9] staging: iio: ad7606_core: Use devm_* APIs
Date: Sat, 31 Aug 2013 22:42:34 +0530
Message-Id: <1377969159-2491-4-git-send-email-sachin.kamat@linaro.org>
In-Reply-To: <1377969159-2491-1-git-send-email-sachin.kamat@linaro.org>
References: <1377969159-2491-1-git-send-email-sachin.kamat@linaro.org>
Sender: linux-iio-owner@vger.kernel.org
List-Id: linux-iio@vger.kernel.org

devm_* APIs are device managed and make code simpler.

Signed-off-by: Sachin Kamat <sachin.kamat@linaro.org>
---
 drivers/staging/iio/adc/ad7606_core.c |   23 +++++++----------------
 1 files changed, 7 insertions(+), 16 deletions(-)

diff --git a/drivers/staging/iio/adc/ad7606_core.c b/drivers/staging/iio/adc/ad7606_core.c
index 72868ce..0eb5ed0 100644
--- a/drivers/staging/iio/adc/ad7606_core.c
+++ b/drivers/staging/iio/adc/ad7606_core.c
@@ -466,12 +466,11 @@ struct iio_dev *ad7606_probe(struct device *dev, int irq,
 	struct ad7606_platform_data *pdata = dev->platform_data;
 	struct ad7606_state *st;
 	int ret;
-	struct iio_dev *indio_dev = iio_device_alloc(sizeof(*st));
+	struct iio_dev *indio_dev;
 
-	if (indio_dev == NULL) {
-		ret = -ENOMEM;
-		goto error_ret;
-	}
+	indio_dev = devm_iio_device_alloc(dev, sizeof(*st));
+	if (!indio_dev)
+		return ERR_PTR(-ENOMEM);
 
 	st = iio_priv(indio_dev);
 
@@ -489,11 +488,11 @@ struct iio_dev *ad7606_probe(struct device *dev, int irq,
 		st->oversampling = pdata->default_os;
 	}
 
-	st->reg = regulator_get(dev, "vcc");
+	st->reg = devm_regulator_get(dev, "vcc");
 	if (!IS_ERR(st->reg)) {
 		ret = regulator_enable(st->reg);
 		if (ret)
-			goto error_put_reg;
+			return ERR_PTR(ret);
 	}
 
 	st->pdata = pdata;
@@ -554,11 +553,6 @@ error_free_gpios:
 error_disable_reg:
 	if (!IS_ERR(st->reg))
 		regulator_disable(st->reg);
-error_put_reg:
-	if (!IS_ERR(st->reg))
-		regulator_put(st->reg);
-	iio_device_free(indio_dev);
-error_ret:
 	return ERR_PTR(ret);
 }
 
@@ -570,13 +564,10 @@ int ad7606_remove(struct iio_dev *indio_dev, int irq)
 	ad7606_ring_cleanup(indio_dev);
 
 	free_irq(irq, indio_dev);
-	if (!IS_ERR(st->reg)) {
+	if (!IS_ERR(st->reg))
 		regulator_disable(st->reg);
-		regulator_put(st->reg);
-	}
 
 	ad7606_free_gpios(st);
-	iio_device_free(indio_dev);
 
 	return 0;
 }
-- 
1.7.4.1

