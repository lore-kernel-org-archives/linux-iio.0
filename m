Return-Path: <Michael.Hennerich@analog.com>
From: <michael.hennerich@analog.com>
To: jic23@cam.ac.uk
CC: linux-iio@vger.kernel.org, drivers@analog.com,
        device-drivers-devel@blackfin.uclinux.org,
        Michael Hennerich <michael.hennerich@analog.com>
Subject: [PATCH 3/3] IIO: DAC: AD5446: Add support for AD5601/AD5611/AD5621
Date: Thu, 10 Mar 2011 12:52:46 +0100
Message-ID: <1299757966-25592-3-git-send-email-michael.hennerich@analog.com>
In-Reply-To: <1299757966-25592-1-git-send-email-michael.hennerich@analog.com>
References: <1299757966-25592-1-git-send-email-michael.hennerich@analog.com>
MIME-Version: 1.0
Content-Type: text/plain
List-ID: <linux-iio@vger.kernel.org>

From: Michael Hennerich <michael.hennerich@analog.com>

This patch adds support for the AD5601/AD5611/AD5621 single channel,
8-/10-/12-bit, buffered voltage output DACs.

Signed-off-by: Michael Hennerich <michael.hennerich@analog.com>
---
 drivers/staging/iio/dac/Kconfig  |    3 ++-
 drivers/staging/iio/dac/ad5446.c |   24 ++++++++++++++++++++++++
 drivers/staging/iio/dac/ad5446.h |    3 +++
 3 files changed, 29 insertions(+), 1 deletions(-)

diff --git a/drivers/staging/iio/dac/Kconfig b/drivers/staging/iio/dac/Kconfig
index 3c72871..9539545 100644
--- a/drivers/staging/iio/dac/Kconfig
+++ b/drivers/staging/iio/dac/Kconfig
@@ -15,7 +15,8 @@ config AD5446
 	depends on SPI
 	help
 	  Say yes here to build support for Analog Devices AD5444, AD5446,
-	  AD5512A, AD5542A, AD5543, AD5553, AD5620, AD5640, AD5660 DACs.
+	  AD5512A, AD5542A, AD5543, AD5553, AD5601, AD5611, AD5621, AD5620,
+	  AD5640, AD5660 DACs.
 
 	  To compile this driver as a module, choose M here: the
 	  module will be called ad5446.
diff --git a/drivers/staging/iio/dac/ad5446.c b/drivers/staging/iio/dac/ad5446.c
index 861a7ea..8623a72 100644
--- a/drivers/staging/iio/dac/ad5446.c
+++ b/drivers/staging/iio/dac/ad5446.c
@@ -269,6 +269,27 @@ static const struct ad5446_chip_info ad5446_chip_info_tbl[] = {
 		.left_shift = 0,
 		.store_sample = ad5542_store_sample,
 	},
+	[ID_AD5601] = {
+		.bits = 8,
+		.storagebits = 16,
+		.left_shift = 6,
+		.store_sample = ad5542_store_sample,
+		.store_pwr_down = ad5620_store_pwr_down,
+	},
+	[ID_AD5611] = {
+		.bits = 10,
+		.storagebits = 16,
+		.left_shift = 4,
+		.store_sample = ad5542_store_sample,
+		.store_pwr_down = ad5620_store_pwr_down,
+	},
+	[ID_AD5621] = {
+		.bits = 12,
+		.storagebits = 16,
+		.left_shift = 2,
+		.store_sample = ad5542_store_sample,
+		.store_pwr_down = ad5620_store_pwr_down,
+	},
 	[ID_AD5620_2500] = {
 		.bits = 12,
 		.storagebits = 16,
@@ -424,6 +445,9 @@ static const struct spi_device_id ad5446_id[] = {
 	{"ad5542a", ID_AD5542A},
 	{"ad5543", ID_AD5543},
 	{"ad5553", ID_AD5553},
+	{"ad5601", ID_AD5601},
+	{"ad5611", ID_AD5611},
+	{"ad5621", ID_AD5621},
 	{"ad5620-2500", ID_AD5620_2500}, /* AD5620/40/60: */
 	{"ad5620-1250", ID_AD5620_1250}, /* part numbers may look differently */
 	{"ad5640-2500", ID_AD5640_2500},
diff --git a/drivers/staging/iio/dac/ad5446.h b/drivers/staging/iio/dac/ad5446.h
index e9397a6..7ac63ab 100644
--- a/drivers/staging/iio/dac/ad5446.h
+++ b/drivers/staging/iio/dac/ad5446.h
@@ -96,6 +96,9 @@ enum ad5446_supported_device_ids {
 	ID_AD5543,
 	ID_AD5512A,
 	ID_AD5553,
+	ID_AD5601,
+	ID_AD5611,
+	ID_AD5621,
 	ID_AD5620_2500,
 	ID_AD5620_1250,
 	ID_AD5640_2500,
-- 
1.6.0.2
