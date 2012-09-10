Return-Path: <linux-iio-owner@vger.kernel.org>
Received: from smtp-out-022.synserver.de ([212.40.185.22]:1240 "EHLO
	smtp-out-022.synserver.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752387Ab2IJIeS (ORCPT
	<rfc822;linux-iio@vger.kernel.org>); Mon, 10 Sep 2012 04:34:18 -0400
From: Lars-Peter Clausen <lars@metafoo.de>
To: Jonathan Cameron <jic23@cam.ac.uk>
Cc: linux-iio@vger.kernel.org, drivers@analog.com,
	Lars-Peter Clausen <lars@metafoo.de>
Subject: [PATCH v2 09/10] iio:ad7476: Add ad7940 support
Date: Mon, 10 Sep 2012 10:34:40 +0200
Message-Id: <1347266081-6045-9-git-send-email-lars@metafoo.de>
In-Reply-To: <1347266081-6045-1-git-send-email-lars@metafoo.de>
References: <1347266081-6045-1-git-send-email-lars@metafoo.de>
Sender: linux-iio-owner@vger.kernel.org
List-Id: linux-iio@vger.kernel.org

The AD7940 is a single channel 14 bit ADC similar to the ADCs already supported
by the ad7476 driver, but it does have a different shift factor.

Signed-off-by: Lars-Peter Clausen <lars@metafoo.de>
---
 drivers/iio/adc/Kconfig  |    4 ++--
 drivers/iio/adc/ad7476.c |   18 ++++++++++++++----
 2 files changed, 16 insertions(+), 6 deletions(-)

diff --git a/drivers/iio/adc/Kconfig b/drivers/iio/adc/Kconfig
index 364d2d7..7152a49 100644
--- a/drivers/iio/adc/Kconfig
+++ b/drivers/iio/adc/Kconfig
@@ -25,8 +25,8 @@ config AD7476
 	select IIO_TRIGGERED_BUFFER
 	help
 	  Say yes here to build support for Analog Devices AD7475, AD7476, AD7477,
-	  AD7478, AD7466, AD7467, AD7468, AD7495, AD7910, AD7920 SPI analog to
-	  digital converters (ADC).
+	  AD7478, AD7466, AD7467, AD7468, AD7495, AD7910, AD7920, AD7920 SPI analog
+	  to digital converters (ADC).
 
 	  If unsure, say N (but it's safe to say "Y").
 
diff --git a/drivers/iio/adc/ad7476.c b/drivers/iio/adc/ad7476.c
index b3991a7..e6c92a5 100644
--- a/drivers/iio/adc/ad7476.c
+++ b/drivers/iio/adc/ad7476.c
@@ -48,7 +48,8 @@ enum ad7476_supported_device_ids {
 	ID_AD7466,
 	ID_AD7467,
 	ID_AD7468,
-	ID_AD7495
+	ID_AD7495,
+	ID_AD7940,
 };
 
 static irqreturn_t ad7476_trigger_handler(int irq, void  *p)
@@ -126,7 +127,7 @@ static int ad7476_read_raw(struct iio_dev *indio_dev,
 	return -EINVAL;
 }
 
-#define AD7476_CHAN(bits)					\
+#define _AD7476_CHAN(bits, _shift)				\
 	{							\
 	.type = IIO_VOLTAGE,					\
 	.indexed = 1,						\
@@ -134,12 +135,16 @@ static int ad7476_read_raw(struct iio_dev *indio_dev,
 	IIO_CHAN_INFO_SCALE_SHARED_BIT,				\
 	.scan_type = {						\
 		.sign = 'u',					\
-		.realbits = bits,				\
+		.realbits = (bits),				\
 		.storagebits = 16,				\
-		.shift = 13 - bits,				\
+		.shift = (_shift),				\
+		.endianness = IIO_BE,				\
 	},							\
 }
 
+#define AD7476_CHAN(bits) _AD7476_CHAN((bits), 13 - (bits))
+#define AD7940_CHAN(bits) _AD7476_CHAN((bits), 15 - (bits))
+
 static const struct ad7476_chip_info ad7476_chip_info_tbl[] = {
 	[ID_AD7466] = {
 		.channel[0] = AD7476_CHAN(12),
@@ -158,6 +163,10 @@ static const struct ad7476_chip_info ad7476_chip_info_tbl[] = {
 		.channel[1] = IIO_CHAN_SOFT_TIMESTAMP(1),
 		.int_vref_uv = 2500000,
 	},
+	[ID_AD7940] = {
+		.channel[0] = AD7940_CHAN(14),
+		.channel[1] = IIO_CHAN_SOFT_TIMESTAMP(1),
+	},
 };
 
 static const struct iio_info ad7476_info = {
@@ -259,6 +268,7 @@ static const struct spi_device_id ad7476_id[] = {
 	{"ad7495", ID_AD7495},
 	{"ad7910", ID_AD7467},
 	{"ad7920", ID_AD7466},
+	{"ad7940", ID_AD7940},
 	{}
 };
 MODULE_DEVICE_TABLE(spi, ad7476_id);
-- 
1.7.10.4

