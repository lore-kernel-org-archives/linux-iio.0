Return-Path: <linux-iio-owner@vger.kernel.org>
Received: from saturn.retrosnub.co.uk ([46.235.226.198]:33806 "EHLO
        saturn.retrosnub.co.uk" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1750928AbeETNr2 (ORCPT
        <rfc822;linux-iio@vger.kernel.org>); Sun, 20 May 2018 09:47:28 -0400
From: Jonathan Cameron <Jonathan.Cameron@huawei.com>
To: linux-iio@vger.kernel.org
Cc: lars@metafoo.de, Jonathan Cameron <Jonathan.Cameron@huawei.com>
Subject: [PATCH] staging: iio: Drop ADIS16060 driver from staging
Date: Sun, 20 May 2018 14:45:01 +0100
Message-Id: <20180520134501.25587-1-Jonathan.Cameron@huawei.com>
Sender: linux-iio-owner@vger.kernel.org
List-Id: linux-iio@vger.kernel.org

This part has been declared "not for new designs". It is now
difficult to obtain and we have had no-one come forward with hardware
making it difficult to proceed with the necessary work to move this
driver out of staging.

The device uses two separate chip selects and would require locking
between them which is thought to be difficult to enforce without
non trivial changes in the SPI subsystem.  This work simply isn't worth
doing given the status of the part and the fact no one seems to have
gone for a similar hardware design since this one.

If anyone does have access to one of these and is willing to contribute
the time necessary then we can reevaluate dropping the driver.

Signed-off-by: Jonathan Cameron <Jonathan.Cameron@huawei.com>
---
 drivers/staging/iio/Kconfig               |   1 -
 drivers/staging/iio/Makefile              |   1 -
 drivers/staging/iio/gyro/Kconfig          |  16 --
 drivers/staging/iio/gyro/Makefile         |   6 -
 drivers/staging/iio/gyro/adis16060_core.c | 234 ----------------------
 5 files changed, 258 deletions(-)

diff --git a/drivers/staging/iio/Kconfig b/drivers/staging/iio/Kconfig
index aee2335a25a1..e86ac9e47867 100644
--- a/drivers/staging/iio/Kconfig
+++ b/drivers/staging/iio/Kconfig
@@ -9,7 +9,6 @@ source "drivers/staging/iio/adc/Kconfig"
 source "drivers/staging/iio/addac/Kconfig"
 source "drivers/staging/iio/cdc/Kconfig"
 source "drivers/staging/iio/frequency/Kconfig"
-source "drivers/staging/iio/gyro/Kconfig"
 source "drivers/staging/iio/impedance-analyzer/Kconfig"
 source "drivers/staging/iio/meter/Kconfig"
 source "drivers/staging/iio/resolver/Kconfig"
diff --git a/drivers/staging/iio/Makefile b/drivers/staging/iio/Makefile
index c28d657497de..b15904b99581 100644
--- a/drivers/staging/iio/Makefile
+++ b/drivers/staging/iio/Makefile
@@ -8,7 +8,6 @@ obj-y += adc/
 obj-y += addac/
 obj-y += cdc/
 obj-y += frequency/
-obj-y += gyro/
 obj-y += impedance-analyzer/
 obj-y += meter/
 obj-y += resolver/
diff --git a/drivers/staging/iio/gyro/Kconfig b/drivers/staging/iio/gyro/Kconfig
deleted file mode 100644
index f62f68fd6f3f..000000000000
--- a/drivers/staging/iio/gyro/Kconfig
+++ /dev/null
@@ -1,16 +0,0 @@
-#
-# IIO Digital Gyroscope Sensor drivers configuration
-#
-menu "Digital gyroscope sensors"
-
-config ADIS16060
-	tristate "Analog Devices ADIS16060 Yaw Rate Gyroscope with SPI driver"
-	depends on SPI
-	help
-	  Say Y (yes) here to build support for Analog Devices adis16060 wide bandwidth
-	  yaw rate gyroscope with SPI.
-
-	  To compile this driver as a module, say M here: the module will be
-	  called adis16060. If unsure, say N.
-
-endmenu
diff --git a/drivers/staging/iio/gyro/Makefile b/drivers/staging/iio/gyro/Makefile
deleted file mode 100644
index cf22d6d55e27..000000000000
--- a/drivers/staging/iio/gyro/Makefile
+++ /dev/null
@@ -1,6 +0,0 @@
-#
-# Makefile for digital gyroscope sensor drivers
-#
-
-adis16060-y             := adis16060_core.o
-obj-$(CONFIG_ADIS16060) += adis16060.o
diff --git a/drivers/staging/iio/gyro/adis16060_core.c b/drivers/staging/iio/gyro/adis16060_core.c
deleted file mode 100644
index 4e7630caf7d3..000000000000
--- a/drivers/staging/iio/gyro/adis16060_core.c
+++ /dev/null
@@ -1,234 +0,0 @@
-/*
- * ADIS16060 Wide Bandwidth Yaw Rate Gyroscope with SPI driver
- *
- * Copyright 2010 Analog Devices Inc.
- *
- * Licensed under the GPL-2 or later.
- */
-
-#include <linux/module.h>
-#include <linux/delay.h>
-#include <linux/mutex.h>
-#include <linux/device.h>
-#include <linux/kernel.h>
-#include <linux/spi/spi.h>
-#include <linux/slab.h>
-#include <linux/sysfs.h>
-
-#include <linux/iio/iio.h>
-#include <linux/iio/sysfs.h>
-
-#define ADIS16060_GYRO		0x20 /* Measure Angular Rate (Gyro) */
-#define ADIS16060_TEMP_OUT	0x10 /* Measure Temperature */
-#define ADIS16060_AIN2		0x80 /* Measure AIN2 */
-#define ADIS16060_AIN1		0x40 /* Measure AIN1 */
-
-/**
- * struct adis16060_state - device instance specific data
- * @us_w:		actual spi_device to write config
- * @us_r:		actual spi_device to read back data
- * @buf:		transmit or receive buffer
- * @buf_lock:		mutex to protect tx and rx
- **/
-struct adis16060_state {
-	struct spi_device		*us_w;
-	struct spi_device		*us_r;
-	struct mutex			buf_lock;
-
-	u8 buf[3] ____cacheline_aligned;
-};
-
-static struct iio_dev *adis16060_iio_dev;
-
-static int adis16060_spi_write_then_read(struct iio_dev *indio_dev,
-					 u8 conf, u16 *val)
-{
-	int ret;
-	struct adis16060_state *st = iio_priv(indio_dev);
-
-	mutex_lock(&st->buf_lock);
-	st->buf[2] = conf; /* The last 8 bits clocked in are latched */
-	ret = spi_write(st->us_w, st->buf, 3);
-
-	if (ret < 0) {
-		mutex_unlock(&st->buf_lock);
-		return ret;
-	}
-
-	ret = spi_read(st->us_r, st->buf, 3);
-
-	/* The internal successive approximation ADC begins the
-	 * conversion process on the falling edge of MSEL1 and
-	 * starts to place data MSB first on the DOUT line at
-	 * the 6th falling edge of SCLK
-	 */
-	if (!ret)
-		*val = ((st->buf[0] & 0x3) << 12) |
-			(st->buf[1] << 4) |
-			((st->buf[2] >> 4) & 0xF);
-	mutex_unlock(&st->buf_lock);
-
-	return ret;
-}
-
-static int adis16060_read_raw(struct iio_dev *indio_dev,
-			      struct iio_chan_spec const *chan,
-			      int *val, int *val2,
-			      long mask)
-{
-	u16 tval = 0;
-	int ret;
-
-	switch (mask) {
-	case IIO_CHAN_INFO_RAW:
-		ret = adis16060_spi_write_then_read(indio_dev,
-						    chan->address, &tval);
-		if (ret < 0)
-			return ret;
-
-		*val = tval;
-		return IIO_VAL_INT;
-	case IIO_CHAN_INFO_OFFSET:
-		*val = -7;
-		*val2 = 461117;
-		return IIO_VAL_INT_PLUS_MICRO;
-	case IIO_CHAN_INFO_SCALE:
-		*val = 0;
-		*val2 = 34000;
-		return IIO_VAL_INT_PLUS_MICRO;
-	}
-
-	return -EINVAL;
-}
-
-static const struct iio_info adis16060_info = {
-	.read_raw = adis16060_read_raw,
-};
-
-static const struct iio_chan_spec adis16060_channels[] = {
-	{
-		.type = IIO_ANGL_VEL,
-		.modified = 1,
-		.channel2 = IIO_MOD_Z,
-		.info_mask_separate = BIT(IIO_CHAN_INFO_RAW),
-		.address = ADIS16060_GYRO,
-	}, {
-		.type = IIO_VOLTAGE,
-		.indexed = 1,
-		.channel = 0,
-		.info_mask_separate = BIT(IIO_CHAN_INFO_RAW),
-		.address = ADIS16060_AIN1,
-	}, {
-		.type = IIO_VOLTAGE,
-		.indexed = 1,
-		.channel = 1,
-		.info_mask_separate = BIT(IIO_CHAN_INFO_RAW),
-		.address = ADIS16060_AIN2,
-	}, {
-		.type = IIO_TEMP,
-		.indexed = 1,
-		.channel = 0,
-		.info_mask_separate = BIT(IIO_CHAN_INFO_RAW) |
-		BIT(IIO_CHAN_INFO_OFFSET) | BIT(IIO_CHAN_INFO_SCALE),
-		.address = ADIS16060_TEMP_OUT,
-	}
-};
-
-static int adis16060_r_probe(struct spi_device *spi)
-{
-	int ret;
-	struct adis16060_state *st;
-	struct iio_dev *indio_dev;
-
-	/* setup the industrialio driver allocated elements */
-	indio_dev = devm_iio_device_alloc(&spi->dev, sizeof(*st));
-	if (!indio_dev)
-		return -ENOMEM;
-	/* this is only used for removal purposes */
-	spi_set_drvdata(spi, indio_dev);
-	st = iio_priv(indio_dev);
-	st->us_r = spi;
-	mutex_init(&st->buf_lock);
-
-	indio_dev->name = spi->dev.driver->name;
-	indio_dev->dev.parent = &spi->dev;
-	indio_dev->info = &adis16060_info;
-	indio_dev->modes = INDIO_DIRECT_MODE;
-	indio_dev->channels = adis16060_channels;
-	indio_dev->num_channels = ARRAY_SIZE(adis16060_channels);
-
-	ret = devm_iio_device_register(&spi->dev, indio_dev);
-	if (ret)
-		return ret;
-
-	adis16060_iio_dev = indio_dev;
-	return 0;
-}
-
-static int adis16060_w_probe(struct spi_device *spi)
-{
-	int ret;
-	struct iio_dev *indio_dev = adis16060_iio_dev;
-	struct adis16060_state *st;
-
-	if (!indio_dev) {
-		ret =  -ENODEV;
-		goto error_ret;
-	}
-	st = iio_priv(indio_dev);
-	spi_set_drvdata(spi, indio_dev);
-	st->us_w = spi;
-	return 0;
-
-error_ret:
-	return ret;
-}
-
-static int adis16060_w_remove(struct spi_device *spi)
-{
-	return 0;
-}
-
-static struct spi_driver adis16060_r_driver = {
-	.driver = {
-		.name = "adis16060_r",
-	},
-	.probe = adis16060_r_probe,
-};
-
-static struct spi_driver adis16060_w_driver = {
-	.driver = {
-		.name = "adis16060_w",
-	},
-	.probe = adis16060_w_probe,
-	.remove = adis16060_w_remove,
-};
-
-static __init int adis16060_init(void)
-{
-	int ret;
-
-	ret = spi_register_driver(&adis16060_r_driver);
-	if (ret < 0)
-		return ret;
-
-	ret = spi_register_driver(&adis16060_w_driver);
-	if (ret < 0) {
-		spi_unregister_driver(&adis16060_r_driver);
-		return ret;
-	}
-
-	return 0;
-}
-module_init(adis16060_init);
-
-static __exit void adis16060_exit(void)
-{
-	spi_unregister_driver(&adis16060_w_driver);
-	spi_unregister_driver(&adis16060_r_driver);
-}
-module_exit(adis16060_exit);
-
-MODULE_AUTHOR("Barry Song <21cnbao@gmail.com>");
-MODULE_DESCRIPTION("Analog Devices ADIS16060 Yaw Rate Gyroscope Driver");
-MODULE_LICENSE("GPL v2");
-- 
2.17.0

