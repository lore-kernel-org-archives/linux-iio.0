Return-Path: <linux-iio-owner@vger.kernel.org>
Received: from smtp-out-096.synserver.de ([212.40.185.96]:1035 "EHLO
	smtp-out-092.synserver.de" rhost-flags-OK-OK-OK-FAIL)
	by vger.kernel.org with ESMTP id S1751537Ab2FZImB (ORCPT
	<rfc822;linux-iio@vger.kernel.org>); Tue, 26 Jun 2012 04:42:01 -0400
From: Lars-Peter Clausen <lars@metafoo.de>
To: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
Cc: Jonathan Cameron <jic23@cam.ac.uk>, devel@driverdev.osuosl.org,
	linux-iio@vger.kernel.org, Lars-Peter Clausen <lars@metafoo.de>
Subject: [PATCH] iio:dac:ad5446: Add support for the AD5450/51/52/53
Date: Tue, 26 Jun 2012 10:45:43 +0200
Message-Id: <1340700343-16938-1-git-send-email-lars@metafoo.de>
Sender: linux-iio-owner@vger.kernel.org
List-Id: linux-iio@vger.kernel.org

This patch adds support for the Analog Devices AD5450/51/52/53 Digital-to-Analog
converters.

The AD5452 and AD5453 are software compatible to the existing AD5444 and AD5446.
The AD5450 and AD5451 are similar but have a smaller resolution.

Signed-off-by: Lars-Peter Clausen <lars@metafoo.de>
Acked-by: Jonathan Cameron <jic23@kernel.org>
---
 drivers/iio/dac/Kconfig  |    6 +++---
 drivers/iio/dac/ad5446.c |   12 ++++++++++++
 drivers/iio/dac/ad5446.h |    2 ++
 3 files changed, 17 insertions(+), 3 deletions(-)

diff --git a/drivers/iio/dac/Kconfig b/drivers/iio/dac/Kconfig
index 92fb3a0..afd207e 100644
--- a/drivers/iio/dac/Kconfig
+++ b/drivers/iio/dac/Kconfig
@@ -59,9 +59,9 @@ config AD5446
 	tristate "Analog Devices AD5446 and similar single channel DACs driver"
 	depends on SPI
 	help
-	  Say yes here to build support for Analog Devices AD5444, AD5446,
-	  AD5512A, AD5541A, AD5542A, AD5543, AD5553, AD5601, AD5611, AD5620,
-	  AD5621, AD5640, AD5660, AD5662 DACs.
+	  Say yes here to build support for Analog Devices AD5444, AD5446, AD5450,
+	  AD5451, AD5452, AD5453, AD5512A, AD5541A, AD5542A, AD5543, AD5553, AD5601,
+	  AD5611, AD5620, AD5621, AD5640, AD5660, AD5662 DACs.
 
 	  To compile this driver as a module, choose M here: the
 	  module will be called ad5446.
diff --git a/drivers/iio/dac/ad5446.c b/drivers/iio/dac/ad5446.c
index 49f557f..2ca5059 100644
--- a/drivers/iio/dac/ad5446.c
+++ b/drivers/iio/dac/ad5446.c
@@ -147,6 +147,14 @@ static const struct ad5446_chip_info ad5446_chip_info_tbl[] = {
 		.channel = AD5446_CHANNEL(14, 16, 0),
 		.write = ad5446_write,
 	},
+	[ID_AD5450] = {
+		.channel = AD5446_CHANNEL(8, 16, 6),
+		.write = ad5446_write,
+	},
+	[ID_AD5451] = {
+		.channel = AD5446_CHANNEL(10, 16, 4),
+		.write = ad5446_write,
+	},
 	[ID_AD5541A] = {
 		.channel = AD5446_CHANNEL(16, 16, 0),
 		.write = ad5446_write,
@@ -346,6 +354,10 @@ static int ad5446_remove(struct spi_device *spi)
 static const struct spi_device_id ad5446_id[] = {
 	{"ad5444", ID_AD5444},
 	{"ad5446", ID_AD5446},
+	{"ad5450", ID_AD5450},
+	{"ad5451", ID_AD5451},
+	{"ad5452", ID_AD5444}, /* ad5452 is compatible to the ad5444 */
+	{"ad5453", ID_AD5446}, /* ad5453 is compatible to the ad5446 */
 	{"ad5512a", ID_AD5512A},
 	{"ad5541a", ID_AD5541A},
 	{"ad5542a", ID_AD5541A}, /* ad5541a and ad5542a are compatible */
diff --git a/drivers/iio/dac/ad5446.h b/drivers/iio/dac/ad5446.h
index dfd68ce..2934269 100644
--- a/drivers/iio/dac/ad5446.h
+++ b/drivers/iio/dac/ad5446.h
@@ -71,6 +71,8 @@ struct ad5446_chip_info {
 enum ad5446_supported_device_ids {
 	ID_AD5444,
 	ID_AD5446,
+	ID_AD5450,
+	ID_AD5451,
 	ID_AD5541A,
 	ID_AD5512A,
 	ID_AD5553,
-- 
1.7.10

