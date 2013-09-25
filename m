Return-Path: <sachin.kamat@linaro.org>
From: Sachin Kamat <sachin.kamat@linaro.org>
To: linux-iio@vger.kernel.org
Cc: jic23@kernel.org,
	lars@metafoo.de,
	sachin.kamat@linaro.org
Subject: [PATCH 02/32] iio: accel: kxsd9: Use devm_iio_device_register
Date: Wed, 25 Sep 2013 16:19:38 +0530
Message-Id: <1380106208-6948-3-git-send-email-sachin.kamat@linaro.org>
In-Reply-To: <1380106208-6948-1-git-send-email-sachin.kamat@linaro.org>
References: <1380106208-6948-1-git-send-email-sachin.kamat@linaro.org>
List-ID: <linux-iio@vger.kernel.org>

devm_iio_device_register simplifies the code.

Signed-off-by: Sachin Kamat <sachin.kamat@linaro.org>
---
 drivers/iio/accel/kxsd9.c |   10 +---------
 1 file changed, 1 insertion(+), 9 deletions(-)

diff --git a/drivers/iio/accel/kxsd9.c b/drivers/iio/accel/kxsd9.c
index 709c132..3048686 100644
--- a/drivers/iio/accel/kxsd9.c
+++ b/drivers/iio/accel/kxsd9.c
@@ -244,20 +244,13 @@ static int kxsd9_probe(struct spi_device *spi)
 	spi_setup(spi);
 	kxsd9_power_up(st);
 
-	ret = iio_device_register(indio_dev);
+	ret = devm_iio_device_register(&spi->dev, indio_dev);
 	if (ret)
 		return ret;
 
 	return 0;
 }
 
-static int kxsd9_remove(struct spi_device *spi)
-{
-	iio_device_unregister(spi_get_drvdata(spi));
-
-	return 0;
-}
-
 static const struct spi_device_id kxsd9_id[] = {
 	{"kxsd9", 0},
 	{ },
@@ -270,7 +263,6 @@ static struct spi_driver kxsd9_driver = {
 		.owner = THIS_MODULE,
 	},
 	.probe = kxsd9_probe,
-	.remove = kxsd9_remove,
 	.id_table = kxsd9_id,
 };
 module_spi_driver(kxsd9_driver);
-- 
1.7.9.5
