Return-Path: <Michael.Hennerich@analog.com>
From: <michael.hennerich@analog.com>
To: greg@kroah.com
CC: linux-iio@vger.kernel.org, drivers@analog.com, jic23@cam.ac.uk,
        Michael Hennerich <michael.hennerich@analog.com>
Subject: [PATCH] staging: iio: adc: ad7476 more list review feedback by Jonathan Cameron
Date: Mon, 11 Oct 2010 18:05:56 +0200
Message-ID: <1286813156-4607-1-git-send-email-michael.hennerich@analog.com>
MIME-Version: 1.0
Content-Type: text/plain
List-ID: <linux-iio@vger.kernel.org>

From: Michael Hennerich <michael.hennerich@analog.com>

Print in_scale in decimal format.
Kconfig list the names of the parts in full, to ease seraching.
Use st->spi in the call as it is only used the once.

Signed-off-by: Michael Hennerich <michael.hennerich@analog.com>
Acked-by: Jonathan Cameron <jic23@cam.ac.uk>
---
 drivers/staging/iio/adc/Kconfig       |    5 +++--
 drivers/staging/iio/adc/ad7476_core.c |   11 +++--------
 2 files changed, 6 insertions(+), 10 deletions(-)

diff --git a/drivers/staging/iio/adc/Kconfig b/drivers/staging/iio/adc/Kconfig
index 71713ee..81a7d45 100644
--- a/drivers/staging/iio/adc/Kconfig
+++ b/drivers/staging/iio/adc/Kconfig
@@ -51,8 +51,9 @@ config AD7476
 	tristate "Analog Devices AD7475/6/7/8 AD7466/7/8 and AD7495 ADC driver"
 	depends on SPI
 	help
-	  Say yes here to build support for Analog Devices AD7475/6/7/8,
-	  AD7466/7/8 and AD7495 ADC driver.
+	  Say yes here to build support for Analog Devices
+	  AD7475, AD7476, AD7477, AD7478, AD7466, AD7467, AD7468, AD7495
+	  SPI analog to digital convertors (ADC).
 	  If unsure, say N (but it's safe to say "Y").
 
 	  To compile this driver as a module, choose M here: the
diff --git a/drivers/staging/iio/adc/ad7476_core.c b/drivers/staging/iio/adc/ad7476_core.c
index bbd72a6..deb68c8 100644
--- a/drivers/staging/iio/adc/ad7476_core.c
+++ b/drivers/staging/iio/adc/ad7476_core.c
@@ -26,10 +26,9 @@
 
 static int ad7476_scan_direct(struct ad7476_state *st)
 {
-	struct spi_device *spi = st->spi;
 	int ret;
 
-	ret = spi_sync(spi, &st->msg);
+	ret = spi_sync(st->spi, &st->msg);
 	if (ret)
 		return ret;
 
@@ -67,13 +66,9 @@ static ssize_t ad7476_show_scale(struct device *dev,
 	struct iio_dev *dev_info = dev_get_drvdata(dev);
 	struct ad7476_state *st = iio_dev_get_devdata(dev_info);
 	/* Corresponds to Vref / 2^(bits) */
+	unsigned int scale_uv = (st->int_vref_mv * 1000) >> st->chip_info->bits;
 
-	if ((1 << (st->chip_info->bits + 1)) > st->int_vref_mv)
-		return sprintf(buf, "%d/2^%d\n",
-			       st->int_vref_mv, st->chip_info->bits);
-	else
-		return sprintf(buf, "%d\n",
-			       st->int_vref_mv >> st->chip_info->bits);
+	return sprintf(buf, "%d.%d\n", scale_uv / 1000, scale_uv % 1000);
 }
 static IIO_DEVICE_ATTR(in_scale, S_IRUGO, ad7476_show_scale, NULL, 0);
 
-- 
1.6.0.2
