Return-Path: <sachin.kamat@linaro.org>
From: Sachin Kamat <sachin.kamat@linaro.org>
To: linux-iio@vger.kernel.org
Cc: jic23@kernel.org,
	lars@metafoo.de,
	sachin.kamat@linaro.org
Subject: [PATCH 8/8] iio: amplifiers: ad8366: Use devm_iio_device_register
Date: Tue, 24 Sep 2013 17:35:38 +0530
Message-Id: <1380024338-30204-9-git-send-email-sachin.kamat@linaro.org>
In-Reply-To: <1380024338-30204-1-git-send-email-sachin.kamat@linaro.org>
References: <1380024338-30204-1-git-send-email-sachin.kamat@linaro.org>
List-ID: <linux-iio@vger.kernel.org>

devm_iio_device_register simplifies the code.

Signed-off-by: Sachin Kamat <sachin.kamat@linaro.org>
---
 drivers/iio/amplifiers/ad8366.c |    4 +---
 1 file changed, 1 insertion(+), 3 deletions(-)

diff --git a/drivers/iio/amplifiers/ad8366.c b/drivers/iio/amplifiers/ad8366.c
index ba6f6a9..6af459c 100644
--- a/drivers/iio/amplifiers/ad8366.c
+++ b/drivers/iio/amplifiers/ad8366.c
@@ -162,7 +162,7 @@ static int ad8366_probe(struct spi_device *spi)
 	indio_dev->channels = ad8366_channels;
 	indio_dev->num_channels = ARRAY_SIZE(ad8366_channels);
 
-	ret = iio_device_register(indio_dev);
+	ret = devm_iio_device_register(&spi->dev, indio_dev);
 	if (ret)
 		goto error_disable_reg;
 
@@ -183,8 +183,6 @@ static int ad8366_remove(struct spi_device *spi)
 	struct ad8366_state *st = iio_priv(indio_dev);
 	struct regulator *reg = st->reg;
 
-	iio_device_unregister(indio_dev);
-
 	if (!IS_ERR(reg))
 		regulator_disable(reg);
 
-- 
1.7.9.5
