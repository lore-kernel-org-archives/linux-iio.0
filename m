Return-Path: <linux-iio-owner@vger.kernel.org>
Received: from smtp-out-249.synserver.de ([212.40.185.249]:1127 "EHLO
	smtp-out-240.synserver.de" rhost-flags-OK-OK-OK-FAIL)
	by vger.kernel.org with ESMTP id S1751285Ab2BPKrs (ORCPT
	<rfc822;linux-iio@vger.kernel.org>); Thu, 16 Feb 2012 05:47:48 -0500
From: Lars-Peter Clausen <lars@metafoo.de>
To: Jonathan Cameron <jic23@cam.ac.uk>
Cc: linux-iio@vger.kernel.org,
	device-drivers-devel@blackfin.uclinux.org, drivers@analog.com,
	Lars-Peter Clausen <lars@metafoo.de>
Subject: [PATCH 4/5] staging:iio:dac:ad5064: Add AD5666 support
Date: Thu, 16 Feb 2012 11:49:10 +0100
Message-Id: <1329389351-21584-4-git-send-email-lars@metafoo.de>
In-Reply-To: <1329389351-21584-1-git-send-email-lars@metafoo.de>
References: <1329389351-21584-1-git-send-email-lars@metafoo.de>
Sender: linux-iio-owner@vger.kernel.org
List-Id: linux-iio@vger.kernel.org

The AD5666 is similar to the ad5064-1, but has a internal reference voltage.

Signed-off-by: Lars-Peter Clausen <lars@metafoo.de>
---
 drivers/staging/iio/dac/Kconfig  |    6 +++---
 drivers/staging/iio/dac/ad5064.c |   20 ++++++++++++++++++--
 2 files changed, 21 insertions(+), 5 deletions(-)

diff --git a/drivers/staging/iio/dac/Kconfig b/drivers/staging/iio/dac/Kconfig
index f86179c..4d10537 100644
--- a/drivers/staging/iio/dac/Kconfig
+++ b/drivers/staging/iio/dac/Kconfig
@@ -4,11 +4,11 @@
 menu "Digital to analog converters"
 
 config AD5064
-	tristate "Analog Devices AD5064/64-1/44/24, AD5628/48/68 DAC driver"
+	tristate "Analog Devices AD5064/64-1/44/24, AD5628/48/68, AD5666 DAC driver"
 	depends on SPI
 	help
-	  Say yes here to build support for Analog Devices AD5064, AD5064-1,
-	  AD5044, AD5024, AD5628, AD5648, AD5668 Digital to Analog Converter.
+	  Say yes here to build support for Analog Devices AD5064, AD5064-1, AD5044,
+	  AD5024, AD5628, AD5648, AD5666, AD5668 Digital to Analog Converter.
 
 	  To compile this driver as a module, choose M here: the
 	  module will be called ad5064.
diff --git a/drivers/staging/iio/dac/ad5064.c b/drivers/staging/iio/dac/ad5064.c
index 8cf8ca3..2457182 100644
--- a/drivers/staging/iio/dac/ad5064.c
+++ b/drivers/staging/iio/dac/ad5064.c
@@ -1,5 +1,5 @@
 /*
- * AD5064, AD5064-1, AD5044, AD5024, AD5628, AD5648, AD5668
+ * AD5064, AD5064-1, AD5044, AD5024, AD5628, AD5648, AD5666, AD5668
  * Digital to analog converters driver
  *
  * Copyright 2011 Analog Devices Inc.
@@ -103,6 +103,8 @@ enum ad5064_type {
 	ID_AD5648_2,
 	ID_AD5668_1,
 	ID_AD5668_2,
+	ID_AD5666_1,
+	ID_AD5666_2,
 };
 
 static ssize_t ad5064_read_powerdown_mode(struct iio_dev *indio_dev,
@@ -200,6 +202,18 @@ static const struct ad5064_chip_info ad5064_chip_info_tbl[] = {
 		.channels = ad5044_channels,
 		.num_channels = 8,
 	},
+	[ID_AD5666_1] = {
+		.shared_vref = true,
+		.internal_vref = 2500000,
+		.channels = ad5064_channels,
+		.num_channels = 4,
+	},
+	[ID_AD5666_2] = {
+		.shared_vref = true,
+		.internal_vref = 5000000,
+		.channels = ad5064_channels,
+		.num_channels = 4,
+	},
 	[ID_AD5668_1] = {
 		.shared_vref = true,
 		.internal_vref = 2500000,
@@ -509,6 +523,8 @@ static const struct spi_device_id ad5064_id[] = {
 	{"ad5628-2", ID_AD5628_2},
 	{"ad5648-1", ID_AD5648_1},
 	{"ad5648-2", ID_AD5648_2},
+	{"ad5666-1", ID_AD5666_1},
+	{"ad5666-2", ID_AD5666_2},
 	{"ad5668-1", ID_AD5668_1},
 	{"ad5668-2", ID_AD5668_2},
 	{"ad5668-3", ID_AD5668_2}, /* similar enough to ad5668-2 */
@@ -528,5 +544,5 @@ static struct spi_driver ad5064_driver = {
 module_spi_driver(ad5064_driver);
 
 MODULE_AUTHOR("Lars-Peter Clausen <lars@metafoo.de>");
-MODULE_DESCRIPTION("Analog Devices AD5064/64-1/44/24, AD5628/48/68 DAC");
+MODULE_DESCRIPTION("Analog Devices AD5064/64-1/44/24, AD5628/48/68, AD5666 DAC");
 MODULE_LICENSE("GPL v2");
-- 
1.7.9

