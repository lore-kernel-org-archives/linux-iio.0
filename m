Return-Path: <sachin.kamat@linaro.org>
From: Sachin Kamat <sachin.kamat@linaro.org>
To: linux-iio@vger.kernel.org
Cc: jic23@kernel.org,
	lars@metafoo.de,
	sachin.kamat@linaro.org
Subject: [PATCH 30/32] staging: iio: ad2s1200: Use devm_iio_device_register
Date: Wed, 25 Sep 2013 16:20:06 +0530
Message-Id: <1380106208-6948-31-git-send-email-sachin.kamat@linaro.org>
In-Reply-To: <1380106208-6948-1-git-send-email-sachin.kamat@linaro.org>
References: <1380106208-6948-1-git-send-email-sachin.kamat@linaro.org>
List-ID: <linux-iio@vger.kernel.org>

devm_iio_device_register simplifies the code.

Signed-off-by: Sachin Kamat <sachin.kamat@linaro.org>
---
 drivers/staging/iio/resolver/ad2s1200.c |   10 +---------
 1 file changed, 1 insertion(+), 9 deletions(-)

diff --git a/drivers/staging/iio/resolver/ad2s1200.c b/drivers/staging/iio/resolver/ad2s1200.c
index 62d3017..36eedd8 100644
--- a/drivers/staging/iio/resolver/ad2s1200.c
+++ b/drivers/staging/iio/resolver/ad2s1200.c
@@ -131,7 +131,7 @@ static int ad2s1200_probe(struct spi_device *spi)
 	indio_dev->num_channels = ARRAY_SIZE(ad2s1200_channels);
 	indio_dev->name = spi_get_device_id(spi)->name;
 
-	ret = iio_device_register(indio_dev);
+	ret = devm_iio_device_register(&spi->dev, indio_dev);
 	if (ret)
 		return ret;
 
@@ -142,13 +142,6 @@ static int ad2s1200_probe(struct spi_device *spi)
 	return 0;
 }
 
-static int ad2s1200_remove(struct spi_device *spi)
-{
-	iio_device_unregister(spi_get_drvdata(spi));
-
-	return 0;
-}
-
 static const struct spi_device_id ad2s1200_id[] = {
 	{ "ad2s1200" },
 	{ "ad2s1205" },
@@ -162,7 +155,6 @@ static struct spi_driver ad2s1200_driver = {
 		.owner = THIS_MODULE,
 	},
 	.probe = ad2s1200_probe,
-	.remove = ad2s1200_remove,
 	.id_table = ad2s1200_id,
 };
 module_spi_driver(ad2s1200_driver);
-- 
1.7.9.5
