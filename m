Return-Path: <Michael.Hennerich@analog.com>
From: <michael.hennerich@analog.com>
To: greg@kroah.com
CC: linux-iio@vger.kernel.org, drivers@analog.com, jic23@cam.ac.uk,
        device-drivers-devel@blackfin.uclinux.org,
        Michael Hennerich <michael.hennerich@analog.com>
Subject: [PATCH] staging: iio: dac: ad5446: Enable driver support for AD5620/AD5640/AD5660 DA converters
Date: Tue, 23 Nov 2010 11:14:16 +0100
Message-ID: <1290507256-31535-1-git-send-email-michael.hennerich@analog.com>
MIME-Version: 1.0
Content-Type: text/plain
List-ID: <linux-iio@vger.kernel.org>

From: Michael Hennerich <michael.hennerich@analog.com>

Initial support for single channel, 12-/14-/16-Bit nanoDAC with On-Chip Reference

staging: iio: dac: ad5446: Fix according to review feedback

Review feedback by Jonathan Cameron:
	Use kernel doc style to document headers.
	Turn data into a union
	Add some comments for clarity

Signed-off-by: Michael Hennerich <michael.hennerich@analog.com>
Acked-by: Jonathan Cameron <jic23@cam.ac.uk>
---
 drivers/staging/iio/dac/Kconfig  |    6 +-
 drivers/staging/iio/dac/ad5446.c |  120 ++++++++++++++++++++++++++++++++------
 drivers/staging/iio/dac/ad5446.h |   72 +++++++++++++++++++---
 3 files changed, 167 insertions(+), 31 deletions(-)

diff --git a/drivers/staging/iio/dac/Kconfig b/drivers/staging/iio/dac/Kconfig
index 9c497cc..9191bd2 100644
--- a/drivers/staging/iio/dac/Kconfig
+++ b/drivers/staging/iio/dac/Kconfig
@@ -11,11 +11,11 @@ config AD5624R_SPI
 	  AD5664R convertors (DAC). This driver uses the common SPI interface.

 config AD5446
-	tristate "Analog Devices AD5444, AD5446 and AD5541A, AD5512A DAC SPI driver"
+	tristate "Analog Devices AD5444/6, AD5620/40/60 and AD5541A/12A DAC SPI driver"
 	depends on SPI
 	help
-	  Say yes here to build support for Analog Devices AD5444, AD5446
-	  and AD5541A, AD5512A DACs.
+	  Say yes here to build support for Analog Devices AD5444, AD5446,
+	  AD5620, AD5640, AD5660 and AD5541A, AD5512A DACs.

 	  To compile this driver as a module, choose M here: the
 	  module will be called ad5446.
diff --git a/drivers/staging/iio/dac/ad5446.c b/drivers/staging/iio/dac/ad5446.c
index ac3165b..4d65d27 100644
--- a/drivers/staging/iio/dac/ad5446.c
+++ b/drivers/staging/iio/dac/ad5446.c
@@ -23,6 +23,31 @@

 #include "ad5446.h"

+static void ad5446_store_sample(struct ad5446_state *st, unsigned val)
+{
+	st->data.d16 = cpu_to_be16(AD5446_LOAD |
+					(val << st->chip_info->left_shift));
+}
+
+static void ad5542_store_sample(struct ad5446_state *st, unsigned val)
+{
+	st->data.d16 = cpu_to_be16(val << st->chip_info->left_shift);
+}
+
+static void ad5620_store_sample(struct ad5446_state *st, unsigned val)
+{
+	st->data.d16 = cpu_to_be16(AD5620_LOAD |
+					(val << st->chip_info->left_shift));
+}
+
+static void ad5660_store_sample(struct ad5446_state *st, unsigned val)
+{
+	val |= AD5660_LOAD;
+	st->data.d24[0] = (val >> 16) & 0xFF;
+	st->data.d24[1] = (val >> 8) & 0xFF;
+	st->data.d24[2] = val & 0xFF;
+}
+
 static ssize_t ad5446_write(struct device *dev,
 		struct device_attribute *attr,
 		const char *buf,
@@ -43,18 +68,7 @@ static ssize_t ad5446_write(struct device *dev,
 	}

 	mutex_lock(&dev_info->mlock);
-	switch (spi_get_device_id(st->spi)->driver_data) {
-	case ID_AD5444:
-	case ID_AD5446:
-			st->data = cpu_to_be16(AD5446_LOAD |
-					(val << st->chip_info->left_shift));
-			break;
-	case ID_AD5542A:
-	case ID_AD5512A:
-			st->data = cpu_to_be16(val << st->chip_info->left_shift);
-			break;
-	}
-
+	st->chip_info->store_sample(st, val);
 	ret = spi_sync(st->spi, &st->msg);
 	mutex_unlock(&dev_info->mlock);

@@ -105,24 +119,76 @@ static const struct ad5446_chip_info ad5446_chip_info_tbl[] = {
 		.storagebits = 16,
 		.left_shift = 2,
 		.sign = 'u', /* IIO_SCAN_EL_TYPE_UNSIGNED */
+		.store_sample = ad5446_store_sample,
 	},
 	[ID_AD5446] = {
 		.bits = 14,
 		.storagebits = 16,
 		.left_shift = 0,
 		.sign = 'u', /* IIO_SCAN_EL_TYPE_UNSIGNED */
+		.store_sample = ad5446_store_sample,
 	},
 	[ID_AD5542A] = {
 		.bits = 16,
 		.storagebits = 16,
 		.left_shift = 0,
 		.sign = 'u', /* IIO_SCAN_EL_TYPE_UNSIGNED */
+		.store_sample = ad5542_store_sample,
 	},
 	[ID_AD5512A] = {
 		.bits = 12,
 		.storagebits = 16,
 		.left_shift = 4,
 		.sign = 'u', /* IIO_SCAN_EL_TYPE_UNSIGNED */
+		.store_sample = ad5542_store_sample,
+	},
+	[ID_AD5620_2500] = {
+		.bits = 12,
+		.storagebits = 16,
+		.left_shift = 2,
+		.sign = 'u', /* IIO_SCAN_EL_TYPE_UNSIGNED */
+		.int_vref_mv = 2500,
+		.store_sample = ad5620_store_sample,
+	},
+	[ID_AD5620_1250] = {
+		.bits = 12,
+		.storagebits = 16,
+		.left_shift = 2,
+		.sign = 'u', /* IIO_SCAN_EL_TYPE_UNSIGNED */
+		.int_vref_mv = 1250,
+		.store_sample = ad5620_store_sample,
+	},
+	[ID_AD5640_2500] = {
+		.bits = 14,
+		.storagebits = 16,
+		.left_shift = 0,
+		.sign = 'u', /* IIO_SCAN_EL_TYPE_UNSIGNED */
+		.int_vref_mv = 2500,
+		.store_sample = ad5620_store_sample,
+	},
+	[ID_AD5640_1250] = {
+		.bits = 14,
+		.storagebits = 16,
+		.left_shift = 0,
+		.sign = 'u', /* IIO_SCAN_EL_TYPE_UNSIGNED */
+		.int_vref_mv = 1250,
+		.store_sample = ad5620_store_sample,
+	},
+	[ID_AD5660_2500] = {
+		.bits = 16,
+		.storagebits = 24,
+		.left_shift = 0,
+		.sign = 'u', /* IIO_SCAN_EL_TYPE_UNSIGNED */
+		.int_vref_mv = 2500,
+		.store_sample = ad5660_store_sample,
+	},
+	[ID_AD5660_1250] = {
+		.bits = 16,
+		.storagebits = 24,
+		.left_shift = 0,
+		.sign = 'u', /* IIO_SCAN_EL_TYPE_UNSIGNED */
+		.int_vref_mv = 1250,
+		.store_sample = ad5660_store_sample,
 	},
 };

@@ -168,16 +234,28 @@ static int __devinit ad5446_probe(struct spi_device *spi)

 	/* Setup default message */

-	st->xfer.tx_buf = &st->data,
-	st->xfer.len = 2,
+	st->xfer.tx_buf = &st->data;
+	st->xfer.len = st->chip_info->storagebits / 8;

 	spi_message_init(&st->msg);
 	spi_message_add_tail(&st->xfer, &st->msg);

-	if (voltage_uv)
-		st->vref_mv = voltage_uv / 1000;
-	else
-		dev_warn(&spi->dev, "reference voltage unspecified\n");
+	switch (spi_get_device_id(spi)->driver_data) {
+		case ID_AD5620_2500:
+		case ID_AD5620_1250:
+		case ID_AD5640_2500:
+		case ID_AD5640_1250:
+		case ID_AD5660_2500:
+		case ID_AD5660_1250:
+			st->vref_mv = st->chip_info->int_vref_mv;
+			break;
+		default:
+			if (voltage_uv)
+				st->vref_mv = voltage_uv / 1000;
+			else
+				dev_warn(&spi->dev,
+					 "reference voltage unspecified\n");
+	}

 	ret = iio_device_register(st->indio_dev);
 	if (ret)
@@ -217,6 +295,12 @@ static const struct spi_device_id ad5446_id[] = {
 	{"ad5446", ID_AD5446},
 	{"ad5542a", ID_AD5542A},
 	{"ad5512a", ID_AD5512A},
+	{"ad5620-2500", ID_AD5620_2500}, /* AD5620/40/60: */
+	{"ad5620-1250", ID_AD5620_1250}, /* part numbers may look differently */
+	{"ad5640-2500", ID_AD5640_2500},
+	{"ad5640-1250", ID_AD5640_1250},
+	{"ad5660-2500", ID_AD5660_2500},
+	{"ad5660-1250", ID_AD5660_1250},
 	{}
 };

diff --git a/drivers/staging/iio/dac/ad5446.h b/drivers/staging/iio/dac/ad5446.h
index 24a9cda..ca795a9 100644
--- a/drivers/staging/iio/dac/ad5446.h
+++ b/drivers/staging/iio/dac/ad5446.h
@@ -5,8 +5,8 @@
  *
  * Licensed under the GPL-2 or later.
  */
-#ifndef IIO_ADC_AD5446_H_
-#define IIO_ADC_AD5446_H_
+#ifndef IIO_DAC_AD5446_H_
+#define IIO_DAC_AD5446_H_

 /* DAC Control Bits */

@@ -15,14 +15,30 @@
 #define AD5446_NOP		(0x2 << 14) /* No operation */
 #define AD5446_CLK_RISING	(0x3 << 14) /* Clock data on rising edge */

+#define AD5620_LOAD		(0x0 << 14) /* Load and update Norm Operation*/
+#define AD5620_PWRDWN_1k	(0x1 << 14) /* Power-down: 1kOhm to GND */
+#define AD5620_PWRDWN_100k	(0x2 << 14) /* Power-down: 100kOhm to GND */
+#define AD5620_PWRDWN_TRISTATE	(0x3 << 14) /* Power-down: Three-state */
+
+#define AD5660_LOAD		(0x0 << 16) /* Load and update Norm Operation*/
+#define AD5660_PWRDWN_1k	(0x1 << 16) /* Power-down: 1kOhm to GND */
+#define AD5660_PWRDWN_100k	(0x2 << 16) /* Power-down: 100kOhm to GND */
+#define AD5660_PWRDWN_TRISTATE	(0x3 << 16) /* Power-down: Three-state */
+
 #define RES_MASK(bits)	((1 << (bits)) - 1)

-struct ad5446_chip_info {
-	u8				bits;		/* number of DAC bits */
-	u8				storagebits;	/* number of bits written to the DAC */
-	u8				left_shift;	/* number of bits the datum must be shifted */
-	char				sign;		/* [s]igned or [u]nsigned */
-};
+/**
+ * struct ad5446_state - driver instance specific data
+ * @indio_dev:		the industrial I/O device
+ * @spi:		spi_device
+ * @chip_info:		chip model specific constants, available modes etc
+ * @reg:		supply regulator
+ * @poll_work:		bottom half of polling interrupt handler
+ * @vref_mv:		actual reference voltage used
+ * @xfer:		default spi transfer
+ * @msg:		default spi message
+ * @data:		spi transmit buffer
+ */

 struct ad5446_state {
 	struct iio_dev			*indio_dev;
@@ -33,14 +49,50 @@ struct ad5446_state {
 	unsigned short			vref_mv;
 	struct spi_transfer		xfer;
 	struct spi_message		msg;
-	unsigned short			data;
+	union {
+		unsigned short		d16;
+		unsigned char		d24[3];
+	} data;
+};
+
+/**
+ * struct ad5446_chip_info - chip specifc information
+ * @bits:		accuracy of the DAC in bits
+ * @storagebits:	number of bits written to the DAC
+ * @left_shift:		number of bits the datum must be shifted
+ * @sign:		data representation [s]igned or [u]nsigned
+ * @int_vref_mv:	AD5620/40/60: the internal reference voltage
+ * @store_sample:	chip specifc helper function to store the datum
+ */
+
+struct ad5446_chip_info {
+	u8				bits;
+	u8				storagebits;
+	u8				left_shift;
+	char				sign;
+	u16				int_vref_mv;
+	void (*store_sample)		(struct ad5446_state *st, unsigned val);
 };

+/**
+ * ad5446_supported_device_ids:
+ * The AD5620/40/60 parts are available in different fixed internal reference
+ * voltage options. The actual part numbers may look differently
+ * (and a bit cryptic), however this style is used to make clear which
+ * parts are supported here.
+ */
+
 enum ad5446_supported_device_ids {
 	ID_AD5444,
 	ID_AD5446,
 	ID_AD5542A,
 	ID_AD5512A,
+	ID_AD5620_2500,
+	ID_AD5620_1250,
+	ID_AD5640_2500,
+	ID_AD5640_1250,
+	ID_AD5660_2500,
+	ID_AD5660_1250,
 };

-#endif /* IIO_ADC_AD5446_H_ */
+#endif /* IIO_DAC_AD5446_H_ */
--
1.6.0.2
