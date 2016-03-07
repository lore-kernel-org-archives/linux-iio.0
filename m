Return-Path: <linux-iio-owner@vger.kernel.org>
Received: from smtp-out-074.synserver.de ([212.40.185.74]:1199 "EHLO
	smtp-out-070.synserver.de" rhost-flags-OK-OK-OK-FAIL)
	by vger.kernel.org with ESMTP id S1752273AbcCGOWl (ORCPT
	<rfc822;linux-iio@vger.kernel.org>); Mon, 7 Mar 2016 09:22:41 -0500
From: Lars-Peter Clausen <lars@metafoo.de>
To: Jonathan Cameron <jic23@kernel.org>
Cc: Hartmut Knaack <knaack.h@gmx.de>,
	Peter Meerwald <pmeerw@pmeerw.net>, linux-iio@vger.kernel.org,
	Lars-Peter Clausen <lars@metafoo.de>
Subject: [PATCH 1/2] staging:iio:adis16204: Remove adis16204 driver
Date: Mon,  7 Mar 2016 15:22:31 +0100
Message-Id: <1457360552-12314-1-git-send-email-lars@metafoo.de>
Sender: linux-iio-owner@vger.kernel.org
List-Id: linux-iio@vger.kernel.org

The ADIS16204 part has been obsoleted, which makes it hard to get the
hardware to even test the driver. Considering this there is no expectation
that the driver will be cleaned up and be able to move out of staging, so
remove the driver.

Signed-off-by: Lars-Peter Clausen <lars@metafoo.de>
---
 drivers/staging/iio/accel/Kconfig          |  12 --
 drivers/staging/iio/accel/Makefile         |   3 -
 drivers/staging/iio/accel/adis16204.h      |  68 --------
 drivers/staging/iio/accel/adis16204_core.c | 253 -----------------------------
 4 files changed, 336 deletions(-)
 delete mode 100644 drivers/staging/iio/accel/adis16204.h
 delete mode 100644 drivers/staging/iio/accel/adis16204_core.c

diff --git a/drivers/staging/iio/accel/Kconfig b/drivers/staging/iio/accel/Kconfig
index fa67da9..5bc9803 100644
--- a/drivers/staging/iio/accel/Kconfig
+++ b/drivers/staging/iio/accel/Kconfig
@@ -27,18 +27,6 @@ config ADIS16203
 	  To compile this driver as a module, say M here: the module will be
 	  called adis16203.
 
-config ADIS16204
-	tristate "Analog Devices ADIS16204 Programmable High-g Digital Impact Sensor and Recorder"
-	depends on SPI
-	select IIO_ADIS_LIB
-	select IIO_ADIS_LIB_BUFFER if IIO_BUFFER
-	help
-	  Say Y here to build support for Analog Devices adis16204 Programmable
-	  High-g Digital Impact Sensor and Recorder.
-
-	  To compile this driver as a module, say M here: the module will be
-	  called adis16204.
-
 config ADIS16209
 	tristate "Analog Devices ADIS16209 Dual-Axis Digital Inclinometer and Accelerometer"
 	depends on SPI
diff --git a/drivers/staging/iio/accel/Makefile b/drivers/staging/iio/accel/Makefile
index 1ed137f..8ad9732 100644
--- a/drivers/staging/iio/accel/Makefile
+++ b/drivers/staging/iio/accel/Makefile
@@ -8,9 +8,6 @@ obj-$(CONFIG_ADIS16201) += adis16201.o
 adis16203-y             := adis16203_core.o
 obj-$(CONFIG_ADIS16203) += adis16203.o
 
-adis16204-y             := adis16204_core.o
-obj-$(CONFIG_ADIS16204) += adis16204.o
-
 adis16209-y             := adis16209_core.o
 obj-$(CONFIG_ADIS16209) += adis16209.o
 
diff --git a/drivers/staging/iio/accel/adis16204.h b/drivers/staging/iio/accel/adis16204.h
deleted file mode 100644
index 0b23f0b..0000000
--- a/drivers/staging/iio/accel/adis16204.h
+++ /dev/null
@@ -1,68 +0,0 @@
-#ifndef SPI_ADIS16204_H_
-#define SPI_ADIS16204_H_
-
-#define ADIS16204_STARTUP_DELAY	220 /* ms */
-
-#define ADIS16204_FLASH_CNT      0x00 /* Flash memory write count */
-#define ADIS16204_SUPPLY_OUT     0x02 /* Output, power supply */
-#define ADIS16204_XACCL_OUT      0x04 /* Output, x-axis accelerometer */
-#define ADIS16204_YACCL_OUT      0x06 /* Output, y-axis accelerometer */
-#define ADIS16204_AUX_ADC        0x08 /* Output, auxiliary ADC input */
-#define ADIS16204_TEMP_OUT       0x0A /* Output, temperature */
-#define ADIS16204_X_PEAK_OUT     0x0C /* Twos complement */
-#define ADIS16204_Y_PEAK_OUT     0x0E /* Twos complement */
-#define ADIS16204_XACCL_NULL     0x10 /* Calibration, x-axis acceleration offset null */
-#define ADIS16204_YACCL_NULL     0x12 /* Calibration, y-axis acceleration offset null */
-#define ADIS16204_XACCL_SCALE    0x14 /* X-axis scale factor calibration register */
-#define ADIS16204_YACCL_SCALE    0x16 /* Y-axis scale factor calibration register */
-#define ADIS16204_XY_RSS_OUT     0x18 /* XY combined acceleration (RSS) */
-#define ADIS16204_XY_PEAK_OUT    0x1A /* Peak, XY combined output (RSS) */
-#define ADIS16204_CAP_BUF_1      0x1C /* Capture buffer output register 1 */
-#define ADIS16204_CAP_BUF_2      0x1E /* Capture buffer output register 2 */
-#define ADIS16204_ALM_MAG1       0x20 /* Alarm 1 amplitude threshold */
-#define ADIS16204_ALM_MAG2       0x22 /* Alarm 2 amplitude threshold */
-#define ADIS16204_ALM_CTRL       0x28 /* Alarm control */
-#define ADIS16204_CAPT_PNTR      0x2A /* Capture register address pointer */
-#define ADIS16204_AUX_DAC        0x30 /* Auxiliary DAC data */
-#define ADIS16204_GPIO_CTRL      0x32 /* General-purpose digital input/output control */
-#define ADIS16204_MSC_CTRL       0x34 /* Miscellaneous control */
-#define ADIS16204_SMPL_PRD       0x36 /* Internal sample period (rate) control */
-#define ADIS16204_AVG_CNT        0x38 /* Operation, filter configuration */
-#define ADIS16204_SLP_CNT        0x3A /* Operation, sleep mode control */
-#define ADIS16204_DIAG_STAT      0x3C /* Diagnostics, system status register */
-#define ADIS16204_GLOB_CMD       0x3E /* Operation, system command register */
-
-/* MSC_CTRL */
-#define ADIS16204_MSC_CTRL_PWRUP_SELF_TEST	BIT(10) /* Self-test at power-on: 1 = disabled, 0 = enabled */
-#define ADIS16204_MSC_CTRL_SELF_TEST_EN	        BIT(8)  /* Self-test enable */
-#define ADIS16204_MSC_CTRL_DATA_RDY_EN	        BIT(2)  /* Data-ready enable: 1 = enabled, 0 = disabled */
-#define ADIS16204_MSC_CTRL_ACTIVE_HIGH	        BIT(1)  /* Data-ready polarity: 1 = active high, 0 = active low */
-#define ADIS16204_MSC_CTRL_DATA_RDY_DIO2	BIT(0)  /* Data-ready line selection: 1 = DIO2, 0 = DIO1 */
-
-/* DIAG_STAT */
-#define ADIS16204_DIAG_STAT_ALARM2        BIT(9) /* Alarm 2 status: 1 = alarm active, 0 = alarm inactive */
-#define ADIS16204_DIAG_STAT_ALARM1        BIT(8) /* Alarm 1 status: 1 = alarm active, 0 = alarm inactive */
-#define ADIS16204_DIAG_STAT_SELFTEST_FAIL_BIT 5 /* Self-test diagnostic error flag: 1 = error condition,
-						0 = normal operation */
-#define ADIS16204_DIAG_STAT_SPI_FAIL_BIT      3 /* SPI communications failure */
-#define ADIS16204_DIAG_STAT_FLASH_UPT_BIT     2 /* Flash update failure */
-#define ADIS16204_DIAG_STAT_POWER_HIGH_BIT    1 /* Power supply above 3.625 V */
-#define ADIS16204_DIAG_STAT_POWER_LOW_BIT     0 /* Power supply below 2.975 V */
-
-/* GLOB_CMD */
-#define ADIS16204_GLOB_CMD_SW_RESET	BIT(7)
-#define ADIS16204_GLOB_CMD_CLEAR_STAT	BIT(4)
-#define ADIS16204_GLOB_CMD_FACTORY_CAL	BIT(1)
-
-#define ADIS16204_ERROR_ACTIVE          BIT(14)
-
-enum adis16204_scan {
-	ADIS16204_SCAN_ACC_X,
-	ADIS16204_SCAN_ACC_Y,
-	ADIS16204_SCAN_ACC_XY,
-	ADIS16204_SCAN_SUPPLY,
-	ADIS16204_SCAN_AUX_ADC,
-	ADIS16204_SCAN_TEMP,
-};
-
-#endif /* SPI_ADIS16204_H_ */
diff --git a/drivers/staging/iio/accel/adis16204_core.c b/drivers/staging/iio/accel/adis16204_core.c
deleted file mode 100644
index 20a9df6..0000000
--- a/drivers/staging/iio/accel/adis16204_core.c
+++ /dev/null
@@ -1,253 +0,0 @@
-/*
- * ADIS16204 Programmable High-g Digital Impact Sensor and Recorder
- *
- * Copyright 2010 Analog Devices Inc.
- *
- * Licensed under the GPL-2 or later.
- */
-
-#include <linux/interrupt.h>
-#include <linux/irq.h>
-#include <linux/delay.h>
-#include <linux/mutex.h>
-#include <linux/device.h>
-#include <linux/kernel.h>
-#include <linux/spi/spi.h>
-#include <linux/slab.h>
-#include <linux/sysfs.h>
-#include <linux/list.h>
-#include <linux/module.h>
-
-#include <linux/iio/iio.h>
-#include <linux/iio/sysfs.h>
-#include <linux/iio/buffer.h>
-#include <linux/iio/imu/adis.h>
-
-#include "adis16204.h"
-
-/* Unique to this driver currently */
-
-static const u8 adis16204_addresses[][2] = {
-	[ADIS16204_SCAN_ACC_X] = { ADIS16204_XACCL_NULL, ADIS16204_X_PEAK_OUT },
-	[ADIS16204_SCAN_ACC_Y] = { ADIS16204_YACCL_NULL, ADIS16204_Y_PEAK_OUT },
-	[ADIS16204_SCAN_ACC_XY] = { 0, ADIS16204_XY_PEAK_OUT },
-};
-
-static int adis16204_read_raw(struct iio_dev *indio_dev,
-			      struct iio_chan_spec const *chan,
-			      int *val, int *val2,
-			      long mask)
-{
-	struct adis *st = iio_priv(indio_dev);
-	int ret;
-	int bits;
-	u8 addr;
-	s16 val16;
-	int addrind;
-
-	switch (mask) {
-	case IIO_CHAN_INFO_RAW:
-		return adis_single_conversion(indio_dev, chan,
-				ADIS16204_ERROR_ACTIVE, val);
-	case IIO_CHAN_INFO_SCALE:
-		switch (chan->type) {
-		case IIO_VOLTAGE:
-			if (chan->channel == 0) {
-				*val = 1;
-				*val2 = 220000; /* 1.22 mV */
-			} else {
-				*val = 0;
-				*val2 = 610000; /* 0.61 mV */
-			}
-			return IIO_VAL_INT_PLUS_MICRO;
-		case IIO_TEMP:
-			*val = -470; /* 0.47 C */
-			*val2 = 0;
-			return IIO_VAL_INT_PLUS_MICRO;
-		case IIO_ACCEL:
-			*val = 0;
-			switch (chan->channel2) {
-			case IIO_MOD_X:
-			case IIO_MOD_ROOT_SUM_SQUARED_X_Y:
-				*val2 = IIO_G_TO_M_S_2(17125); /* 17.125 mg */
-				break;
-			case IIO_MOD_Y:
-			case IIO_MOD_Z:
-				*val2 = IIO_G_TO_M_S_2(8407); /* 8.407 mg */
-				break;
-			}
-			return IIO_VAL_INT_PLUS_MICRO;
-		default:
-			return -EINVAL;
-		}
-		break;
-	case IIO_CHAN_INFO_OFFSET:
-		*val = 25000 / -470 - 1278; /* 25 C = 1278 */
-		return IIO_VAL_INT;
-	case IIO_CHAN_INFO_CALIBBIAS:
-	case IIO_CHAN_INFO_PEAK:
-		if (mask == IIO_CHAN_INFO_CALIBBIAS) {
-			bits = 12;
-			addrind = 0;
-		} else { /* PEAK_SEPARATE */
-			bits = 14;
-			addrind = 1;
-		}
-		mutex_lock(&indio_dev->mlock);
-		addr = adis16204_addresses[chan->scan_index][addrind];
-		ret = adis_read_reg_16(st, addr, &val16);
-		if (ret) {
-			mutex_unlock(&indio_dev->mlock);
-			return ret;
-		}
-		val16 &= (1 << bits) - 1;
-		val16 = (s16)(val16 << (16 - bits)) >> (16 - bits);
-		*val = val16;
-		mutex_unlock(&indio_dev->mlock);
-		return IIO_VAL_INT;
-	}
-	return -EINVAL;
-}
-
-static int adis16204_write_raw(struct iio_dev *indio_dev,
-			       struct iio_chan_spec const *chan,
-			       int val,
-			       int val2,
-			       long mask)
-{
-	struct adis *st = iio_priv(indio_dev);
-	int bits;
-	s16 val16;
-	u8 addr;
-
-	switch (mask) {
-	case IIO_CHAN_INFO_CALIBBIAS:
-		switch (chan->type) {
-		case IIO_ACCEL:
-			bits = 12;
-			break;
-		default:
-			return -EINVAL;
-		}
-		val16 = val & ((1 << bits) - 1);
-		addr = adis16204_addresses[chan->scan_index][1];
-		return adis_write_reg_16(st, addr, val16);
-	}
-	return -EINVAL;
-}
-
-static const struct iio_chan_spec adis16204_channels[] = {
-	ADIS_SUPPLY_CHAN(ADIS16204_SUPPLY_OUT, ADIS16204_SCAN_SUPPLY, 0, 12),
-	ADIS_AUX_ADC_CHAN(ADIS16204_AUX_ADC, ADIS16204_SCAN_AUX_ADC, 0, 12),
-	ADIS_TEMP_CHAN(ADIS16204_TEMP_OUT, ADIS16204_SCAN_TEMP, 0, 12),
-	ADIS_ACCEL_CHAN(X, ADIS16204_XACCL_OUT, ADIS16204_SCAN_ACC_X,
-			BIT(IIO_CHAN_INFO_CALIBBIAS) | BIT(IIO_CHAN_INFO_PEAK),
-			0, 14),
-	ADIS_ACCEL_CHAN(Y, ADIS16204_YACCL_OUT, ADIS16204_SCAN_ACC_Y,
-			BIT(IIO_CHAN_INFO_CALIBBIAS) | BIT(IIO_CHAN_INFO_PEAK),
-			0, 14),
-	ADIS_ACCEL_CHAN(ROOT_SUM_SQUARED_X_Y, ADIS16204_XY_RSS_OUT,
-			ADIS16204_SCAN_ACC_XY, BIT(IIO_CHAN_INFO_PEAK), 0, 14),
-	IIO_CHAN_SOFT_TIMESTAMP(5),
-};
-
-static const struct iio_info adis16204_info = {
-	.read_raw = &adis16204_read_raw,
-	.write_raw = &adis16204_write_raw,
-	.update_scan_mode = adis_update_scan_mode,
-	.driver_module = THIS_MODULE,
-};
-
-static const char * const adis16204_status_error_msgs[] = {
-	[ADIS16204_DIAG_STAT_SELFTEST_FAIL_BIT] = "Self test failure",
-	[ADIS16204_DIAG_STAT_SPI_FAIL_BIT] = "SPI failure",
-	[ADIS16204_DIAG_STAT_FLASH_UPT_BIT] = "Flash update failed",
-	[ADIS16204_DIAG_STAT_POWER_HIGH_BIT] = "Power supply above 3.625V",
-	[ADIS16204_DIAG_STAT_POWER_LOW_BIT] = "Power supply below 2.975V",
-};
-
-static const struct adis_data adis16204_data = {
-	.read_delay = 20,
-	.msc_ctrl_reg = ADIS16204_MSC_CTRL,
-	.glob_cmd_reg = ADIS16204_GLOB_CMD,
-	.diag_stat_reg = ADIS16204_DIAG_STAT,
-
-	.self_test_mask = ADIS16204_MSC_CTRL_SELF_TEST_EN,
-	.startup_delay = ADIS16204_STARTUP_DELAY,
-
-	.status_error_msgs = adis16204_status_error_msgs,
-	.status_error_mask = BIT(ADIS16204_DIAG_STAT_SELFTEST_FAIL_BIT) |
-		BIT(ADIS16204_DIAG_STAT_SPI_FAIL_BIT) |
-		BIT(ADIS16204_DIAG_STAT_FLASH_UPT_BIT) |
-		BIT(ADIS16204_DIAG_STAT_POWER_HIGH_BIT) |
-		BIT(ADIS16204_DIAG_STAT_POWER_LOW_BIT),
-};
-
-static int adis16204_probe(struct spi_device *spi)
-{
-	int ret;
-	struct adis *st;
-	struct iio_dev *indio_dev;
-
-	/* setup the industrialio driver allocated elements */
-	indio_dev = devm_iio_device_alloc(&spi->dev, sizeof(*st));
-	if (!indio_dev)
-		return -ENOMEM;
-	st = iio_priv(indio_dev);
-	/* this is only used for removal purposes */
-	spi_set_drvdata(spi, indio_dev);
-
-	indio_dev->name = spi->dev.driver->name;
-	indio_dev->dev.parent = &spi->dev;
-	indio_dev->info = &adis16204_info;
-	indio_dev->channels = adis16204_channels;
-	indio_dev->num_channels = ARRAY_SIZE(adis16204_channels);
-	indio_dev->modes = INDIO_DIRECT_MODE;
-
-	ret = adis_init(st, indio_dev, spi, &adis16204_data);
-	if (ret)
-		return ret;
-
-	ret = adis_setup_buffer_and_trigger(st, indio_dev, NULL);
-	if (ret)
-		return ret;
-
-	/* Get the device into a sane initial state */
-	ret = adis_initial_startup(st);
-	if (ret)
-		goto error_cleanup_buffer_trigger;
-	ret = iio_device_register(indio_dev);
-	if (ret)
-		goto error_cleanup_buffer_trigger;
-
-	return 0;
-
-error_cleanup_buffer_trigger:
-	adis_cleanup_buffer_and_trigger(st, indio_dev);
-	return ret;
-}
-
-static int adis16204_remove(struct spi_device *spi)
-{
-	struct iio_dev *indio_dev = spi_get_drvdata(spi);
-	struct adis *st = iio_priv(indio_dev);
-
-	iio_device_unregister(indio_dev);
-	adis_cleanup_buffer_and_trigger(st, indio_dev);
-
-	return 0;
-}
-
-static struct spi_driver adis16204_driver = {
-	.driver = {
-		.name = "adis16204",
-	},
-	.probe = adis16204_probe,
-	.remove = adis16204_remove,
-};
-module_spi_driver(adis16204_driver);
-
-MODULE_AUTHOR("Barry Song <21cnbao@gmail.com>");
-MODULE_DESCRIPTION("ADIS16204 High-g Digital Impact Sensor and Recorder");
-MODULE_LICENSE("GPL v2");
-MODULE_ALIAS("spi:adis16204");
-- 
2.1.4

