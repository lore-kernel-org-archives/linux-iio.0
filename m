Return-Path: <linux-iio-owner@vger.kernel.org>
Received: from smtp-out-249.synserver.de ([212.40.185.249]:1061 "EHLO
	smtp-out-240.synserver.de" rhost-flags-OK-OK-OK-FAIL)
	by vger.kernel.org with ESMTP id S1751285Ab2BPKrt (ORCPT
	<rfc822;linux-iio@vger.kernel.org>); Thu, 16 Feb 2012 05:47:49 -0500
From: Lars-Peter Clausen <lars@metafoo.de>
To: Jonathan Cameron <jic23@cam.ac.uk>
Cc: linux-iio@vger.kernel.org,
	device-drivers-devel@blackfin.uclinux.org, drivers@analog.com,
	Lars-Peter Clausen <lars@metafoo.de>
Subject: [PATCH 5/5] staging:iio:dac:ad5064: Add AD5025/AD5045/AD5065 support
Date: Thu, 16 Feb 2012 11:49:11 +0100
Message-Id: <1329389351-21584-5-git-send-email-lars@metafoo.de>
In-Reply-To: <1329389351-21584-1-git-send-email-lars@metafoo.de>
References: <1329389351-21584-1-git-send-email-lars@metafoo.de>
Sender: linux-iio-owner@vger.kernel.org
List-Id: linux-iio@vger.kernel.org

The AD5025/AD5045/AD5065 are identical to the AD5024/AD5044/AD5064 excpet that
they have 2 instead of 4 DAC channels.

Signed-off-by: Lars-Peter Clausen <lars@metafoo.de>
---
 drivers/staging/iio/dac/Kconfig  |    7 ++++---
 drivers/staging/iio/dac/ad5064.c |   27 ++++++++++++++++++++++++---
 2 files changed, 28 insertions(+), 6 deletions(-)

diff --git a/drivers/staging/iio/dac/Kconfig b/drivers/staging/iio/dac/Kconfig
index 4d10537..40ab599 100644
--- a/drivers/staging/iio/dac/Kconfig
+++ b/drivers/staging/iio/dac/Kconfig
@@ -4,11 +4,12 @@
 menu "Digital to analog converters"
 
 config AD5064
-	tristate "Analog Devices AD5064/64-1/44/24, AD5628/48/68, AD5666 DAC driver"
+	tristate "Analog Devices AD5064/64-1/65/44/45/24/25, AD5628/48/68, AD5666 DAC driver"
 	depends on SPI
 	help
-	  Say yes here to build support for Analog Devices AD5064, AD5064-1, AD5044,
-	  AD5024, AD5628, AD5648, AD5666, AD5668 Digital to Analog Converter.
+	  Say yes here to build support for Analog Devices AD5024, AD5025, AD5044,
+	  AD5045, AD5064, AD5064-1, AD5065, AD5628, AD5648, AD5666, AD5668 Digital
+	  to Analog Converter.
 
 	  To compile this driver as a module, choose M here: the
 	  module will be called ad5064.
diff --git a/drivers/staging/iio/dac/ad5064.c b/drivers/staging/iio/dac/ad5064.c
index 2457182..65a9128 100644
--- a/drivers/staging/iio/dac/ad5064.c
+++ b/drivers/staging/iio/dac/ad5064.c
@@ -1,6 +1,6 @@
 /*
- * AD5064, AD5064-1, AD5044, AD5024, AD5628, AD5648, AD5666, AD5668
- * Digital to analog converters driver
+ * AD5024, AD5025, AD5044, AD5045, AD5064, AD5064-1, AD5065, AD5628, AD5648,
+ * AD5666, AD5668 Digital to analog converters driver
  *
  * Copyright 2011 Analog Devices Inc.
  *
@@ -94,9 +94,12 @@ struct ad5064_state {
 
 enum ad5064_type {
 	ID_AD5024,
+	ID_AD5025,
 	ID_AD5044,
+	ID_AD5045,
 	ID_AD5064,
 	ID_AD5064_1,
+	ID_AD5065,
 	ID_AD5628_1,
 	ID_AD5628_2,
 	ID_AD5648_1,
@@ -163,16 +166,31 @@ static const struct ad5064_chip_info ad5064_chip_info_tbl[] = {
 		.channels = ad5024_channels,
 		.num_channels = 4,
 	},
+	[ID_AD5025] = {
+		.shared_vref = false,
+		.channels = ad5024_channels,
+		.num_channels = 2,
+	},
 	[ID_AD5044] = {
 		.shared_vref = false,
 		.channels = ad5044_channels,
 		.num_channels = 4,
 	},
+	[ID_AD5045] = {
+		.shared_vref = false,
+		.channels = ad5044_channels,
+		.num_channels = 2,
+	},
 	[ID_AD5064] = {
 		.shared_vref = false,
 		.channels = ad5064_channels,
 		.num_channels = 4,
 	},
+	[ID_AD5065] = {
+		.shared_vref = false,
+		.channels = ad5064_channels,
+		.num_channels = 2,
+	},
 	[ID_AD5064_1] = {
 		.shared_vref = true,
 		.channels = ad5064_channels,
@@ -516,8 +534,11 @@ static int __devexit ad5064_remove(struct spi_device *spi)
 
 static const struct spi_device_id ad5064_id[] = {
 	{"ad5024", ID_AD5024},
+	{"ad5025", ID_AD5025},
 	{"ad5044", ID_AD5044},
+	{"ad5045", ID_AD5045},
 	{"ad5064", ID_AD5064},
+	{"ad5065", ID_AD5065},
 	{"ad5064-1", ID_AD5064_1},
 	{"ad5628-1", ID_AD5628_1},
 	{"ad5628-2", ID_AD5628_2},
@@ -544,5 +565,5 @@ static struct spi_driver ad5064_driver = {
 module_spi_driver(ad5064_driver);
 
 MODULE_AUTHOR("Lars-Peter Clausen <lars@metafoo.de>");
-MODULE_DESCRIPTION("Analog Devices AD5064/64-1/44/24, AD5628/48/68, AD5666 DAC");
+MODULE_DESCRIPTION("Analog Devices AD5024/25/44/45/64/64-1/65, AD5628/48/68, AD5666 DAC");
 MODULE_LICENSE("GPL v2");
-- 
1.7.9

