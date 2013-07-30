Return-Path: <sachin.kamat@linaro.org>
From: Sachin Kamat <sachin.kamat@linaro.org>
To: linux-iio@vger.kernel.org
Cc: jic23@cam.ac.uk,
	jic23@kernel.org,
	sachin.kamat@linaro.org,
	Michael Hennerich <hennerich@blackfin.uclinux.org>
Subject: [PATCH 1/3] iio: amplifiers: ad8366: Use devm_* APIs
Date: Tue, 30 Jul 2013 11:54:21 +0530
Message-Id: <1375165463-23453-1-git-send-email-sachin.kamat@linaro.org>
List-ID: <linux-iio@vger.kernel.org>

devm_* APIs are device managed and make code simpler.

Signed-off-by: Sachin Kamat <sachin.kamat@linaro.org>
Cc: Michael Hennerich <hennerich@blackfin.uclinux.org>
---
This series compile tested on togreg branch of
git://git.kernel.org/pub/scm/linux/kernel/git/jic23/iio.git
---
 drivers/iio/amplifiers/ad8366.c |   13 +++----------
 1 file changed, 3 insertions(+), 10 deletions(-)

diff --git a/drivers/iio/amplifiers/ad8366.c b/drivers/iio/amplifiers/ad8366.c
index d354554..d0a79a4 100644
--- a/drivers/iio/amplifiers/ad8366.c
+++ b/drivers/iio/amplifiers/ad8366.c
@@ -139,17 +139,17 @@ static int ad8366_probe(struct spi_device *spi)
 	struct ad8366_state *st;
 	int ret;
 
-	indio_dev = iio_device_alloc(sizeof(*st));
+	indio_dev = devm_iio_device_alloc(&spi->dev, sizeof(*st));
 	if (indio_dev == NULL)
 		return -ENOMEM;
 
 	st = iio_priv(indio_dev);
 
-	st->reg = regulator_get(&spi->dev, "vcc");
+	st->reg = devm_regulator_get(&spi->dev, "vcc");
 	if (!IS_ERR(st->reg)) {
 		ret = regulator_enable(st->reg);
 		if (ret)
-			goto error_put_reg;
+			return ret;
 	}
 
 	spi_set_drvdata(spi, indio_dev);
@@ -173,11 +173,6 @@ static int ad8366_probe(struct spi_device *spi)
 error_disable_reg:
 	if (!IS_ERR(st->reg))
 		regulator_disable(st->reg);
-error_put_reg:
-	if (!IS_ERR(st->reg))
-		regulator_put(st->reg);
-
-	iio_device_free(indio_dev);
 
 	return ret;
 }
@@ -195,8 +190,6 @@ static int ad8366_remove(struct spi_device *spi)
 		regulator_put(reg);
 	}
 
-	iio_device_free(indio_dev);
-
 	return 0;
 }
 
-- 
1.7.9.5
