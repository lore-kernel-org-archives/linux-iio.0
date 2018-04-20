Return-Path: <linux-iio-owner@vger.kernel.org>
Received: from mail-wr0-f193.google.com ([209.85.128.193]:36649 "EHLO
        mail-wr0-f193.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1751237AbeDTTcG (ORCPT
        <rfc822;linux-iio@vger.kernel.org>); Fri, 20 Apr 2018 15:32:06 -0400
Date: Fri, 20 Apr 2018 21:32:01 +0200
From: David Veenstra <davidjulianveenstra@gmail.com>
To: lars@metafoo.de, jic23@kernel.org, pmeerw@pmeerw.net
Cc: robh+dt@kernel.org, Michael.Hennerich@analog.com, knaack.h@gmx.de,
        daniel.baluta@nxp.com, linux-iio@vger.kernel.org,
        devel@driverdev.osuosl.org, devicetree@vger.kernel.org
Subject: [PATCH v2 13/13] staging: iio: ad2s1200: Move driver out of staging
Message-ID: <826d15c281ea86d6e7677c7c12f1f54434cb4bbb.1524247563.git.davidjulianveenstra@gmail.com>
References: <cover.1524247563.git.davidjulianveenstra@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
In-Reply-To: <cover.1524247563.git.davidjulianveenstra@gmail.com>
Sender: linux-iio-owner@vger.kernel.org
List-Id: linux-iio@vger.kernel.org

Move the iio driver for the ad2s1200 resolver-to-digital
converter out of staging, into mainline iio subsystems.

Signed-off-by: David Veenstra <davidjulianveenstra@gmail.com>
---
Changes in v2:
  - Added commit message.
  - Also move device tree binding documentation out of staging.
  - Disabled move detection.

 .../devicetree/bindings/iio/resolver/ad2s1200.txt  |  16 ++
 .../bindings/staging/iio/resolver/ad2s1200.txt     |  16 --
 drivers/iio/Kconfig                                |   1 +
 drivers/iio/Makefile                               |   1 +
 drivers/iio/resolver/Kconfig                       |  17 ++
 drivers/iio/resolver/Makefile                      |   5 +
 drivers/iio/resolver/ad2s1200.c                    | 250 +++++++++++++++++++++
 drivers/staging/iio/resolver/Kconfig               |  12 -
 drivers/staging/iio/resolver/Makefile              |   1 -
 drivers/staging/iio/resolver/ad2s1200.c            | 250 ---------------------
 10 files changed, 290 insertions(+), 279 deletions(-)
 create mode 100644 Documentation/devicetree/bindings/iio/resolver/ad2s1200.txt
 delete mode 100644 Documentation/devicetree/bindings/staging/iio/resolver/ad2s1200.txt
 create mode 100644 drivers/iio/resolver/Kconfig
 create mode 100644 drivers/iio/resolver/Makefile
 create mode 100644 drivers/iio/resolver/ad2s1200.c
 delete mode 100644 drivers/staging/iio/resolver/ad2s1200.c

diff --git a/Documentation/devicetree/bindings/iio/resolver/ad2s1200.txt b/Documentation/devicetree/bindings/iio/resolver/ad2s1200.txt
new file mode 100644
index 000000000000..85c009987878
--- /dev/null
+++ b/Documentation/devicetree/bindings/iio/resolver/ad2s1200.txt
@@ -0,0 +1,16 @@
+Analog Devices AD2S1200 Resolver-to-Digital Converter
+
+Required properties:
+ - compatible : should be "adi,ad2s1200"
+ - reg : the SPI chip select number of the device
+ - sample-gpios : The GPIO pin connected to the SAMPLE line of the AD2S1200
+ - rdvel-gpios : The GPIO pin connected to the RDVEL line of the AD2S1200
+
+Example:
+
+	resolver {
+		compatible = "adi,ad2s1200";
+		reg = <4>;
+		sample-gpios = <&gpio 5 GPIO_ACTIVE_HIGH>;
+		rdvel-gpios = <&gpio 6 GPIO_ACTIVE_HIGH>;
+	};
diff --git a/Documentation/devicetree/bindings/staging/iio/resolver/ad2s1200.txt b/Documentation/devicetree/bindings/staging/iio/resolver/ad2s1200.txt
deleted file mode 100644
index 85c009987878..000000000000
--- a/Documentation/devicetree/bindings/staging/iio/resolver/ad2s1200.txt
+++ /dev/null
@@ -1,16 +0,0 @@
-Analog Devices AD2S1200 Resolver-to-Digital Converter
-
-Required properties:
- - compatible : should be "adi,ad2s1200"
- - reg : the SPI chip select number of the device
- - sample-gpios : The GPIO pin connected to the SAMPLE line of the AD2S1200
- - rdvel-gpios : The GPIO pin connected to the RDVEL line of the AD2S1200
-
-Example:
-
-	resolver {
-		compatible = "adi,ad2s1200";
-		reg = <4>;
-		sample-gpios = <&gpio 5 GPIO_ACTIVE_HIGH>;
-		rdvel-gpios = <&gpio 6 GPIO_ACTIVE_HIGH>;
-	};
diff --git a/drivers/iio/Kconfig b/drivers/iio/Kconfig
index b3c8c6ef0dff..4bec3ccbf4a1 100644
--- a/drivers/iio/Kconfig
+++ b/drivers/iio/Kconfig
@@ -92,6 +92,7 @@ source "drivers/iio/potentiometer/Kconfig"
 source "drivers/iio/potentiostat/Kconfig"
 source "drivers/iio/pressure/Kconfig"
 source "drivers/iio/proximity/Kconfig"
+source "drivers/iio/resolver/Kconfig"
 source "drivers/iio/temperature/Kconfig"
 
 endif # IIO
diff --git a/drivers/iio/Makefile b/drivers/iio/Makefile
index b16b2e9ddc40..1865361b8714 100644
--- a/drivers/iio/Makefile
+++ b/drivers/iio/Makefile
@@ -35,5 +35,6 @@ obj-y += potentiometer/
 obj-y += potentiostat/
 obj-y += pressure/
 obj-y += proximity/
+obj-y += resolver/
 obj-y += temperature/
 obj-y += trigger/
diff --git a/drivers/iio/resolver/Kconfig b/drivers/iio/resolver/Kconfig
new file mode 100644
index 000000000000..2ced9f22aa70
--- /dev/null
+++ b/drivers/iio/resolver/Kconfig
@@ -0,0 +1,17 @@
+#
+# Resolver/Synchro drivers
+#
+menu "Resolver to digital converters"
+
+config AD2S1200
+	tristate "Analog Devices ad2s1200/ad2s1205 driver"
+	depends on SPI
+	depends on GPIOLIB || COMPILE_TEST
+	help
+	  Say yes here to build support for Analog Devices spi resolver
+	  to digital converters, ad2s1200 and ad2s1205, provides direct access
+	  via sysfs.
+
+	  To compile this driver as a module, choose M here: the
+	  module will be called ad2s1200.
+endmenu
diff --git a/drivers/iio/resolver/Makefile b/drivers/iio/resolver/Makefile
new file mode 100644
index 000000000000..4e1dccae07e7
--- /dev/null
+++ b/drivers/iio/resolver/Makefile
@@ -0,0 +1,5 @@
+#
+# Makefile for Resolver/Synchro drivers
+#
+
+obj-$(CONFIG_AD2S1200) += ad2s1200.o
diff --git a/drivers/iio/resolver/ad2s1200.c b/drivers/iio/resolver/ad2s1200.c
new file mode 100644
index 000000000000..4f5dd28b174a
--- /dev/null
+++ b/drivers/iio/resolver/ad2s1200.c
@@ -0,0 +1,250 @@
+/*
+ * ad2s1200.c simple support for the ADI Resolver to Digital Converters:
+ * AD2S1200/1205
+ *
+ * Copyright (c) 2010-2010 Analog Devices Inc.
+ *
+ * This program is free software; you can redistribute it and/or modify
+ * it under the terms of the GNU General Public License version 2 as
+ * published by the Free Software Foundation.
+ *
+ */
+
+#include <linux/bitops.h>
+#include <linux/delay.h>
+#include <linux/device.h>
+#include <linux/gpio.h>
+#include <linux/gpio/consumer.h>
+#include <linux/module.h>
+#include <linux/mutex.h>
+#include <linux/spi/spi.h>
+#include <linux/sysfs.h>
+#include <linux/types.h>
+
+#include <linux/iio/iio.h>
+#include <linux/iio/sysfs.h>
+
+#define DRV_NAME "ad2s1200"
+
+/* input pin sample and rdvel is controlled by driver */
+#define AD2S1200_PN	2
+
+/* input clock on serial interface */
+#define AD2S1200_HZ	8192000
+/* clock period in nano second */
+#define AD2S1200_TSCLK	(1000000000 / AD2S1200_HZ)
+
+/**
+ * struct ad2s1200_state - driver instance specific data
+ * @lock:	protect driver state
+ * @sdev:	spi device
+ * @sample:	GPIO pin SAMPLE
+ * @rdvel:	GPIO pin RDVEL
+ * @rx:		buffer for spi transfers
+ */
+struct ad2s1200_state {
+	struct mutex lock;
+	struct spi_device *sdev;
+	struct gpio_desc *sample;
+	struct gpio_desc *rdvel;
+	u8 rx[2] ____cacheline_aligned;
+};
+
+static int ad2s1200_read_raw(struct iio_dev *indio_dev,
+			     struct iio_chan_spec const *chan,
+			     int *val,
+			     int *val2,
+			     long m)
+{
+	struct ad2s1200_state *st = iio_priv(indio_dev);
+	int ret = 0;
+	u16 vel;
+
+	/*
+	 * Below a fractional approximation of Pi is needed.
+	 * The following approximation will be used: 103993 / 33102.
+	 * This is accurate in 9 decimals places.
+	 *
+	 * This fraction is based on OEIS series of nominator/denominator
+	 * of convergents to Pi (A002485 and A002486).
+	 */
+	switch (m) {
+	case IIO_CHAN_INFO_SCALE:
+		switch (chan->type) {
+		case IIO_ANGL:
+			/*
+			 * 2 * Pi / (2^12 - 1) ~= 2 * 103993 / (33102 * 0xFFF)
+			 *
+			 * Since there only fit 3 whole radians in 360 degrees,
+			 * usage of iio_convert_raw_to_processed for this
+			 * channel will be highly inaccurate.
+			 */
+			*val = 103993;
+			*val2 = 16551 * 0xFFF;
+			return IIO_VAL_FRACTIONAL;
+		case IIO_ANGL_VEL:
+			/*
+			 * 2 * Pi ~= 2 * 103993 / 33102
+			 *
+			 * iio_convert_raw_to_processed uses integer
+			 * division. This will cause at most 5% error
+			 * (for very small values). But for 99.5% of the values
+			 * it will cause less that 1% error.
+			 */
+			*val = 103993;
+			*val2 = 16551;
+			return IIO_VAL_FRACTIONAL;
+		default:
+			return -EINVAL;
+		}
+		break;
+	case IIO_CHAN_INFO_RAW:
+		mutex_lock(&st->lock);
+		gpiod_set_value(st->sample, 0);
+
+		/* delay (6 * AD2S1200_TSCLK + 20) nano seconds */
+		udelay(1);
+		gpiod_set_value(st->sample, 1);
+		gpiod_set_value(st->rdvel, !!(chan->type == IIO_ANGL));
+
+		ret = spi_read(st->sdev, st->rx, 2);
+		if (ret < 0) {
+			mutex_unlock(&st->lock);
+			return ret;
+		}
+
+		vel = be16_to_cpup((__be16 *)st->rx);
+		switch (chan->type) {
+		case IIO_ANGL:
+			*val = vel >> 4;
+			break;
+		case IIO_ANGL_VEL:
+			*val = sign_extend32((s16)vel >> 4, 11);
+			break;
+		default:
+			mutex_unlock(&st->lock);
+			return -EINVAL;
+		}
+
+		/* delay (2 * AD2S1200_TSCLK + 20) ns for sample pulse */
+		udelay(1);
+		mutex_unlock(&st->lock);
+
+		return IIO_VAL_INT;
+	default:
+		break;
+	}
+
+	return -EINVAL;
+}
+
+static const struct iio_chan_spec ad2s1200_channels[] = {
+	{
+		.type = IIO_ANGL,
+		.indexed = 1,
+		.channel = 0,
+		.info_mask_separate = BIT(IIO_CHAN_INFO_RAW),
+		.info_mask_shared_by_type = BIT(IIO_CHAN_INFO_SCALE),
+	}, {
+		.type = IIO_ANGL_VEL,
+		.indexed = 1,
+		.channel = 0,
+		.info_mask_separate = BIT(IIO_CHAN_INFO_RAW),
+		.info_mask_shared_by_type = BIT(IIO_CHAN_INFO_SCALE),
+	}
+};
+
+static const struct iio_info ad2s1200_info = {
+	.read_raw = ad2s1200_read_raw,
+};
+
+static int ad2s1200_probe(struct spi_device *spi)
+{
+	unsigned short *pins = spi->dev.platform_data;
+	struct ad2s1200_state *st;
+	struct iio_dev *indio_dev;
+	struct device *dev;
+	int pn, ret = 0;
+
+	dev = &spi->dev;
+
+	if (pins) {
+		for (pn = 0; pn < AD2S1200_PN; pn++) {
+			ret = devm_gpio_request_one(dev, pins[pn],
+						    GPIOF_DIR_OUT,
+						    DRV_NAME);
+			if (ret) {
+				dev_err(dev,
+					"Failed to claim gpio %d\n: err=%d",
+					pins[pn],
+					ret);
+				return ret;
+			}
+		}
+	}
+
+	indio_dev = devm_iio_device_alloc(dev, sizeof(*st));
+	if (!indio_dev)
+		return -ENOMEM;
+
+	spi_set_drvdata(spi, indio_dev);
+	st = iio_priv(indio_dev);
+	mutex_init(&st->lock);
+	st->sdev = spi;
+
+	if (pins) {
+		st->sample = gpio_to_desc(pins[0]);
+		st->rdvel = gpio_to_desc(pins[1]);
+	} else {
+		st->sample = devm_gpiod_get(dev, "sample", GPIOD_OUT_LOW);
+		if (IS_ERR(st->sample)) {
+			dev_err(dev, "Failed to claim SAMPLE gpio: err=%ld\n",
+				PTR_ERR(st->sample));
+			return PTR_ERR(st->sample);
+		}
+
+		st->rdvel = devm_gpiod_get(dev, "rdvel", GPIOD_OUT_LOW);
+		if (IS_ERR(st->rdvel)) {
+			dev_err(dev, "Failed to claim RDVEL gpio: err=%ld\n",
+				PTR_ERR(st->rdvel));
+			return PTR_ERR(st->rdvel);
+		}
+	}
+
+	indio_dev->dev.parent = dev;
+	indio_dev->info = &ad2s1200_info;
+	indio_dev->modes = INDIO_DIRECT_MODE;
+	indio_dev->channels = ad2s1200_channels;
+	indio_dev->num_channels = ARRAY_SIZE(ad2s1200_channels);
+	indio_dev->name = spi_get_device_id(spi)->name;
+
+	ret = devm_iio_device_register(dev, indio_dev);
+	if (ret)
+		return ret;
+
+	spi->max_speed_hz = AD2S1200_HZ;
+	spi->mode = SPI_MODE_3;
+	spi_setup(spi);
+
+	return 0;
+}
+
+static const struct spi_device_id ad2s1200_id[] = {
+	{ "ad2s1200" },
+	{ "ad2s1205" },
+	{}
+};
+MODULE_DEVICE_TABLE(spi, ad2s1200_id);
+
+static struct spi_driver ad2s1200_driver = {
+	.driver = {
+		.name = DRV_NAME,
+	},
+	.probe = ad2s1200_probe,
+	.id_table = ad2s1200_id,
+};
+module_spi_driver(ad2s1200_driver);
+
+MODULE_AUTHOR("Graff Yang <graff.yang@gmail.com>");
+MODULE_DESCRIPTION("Analog Devices AD2S1200/1205 Resolver to Digital SPI driver");
+MODULE_LICENSE("GPL v2");
diff --git a/drivers/staging/iio/resolver/Kconfig b/drivers/staging/iio/resolver/Kconfig
index 1c7e2860d6b7..6a469ee6101f 100644
--- a/drivers/staging/iio/resolver/Kconfig
+++ b/drivers/staging/iio/resolver/Kconfig
@@ -13,18 +13,6 @@ config AD2S90
 	  To compile this driver as a module, choose M here: the
 	  module will be called ad2s90.
 
-config AD2S1200
-	tristate "Analog Devices ad2s1200/ad2s1205 driver"
-	depends on SPI
-	depends on GPIOLIB || COMPILE_TEST
-	help
-	  Say yes here to build support for Analog Devices spi resolver
-	  to digital converters, ad2s1200 and ad2s1205, provides direct access
-	  via sysfs.
-
-	  To compile this driver as a module, choose M here: the
-	  module will be called ad2s1200.
-
 config AD2S1210
 	tristate "Analog Devices ad2s1210 driver"
 	depends on SPI
diff --git a/drivers/staging/iio/resolver/Makefile b/drivers/staging/iio/resolver/Makefile
index 14375e444ebf..8d901dc7500b 100644
--- a/drivers/staging/iio/resolver/Makefile
+++ b/drivers/staging/iio/resolver/Makefile
@@ -3,5 +3,4 @@
 #
 
 obj-$(CONFIG_AD2S90) += ad2s90.o
-obj-$(CONFIG_AD2S1200) += ad2s1200.o
 obj-$(CONFIG_AD2S1210) += ad2s1210.o
diff --git a/drivers/staging/iio/resolver/ad2s1200.c b/drivers/staging/iio/resolver/ad2s1200.c
deleted file mode 100644
index 4f5dd28b174a..000000000000
--- a/drivers/staging/iio/resolver/ad2s1200.c
+++ /dev/null
@@ -1,250 +0,0 @@
-/*
- * ad2s1200.c simple support for the ADI Resolver to Digital Converters:
- * AD2S1200/1205
- *
- * Copyright (c) 2010-2010 Analog Devices Inc.
- *
- * This program is free software; you can redistribute it and/or modify
- * it under the terms of the GNU General Public License version 2 as
- * published by the Free Software Foundation.
- *
- */
-
-#include <linux/bitops.h>
-#include <linux/delay.h>
-#include <linux/device.h>
-#include <linux/gpio.h>
-#include <linux/gpio/consumer.h>
-#include <linux/module.h>
-#include <linux/mutex.h>
-#include <linux/spi/spi.h>
-#include <linux/sysfs.h>
-#include <linux/types.h>
-
-#include <linux/iio/iio.h>
-#include <linux/iio/sysfs.h>
-
-#define DRV_NAME "ad2s1200"
-
-/* input pin sample and rdvel is controlled by driver */
-#define AD2S1200_PN	2
-
-/* input clock on serial interface */
-#define AD2S1200_HZ	8192000
-/* clock period in nano second */
-#define AD2S1200_TSCLK	(1000000000 / AD2S1200_HZ)
-
-/**
- * struct ad2s1200_state - driver instance specific data
- * @lock:	protect driver state
- * @sdev:	spi device
- * @sample:	GPIO pin SAMPLE
- * @rdvel:	GPIO pin RDVEL
- * @rx:		buffer for spi transfers
- */
-struct ad2s1200_state {
-	struct mutex lock;
-	struct spi_device *sdev;
-	struct gpio_desc *sample;
-	struct gpio_desc *rdvel;
-	u8 rx[2] ____cacheline_aligned;
-};
-
-static int ad2s1200_read_raw(struct iio_dev *indio_dev,
-			     struct iio_chan_spec const *chan,
-			     int *val,
-			     int *val2,
-			     long m)
-{
-	struct ad2s1200_state *st = iio_priv(indio_dev);
-	int ret = 0;
-	u16 vel;
-
-	/*
-	 * Below a fractional approximation of Pi is needed.
-	 * The following approximation will be used: 103993 / 33102.
-	 * This is accurate in 9 decimals places.
-	 *
-	 * This fraction is based on OEIS series of nominator/denominator
-	 * of convergents to Pi (A002485 and A002486).
-	 */
-	switch (m) {
-	case IIO_CHAN_INFO_SCALE:
-		switch (chan->type) {
-		case IIO_ANGL:
-			/*
-			 * 2 * Pi / (2^12 - 1) ~= 2 * 103993 / (33102 * 0xFFF)
-			 *
-			 * Since there only fit 3 whole radians in 360 degrees,
-			 * usage of iio_convert_raw_to_processed for this
-			 * channel will be highly inaccurate.
-			 */
-			*val = 103993;
-			*val2 = 16551 * 0xFFF;
-			return IIO_VAL_FRACTIONAL;
-		case IIO_ANGL_VEL:
-			/*
-			 * 2 * Pi ~= 2 * 103993 / 33102
-			 *
-			 * iio_convert_raw_to_processed uses integer
-			 * division. This will cause at most 5% error
-			 * (for very small values). But for 99.5% of the values
-			 * it will cause less that 1% error.
-			 */
-			*val = 103993;
-			*val2 = 16551;
-			return IIO_VAL_FRACTIONAL;
-		default:
-			return -EINVAL;
-		}
-		break;
-	case IIO_CHAN_INFO_RAW:
-		mutex_lock(&st->lock);
-		gpiod_set_value(st->sample, 0);
-
-		/* delay (6 * AD2S1200_TSCLK + 20) nano seconds */
-		udelay(1);
-		gpiod_set_value(st->sample, 1);
-		gpiod_set_value(st->rdvel, !!(chan->type == IIO_ANGL));
-
-		ret = spi_read(st->sdev, st->rx, 2);
-		if (ret < 0) {
-			mutex_unlock(&st->lock);
-			return ret;
-		}
-
-		vel = be16_to_cpup((__be16 *)st->rx);
-		switch (chan->type) {
-		case IIO_ANGL:
-			*val = vel >> 4;
-			break;
-		case IIO_ANGL_VEL:
-			*val = sign_extend32((s16)vel >> 4, 11);
-			break;
-		default:
-			mutex_unlock(&st->lock);
-			return -EINVAL;
-		}
-
-		/* delay (2 * AD2S1200_TSCLK + 20) ns for sample pulse */
-		udelay(1);
-		mutex_unlock(&st->lock);
-
-		return IIO_VAL_INT;
-	default:
-		break;
-	}
-
-	return -EINVAL;
-}
-
-static const struct iio_chan_spec ad2s1200_channels[] = {
-	{
-		.type = IIO_ANGL,
-		.indexed = 1,
-		.channel = 0,
-		.info_mask_separate = BIT(IIO_CHAN_INFO_RAW),
-		.info_mask_shared_by_type = BIT(IIO_CHAN_INFO_SCALE),
-	}, {
-		.type = IIO_ANGL_VEL,
-		.indexed = 1,
-		.channel = 0,
-		.info_mask_separate = BIT(IIO_CHAN_INFO_RAW),
-		.info_mask_shared_by_type = BIT(IIO_CHAN_INFO_SCALE),
-	}
-};
-
-static const struct iio_info ad2s1200_info = {
-	.read_raw = ad2s1200_read_raw,
-};
-
-static int ad2s1200_probe(struct spi_device *spi)
-{
-	unsigned short *pins = spi->dev.platform_data;
-	struct ad2s1200_state *st;
-	struct iio_dev *indio_dev;
-	struct device *dev;
-	int pn, ret = 0;
-
-	dev = &spi->dev;
-
-	if (pins) {
-		for (pn = 0; pn < AD2S1200_PN; pn++) {
-			ret = devm_gpio_request_one(dev, pins[pn],
-						    GPIOF_DIR_OUT,
-						    DRV_NAME);
-			if (ret) {
-				dev_err(dev,
-					"Failed to claim gpio %d\n: err=%d",
-					pins[pn],
-					ret);
-				return ret;
-			}
-		}
-	}
-
-	indio_dev = devm_iio_device_alloc(dev, sizeof(*st));
-	if (!indio_dev)
-		return -ENOMEM;
-
-	spi_set_drvdata(spi, indio_dev);
-	st = iio_priv(indio_dev);
-	mutex_init(&st->lock);
-	st->sdev = spi;
-
-	if (pins) {
-		st->sample = gpio_to_desc(pins[0]);
-		st->rdvel = gpio_to_desc(pins[1]);
-	} else {
-		st->sample = devm_gpiod_get(dev, "sample", GPIOD_OUT_LOW);
-		if (IS_ERR(st->sample)) {
-			dev_err(dev, "Failed to claim SAMPLE gpio: err=%ld\n",
-				PTR_ERR(st->sample));
-			return PTR_ERR(st->sample);
-		}
-
-		st->rdvel = devm_gpiod_get(dev, "rdvel", GPIOD_OUT_LOW);
-		if (IS_ERR(st->rdvel)) {
-			dev_err(dev, "Failed to claim RDVEL gpio: err=%ld\n",
-				PTR_ERR(st->rdvel));
-			return PTR_ERR(st->rdvel);
-		}
-	}
-
-	indio_dev->dev.parent = dev;
-	indio_dev->info = &ad2s1200_info;
-	indio_dev->modes = INDIO_DIRECT_MODE;
-	indio_dev->channels = ad2s1200_channels;
-	indio_dev->num_channels = ARRAY_SIZE(ad2s1200_channels);
-	indio_dev->name = spi_get_device_id(spi)->name;
-
-	ret = devm_iio_device_register(dev, indio_dev);
-	if (ret)
-		return ret;
-
-	spi->max_speed_hz = AD2S1200_HZ;
-	spi->mode = SPI_MODE_3;
-	spi_setup(spi);
-
-	return 0;
-}
-
-static const struct spi_device_id ad2s1200_id[] = {
-	{ "ad2s1200" },
-	{ "ad2s1205" },
-	{}
-};
-MODULE_DEVICE_TABLE(spi, ad2s1200_id);
-
-static struct spi_driver ad2s1200_driver = {
-	.driver = {
-		.name = DRV_NAME,
-	},
-	.probe = ad2s1200_probe,
-	.id_table = ad2s1200_id,
-};
-module_spi_driver(ad2s1200_driver);
-
-MODULE_AUTHOR("Graff Yang <graff.yang@gmail.com>");
-MODULE_DESCRIPTION("Analog Devices AD2S1200/1205 Resolver to Digital SPI driver");
-MODULE_LICENSE("GPL v2");
-- 
2.16.2

