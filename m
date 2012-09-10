Return-Path: <linux-iio-owner@vger.kernel.org>
Received: from smtp-out-022.synserver.de ([212.40.185.22]:1142 "EHLO
	smtp-out-022.synserver.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752638Ab2IJIeT (ORCPT
	<rfc822;linux-iio@vger.kernel.org>); Mon, 10 Sep 2012 04:34:19 -0400
From: Lars-Peter Clausen <lars@metafoo.de>
To: Jonathan Cameron <jic23@cam.ac.uk>
Cc: linux-iio@vger.kernel.org, drivers@analog.com,
	Lars-Peter Clausen <lars@metafoo.de>
Subject: [PATCH v2 10/10] iio:ad7476: Add support for ad7274/ad7275/ad7276/ad7277/ad7278
Date: Mon, 10 Sep 2012 10:34:41 +0200
Message-Id: <1347266081-6045-10-git-send-email-lars@metafoo.de>
In-Reply-To: <1347266081-6045-1-git-send-email-lars@metafoo.de>
References: <1347266081-6045-1-git-send-email-lars@metafoo.de>
Sender: linux-iio-owner@vger.kernel.org
List-Id: linux-iio@vger.kernel.org

The ad7276/ad7277/ad7278 are similar to the ad7476/ad7477/ad7478 but have the
same number of leading zeros as the ad7940. The ad7274/ad7275 have a extra pin
for VREF where as for the ad7276/ad7277/ad7278 VREF is taken from VDD, but
otherwise they are compatible to the ad7276/ad7277.

Signed-off-by: Lars-Peter Clausen <lars@metafoo.de>
---
 drivers/iio/adc/Kconfig  |    6 +++---
 drivers/iio/adc/ad7476.c |   20 ++++++++++++++++++++
 2 files changed, 23 insertions(+), 3 deletions(-)

diff --git a/drivers/iio/adc/Kconfig b/drivers/iio/adc/Kconfig
index 7152a49..645c052 100644
--- a/drivers/iio/adc/Kconfig
+++ b/drivers/iio/adc/Kconfig
@@ -24,9 +24,9 @@ config AD7476
 	select IIO_BUFFER
 	select IIO_TRIGGERED_BUFFER
 	help
-	  Say yes here to build support for Analog Devices AD7475, AD7476, AD7477,
-	  AD7478, AD7466, AD7467, AD7468, AD7495, AD7910, AD7920, AD7920 SPI analog
-	  to digital converters (ADC).
+	  Say yes here to build support for Analog Devices AD7274, AD7275, AD7276,
+	  AD7277, AD7278, AD7475, AD7476, AD7477, AD7478, AD7466, AD7467, AD7468,
+	  AD7495, AD7910, AD7920, AD7920 SPI analog to digital converters (ADC).
 
 	  If unsure, say N (but it's safe to say "Y").
 
diff --git a/drivers/iio/adc/ad7476.c b/drivers/iio/adc/ad7476.c
index e6c92a5..9cb10f4 100644
--- a/drivers/iio/adc/ad7476.c
+++ b/drivers/iio/adc/ad7476.c
@@ -45,6 +45,9 @@ struct ad7476_state {
 };
 
 enum ad7476_supported_device_ids {
+	ID_AD7276,
+	ID_AD7277,
+	ID_AD7278,
 	ID_AD7466,
 	ID_AD7467,
 	ID_AD7468,
@@ -146,6 +149,18 @@ static int ad7476_read_raw(struct iio_dev *indio_dev,
 #define AD7940_CHAN(bits) _AD7476_CHAN((bits), 15 - (bits))
 
 static const struct ad7476_chip_info ad7476_chip_info_tbl[] = {
+	[ID_AD7276] = {
+		.channel[0] = AD7940_CHAN(12),
+		.channel[1] = IIO_CHAN_SOFT_TIMESTAMP(1),
+	},
+	[ID_AD7277] = {
+		.channel[0] = AD7940_CHAN(10),
+		.channel[1] = IIO_CHAN_SOFT_TIMESTAMP(1),
+	},
+	[ID_AD7278] = {
+		.channel[0] = AD7940_CHAN(8),
+		.channel[1] = IIO_CHAN_SOFT_TIMESTAMP(1),
+	},
 	[ID_AD7466] = {
 		.channel[0] = AD7476_CHAN(12),
 		.channel[1] = IIO_CHAN_SOFT_TIMESTAMP(1),
@@ -255,6 +270,11 @@ static int __devexit ad7476_remove(struct spi_device *spi)
 }
 
 static const struct spi_device_id ad7476_id[] = {
+	{"ad7274", ID_AD7276},
+	{"ad7275", ID_AD7277},
+	{"ad7276", ID_AD7276},
+	{"ad7277", ID_AD7277},
+	{"ad7278", ID_AD7278},
 	{"ad7466", ID_AD7466},
 	{"ad7467", ID_AD7467},
 	{"ad7468", ID_AD7468},
-- 
1.7.10.4

