Return-Path: <Michael.Hennerich@analog.com>
From: <michael.hennerich@analog.com>
To: <greg@kroah.com>
CC: <linux-iio@vger.kernel.org>, <drivers@analog.com>, <jic23@cam.ac.uk>,
	<device-drivers-devel@blackfin.uclinux.org>, Michael Hennerich
	<michael.hennerich@analog.com>
Subject: [PATCH] IIO: DAC: AD5791: Add support for the AD5760/AD5780 High Resolution DACs
Date: Wed, 27 Apr 2011 17:13:58 +0200
Message-ID: <1303917238-17998-1-git-send-email-michael.hennerich@analog.com>
MIME-Version: 1.0
Content-Type: text/plain
List-ID: <linux-iio@vger.kernel.org>

From: Michael Hennerich <michael.hennerich@analog.com>

Add support for the AD5760/AD5780 High Resolution Voltage Output DACs

Signed-off-by: Michael Hennerich <michael.hennerich@analog.com>
Acked-by: Jonathan Cameron <jic23@cam.ac.uk>
---
 drivers/staging/iio/dac/Kconfig  |    7 +++--
 drivers/staging/iio/dac/ad5791.c |   54 ++++++++++++++++++++++++++-----------
 drivers/staging/iio/dac/ad5791.h |    9 +++++-
 3 files changed, 50 insertions(+), 20 deletions(-)

diff --git a/drivers/staging/iio/dac/Kconfig b/drivers/staging/iio/dac/Kconfig
index f25468a..d5a5556 100644
--- a/drivers/staging/iio/dac/Kconfig
+++ b/drivers/staging/iio/dac/Kconfig
@@ -32,11 +32,12 @@ config AD5504
 	  module will be called ad5504.

 config AD5791
-	tristate "Analog Devices AD5781/AD5791 DAC SPI driver"
+	tristate "Analog Devices AD5760/AD5780/AD5781/AD5791 DAC SPI driver"
 	depends on SPI
 	help
-	  Say yes here to build support for Analog Devices AD5781, AD5791,
-	  High Resolution Voltage Output Digital to Analog Converter.
+	  Say yes here to build support for Analog Devices AD5760, AD5780,
+	  AD5781, AD5791 High Resolution Voltage Output Digital to
+	  Analog Converter.

 	  To compile this driver as a module, choose M here: the
 	  module will be called ad5791.
diff --git a/drivers/staging/iio/dac/ad5791.c b/drivers/staging/iio/dac/ad5791.c
index c4a258d..acfd13b 100644
--- a/drivers/staging/iio/dac/ad5791.c
+++ b/drivers/staging/iio/dac/ad5791.c
@@ -1,5 +1,5 @@
 /*
- * AD5791, AD5791 Voltage Output Digital to Analog Converter
+ * AD5760, AD5780, AD5781, AD5791 Voltage Output Digital to Analog Converter
  *
  * Copyright 2011 Analog Devices Inc.
  *
@@ -242,17 +242,6 @@ static const struct attribute_group ad5791_attribute_group = {
 	.attrs = ad5791_attributes,
 };

-static const struct ad5791_chip_info ad5791_chip_info_tbl[] = {
-	[ID_AD5791] = {
-		.bits = 20,
-		.left_shift = 0,
-	},
-	[ID_AD5781] = {
-		.bits = 18,
-		.left_shift = 2,
-	},
-};
-
 static int ad5791_get_lin_comp(unsigned int span)
 {
 	if (span <= 10000)
@@ -267,6 +256,37 @@ static int ad5791_get_lin_comp(unsigned int span)
 		return AD5791_LINCOMP_19_20;
 }

+static int ad5780_get_lin_comp(unsigned int span)
+{
+	if (span <= 10000)
+		return AD5780_LINCOMP_0_10;
+	else
+		return AD5780_LINCOMP_10_20;
+}
+
+static const struct ad5791_chip_info ad5791_chip_info_tbl[] = {
+	[ID_AD5760] = {
+		.bits = 16,
+		.left_shift = 4,
+		.get_lin_comp = ad5780_get_lin_comp,
+	},
+	[ID_AD5780] = {
+		.bits = 18,
+		.left_shift = 2,
+		.get_lin_comp = ad5780_get_lin_comp,
+	},
+	[ID_AD5781] = {
+		.bits = 18,
+		.left_shift = 2,
+		.get_lin_comp = ad5791_get_lin_comp,
+	},
+	[ID_AD5791] = {
+		.bits = 20,
+		.left_shift = 0,
+		.get_lin_comp = ad5791_get_lin_comp,
+	},
+};
+
 static int __devinit ad5791_probe(struct spi_device *spi)
 {
 	struct ad5791_platform_data *pdata = spi->dev.platform_data;
@@ -314,8 +334,8 @@ static int __devinit ad5791_probe(struct spi_device *spi)
 		&ad5791_chip_info_tbl[spi_get_device_id(spi)->driver_data];


-	st->ctrl = AD5761_CTRL_LINCOMP(ad5791_get_lin_comp(st->vref_mv)) |
-		  ((pdata && pdata->use_rbuf_gain2) ? 0 : AD5791_CTRL_RBUF) |
+	st->ctrl = AD5761_CTRL_LINCOMP(st->chip_info->get_lin_comp(st->vref_mv))
+		  | ((pdata && pdata->use_rbuf_gain2) ? 0 : AD5791_CTRL_RBUF) |
 		  AD5791_CTRL_BIN2SC;

 	ret = ad5791_spi_write(spi, AD5791_ADDR_CTRL, st->ctrl |
@@ -386,8 +406,10 @@ static int __devexit ad5791_remove(struct spi_device *spi)
 }

 static const struct spi_device_id ad5791_id[] = {
-	{"ad5791", ID_AD5791},
+	{"ad5760", ID_AD5760},
+	{"ad5780", ID_AD5780},
 	{"ad5781", ID_AD5781},
+	{"ad5791", ID_AD5791},
 	{}
 };

@@ -414,5 +436,5 @@ static __exit void ad5791_spi_exit(void)
 module_exit(ad5791_spi_exit);

 MODULE_AUTHOR("Michael Hennerich <hennerich@blackfin.uclinux.org>");
-MODULE_DESCRIPTION("Analog Devices AD5791/AD5781 DAC");
+MODULE_DESCRIPTION("Analog Devices AD5760/AD5780/AD5781/AD5791 DAC");
 MODULE_LICENSE("GPL v2");
diff --git a/drivers/staging/iio/dac/ad5791.h b/drivers/staging/iio/dac/ad5791.h
index 71c7d59..f09ad9a 100644
--- a/drivers/staging/iio/dac/ad5791.h
+++ b/drivers/staging/iio/dac/ad5791.h
@@ -38,6 +38,9 @@
 #define AD5791_LINCOMP_16_19		3
 #define AD5791_LINCOMP_19_20		12

+#define AD5780_LINCOMP_0_10		0
+#define AD5780_LINCOMP_10_20		12
+
 /* Software Control Register */
 #define AD5791_SWCTRL_LDAC		(1 << 0)
 #define AD5791_SWCTRL_CLR		(1 << 1)
@@ -67,11 +70,13 @@ struct ad5791_platform_data {
  * struct ad5791_chip_info - chip specific information
  * @bits:		accuracy of the DAC in bits
  * @left_shift:		number of bits the datum must be shifted
+ * @get_lin_comp:	function pointer to the device specific function
  */

 struct ad5791_chip_info {
 	u8			bits;
 	u8			left_shift;
+	int (*get_lin_comp)	(unsigned int span);
 };

 /**
@@ -102,8 +107,10 @@ struct ad5791_state {
  */

 enum ad5791_supported_device_ids {
-	ID_AD5791,
+	ID_AD5760,
+	ID_AD5780,
 	ID_AD5781,
+	ID_AD5791,
 };

 #endif /* SPI_AD5791_H_ */
--
1.6.0.2
