Return-Path: <lars@metafoo.de>
From: Lars-Peter Clausen <lars@metafoo.de>
To: Greg Kroah-Hartman <gregkh@suse.de>
CC: Jonathan Cameron <jic23@kernel.org>, Michael Hennerich
	<michael.hennerich@analog.com>, <devel@driverdev.osuosl.org>,
	<linux-iio@vger.kernel.org>, <device-drivers-devel@blackfin.uclinux.org>,
	<drivers@analog.com>, Lars-Peter Clausen <lars@metafoo.de>
Subject: [PATCH] iio:staging:dac:ad5791: Add id entry for the ad5790
Date: Fri, 9 Dec 2011 17:12:42 +0100
Message-ID: <1323447162-17788-1-git-send-email-lars@metafoo.de>
MIME-Version: 1.0
Content-Type: text/plain
List-ID: <linux-iio@vger.kernel.org>

The ad5790 has a binary compatible interface to ad5791, so we just have to add
an entry to the drivers device table to add support for it.

Signed-off-by: Lars-Peter Clausen <lars@metafoo.de>
---
 drivers/staging/iio/dac/Kconfig  |    4 ++--
 drivers/staging/iio/dac/ad5791.c |    6 ++++--
 2 files changed, 6 insertions(+), 4 deletions(-)

diff --git a/drivers/staging/iio/dac/Kconfig b/drivers/staging/iio/dac/Kconfig
index bbc33dd..13e2797 100644
--- a/drivers/staging/iio/dac/Kconfig
+++ b/drivers/staging/iio/dac/Kconfig
@@ -86,11 +86,11 @@ config AD5764
 	  module will be called ad5764.
 
 config AD5791
-	tristate "Analog Devices AD5760/AD5780/AD5781/AD5791 DAC SPI driver"
+	tristate "Analog Devices AD5760/AD5780/AD5781/AD5790/AD5791 DAC SPI driver"
 	depends on SPI
 	help
 	  Say yes here to build support for Analog Devices AD5760, AD5780,
-	  AD5781, AD5791 High Resolution Voltage Output Digital to
+	  AD5781, AD5790, AD5791 High Resolution Voltage Output Digital to
 	  Analog Converter.
 
 	  To compile this driver as a module, choose M here: the
diff --git a/drivers/staging/iio/dac/ad5791.c b/drivers/staging/iio/dac/ad5791.c
index 79c4821..e919025 100644
--- a/drivers/staging/iio/dac/ad5791.c
+++ b/drivers/staging/iio/dac/ad5791.c
@@ -1,5 +1,6 @@
 /*
- * AD5760, AD5780, AD5781, AD5791 Voltage Output Digital to Analog Converter
+ * AD5760, AD5780, AD5781, AD5790, AD5791 Voltage Output Digital to Analog
+ * Converter
  *
  * Copyright 2011 Analog Devices Inc.
  *
@@ -397,6 +398,7 @@ static const struct spi_device_id ad5791_id[] = {
 	{"ad5760", ID_AD5760},
 	{"ad5780", ID_AD5780},
 	{"ad5781", ID_AD5781},
+	{"ad5790", ID_AD5791},
 	{"ad5791", ID_AD5791},
 	{}
 };
@@ -425,5 +427,5 @@ static __exit void ad5791_spi_exit(void)
 module_exit(ad5791_spi_exit);
 
 MODULE_AUTHOR("Michael Hennerich <hennerich@blackfin.uclinux.org>");
-MODULE_DESCRIPTION("Analog Devices AD5760/AD5780/AD5781/AD5791 DAC");
+MODULE_DESCRIPTION("Analog Devices AD5760/AD5780/AD5781/AD5790/AD5791 DAC");
 MODULE_LICENSE("GPL v2");
-- 
1.7.7.3
