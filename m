Return-Path: <SRS0=mhKp=6U=gmail.com=gehariprasath@kernel.org>
From: Hari Prasath <gehariprasath@gmail.com>
To: lars@metafoo.de
Cc: gehariprasath@gmail.com,
	Hari Prasath <hgujulan@visteon.com>,
	Michael Hennerich <Michael.Hennerich@analog.com>,
	Jonathan Cameron <jic23@kernel.org>,
	Hartmut Knaack <knaack.h@gmx.de>,
	Peter Meerwald-Stadler <pmeerw@pmeerw.net>,
	Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
	linux-iio@vger.kernel.org,
	devel@driverdev.osuosl.org,
	linux-kernel@vger.kernel.org
Subject: [PATCH] staging: iio: adc: add missing of_node references to iio_dev
Date: Mon, 17 Jul 2017 17:43:29 +0530
Message-Id: <20170717121329.24163-1-gehariprasath@gmail.com>
List-ID: <linux-iio@vger.kernel.org>

From: Hari Prasath <hgujulan@visteon.com>

Adding missing indio_dev->dev.of_node references to allow iio consumers
to access the device channels.

Signed-off-by: Hari Prasath <gehariprasath@gmail.com>
---
 drivers/staging/iio/adc/ad7192.c | 1 +
 drivers/staging/iio/adc/ad7780.c | 1 +
 2 files changed, 2 insertions(+)

diff --git a/drivers/staging/iio/adc/ad7192.c b/drivers/staging/iio/adc/ad7192.c
index d11c6de..78308a5 100644
--- a/drivers/staging/iio/adc/ad7192.c
+++ b/drivers/staging/iio/adc/ad7192.c
@@ -668,6 +668,7 @@ static int ad7192_probe(struct spi_device *spi)
 	spi_set_drvdata(spi, indio_dev);
 	st->devid = spi_get_device_id(spi)->driver_data;
 	indio_dev->dev.parent = &spi->dev;
+	indio_dev->dev.of_node = spi->dev.of_node;
 	indio_dev->name = spi_get_device_id(spi)->name;
 	indio_dev->modes = INDIO_DIRECT_MODE;
 
diff --git a/drivers/staging/iio/adc/ad7780.c b/drivers/staging/iio/adc/ad7780.c
index dec3ba6..e38d2ab9 100644
--- a/drivers/staging/iio/adc/ad7780.c
+++ b/drivers/staging/iio/adc/ad7780.c
@@ -195,6 +195,7 @@ static int ad7780_probe(struct spi_device *spi)
 	spi_set_drvdata(spi, indio_dev);
 
 	indio_dev->dev.parent = &spi->dev;
+	indio_dev->dev.of_node = spi->dev.of_node;
 	indio_dev->name = spi_get_device_id(spi)->name;
 	indio_dev->modes = INDIO_DIRECT_MODE;
 	indio_dev->channels = &st->chip_info->channel;
-- 
2.10.0.GIT
