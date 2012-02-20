Return-Path: <linux-iio-owner@vger.kernel.org>
Received: from smtp-out-025.synserver.de ([212.40.185.25]:1069 "EHLO
	smtp-out-025.synserver.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752591Ab2BTLyA (ORCPT
	<rfc822;linux-iio@vger.kernel.org>); Mon, 20 Feb 2012 06:54:00 -0500
From: Lars-Peter Clausen <lars@metafoo.de>
To: Jonathan Cameron <jic23@cam.ac.uk>
Cc: linux-iio@vger.kernel.org,
	device-drivers-devel@blackfin.uclinux.org, drivers@analog.com,
	Lars-Peter Clausen <lars@metafoo.de>
Subject: [PATCH v2 6/6] staging:iio:dac:ad5064: Add AD5666 support
Date: Mon, 20 Feb 2012 12:55:20 +0100
Message-Id: <1329738920-14281-6-git-send-email-lars@metafoo.de>
In-Reply-To: <1329738920-14281-1-git-send-email-lars@metafoo.de>
References: <1329738920-14281-1-git-send-email-lars@metafoo.de>
Sender: linux-iio-owner@vger.kernel.org
List-Id: linux-iio@vger.kernel.org

The AD5666 is identical to the ad5064-1, except has a internal reference
voltage.

Signed-off-by: Lars-Peter Clausen <lars@metafoo.de>
Acked-by: Jonathan Cameron <jic23@kernel.org>
---
 drivers/staging/iio/dac/Kconfig  |    6 +++---
 drivers/staging/iio/dac/ad5064.c |   20 ++++++++++++++++++--
 2 files changed, 21 insertions(+), 5 deletions(-)

diff --git a/drivers/staging/iio/dac/Kconfig b/drivers/staging/iio/dac/Kconfig
index ab8516d..a57803a 100644
--- a/drivers/staging/iio/dac/Kconfig
+++ b/drivers/staging/iio/dac/Kconfig
@@ -4,12 +4,12 @@
 menu "Digital to analog converters"
 
 config AD5064
-	tristate "Analog Devices AD5064/64-1/65/44/45/24/25, AD5628/48/68 DAC driver"
+	tristate "Analog Devices AD5064/64-1/65/44/45/24/25, AD5628/48/66/68 DAC driver"
 	depends on SPI
 	help
 	  Say yes here to build support for Analog Devices AD5024, AD5025, AD5044,
-	  AD5045, AD5064, AD5064-1, AD5065, AD5628, AD5648, AD5668 Digital to Analog
-	  Converter.
+	  AD5045, AD5064, AD5064-1, AD5065, AD5628, AD5648, AD5666, AD5668 Digital
+	  to Analog Converter.
 
 	  To compile this driver as a module, choose M here: the
 	  module will be called ad5064.
diff --git a/drivers/staging/iio/dac/ad5064.c b/drivers/staging/iio/dac/ad5064.c
index 6dab064..06b1627 100644
--- a/drivers/staging/iio/dac/ad5064.c
+++ b/drivers/staging/iio/dac/ad5064.c
@@ -1,6 +1,6 @@
 /*
  * AD5024, AD5025, AD5044, AD5045, AD5064, AD5064-1, AD5065, AD5628, AD5648,
- * AD5668 Digital to analog converters driver
+ * AD5666, AD5668 Digital to analog converters driver
  *
  * Copyright 2011 Analog Devices Inc.
  *
@@ -104,6 +104,8 @@ enum ad5064_type {
 	ID_AD5628_2,
 	ID_AD5648_1,
 	ID_AD5648_2,
+	ID_AD5666_1,
+	ID_AD5666_2,
 	ID_AD5668_1,
 	ID_AD5668_2,
 };
@@ -388,6 +390,18 @@ static const struct ad5064_chip_info ad5064_chip_info_tbl[] = {
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
@@ -520,6 +534,8 @@ static const struct spi_device_id ad5064_id[] = {
 	{"ad5628-2", ID_AD5628_2},
 	{"ad5648-1", ID_AD5648_1},
 	{"ad5648-2", ID_AD5648_2},
+	{"ad5666-1", ID_AD5666_1},
+	{"ad5666-2", ID_AD5666_2},
 	{"ad5668-1", ID_AD5668_1},
 	{"ad5668-2", ID_AD5668_2},
 	{"ad5668-3", ID_AD5668_2}, /* similar enough to ad5668-2 */
@@ -539,5 +555,5 @@ static struct spi_driver ad5064_driver = {
 module_spi_driver(ad5064_driver);
 
 MODULE_AUTHOR("Lars-Peter Clausen <lars@metafoo.de>");
-MODULE_DESCRIPTION("Analog Devices AD5024/25/44/45/64/64-1/65, AD5628/48/68 DAC");
+MODULE_DESCRIPTION("Analog Devices AD5024/25/44/45/64/64-1/65, AD5628/48/66/68 DAC");
 MODULE_LICENSE("GPL v2");
-- 
1.7.9

