Return-Path: <linux-iio-owner@vger.kernel.org>
Received: from mail-pg0-f66.google.com ([74.125.83.66]:33020 "EHLO
        mail-pg0-f66.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1751281AbdGQMfO (ORCPT
        <rfc822;linux-iio@vger.kernel.org>); Mon, 17 Jul 2017 08:35:14 -0400
From: Hari Prasath <gehariprasath@gmail.com>
To: lars@metafoo.de
Cc: gehariprasath@gmail.com,
        Michael Hennerich <Michael.Hennerich@analog.com>,
        Jonathan Cameron <jic23@kernel.org>,
        Hartmut Knaack <knaack.h@gmx.de>,
        Peter Meerwald-Stadler <pmeerw@pmeerw.net>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        linux-iio@vger.kernel.org, devel@driverdev.osuosl.org,
        linux-kernel@vger.kernel.org
Subject: [PATCHv2] staging: iio: adc: add missing of_node references to iio_dev
Date: Mon, 17 Jul 2017 18:04:26 +0530
Message-Id: <20170717123426.25095-1-gehariprasath@gmail.com>
Sender: linux-iio-owner@vger.kernel.org
List-Id: linux-iio@vger.kernel.org

Adding missing indio_dev->dev.of_node references to allow iio consumers
to access the device channels.

Signed-off-by: Hari Prasath <gehariprasath@gmail.com>
---
	v2: Wrong from mail ID in first version of patch
---
 drivers/staging/iio/adc/ad7192.c | 1 -
 drivers/staging/iio/adc/ad7780.c | 1 -
 2 files changed, 2 deletions(-)

diff --git a/drivers/staging/iio/adc/ad7192.c b/drivers/staging/iio/adc/ad7192.c
index 78308a5..d11c6de 100644
--- a/drivers/staging/iio/adc/ad7192.c
+++ b/drivers/staging/iio/adc/ad7192.c
@@ -668,7 +668,6 @@ static int ad7192_probe(struct spi_device *spi)
 	spi_set_drvdata(spi, indio_dev);
 	st->devid = spi_get_device_id(spi)->driver_data;
 	indio_dev->dev.parent = &spi->dev;
-	indio_dev->dev.of_node = spi->dev.of_node;
 	indio_dev->name = spi_get_device_id(spi)->name;
 	indio_dev->modes = INDIO_DIRECT_MODE;
 
diff --git a/drivers/staging/iio/adc/ad7780.c b/drivers/staging/iio/adc/ad7780.c
index e38d2ab9..dec3ba6 100644
--- a/drivers/staging/iio/adc/ad7780.c
+++ b/drivers/staging/iio/adc/ad7780.c
@@ -195,7 +195,6 @@ static int ad7780_probe(struct spi_device *spi)
 	spi_set_drvdata(spi, indio_dev);
 
 	indio_dev->dev.parent = &spi->dev;
-	indio_dev->dev.of_node = spi->dev.of_node;
 	indio_dev->name = spi_get_device_id(spi)->name;
 	indio_dev->modes = INDIO_DIRECT_MODE;
 	indio_dev->channels = &st->chip_info->channel;
-- 
2.10.0.GIT

