Return-Path: <himangi774@gmail.com>
Date: Sun, 3 Aug 2014 15:30:48 +0530
From: Himangi Saraogi <himangi774@gmail.com>
To: Jonathan Cameron <jic23@kernel.org>,
	Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
	linux-iio@vger.kernel.org, devel@driverdev.osuosl.org,
	linux-kernel@vger.kernel.org
Cc: Julia Lawall <julia.lawall@lip6.fr>
Subject: [PATCH] staging: iio: ad9951: Use devm_iio_device_register
Message-ID: <20140803100048.GA6936@himangi-Dell>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
List-ID: <linux-iio@vger.kernel.org>

This patch introduces the use of devm_iio_device_register and does away
with the unregister in the remove function. The remove function is no
longer required and is completely removed.

Signed-off-by: Himangi Saraogi <himangi774@gmail.com>
Acked-by: Julia Lawall <julia.lawall@lip6.fr>
---
 drivers/staging/iio/frequency/ad9951.c | 10 +---------
 1 file changed, 1 insertion(+), 9 deletions(-)

diff --git a/drivers/staging/iio/frequency/ad9951.c b/drivers/staging/iio/frequency/ad9951.c
index 5e8990a..d465db0 100644
--- a/drivers/staging/iio/frequency/ad9951.c
+++ b/drivers/staging/iio/frequency/ad9951.c
@@ -175,7 +175,7 @@ static int ad9951_probe(struct spi_device *spi)
 	idev->info = &ad9951_info;
 	idev->modes = INDIO_DIRECT_MODE;
 
-	ret = iio_device_register(idev);
+	ret = devm_iio_device_register(&spi->dev, idev);
 	if (ret)
 		return ret;
 	spi->max_speed_hz = 2000000;
@@ -186,20 +186,12 @@ static int ad9951_probe(struct spi_device *spi)
 	return 0;
 }
 
-static int ad9951_remove(struct spi_device *spi)
-{
-	iio_device_unregister(spi_get_drvdata(spi));
-
-	return 0;
-}
-
 static struct spi_driver ad9951_driver = {
 	.driver = {
 		.name = DRV_NAME,
 		.owner = THIS_MODULE,
 	},
 	.probe = ad9951_probe,
-	.remove = ad9951_remove,
 };
 module_spi_driver(ad9951_driver);
 
-- 
1.9.1
