Return-Path: <sachin.kamat@linaro.org>
From: Sachin Kamat <sachin.kamat@linaro.org>
To: linux-iio@vger.kernel.org
Cc: jic23@kernel.org,
	lars@metafoo.de,
	sachin.kamat@linaro.org
Subject: [PATCH 3/8] iio: adc: mcp320x: Use devm_iio_device_register
Date: Tue, 24 Sep 2013 17:35:33 +0530
Message-Id: <1380024338-30204-4-git-send-email-sachin.kamat@linaro.org>
In-Reply-To: <1380024338-30204-1-git-send-email-sachin.kamat@linaro.org>
References: <1380024338-30204-1-git-send-email-sachin.kamat@linaro.org>
List-ID: <linux-iio@vger.kernel.org>

devm_iio_device_register simplifies the code.

Signed-off-by: Sachin Kamat <sachin.kamat@linaro.org>
---
 drivers/iio/adc/mcp320x.c |    3 +--
 1 file changed, 1 insertion(+), 2 deletions(-)

diff --git a/drivers/iio/adc/mcp320x.c b/drivers/iio/adc/mcp320x.c
index 28a086e..5333558 100644
--- a/drivers/iio/adc/mcp320x.c
+++ b/drivers/iio/adc/mcp320x.c
@@ -203,7 +203,7 @@ static int mcp320x_probe(struct spi_device *spi)
 
 	mutex_init(&adc->lock);
 
-	ret = iio_device_register(indio_dev);
+	ret = devm_iio_device_register(&spi->dev, indio_dev);
 	if (ret < 0)
 		goto reg_disable;
 
@@ -220,7 +220,6 @@ static int mcp320x_remove(struct spi_device *spi)
 	struct iio_dev *indio_dev = spi_get_drvdata(spi);
 	struct mcp320x *adc = iio_priv(indio_dev);
 
-	iio_device_unregister(indio_dev);
 	regulator_disable(adc->reg);
 
 	return 0;
-- 
1.7.9.5
