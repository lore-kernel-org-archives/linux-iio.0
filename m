Return-Path: <lars@metafoo.de>
From: Lars-Peter Clausen <lars@metafoo.de>
To: Jonathan Cameron <jic23@cam.ac.uk>
CC: Michael Hennerich <michael.hennerich@analog.com>,
	<linux-iio@vger.kernel.org>, <device-drivers-devel@blackfin.uclinux.org>,
	<drivers@analog.com>, Lars-Peter Clausen <lars@metafoo.de>
Subject: [PATCH] staging:iio:dac:ad5446: Add support for the AD5662
Date: Fri, 28 Oct 2011 11:05:21 +0200
Message-ID: <1319792721-27108-1-git-send-email-lars@metafoo.de>
MIME-Version: 1.0
Content-Type: text/plain
List-ID: <linux-iio@vger.kernel.org>

The AD5662 is compatible to the AD5660, but uses an external reference instead
of an internal.

Signed-off-by: Lars-Peter Clausen <lars@metafoo.de>
---
 drivers/staging/iio/dac/Kconfig  |    2 +-
 drivers/staging/iio/dac/ad5446.c |    6 ++++++
 drivers/staging/iio/dac/ad5446.h |    1 +
 3 files changed, 8 insertions(+), 1 deletions(-)

diff --git a/drivers/staging/iio/dac/Kconfig b/drivers/staging/iio/dac/Kconfig
index fac8549..daa1079 100644
--- a/drivers/staging/iio/dac/Kconfig
+++ b/drivers/staging/iio/dac/Kconfig
@@ -37,7 +37,7 @@ config AD5446
 	help
 	  Say yes here to build support for Analog Devices AD5444, AD5446,
 	  AD5512A, AD5542A, AD5543, AD5553, AD5601, AD5611, AD5620, AD5621,
-	  AD5640, AD5660 DACs.
+	  AD5640, AD5660, AD5662 DACs.
 
 	  To compile this driver as a module, choose M here: the
 	  module will be called ad5446.
diff --git a/drivers/staging/iio/dac/ad5446.c b/drivers/staging/iio/dac/ad5446.c
index 82ac041..3fcb28b 100644
--- a/drivers/staging/iio/dac/ad5446.c
+++ b/drivers/staging/iio/dac/ad5446.c
@@ -264,6 +264,11 @@ static const struct ad5446_chip_info ad5446_chip_info_tbl[] = {
 		.store_sample = ad5660_store_sample,
 		.store_pwr_down = ad5660_store_pwr_down,
 	},
+	[ID_AD5662] = {
+		.channel = AD5446_CHANNEL(16, 16, 0),
+		.store_sample = ad5660_store_sample,
+		.store_pwr_down = ad5660_store_pwr_down,
+	},
 };
 
 static int ad5446_read_raw(struct iio_dev *indio_dev,
@@ -433,6 +438,7 @@ static const struct spi_device_id ad5446_id[] = {
 	{"ad5640-1250", ID_AD5640_1250},
 	{"ad5660-2500", ID_AD5660_2500},
 	{"ad5660-1250", ID_AD5660_1250},
+	{"ad5662", ID_AD5662},
 	{}
 };
 
diff --git a/drivers/staging/iio/dac/ad5446.h b/drivers/staging/iio/dac/ad5446.h
index 4ea3476..f1ca8fe 100644
--- a/drivers/staging/iio/dac/ad5446.h
+++ b/drivers/staging/iio/dac/ad5446.h
@@ -98,6 +98,7 @@ enum ad5446_supported_device_ids {
 	ID_AD5640_1250,
 	ID_AD5660_2500,
 	ID_AD5660_1250,
+	ID_AD5662,
 };
 
 #endif /* IIO_DAC_AD5446_H_ */
-- 
1.7.7
