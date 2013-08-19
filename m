Return-Path: <sachin.kamat@linaro.org>
From: Sachin Kamat <sachin.kamat@linaro.org>
To: linux-iio@vger.kernel.org
Cc: lars@metafoo.de,
	jic23@cam.ac.uk,
	jic23@kernel.org,
	sachin.kamat@linaro.org
Subject: [PATCH 03/14] iio: dac: ad5380: Use devm_* APIs
Date: Mon, 19 Aug 2013 17:08:14 +0530
Message-Id: <1376912305-6423-3-git-send-email-sachin.kamat@linaro.org>
In-Reply-To: <1376912305-6423-1-git-send-email-sachin.kamat@linaro.org>
References: <1376912305-6423-1-git-send-email-sachin.kamat@linaro.org>
List-ID: <linux-iio@vger.kernel.org>

devm_* APIs are device managed and make code simpler.

Signed-off-by: Sachin Kamat <sachin.kamat@linaro.org>
---
 drivers/iio/dac/ad5380.c |   18 ++++--------------
 1 file changed, 4 insertions(+), 14 deletions(-)

diff --git a/drivers/iio/dac/ad5380.c b/drivers/iio/dac/ad5380.c
index bf2db02..1c44ae3 100644
--- a/drivers/iio/dac/ad5380.c
+++ b/drivers/iio/dac/ad5380.c
@@ -369,11 +369,10 @@ static int ad5380_probe(struct device *dev, struct regmap *regmap,
 	unsigned int ctrl = 0;
 	int ret;
 
-	indio_dev = iio_device_alloc(sizeof(*st));
+	indio_dev = devm_iio_device_alloc(dev, sizeof(*st));
 	if (indio_dev == NULL) {
 		dev_err(dev, "Failed to allocate iio device\n");
-		ret = -ENOMEM;
-		goto error_out;
+		return -ENOMEM;
 	}
 
 	st = iio_priv(indio_dev);
@@ -391,13 +390,13 @@ static int ad5380_probe(struct device *dev, struct regmap *regmap,
 	ret = ad5380_alloc_channels(indio_dev);
 	if (ret) {
 		dev_err(dev, "Failed to allocate channel spec: %d\n", ret);
-		goto error_free;
+		return ret;
 	}
 
 	if (st->chip_info->int_vref == 2500000)
 		ctrl |= AD5380_CTRL_INT_VREF_2V5;
 
-	st->vref_reg = regulator_get(dev, "vref");
+	st->vref_reg = devm_regulator_get(dev, "vref");
 	if (!IS_ERR(st->vref_reg)) {
 		ret = regulator_enable(st->vref_reg);
 		if (ret) {
@@ -434,13 +433,7 @@ error_disable_reg:
 	if (!IS_ERR(st->vref_reg))
 		regulator_disable(st->vref_reg);
 error_free_reg:
-	if (!IS_ERR(st->vref_reg))
-		regulator_put(st->vref_reg);
-
 	kfree(indio_dev->channels);
-error_free:
-	iio_device_free(indio_dev);
-error_out:
 
 	return ret;
 }
@@ -456,11 +449,8 @@ static int ad5380_remove(struct device *dev)
 
 	if (!IS_ERR(st->vref_reg)) {
 		regulator_disable(st->vref_reg);
-		regulator_put(st->vref_reg);
 	}
 
-	iio_device_free(indio_dev);
-
 	return 0;
 }
 
-- 
1.7.9.5
