Return-Path: <linux-iio-owner@vger.kernel.org>
Received: from smtp-out-233.synserver.de ([212.40.185.233]:1144 "EHLO
	smtp-out-233.synserver.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S933329Ab2IGMoM (ORCPT
	<rfc822;linux-iio@vger.kernel.org>); Fri, 7 Sep 2012 08:44:12 -0400
From: Lars-Peter Clausen <lars@metafoo.de>
To: Jonathan Cameron <jic23@cam.ac.uk>
Cc: linux-iio@vger.kernel.org, drivers@analog.com,
	Lars-Peter Clausen <lars@metafoo.de>
Subject: [PATCH 08/10] iio:ad7476: Add ad7910/ad7920 device table entries
Date: Fri,  7 Sep 2012 14:44:30 +0200
Message-Id: <1347021872-7885-8-git-send-email-lars@metafoo.de>
In-Reply-To: <1347021872-7885-1-git-send-email-lars@metafoo.de>
References: <1347021872-7885-1-git-send-email-lars@metafoo.de>
Sender: linux-iio-owner@vger.kernel.org
List-Id: linux-iio@vger.kernel.org

The ad7910/ad7920 are software compatible to the ad7467/ad7466.

Signed-off-by: Lars-Peter Clausen <lars@metafoo.de>
---
 drivers/iio/adc/Kconfig  |    9 +++++----
 drivers/iio/adc/ad7476.c |    4 +++-
 2 files changed, 8 insertions(+), 5 deletions(-)

diff --git a/drivers/iio/adc/Kconfig b/drivers/iio/adc/Kconfig
index 260e20b..364d2d7 100644
--- a/drivers/iio/adc/Kconfig
+++ b/drivers/iio/adc/Kconfig
@@ -19,14 +19,15 @@ config AD7266
 	  ADCs.
 
 config AD7476
-	tristate "Analog Devices AD7475/6/7/8 AD7466/7/8 and AD7495 ADC driver"
+	tristate "Analog Devices AD7476 and similar 1-channel ADCs driver"
 	depends on SPI
 	select IIO_BUFFER
 	select IIO_TRIGGERED_BUFFER
 	help
-	  Say yes here to build support for Analog Devices
-	  AD7475, AD7476, AD7477, AD7478, AD7466, AD7467, AD7468, AD7495
-	  SPI analog to digital converters (ADC).
+	  Say yes here to build support for Analog Devices AD7475, AD7476, AD7477,
+	  AD7478, AD7466, AD7467, AD7468, AD7495, AD7910, AD7920 SPI analog to
+	  digital converters (ADC).
+
 	  If unsure, say N (but it's safe to say "Y").
 
 	  To compile this driver as a module, choose M here: the
diff --git a/drivers/iio/adc/ad7476.c b/drivers/iio/adc/ad7476.c
index 845bd28..1c7ae6f 100644
--- a/drivers/iio/adc/ad7476.c
+++ b/drivers/iio/adc/ad7476.c
@@ -282,6 +282,8 @@ static const struct spi_device_id ad7476_id[] = {
 	{"ad7478", ID_AD7468},
 	{"ad7478a", ID_AD7468},
 	{"ad7495", ID_AD7495},
+	{"ad7910", ID_AD7467},
+	{"ad7920", ID_AD7466},
 	{}
 };
 MODULE_DEVICE_TABLE(spi, ad7476_id);
@@ -298,5 +300,5 @@ static struct spi_driver ad7476_driver = {
 module_spi_driver(ad7476_driver);
 
 MODULE_AUTHOR("Michael Hennerich <hennerich@blackfin.uclinux.org>");
-MODULE_DESCRIPTION("Analog Devices AD7475/6/7/8(A) AD7466/7/8 ADC");
+MODULE_DESCRIPTION("Analog Devices AD7476 and similar 1-channel ADCs");
 MODULE_LICENSE("GPL v2");
-- 
1.7.10.4

