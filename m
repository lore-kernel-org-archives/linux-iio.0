Return-Path: <linux-iio-owner@vger.kernel.org>
Received: from mail-pd0-f170.google.com ([209.85.192.170]:64571 "EHLO
	mail-pd0-f170.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751275Ab3HSLzh (ORCPT
	<rfc822;linux-iio@vger.kernel.org>); Mon, 19 Aug 2013 07:55:37 -0400
Received: by mail-pd0-f170.google.com with SMTP id x10so5117992pdj.29
        for <linux-iio@vger.kernel.org>; Mon, 19 Aug 2013 04:55:37 -0700 (PDT)
From: Sachin Kamat <sachin.kamat@linaro.org>
To: linux-iio@vger.kernel.org
Cc: lars@metafoo.de, jic23@cam.ac.uk, jic23@kernel.org,
	sachin.kamat@linaro.org
Subject: [PATCH 01/14] iio: dac: ad5064: Use devm_* APIs
Date: Mon, 19 Aug 2013 17:08:12 +0530
Message-Id: <1376912305-6423-1-git-send-email-sachin.kamat@linaro.org>
Sender: linux-iio-owner@vger.kernel.org
List-Id: linux-iio@vger.kernel.org

devm_* APIs are device managed and make code simpler.

Signed-off-by: Sachin Kamat <sachin.kamat@linaro.org>
---
This series is compile tested and based on togreg branch of
git://git.kernel.org/pub/scm/linux/kernel/git/jic23/iio.git
---
 drivers/iio/dac/ad5064.c |   21 ++++++---------------
 1 file changed, 6 insertions(+), 15 deletions(-)

diff --git a/drivers/iio/dac/ad5064.c b/drivers/iio/dac/ad5064.c
index aa26d50..a3a52be 100644
--- a/drivers/iio/dac/ad5064.c
+++ b/drivers/iio/dac/ad5064.c
@@ -442,7 +442,7 @@ static int ad5064_probe(struct device *dev, enum ad5064_type type,
 	unsigned int i;
 	int ret;
 
-	indio_dev = iio_device_alloc(sizeof(*st));
+	indio_dev = devm_iio_device_alloc(dev, sizeof(*st));
 	if (indio_dev == NULL)
 		return  -ENOMEM;
 
@@ -456,23 +456,23 @@ static int ad5064_probe(struct device *dev, enum ad5064_type type,
 	for (i = 0; i < ad5064_num_vref(st); ++i)
 		st->vref_reg[i].supply = ad5064_vref_name(st, i);
 
-	ret = regulator_bulk_get(dev, ad5064_num_vref(st),
+	ret = devm_regulator_bulk_get(dev, ad5064_num_vref(st),
 		st->vref_reg);
 	if (ret) {
 		if (!st->chip_info->internal_vref)
-			goto error_free;
+			return ret;
 		st->use_internal_vref = true;
 		ret = ad5064_write(st, AD5064_CMD_CONFIG, 0,
 			AD5064_CONFIG_INT_VREF_ENABLE, 0);
 		if (ret) {
 			dev_err(dev, "Failed to enable internal vref: %d\n",
 				ret);
-			goto error_free;
+			return ret;
 		}
 	} else {
 		ret = regulator_bulk_enable(ad5064_num_vref(st), st->vref_reg);
 		if (ret)
-			goto error_free_reg;
+			return ret;
 	}
 
 	indio_dev->dev.parent = dev;
@@ -498,11 +498,6 @@ static int ad5064_probe(struct device *dev, enum ad5064_type type,
 error_disable_reg:
 	if (!st->use_internal_vref)
 		regulator_bulk_disable(ad5064_num_vref(st), st->vref_reg);
-error_free_reg:
-	if (!st->use_internal_vref)
-		regulator_bulk_free(ad5064_num_vref(st), st->vref_reg);
-error_free:
-	iio_device_free(indio_dev);
 
 	return ret;
 }
@@ -514,12 +509,8 @@ static int ad5064_remove(struct device *dev)
 
 	iio_device_unregister(indio_dev);
 
-	if (!st->use_internal_vref) {
+	if (!st->use_internal_vref)
 		regulator_bulk_disable(ad5064_num_vref(st), st->vref_reg);
-		regulator_bulk_free(ad5064_num_vref(st), st->vref_reg);
-	}
-
-	iio_device_free(indio_dev);
 
 	return 0;
 }
-- 
1.7.9.5

