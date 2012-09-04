Return-Path: <linux-iio-owner@vger.kernel.org>
Received: from smtp-out-217.synserver.de ([212.40.185.217]:1483 "EHLO
	smtp-out-217.synserver.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1756614Ab2IDJFe (ORCPT
	<rfc822;linux-iio@vger.kernel.org>); Tue, 4 Sep 2012 05:05:34 -0400
From: Lars-Peter Clausen <lars@metafoo.de>
To: Jonathan Cameron <jic23@cam.ac.uk>
Cc: linux-iio@vger.kernel.org, drivers@analog.com,
	Lars-Peter Clausen <lars@metafoo.de>
Subject: [PATCH 1/2] iio:ad5446: Add support for the ad5300/ad5310/ad5320
Date: Tue,  4 Sep 2012 11:10:15 +0200
Message-Id: <1346749816-22877-1-git-send-email-lars@metafoo.de>
Sender: linux-iio-owner@vger.kernel.org
List-Id: linux-iio@vger.kernel.org

The ad5300/ad5310/ad5320 is a family of single channel DACs with a SPI interface
similar to the ad5601/ad5611/ad5621 but use a different shift factor for the
data word.

While we are at it also reorder the device part numbers in the ad5446 driver
Kconfig to be ordered alphabetically.

Signed-off-by: Lars-Peter Clausen <lars@metafoo.de>
---
 drivers/iio/dac/Kconfig  |    6 +++---
 drivers/iio/dac/ad5446.c |   18 ++++++++++++++++++
 2 files changed, 21 insertions(+), 3 deletions(-)

diff --git a/drivers/iio/dac/Kconfig b/drivers/iio/dac/Kconfig
index 293b61d..7599d62 100644
--- a/drivers/iio/dac/Kconfig
+++ b/drivers/iio/dac/Kconfig
@@ -59,10 +59,10 @@ config AD5446
 	tristate "Analog Devices AD5446 and similar single channel DACs driver"
 	depends on (SPI_MASTER || I2C)
 	help
-	  Say yes here to build support for Analog Devices AD5602, AD5612, AD5622,
+	  Say yes here to build support for Analog Devices AD5300, AD5310, AD5320,
 	  AD5444, AD5446, AD5450, AD5451, AD5452, AD5453, AD5512A, AD5541A, AD5542A,
-	  AD5543, AD5553, AD5601, AD5611, AD5620, AD5621, AD5640, AD5660, AD5662
-	  DACs.
+	  AD5543, AD5553, AD5601, AD5602, AD5611, AD5612, AD5620, AD5621, AD5622,
+	  AD5640, AD5660, AD5662 DACs.
 
 	  To compile this driver as a module, choose M here: the
 	  module will be called ad5446.
diff --git a/drivers/iio/dac/ad5446.c b/drivers/iio/dac/ad5446.c
index 7f11c1c..2b0968f 100644
--- a/drivers/iio/dac/ad5446.c
+++ b/drivers/iio/dac/ad5446.c
@@ -321,6 +321,9 @@ static int ad5660_write(struct ad5446_state *st, unsigned val)
  * parts are supported here.
  */
 enum ad5446_supported_spi_device_ids {
+	ID_AD5300,
+	ID_AD5310,
+	ID_AD5320,
 	ID_AD5444,
 	ID_AD5446,
 	ID_AD5450,
@@ -341,6 +344,18 @@ enum ad5446_supported_spi_device_ids {
 };
 
 static const struct ad5446_chip_info ad5446_spi_chip_info[] = {
+	[ID_AD5300] = {
+		.channel = AD5446_CHANNEL_POWERDOWN(8, 16, 4),
+		.write = ad5446_write,
+	},
+	[ID_AD5310] = {
+		.channel = AD5446_CHANNEL_POWERDOWN(10, 16, 2),
+		.write = ad5446_write,
+	},
+	[ID_AD5320] = {
+		.channel = AD5446_CHANNEL_POWERDOWN(12, 16, 0),
+		.write = ad5446_write,
+	},
 	[ID_AD5444] = {
 		.channel = AD5446_CHANNEL(12, 16, 2),
 		.write = ad5446_write,
@@ -418,6 +433,9 @@ static const struct ad5446_chip_info ad5446_spi_chip_info[] = {
 };
 
 static const struct spi_device_id ad5446_spi_ids[] = {
+	{"ad5300", ID_AD5300},
+	{"ad5310", ID_AD5310},
+	{"ad5320", ID_AD5320},
 	{"ad5444", ID_AD5444},
 	{"ad5446", ID_AD5446},
 	{"ad5450", ID_AD5450},
-- 
1.7.10.4

