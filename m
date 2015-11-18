Return-Path: <linux-iio-owner@vger.kernel.org>
Received: from mail-bn1on0094.outbound.protection.outlook.com ([157.56.110.94]:58176
	"EHLO na01-bn1-obe.outbound.protection.outlook.com"
	rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
	id S932936AbbKRObX (ORCPT <rfc822;linux-iio@vger.kernel.org>);
	Wed, 18 Nov 2015 09:31:23 -0500
From: Dragos Bogdan <dragos.bogdan@analog.com>
To: Jonathan Cameron <jic23@kernel.org>
CC: Hartmut Knaack <knaack.h@gmx.de>,
	Peter Meerwald <pmeerw@pmeerw.net>,
	Lars-Peter Clausen <lars@metafoo.de>,
	Michael Hennerich <Michael.Hennerich@analog.com>,
	<linux-iio@vger.kernel.org>,
	Dragos Bogdan <dragos.bogdan@analog.com>
Subject: [PATCH] staging:iio:ad7780: Remove the ad7780_platform_data
Date: Wed, 18 Nov 2015 16:16:34 +0200
Message-ID: <1447856194-26450-1-git-send-email-dragos.bogdan@analog.com>
MIME-Version: 1.0
Content-Type: text/plain
Sender: linux-iio-owner@vger.kernel.org
List-Id: linux-iio@vger.kernel.org

The ad7780_platform_data contains just the reference voltage information.
Since the preferred way of specifying this information is using the Linux
regulator framework and the ad7780 platform_data is not used by other
users, it can be completely removed.

Signed-off-by: Dragos Bogdan <dragos.bogdan@analog.com>
---
This patch depends on patch "staging:iio:ad7780: Switch to the gpio
descriptor interface"
---
 drivers/staging/iio/adc/ad7780.c |  9 ++-------
 drivers/staging/iio/adc/ad7780.h | 29 -----------------------------
 2 files changed, 2 insertions(+), 36 deletions(-)
 delete mode 100644 drivers/staging/iio/adc/ad7780.h

diff --git a/drivers/staging/iio/adc/ad7780.c b/drivers/staging/iio/adc/ad7780.c
index 98b5fc4..498e86b 100644
--- a/drivers/staging/iio/adc/ad7780.c
+++ b/drivers/staging/iio/adc/ad7780.c
@@ -22,8 +22,6 @@
 #include <linux/iio/sysfs.h>
 #include <linux/iio/adc/ad_sigma_delta.h>
 
-#include "ad7780.h"
-
 #define AD7780_RDY	BIT(7)
 #define AD7780_FILTER	BIT(6)
 #define AD7780_ERR	BIT(5)
@@ -162,7 +160,6 @@ static const struct iio_info ad7780_info = {
 
 static int ad7780_probe(struct spi_device *spi)
 {
-	struct ad7780_platform_data *pdata = spi->dev.platform_data;
 	struct ad7780_state *st;
 	struct iio_dev *indio_dev;
 	int ret, voltage_uv = 0;
@@ -188,12 +185,10 @@ static int ad7780_probe(struct spi_device *spi)
 	st->chip_info =
 		&ad7780_chip_info_tbl[spi_get_device_id(spi)->driver_data];
 
-	if (pdata && pdata->vref_mv)
-		st->int_vref_mv = pdata->vref_mv;
-	else if (voltage_uv)
+	if (voltage_uv)
 		st->int_vref_mv = voltage_uv / 1000;
 	else
-		dev_warn(&spi->dev, "reference voltage unspecified\n");
+		dev_warn(&spi->dev, "Reference voltage unspecified\n");
 
 	spi_set_drvdata(spi, indio_dev);
 
diff --git a/drivers/staging/iio/adc/ad7780.h b/drivers/staging/iio/adc/ad7780.h
deleted file mode 100644
index 46f61c9..0000000
--- a/drivers/staging/iio/adc/ad7780.h
+++ /dev/null
@@ -1,29 +0,0 @@
-/*
- * AD7780/AD7781 SPI ADC driver
- *
- * Copyright 2011 Analog Devices Inc.
- *
- * Licensed under the GPL-2.
- */
-#ifndef IIO_ADC_AD7780_H_
-#define IIO_ADC_AD7780_H_
-
-/*
- * TODO: struct ad7780_platform_data needs to go into include/linux/iio
- */
-
-/* NOTE:
- * The AD7780 doesn't feature a dedicated SPI chip select, in addition it
- * features a dual use data out ready DOUT/RDY output.
- * In order to avoid contentions on the SPI bus, it's therefore necessary
- * to use spi bus locking combined with a dedicated GPIO to control the
- * power down reset signal of the AD7780.
- *
- * The DOUT/RDY output must also be wired to an interrupt capable GPIO.
- */
-
-struct ad7780_platform_data {
-	u16				vref_mv;
-};
-
-#endif /* IIO_ADC_AD7780_H_ */
-- 
2.1.4

