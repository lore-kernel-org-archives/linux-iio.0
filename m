Return-Path: <linux-iio-owner@vger.kernel.org>
Received: from smtp-out-085.synserver.de ([212.40.185.85]:1076 "EHLO
	smtp-out-078.synserver.de" rhost-flags-OK-OK-OK-FAIL)
	by vger.kernel.org with ESMTP id S1753993Ab2DWRt0 (ORCPT
	<rfc822;linux-iio@vger.kernel.org>); Mon, 23 Apr 2012 13:49:26 -0400
From: Lars-Peter Clausen <lars@metafoo.de>
To: Jonathan Cameron <jic23@cam.ac.uk>
Cc: linux-iio@vger.kernel.org,
	device-drivers-devel@blackfin.uclinux.org, drivers@analog.com,
	Lars-Peter Clausen <lars@metafoo.de>
Subject: [PATCH 8/8] staging:iio:dac:ad5446: Add support for the AD5662
Date: Mon, 23 Apr 2012 19:51:37 +0200
Message-Id: <1335203497-11041-8-git-send-email-lars@metafoo.de>
In-Reply-To: <1335203497-11041-1-git-send-email-lars@metafoo.de>
References: <1335203497-11041-1-git-send-email-lars@metafoo.de>
Sender: linux-iio-owner@vger.kernel.org
List-Id: linux-iio@vger.kernel.org

The AD5662 is compatible to the AD5660, but uses an external reference instead
of an internal.

Signed-off-by: Lars-Peter Clausen <lars@metafoo.de>
---
 drivers/staging/iio/dac/Kconfig  |    2 +-
 drivers/staging/iio/dac/ad5446.c |    5 +++++
 drivers/staging/iio/dac/ad5446.h |    1 +
 3 files changed, 7 insertions(+), 1 deletion(-)

diff --git a/drivers/staging/iio/dac/Kconfig b/drivers/staging/iio/dac/Kconfig
index a57803a..1a2be98 100644
--- a/drivers/staging/iio/dac/Kconfig
+++ b/drivers/staging/iio/dac/Kconfig
@@ -56,7 +56,7 @@ config AD5624R_SPI
 	  AD5664R converters (DAC). This driver uses the common SPI interface.
 
 config AD5446
-	tristate "Analog Devices AD5444/6, AD5620/40/60 and AD5542A/12A DAC SPI driver"
+	tristate "Analog Devices AD5444/6, AD5620/40/60/62 and AD5542A/12A DAC SPI driver"
 	depends on SPI
 	help
 	  Say yes here to build support for Analog Devices AD5444, AD5446,
diff --git a/drivers/staging/iio/dac/ad5446.c b/drivers/staging/iio/dac/ad5446.c
index 90461b2..bcb849b 100644
--- a/drivers/staging/iio/dac/ad5446.c
+++ b/drivers/staging/iio/dac/ad5446.c
@@ -216,6 +216,10 @@ static const struct ad5446_chip_info ad5446_chip_info_tbl[] = {
 		.int_vref_mv = 1250,
 		.store_sample = ad5660_store_sample,
 	},
+	[ID_AD5662] = {
+		.channel = AD5446_CHANNEL(16, 16, 0),
+		.store_sample = ad5660_store_sample,
+	},
 };
 
 static int ad5446_read_raw(struct iio_dev *indio_dev,
@@ -375,6 +379,7 @@ static const struct spi_device_id ad5446_id[] = {
 	{"ad5640-1250", ID_AD5640_1250},
 	{"ad5660-2500", ID_AD5660_2500},
 	{"ad5660-1250", ID_AD5660_1250},
+	{"ad5662", ID_AD5662},
 	{}
 };
 MODULE_DEVICE_TABLE(spi, ad5446_id);
diff --git a/drivers/staging/iio/dac/ad5446.h b/drivers/staging/iio/dac/ad5446.h
index 264df1e..071ce39 100644
--- a/drivers/staging/iio/dac/ad5446.h
+++ b/drivers/staging/iio/dac/ad5446.h
@@ -94,6 +94,7 @@ enum ad5446_supported_device_ids {
 	ID_AD5640_1250,
 	ID_AD5660_2500,
 	ID_AD5660_1250,
+	ID_AD5662,
 };
 
 #endif /* IIO_DAC_AD5446_H_ */
-- 
1.7.9.5

