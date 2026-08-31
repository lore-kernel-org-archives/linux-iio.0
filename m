Received: from mail-pj2-f11.google.com (mail-pj2-f11.google.com [74.125.227.139])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id DE053381EB1
	for <linux-iio@vger.kernel.org>; Mon, 31 Aug 2026 18:49:54 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=74.125.227.139
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1788202196; cv=none; b=Ta7UMgbGs2uEhSiNIAqqrzvRcuhOJWWkQl/Ef20T4rCrglQnQIha0IcFtJfwEeMhru+62+hzrB/WLINvxMORzbV9hpIQrmPn70oQGJw8Lq5st4z8fbTMon5OGKtLJifwsjHCy3Uxpa6rZ2UFQWatneK1FZuAl/Ity3taGf7sCQs=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1788202196; c=relaxed/simple;
	bh=s3529gY1qIH6BXguBj4CoPENBg/23IaE8IfkBpE26AY=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=qAfxqsyrI+LYfAoruN8T7pea4h4NVmumWP7QzFsaDTV4EX7oWHm90c6Z9q5VwZbcLLs2MTmsOzgf4JjjqEQmj2W+YqkaSKpxuVSBG67y4/IwlW8/WLL7WAgj7zcUA7AHKu1eJRCC0NWCUkgUW1BntPqgzgu5qmRnpfm3hgSq72k=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=NLSWbKWt; arc=none smtp.client-ip=74.125.227.139
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="NLSWbKWt"
Received: by mail-pj2-f11.google.com with SMTP id 98e67ed59e1d1-38de693676dso2266256a91.0
        for <linux-iio@vger.kernel.org>; Mon, 31 Aug 2026 11:49:54 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1788202194; x=1788806994; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=m/QhCbTqT6PSPkMVYrCRegnwUxdw0V8vfoEBgpC5gqI=;
        b=NLSWbKWtcOXPF3nMUxpBHgIZmDMs272wkOa0SR3sedh3OqkrZInPv64hHxdLp8N4zE
         KRqtpEIIn+reQB7//1LwzSBEcu/O+2rRjYTkDHwl6J9NHcoivGdC0OZ+9Oe7ptD6ZGzt
         fXhpSqqdjSox3OpSqjDzPEi0oU4/E3KSUmNJntv90uLrJwk9wI28jTrMFDiW9BhW3uE2
         OTNZnXmm3YlVfHCaMi72JdLDxhxnR99dehVvnpxisnPpXXWkACGGGyRKxdC5l8Oo7fBA
         YSREUFIsfnFbPM5U0icw4VydUQAtGEWVuTn9vtsHOK35GJFPowslqsKMsvu+ru81xis3
         a6Yg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1788202194; x=1788806994;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to:content-type;
        bh=m/QhCbTqT6PSPkMVYrCRegnwUxdw0V8vfoEBgpC5gqI=;
        b=YzPmqAEMJyvZZB6WmGRt6SorCm/9jSTDISYyqIg/WZe5p+1PpB63tsjNmWkf61qv8u
         xLOfg4E01KjnTMJdiWhYZEGFVLKzzwgz04iOJ4NOtBYwXOBNdVeuTPVgA1n9rYhV2QnW
         4d/mlMII54xxVErIxEcVRJVcJ2yi1G9tgj7SCk4Qcerv7qKc6O0ssED3pHceywu2q4AI
         zoMavJ2fP+n4a4xleEDXtdTAqkmCpT7NoD2fkXKFhTcGyfK1LpLTDbzIb2MlkT4Jwblx
         JnGe+wnCdet7IeaYXQK1/q3sUQ6QL41vX3Vr1KwQUwBFJ/SZ3bYF5WPthd1D/MwWaOeJ
         6LJQ==
X-Forwarded-Encrypted: i=1; AKwUvBwuDchzhjwbt6k4wN+Jvb7lnTV99l4X4N9Ay4o7vF+mwjFJMNIZappDcvXxPUnyTgX4ftucv3Xy7p8=@vger.kernel.org
X-Gm-Message-State: AFuF++k0d9HuyIbB6CjmZGpHUy3YiI5RPyO5srSq680OizEFqF5rKSSO
	6+irOXpdrcpXX/fKQHsywQsjpBkq79hPgx+N+XLFNTrUq5aBbi1FcPSm
X-Gm-Gg: AYBFou0ufXgkuLmrr+oRrPQ64+oqfWSD4q209pyRLWjhR9IZJnYVObNvp2vHRLnXXvC
	xolu0dZ3nlJWAW0/jAdkH7w7MBBu8E+95beyElX25Pd4Jv2wqsl6674XlOql5vuRUdMUdSBvhtA
	O/ljyHLhAP2Y8Ebinr6S9K9xPlbLhv1v6/aYQhMN4E32YI8cGFwleUswL2LPpT2P0h3MUvb4PU0
	iVqnd/eUnpLSIHxH6Gh4ka5Lp5iW0oU7Zia29cvY02+fuelBmk6PdL8iJfujqgLlOUIIdJCisww
	fWrmBxokWadZe/q9rdyV/WQvxk7uQROKrj83oiMY4lUYZKW3UYd0tf9alwox95IYcmcFetYEFOl
	W5rmCwic+TiqedVRK1f4FYVDtxhzZlljldDOkS+fWy46Papwt0//4XYwYZ0AGGwFuSpbM9Ir3g7
	iwP05OKm9rfJr2ujb78bMHOpS17nihqXl3hvT1caCzd0g2fbF5N6iy4Ikt05Rg7+/oszTBDOQzL
	B9CSY6j
X-Received: by 2002:a17:90a:d407:b0:398:e73e:5a13 with SMTP id 98e67ed59e1d1-39907bbe00cmr3954695a91.9.1788202194123;
        Mon, 31 Aug 2026 11:49:54 -0700 (PDT)
Received: from DESKTOP-M0MLFVC.localdomain ([165.99.41.159])
        by smtp.gmail.com with ESMTPSA id a92af1059eb24-142e0dc854dsm29459223c88.10.2026.08.31.11.49.42
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 31 Aug 2026 11:49:53 -0700 (PDT)
From: Shehryar Ahmad <shehryar.amd@gmail.com>
To: jic23@kernel.org
Cc: nuno.sa@analog.com,
	Michael.Hennerich@analog.com,
	dlechner@baylibre.com,
	andy@kernel.org,
	gregkh@linuxfoundation.org,
	robh@kernel.org,
	krzk+dt@kernel.org,
	conor+dt@kernel.org,
	linux@analog.com,
	linux-iio@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	linux-staging@lists.linux.dev,
	devicetree@vger.kernel.org,
	marcelo.schmitt1@gmail.com,
	danascape@gmail.com,
	Shehryar Ahmad <shehryar.amd@gmail.com>
Subject: [PATCH 2/3] staging: iio: accel: remove adis16203, merged into mainline adis16201 driver
Date: Mon, 31 Aug 2026 23:42:00 +0500
Message-ID: <20260831184201.34416-3-shehryar.amd@gmail.com>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20260831184201.34416-1-shehryar.amd@gmail.com>
References: <20260831184201.34416-1-shehryar.amd@gmail.com>
Precedence: bulk
X-Mailing-List: linux-iio@vger.kernel.org
List-Id: <linux-iio.vger.kernel.org>
List-Subscribe: <mailto:linux-iio+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-iio+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

The ADIS16203 is merged with mainline ADIS16201 in previous patch of
series, remove the staging copy and its build system entries.

Signed-off-by: Shehryar Ahmad <shehryar.amd@gmail.com>
---
 drivers/staging/iio/Kconfig           |   1 -
 drivers/staging/iio/Makefile          |   1 -
 drivers/staging/iio/accel/Kconfig     |  19 --
 drivers/staging/iio/accel/Makefile    |   6 -
 drivers/staging/iio/accel/adis16203.c | 315 --------------------------
 5 files changed, 342 deletions(-)
 delete mode 100644 drivers/staging/iio/accel/Kconfig
 delete mode 100644 drivers/staging/iio/accel/Makefile
 delete mode 100644 drivers/staging/iio/accel/adis16203.c

diff --git a/drivers/staging/iio/Kconfig b/drivers/staging/iio/Kconfig
index a60631c1f..bf6addf29 100644
--- a/drivers/staging/iio/Kconfig
+++ b/drivers/staging/iio/Kconfig
@@ -5,7 +5,6 @@
 menu "IIO staging drivers"
 	depends on IIO
 
-source "drivers/staging/iio/accel/Kconfig"
 source "drivers/staging/iio/adc/Kconfig"
 source "drivers/staging/iio/addac/Kconfig"
 source "drivers/staging/iio/frequency/Kconfig"
diff --git a/drivers/staging/iio/Makefile b/drivers/staging/iio/Makefile
index 628583535..739e4cbf9 100644
--- a/drivers/staging/iio/Makefile
+++ b/drivers/staging/iio/Makefile
@@ -3,7 +3,6 @@
 # Makefile for the industrial I/O core.
 #
 
-obj-y += accel/
 obj-y += adc/
 obj-y += addac/
 obj-y += frequency/
diff --git a/drivers/staging/iio/accel/Kconfig b/drivers/staging/iio/accel/Kconfig
deleted file mode 100644
index cee51f64b..000000000
--- a/drivers/staging/iio/accel/Kconfig
+++ /dev/null
@@ -1,19 +0,0 @@
-# SPDX-License-Identifier: GPL-2.0
-#
-# Accelerometer drivers
-#
-menu "Accelerometers"
-
-config ADIS16203
-	tristate "Analog Devices ADIS16203 Programmable 360 Degrees Inclinometer"
-	depends on SPI
-	select IIO_ADIS_LIB
-	select IIO_ADIS_LIB_BUFFER if IIO_BUFFER
-	help
-	  Say Y here to build support for Analog Devices adis16203 Programmable
-	  360 Degrees Inclinometer.
-
-	  To compile this driver as a module, say M here: the module will be
-	  called adis16203.
-
-endmenu
diff --git a/drivers/staging/iio/accel/Makefile b/drivers/staging/iio/accel/Makefile
deleted file mode 100644
index acac7bc9b..000000000
--- a/drivers/staging/iio/accel/Makefile
+++ /dev/null
@@ -1,6 +0,0 @@
-# SPDX-License-Identifier: GPL-2.0
-#
-# Makefile for industrial I/O accelerometer drivers
-#
-
-obj-$(CONFIG_ADIS16203) += adis16203.o
diff --git a/drivers/staging/iio/accel/adis16203.c b/drivers/staging/iio/accel/adis16203.c
deleted file mode 100644
index 830ff38fd..000000000
--- a/drivers/staging/iio/accel/adis16203.c
+++ /dev/null
@@ -1,315 +0,0 @@
-// SPDX-License-Identifier: GPL-2.0+
-/*
- * ADIS16203 Programmable 360 Degrees Inclinometer
- *
- * Copyright 2010 Analog Devices Inc.
- */
-
-#include <linux/device.h>
-
-#include <linux/iio/iio.h>
-#include <linux/iio/imu/adis.h>
-
-#include <linux/kernel.h>
-#include <linux/module.h>
-#include <linux/spi/spi.h>
-
-#define ADIS16203_STARTUP_DELAY 220 /* ms */
-
-/* Flash memory write count */
-#define ADIS16203_FLASH_CNT      0x00
-
-/* Output, power supply */
-#define ADIS16203_SUPPLY_OUT     0x02
-
-/* Output, auxiliary ADC input */
-#define ADIS16203_AUX_ADC        0x08
-
-/* Output, temperature */
-#define ADIS16203_TEMP_OUT       0x0A
-
-/* Output, x-axis inclination */
-#define ADIS16203_XINCL_OUT      0x0C
-
-/* Output, y-axis inclination */
-#define ADIS16203_YINCL_OUT      0x0E
-
-/* Incline null calibration */
-#define ADIS16203_INCL_NULL      0x18
-
-/* Alarm 1 amplitude threshold */
-#define ADIS16203_ALM_MAG1       0x20
-
-/* Alarm 2 amplitude threshold */
-#define ADIS16203_ALM_MAG2       0x22
-
-/* Alarm 1, sample period */
-#define ADIS16203_ALM_SMPL1      0x24
-
-/* Alarm 2, sample period */
-#define ADIS16203_ALM_SMPL2      0x26
-
-/* Alarm control */
-#define ADIS16203_ALM_CTRL       0x28
-
-/* Auxiliary DAC data */
-#define ADIS16203_AUX_DAC        0x30
-
-/* General-purpose digital input/output control */
-#define ADIS16203_GPIO_CTRL      0x32
-
-/* Miscellaneous control */
-#define ADIS16203_MSC_CTRL       0x34
-
-/* Internal sample period (rate) control */
-#define ADIS16203_SMPL_PRD       0x36
-
-/* Operation, filter configuration */
-#define ADIS16203_AVG_CNT        0x38
-
-/* Operation, sleep mode control */
-#define ADIS16203_SLP_CNT        0x3A
-
-/* Diagnostics, system status register */
-#define ADIS16203_DIAG_STAT      0x3C
-
-/* Operation, system command register */
-#define ADIS16203_GLOB_CMD       0x3E
-
-/* MSC_CTRL */
-
-/* Self-test at power-on: 1 = disabled, 0 = enabled */
-#define ADIS16203_MSC_CTRL_PWRUP_SELF_TEST      BIT(10)
-
-/* Reverses rotation of both inclination outputs */
-#define ADIS16203_MSC_CTRL_REVERSE_ROT_EN       BIT(9)
-
-/* Self-test enable */
-#define ADIS16203_MSC_CTRL_SELF_TEST_EN         BIT(8)
-
-/* Data-ready enable: 1 = enabled, 0 = disabled */
-#define ADIS16203_MSC_CTRL_DATA_RDY_EN          BIT(2)
-
-/* Data-ready polarity: 1 = active high, 0 = active low */
-#define ADIS16203_MSC_CTRL_ACTIVE_HIGH          BIT(1)
-
-/* Data-ready line selection: 1 = DIO1, 0 = DIO0 */
-#define ADIS16203_MSC_CTRL_DATA_RDY_DIO1        BIT(0)
-
-/* DIAG_STAT */
-
-/* Alarm 2 status: 1 = alarm active, 0 = alarm inactive */
-#define ADIS16203_DIAG_STAT_ALARM2        BIT(9)
-
-/* Alarm 1 status: 1 = alarm active, 0 = alarm inactive */
-#define ADIS16203_DIAG_STAT_ALARM1        BIT(8)
-
-/* Self-test diagnostic error flag */
-#define ADIS16203_DIAG_STAT_SELFTEST_FAIL_BIT 5
-
-/* SPI communications failure */
-#define ADIS16203_DIAG_STAT_SPI_FAIL_BIT      3
-
-/* Flash update failure */
-#define ADIS16203_DIAG_STAT_FLASH_UPT_BIT     2
-
-/* Power supply above 3.625 V */
-#define ADIS16203_DIAG_STAT_POWER_HIGH_BIT    1
-
-/* Power supply below 2.975 V */
-#define ADIS16203_DIAG_STAT_POWER_LOW_BIT     0
-
-/* GLOB_CMD */
-
-#define ADIS16203_GLOB_CMD_SW_RESET     BIT(7)
-#define ADIS16203_GLOB_CMD_CLEAR_STAT   BIT(4)
-#define ADIS16203_GLOB_CMD_FACTORY_CAL  BIT(1)
-
-#define ADIS16203_ERROR_ACTIVE          BIT(14)
-
-enum adis16203_scan {
-	 ADIS16203_SCAN_INCLI_X,
-	 ADIS16203_SCAN_INCLI_Y,
-	 ADIS16203_SCAN_SUPPLY,
-	 ADIS16203_SCAN_AUX_ADC,
-	 ADIS16203_SCAN_TEMP,
-};
-
-#define DRIVER_NAME		"adis16203"
-
-static const u8 adis16203_addresses[] = {
-	[ADIS16203_SCAN_INCLI_X] = ADIS16203_INCL_NULL,
-};
-
-static int adis16203_write_raw(struct iio_dev *indio_dev,
-			       struct iio_chan_spec const *chan,
-			       int val,
-			       int val2,
-			       long mask)
-{
-	struct adis *st = iio_priv(indio_dev);
-	/* currently only one writable parameter which keeps this simple */
-	u8 addr = adis16203_addresses[chan->scan_index];
-
-	return adis_write_reg_16(st, addr, val & 0x3FFF);
-}
-
-static int adis16203_read_raw(struct iio_dev *indio_dev,
-			      struct iio_chan_spec const *chan,
-			      int *val, int *val2,
-			      long mask)
-{
-	struct adis *st = iio_priv(indio_dev);
-	int ret;
-	u8 addr;
-	s16 val16;
-
-	switch (mask) {
-	case IIO_CHAN_INFO_RAW:
-		return adis_single_conversion(indio_dev, chan,
-				ADIS16203_ERROR_ACTIVE, val);
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
-			*val = -470; /* -0.47 C */
-			*val2 = 0;
-			return IIO_VAL_INT_PLUS_MICRO;
-		case IIO_INCLI:
-			*val = 0;
-			*val2 = 25000; /* 0.025 degree */
-			return IIO_VAL_INT_PLUS_MICRO;
-		default:
-			return -EINVAL;
-		}
-	case IIO_CHAN_INFO_OFFSET:
-		*val = 25000 / -470 - 1278; /* 25 C = 1278 */
-		return IIO_VAL_INT;
-	case IIO_CHAN_INFO_CALIBBIAS:
-		addr = adis16203_addresses[chan->scan_index];
-		ret = adis_read_reg_16(st, addr, &val16);
-		if (ret)
-			return ret;
-		*val = sign_extend32(val16, 13);
-		return IIO_VAL_INT;
-	default:
-		return -EINVAL;
-	}
-}
-
-static const struct iio_chan_spec adis16203_channels[] = {
-	ADIS_SUPPLY_CHAN(ADIS16203_SUPPLY_OUT, ADIS16203_SCAN_SUPPLY, 0, 12),
-	ADIS_AUX_ADC_CHAN(ADIS16203_AUX_ADC, ADIS16203_SCAN_AUX_ADC, 0, 12),
-	ADIS_INCLI_CHAN(X, ADIS16203_XINCL_OUT, ADIS16203_SCAN_INCLI_X,
-			BIT(IIO_CHAN_INFO_CALIBBIAS), 0, 14),
-	/* Fixme: Not what it appears to be - see data sheet */
-	ADIS_INCLI_CHAN(Y, ADIS16203_YINCL_OUT, ADIS16203_SCAN_INCLI_Y,
-			0, 0, 14),
-	ADIS_TEMP_CHAN(ADIS16203_TEMP_OUT, ADIS16203_SCAN_TEMP, 0, 12),
-	IIO_CHAN_SOFT_TIMESTAMP(5),
-};
-
-static const struct iio_info adis16203_info = {
-	.read_raw = adis16203_read_raw,
-	.write_raw = adis16203_write_raw,
-	.update_scan_mode = adis_update_scan_mode,
-};
-
-static const char * const adis16203_status_error_msgs[] = {
-	[ADIS16203_DIAG_STAT_SELFTEST_FAIL_BIT] = "Self test failure",
-	[ADIS16203_DIAG_STAT_SPI_FAIL_BIT] = "SPI failure",
-	[ADIS16203_DIAG_STAT_FLASH_UPT_BIT] = "Flash update failed",
-	[ADIS16203_DIAG_STAT_POWER_HIGH_BIT] = "Power supply above 3.625V",
-	[ADIS16203_DIAG_STAT_POWER_LOW_BIT] = "Power supply below 2.975V",
-};
-
-static const struct adis_timeout adis16203_timeouts = {
-	.reset_ms = ADIS16203_STARTUP_DELAY,
-	.sw_reset_ms = ADIS16203_STARTUP_DELAY,
-	.self_test_ms = ADIS16203_STARTUP_DELAY
-};
-
-static const struct adis_data adis16203_data = {
-	.read_delay = 20,
-	.msc_ctrl_reg = ADIS16203_MSC_CTRL,
-	.glob_cmd_reg = ADIS16203_GLOB_CMD,
-	.diag_stat_reg = ADIS16203_DIAG_STAT,
-
-	.self_test_mask = ADIS16203_MSC_CTRL_SELF_TEST_EN,
-	.self_test_reg = ADIS16203_MSC_CTRL,
-	.self_test_no_autoclear = true,
-	.timeouts = &adis16203_timeouts,
-
-	.status_error_msgs = adis16203_status_error_msgs,
-	.status_error_mask = BIT(ADIS16203_DIAG_STAT_SELFTEST_FAIL_BIT) |
-		BIT(ADIS16203_DIAG_STAT_SPI_FAIL_BIT) |
-		BIT(ADIS16203_DIAG_STAT_FLASH_UPT_BIT) |
-		BIT(ADIS16203_DIAG_STAT_POWER_HIGH_BIT) |
-		BIT(ADIS16203_DIAG_STAT_POWER_LOW_BIT),
-};
-
-static int adis16203_probe(struct spi_device *spi)
-{
-	int ret;
-	struct iio_dev *indio_dev;
-	struct adis *st;
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
-	indio_dev->channels = adis16203_channels;
-	indio_dev->num_channels = ARRAY_SIZE(adis16203_channels);
-	indio_dev->info = &adis16203_info;
-	indio_dev->modes = INDIO_DIRECT_MODE;
-
-	ret = adis_init(st, indio_dev, spi, &adis16203_data);
-	if (ret)
-		return ret;
-
-	ret = devm_adis_setup_buffer_and_trigger(st, indio_dev, NULL);
-	if (ret)
-		return ret;
-
-	/* Get the device into a sane initial state */
-	ret = __adis_initial_startup(st);
-	if (ret)
-		return ret;
-
-	return devm_iio_device_register(&spi->dev, indio_dev);
-}
-
-static const struct of_device_id adis16203_of_match[] = {
-	{ .compatible = "adi,adis16203" },
-	{ }
-};
-
-MODULE_DEVICE_TABLE(of, adis16203_of_match);
-
-static struct spi_driver adis16203_driver = {
-	.driver = {
-		.name = "adis16203",
-		.of_match_table = adis16203_of_match,
-	},
-	.probe = adis16203_probe,
-};
-module_spi_driver(adis16203_driver);
-
-MODULE_AUTHOR("Barry Song <21cnbao@gmail.com>");
-MODULE_DESCRIPTION("Analog Devices ADIS16203 Programmable 360 Degrees Inclinometer");
-MODULE_LICENSE("GPL v2");
-MODULE_ALIAS("spi:adis16203");
-MODULE_IMPORT_NS("IIO_ADISLIB");
-- 
2.43.0

