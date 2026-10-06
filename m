Received: from mail-ed1-f48.google.com (mail-ed1-f48.google.com [209.85.208.48])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 79F5B3E1D0D
	for <linux-iio@vger.kernel.org>; Tue,  6 Oct 2026 11:51:35 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.208.48
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1791287497; cv=none; b=O39bIeVS8NjgNQwS6wroKPo6t+8wnfb14zdG6N0JyOfJMkLP/+8WnK951TxhGWGvSQORbDqcyRthKV73KMxV2lrTBeKq1QtRaS/Ww0Sfhhk1dnVXBk+eeqIHu61wsoVAu5Dx+yO98JvrkLqYsHB7hktQSZaopwkb6kKmFmCF/fk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1791287497; c=relaxed/simple;
	bh=1YXZs2DmZSNjAs9eWxEzuWZPu/J8GAykWsNE37mfL3k=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=NoTgOWMm0jwJkuTlDNbs+y4my0HL9X5ud8k2POYHrHtAvnOdqH5zXiBwCxfoUcb2+Ae6ahZzKuvVrm7SoOtD3l0N+5toyMbt1S2DXNvSyTcKBYIZ3xMnRTwon5RhExYNT5vEvMg6VOj/AyLGI3gL2qT9Q3zcIniy408FI/53R30=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=EBKozQlB; arc=none smtp.client-ip=209.85.208.48
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="EBKozQlB"
Received: by mail-ed1-f48.google.com with SMTP id 4fb4d7f45d1cf-6a9e5ba741aso843591a12.3
        for <linux-iio@vger.kernel.org>; Tue, 06 Oct 2026 04:51:35 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1791287494; x=1791892294; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to:content-type;
        bh=HeaZOxgi+yPw3XtmGhgaOnby0wPMS2WGx8jpxDJ0+rM=;
        b=EBKozQlBbIN51p82VhbawOpjsorQ1rl37pGNHnlX4ASb9RLTQTA3May1HDV9qgYLJt
         t0oNUywbStBqzbzi2FIY0BBr22ZcyPJK1gMGPmBYymk8N91v4t8biBQa1CHlHN7UTz8W
         c7eK5QRc4NCU/wTkreLKe9yDSSHG8TcKXftjRvHTTZNpAUC4D10zxG6/6pS3ADoasFvg
         LlJFA2kxcmlKibMS+fP+e+vZu6fn+BoWmknzbQy2LOvLKgwCVyjBzk3g9sBnoKnDuB9d
         LWC6STh0h0pkBI0GZGXfXGw4+yWMrstkAyPR+QBFSPetU5AIkymmw9CHfRmTgCgoJPtw
         7WUg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1791287494; x=1791892294;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=HeaZOxgi+yPw3XtmGhgaOnby0wPMS2WGx8jpxDJ0+rM=;
        b=rRSqxbfJKwq7C8lVxPhz6rjIPnqdsXG7n9kjHd4Zw9UoOXCXXcc+gseZcnEewDpGpo
         140mO5R5PwW6OBz1RURZdyKDtYNav9ioX08adzh1cFxqD2mzMR88wxJgYTcGbsW1gCgY
         fVuXrLuyul5CZuAehCu5MFo/z9XahxuDwNQTy7I6Y2qAZpYqXs0ZircgMUuWKcPVSlFT
         kzRuLeYsrcEyDw2/7mWB1RcBKN8kDBFkRPuPycV94M1GSkdvgFwqai2vjRu2sHbmwVeC
         5hUotWqeUmwkSGs2GxvnMLprAsIzrxEptPjGzQYu4mBral/M3DWBJnNnykVb6lphuowX
         Y1LA==
X-Forwarded-Encrypted: i=1; AKwUvBx1+/bP8Q2LfhRYh5qyMrF1LT+cst8FdDIjt48L4Jt0usmTdkHEmM/8ykPDClCDPS46XNSvmCDlV+4=@vger.kernel.org
X-Gm-Message-State: AFq9FYLUfE3mqDkCaoiZToqq9J/5iBS3b/iqS5AbLnTc2A6aPjCBNtAn
	H27ZQs6X1/Xi3ANmnkFi8wBtMzHJENE+1VTWO1w5t7ptYhrxxHiGDSiR5vvOZLx08Sg=
X-Gm-Gg: AYBFou2KA8Qk2D4w3bGs6o7I8uYr5fsQfb39j9DrgiEbzNo9HQpotISw0e4/aYhayrW
	a4g15dDPyaEX9ZvbuJpzz2n9KCyb581GB+eEdyT/ig9qKpAXSVwNqQwHEPHi6pKz7sENm07K2f5
	GVdjU9Hb4F1AKpJ1vfE/4dpu374+1sEzW2kNtOQJYsQ7omVq2YQ15xl6G4+r2jUPIWsFseKIz00
	j33EB8wtiDZWAc1oMh9XrivEzZqoJ6hOvRVJedcUt9+IMXItXAbNPLb1CgNB4ei+03xkuZTugKi
	7P5oHzGxLbxYoiKBPYMZpkgL+pHGQdY43eiPxkQny8seRXoIJoJW1cW92VL4X9RwmJ5AJkql3vJ
	MmjinX+vial19JPV/2kRg1P6RRsi5rTyLi8YJOpUgDu4lQrpg2UZsaG+RkMfrJpUuzdxAwpFSwl
	4idIK2kCLT3uijDmZ9s0b11z4tt1n/qF8D1uKI9Zkl0o10grzVnbhoR7T/Lv3NdCrZHYwXuZbD6
	hOG1y99SzjCuUz6U2fsmJ+TVVQfLcEMeia33nS+JU35gluBAy26mrmz1JQvrRISEyIO0xxRX1tX
	oz8fzW1+1wgjw+vdjdjsfWqQUK1Ksk0dTJWQP9dedMvSHkift9Nv4KMlG2onW/9+Psx1DdEHO2W
	pv37EPO1lWi+WlZywsQzr1dUy0r0xzSb8oeIZPvAFryL9ab4J/yOndB88H3dG3VeybakNcOHHXR
	Otvzz+ZxFnChmpnkeoE+a163p6N7KMYwdoPKewXkXqWkftm/E4n9UrtLpKPMDlwANQIAxnKzyIg
	RlE1z+Sygo=
X-Received: by 2002:a17:907:d20:b0:c29:d77b:66a0 with SMTP id a640c23a62f3a-c3169f8521fmr139623666b.10.1791287493237;
        Tue, 06 Oct 2026 04:51:33 -0700 (PDT)
Received: from cs-280612103108-default.europe-west4-a.c.od237066db22328bb-tp.internal (79.152.7.34.bc.googleusercontent.com. [34.7.152.79])
        by smtp.gmail.com with ESMTPSA id a640c23a62f3a-c316c842f9dsm35854766b.36.2026.10.06.04.51.32
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 06 Oct 2026 04:51:32 -0700 (PDT)
From: Joshua Crofts <joshua.crofts1@gmail.com>
To: Jonathan Cameron <jic23@kernel.org>,
	Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
	David Lechner <dlechner@baylibre.com>,
	=?UTF-8?q?Nuno=20S=C3=A1?= <nuno.sa@analog.com>,
	Andy Shevchenko <andy@kernel.org>,
	Michael Hennerich <Michael.Hennerich@analog.com>
Cc: linux-kernel@vger.kernel.org,
	linux-iio@vger.kernel.org,
	linux-staging@lists.linux.dev,
	linux@analog.com
Subject: [PATCH] staging: iio: adc: ad7816: remove obsolete driver
Date: Tue,  6 Oct 2026 11:51:19 +0000
Message-ID: <20261006115119.1416-1-joshua.crofts1@gmail.com>
X-Mailer: git-send-email 2.43.0
Precedence: bulk
X-Mailing-List: linux-iio@vger.kernel.org
List-Id: <linux-iio.vger.kernel.org>
List-Subscribe: <mailto:linux-iio+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-iio+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

The AD7816 driver has been in staging for 16 years and hasn't seen any
significant improvements for it to mature out of staging.

Additionally, the AD7816/AD7817/AD7818 have been obsolete for ~11 years.

Remove the entire adc/ subdirectory and references to it as this is the
only driver in it.

Signed-off-by: Joshua Crofts <joshua.crofts1@gmail.com>
---
If people want to use the AD7816, Analog Devices have their own fork of
the kernel where the driver is present [1].

Also, I don't see a point in keeping the driver for newcomers to
practice on, as all mechanical changes (checkpatch, cocci) have been
applied.

[1] https://github.com/analogdevicesinc/linux/blob/main/drivers/staging/iio/adc/ad7816.c
---
 drivers/staging/iio/Kconfig      |   1 -
 drivers/staging/iio/Makefile     |   1 -
 drivers/staging/iio/adc/Kconfig  |  18 --
 drivers/staging/iio/adc/Makefile |   6 -
 drivers/staging/iio/adc/ad7816.c | 464 -------------------------------
 5 files changed, 490 deletions(-)
 delete mode 100644 drivers/staging/iio/adc/Kconfig
 delete mode 100644 drivers/staging/iio/adc/Makefile
 delete mode 100644 drivers/staging/iio/adc/ad7816.c

diff --git a/drivers/staging/iio/Kconfig b/drivers/staging/iio/Kconfig
index bf6addf2974f..58d6859e039a 100644
--- a/drivers/staging/iio/Kconfig
+++ b/drivers/staging/iio/Kconfig
@@ -5,7 +5,6 @@
 menu "IIO staging drivers"
 	depends on IIO
 
-source "drivers/staging/iio/adc/Kconfig"
 source "drivers/staging/iio/addac/Kconfig"
 source "drivers/staging/iio/frequency/Kconfig"
 source "drivers/staging/iio/impedance-analyzer/Kconfig"
diff --git a/drivers/staging/iio/Makefile b/drivers/staging/iio/Makefile
index 739e4cbf9a7a..7768c4a8d278 100644
--- a/drivers/staging/iio/Makefile
+++ b/drivers/staging/iio/Makefile
@@ -3,7 +3,6 @@
 # Makefile for the industrial I/O core.
 #
 
-obj-y += adc/
 obj-y += addac/
 obj-y += frequency/
 obj-y += impedance-analyzer/
diff --git a/drivers/staging/iio/adc/Kconfig b/drivers/staging/iio/adc/Kconfig
deleted file mode 100644
index 2f0d6cf048d2..000000000000
--- a/drivers/staging/iio/adc/Kconfig
+++ /dev/null
@@ -1,18 +0,0 @@
-# SPDX-License-Identifier: GPL-2.0
-#
-# ADC drivers
-#
-menu "Analog to digital converters"
-
-config AD7816
-	tristate "Analog Devices AD7816/7/8 temperature sensor and ADC driver"
-	depends on SPI
-	depends on GPIOLIB || COMPILE_TEST
-	help
-	  Say yes here to build support for Analog Devices AD7816/7/8
-	  temperature sensors and ADC.
-
-	  To compile this driver as a module, choose M here: the
-	  module will be called ad7816.
-
-endmenu
diff --git a/drivers/staging/iio/adc/Makefile b/drivers/staging/iio/adc/Makefile
deleted file mode 100644
index 1e2a94c4db84..000000000000
--- a/drivers/staging/iio/adc/Makefile
+++ /dev/null
@@ -1,6 +0,0 @@
-# SPDX-License-Identifier: GPL-2.0
-#
-# Makefile for industrial I/O ADC drivers
-#
-
-obj-$(CONFIG_AD7816) += ad7816.o
diff --git a/drivers/staging/iio/adc/ad7816.c b/drivers/staging/iio/adc/ad7816.c
deleted file mode 100644
index 2a15d7598abb..000000000000
--- a/drivers/staging/iio/adc/ad7816.c
+++ /dev/null
@@ -1,464 +0,0 @@
-// SPDX-License-Identifier: GPL-2.0+
-/*
- * AD7816 digital temperature sensor driver supporting AD7816/7/8
- *
- * Copyright 2010 Analog Devices Inc.
- */
-
-#include <linux/cleanup.h>
-#include <linux/device.h>
-#include <linux/gpio/consumer.h>
-#include <linux/interrupt.h>
-#include <linux/kernel.h>
-#include <linux/list.h>
-#include <linux/module.h>
-#include <linux/mutex.h>
-#include <linux/slab.h>
-#include <linux/spi/spi.h>
-#include <linux/sysfs.h>
-
-#include <linux/iio/events.h>
-#include <linux/iio/iio.h>
-#include <linux/iio/sysfs.h>
-
-/*
- * AD7816 config masks
- */
-#define AD7816_FULL			0x1
-#define AD7816_PD			0x2
-#define AD7816_CS_MASK			0x7
-#define AD7816_CS_MAX			0x4
-
-/*
- * AD7816 temperature masks
- */
-#define AD7816_VALUE_OFFSET		6
-#define AD7816_BOUND_VALUE_BASE		0x8
-#define AD7816_BOUND_VALUE_MIN		-95
-#define AD7816_BOUND_VALUE_MAX		152
-#define AD7816_TEMP_FLOAT_OFFSET	2
-#define AD7816_TEMP_FLOAT_MASK		0x3
-
-/*
- * struct ad7816_chip_info - chip specific information
- */
-
-struct ad7816_chip_info {
-	kernel_ulong_t id;
-	struct spi_device *spi_dev;
-	struct gpio_desc *rdwr_pin;
-	struct gpio_desc *convert_pin;
-	struct gpio_desc *busy_pin;
-	struct mutex lock; /* protect device state during SPI transfers */
-	u8  oti_data[AD7816_CS_MAX + 1];
-	u8  channel_id;	/* 0 always be temperature */
-	u8  mode;
-};
-
-enum ad7816_type {
-	ID_AD7816,
-	ID_AD7817,
-	ID_AD7818,
-};
-
-/*
- * ad7816 data access by SPI
- */
-static int ad7816_spi_read(struct ad7816_chip_info *chip, u16 *data)
-{
-	struct spi_device *spi_dev = chip->spi_dev;
-	int ret;
-	__be16 buf;
-
-	guard(mutex)(&chip->lock);
-
-	gpiod_set_value(chip->rdwr_pin, 1);
-	gpiod_set_value(chip->rdwr_pin, 0);
-	ret = spi_write_then_read(spi_dev, &chip->channel_id, sizeof(chip->channel_id), NULL, 0);
-	if (ret < 0) {
-		dev_err(&spi_dev->dev, "SPI channel setting error\n");
-		return ret;
-	}
-	gpiod_set_value(chip->rdwr_pin, 1);
-
-	if (chip->mode == AD7816_PD) { /* operating mode 2 */
-		gpiod_set_value(chip->convert_pin, 1);
-		gpiod_set_value(chip->convert_pin, 0);
-	} else { /* operating mode 1 */
-		gpiod_set_value(chip->convert_pin, 0);
-		gpiod_set_value(chip->convert_pin, 1);
-	}
-
-	if (chip->id == ID_AD7816 || chip->id == ID_AD7817) {
-		while (gpiod_get_value(chip->busy_pin))
-			cpu_relax();
-	}
-
-	gpiod_set_value(chip->rdwr_pin, 0);
-	gpiod_set_value(chip->rdwr_pin, 1);
-	ret = spi_write_then_read(spi_dev, NULL, 0, &buf, sizeof(buf));
-	if (ret < 0) {
-		dev_err(&spi_dev->dev, "SPI data read error\n");
-		return ret;
-	}
-
-	*data = be16_to_cpu(buf);
-
-	return ret;
-}
-
-static int ad7816_spi_write(struct ad7816_chip_info *chip, u8 data)
-{
-	struct spi_device *spi_dev = chip->spi_dev;
-	int ret;
-
-	guard(mutex)(&chip->lock);
-
-	gpiod_set_value(chip->rdwr_pin, 1);
-	gpiod_set_value(chip->rdwr_pin, 0);
-	ret = spi_write_then_read(spi_dev, &data, sizeof(data), NULL, 0);
-	if (ret < 0)
-		dev_err(&spi_dev->dev, "SPI oti data write error\n");
-
-	return ret;
-}
-
-static ssize_t ad7816_show_mode(struct device *dev,
-				struct device_attribute *attr,
-				char *buf)
-{
-	struct iio_dev *indio_dev = dev_to_iio_dev(dev);
-	struct ad7816_chip_info *chip = iio_priv(indio_dev);
-
-	if (chip->mode)
-		return sysfs_emit(buf, "power-save\n");
-	return sysfs_emit(buf, "full\n");
-}
-
-static ssize_t ad7816_store_mode(struct device *dev,
-				 struct device_attribute *attr,
-				 const char *buf,
-				 size_t len)
-{
-	struct iio_dev *indio_dev = dev_to_iio_dev(dev);
-	struct ad7816_chip_info *chip = iio_priv(indio_dev);
-
-	guard(mutex)(&chip->lock);
-
-	if (strcmp(buf, "full") == 0) {
-		gpiod_set_value(chip->rdwr_pin, 1);
-		chip->mode = AD7816_FULL;
-	} else {
-		gpiod_set_value(chip->rdwr_pin, 0);
-		chip->mode = AD7816_PD;
-	}
-
-	return len;
-}
-
-static IIO_DEVICE_ATTR(mode, 0644,
-		ad7816_show_mode,
-		ad7816_store_mode,
-		0);
-
-static ssize_t ad7816_show_available_modes(struct device *dev,
-					   struct device_attribute *attr,
-					   char *buf)
-{
-	return sysfs_emit(buf, "full\npower-save\n");
-}
-
-static IIO_DEVICE_ATTR(available_modes, 0444, ad7816_show_available_modes,
-			NULL, 0);
-
-static ssize_t ad7816_show_channel(struct device *dev,
-				   struct device_attribute *attr,
-				   char *buf)
-{
-	struct iio_dev *indio_dev = dev_to_iio_dev(dev);
-	struct ad7816_chip_info *chip = iio_priv(indio_dev);
-
-	return sysfs_emit(buf, "%d\n", chip->channel_id);
-}
-
-static ssize_t ad7816_store_channel(struct device *dev,
-				    struct device_attribute *attr,
-				    const char *buf,
-				    size_t len)
-{
-	struct iio_dev *indio_dev = dev_to_iio_dev(dev);
-	struct ad7816_chip_info *chip = iio_priv(indio_dev);
-	unsigned long data;
-	int ret;
-
-	ret = kstrtoul(buf, 10, &data);
-	if (ret)
-		return ret;
-
-	if (data > AD7816_CS_MAX && data != AD7816_CS_MASK) {
-		dev_err(&chip->spi_dev->dev, "Invalid channel id %lu for %s.\n",
-			data, indio_dev->name);
-		return -EINVAL;
-	} else if (strcmp(indio_dev->name, "ad7818") == 0 && data > 1) {
-		dev_err(&chip->spi_dev->dev,
-			"Invalid channel id %lu for ad7818.\n", data);
-		return -EINVAL;
-	} else if (strcmp(indio_dev->name, "ad7816") == 0 && data > 0) {
-		dev_err(&chip->spi_dev->dev,
-			"Invalid channel id %lu for ad7816.\n", data);
-		return -EINVAL;
-	}
-
-	guard(mutex)(&chip->lock);
-
-	chip->channel_id = data;
-
-	return len;
-}
-
-static IIO_DEVICE_ATTR(channel, 0644,
-		ad7816_show_channel,
-		ad7816_store_channel,
-		0);
-
-static ssize_t ad7816_show_value(struct device *dev,
-				 struct device_attribute *attr,
-				 char *buf)
-{
-	struct iio_dev *indio_dev = dev_to_iio_dev(dev);
-	struct ad7816_chip_info *chip = iio_priv(indio_dev);
-	u16 data;
-	s8 value;
-	int ret;
-
-	ret = ad7816_spi_read(chip, &data);
-	if (ret)
-		return -EIO;
-
-	data >>= AD7816_VALUE_OFFSET;
-
-	if (chip->channel_id == 0) {
-		value = (s8)((data >> AD7816_TEMP_FLOAT_OFFSET) - 103);
-		data &= AD7816_TEMP_FLOAT_MASK;
-		if (value < 0)
-			data = BIT(AD7816_TEMP_FLOAT_OFFSET) - data;
-		return sysfs_emit(buf, "%d.%.2d\n", value, data * 25);
-	}
-	return sysfs_emit(buf, "%u\n", data);
-}
-
-static IIO_DEVICE_ATTR(value, 0444, ad7816_show_value, NULL, 0);
-
-static struct attribute *ad7816_attributes[] = {
-	&iio_dev_attr_available_modes.dev_attr.attr,
-	&iio_dev_attr_mode.dev_attr.attr,
-	&iio_dev_attr_channel.dev_attr.attr,
-	&iio_dev_attr_value.dev_attr.attr,
-	NULL,
-};
-
-static const struct attribute_group ad7816_attribute_group = {
-	.attrs = ad7816_attributes,
-};
-
-/*
- * temperature bound events
- */
-
-#define IIO_EVENT_CODE_AD7816_OTI IIO_UNMOD_EVENT_CODE(IIO_TEMP,	\
-						       0,		\
-						       IIO_EV_TYPE_THRESH, \
-						       IIO_EV_DIR_FALLING)
-
-static irqreturn_t ad7816_event_handler(int irq, void *private)
-{
-	iio_push_event(private, IIO_EVENT_CODE_AD7816_OTI,
-		       iio_get_time_ns(private));
-	return IRQ_HANDLED;
-}
-
-static ssize_t ad7816_show_oti(struct device *dev,
-			       struct device_attribute *attr,
-			       char *buf)
-{
-	struct iio_dev *indio_dev = dev_to_iio_dev(dev);
-	struct ad7816_chip_info *chip = iio_priv(indio_dev);
-	int value;
-
-	if (chip->channel_id > AD7816_CS_MAX) {
-		dev_err(dev, "Invalid oti channel id %d.\n", chip->channel_id);
-		return -EINVAL;
-	} else if (chip->channel_id == 0) {
-		value = AD7816_BOUND_VALUE_MIN +
-			(chip->oti_data[chip->channel_id] -
-			AD7816_BOUND_VALUE_BASE);
-		return sysfs_emit(buf, "%d\n", value);
-	}
-	return sysfs_emit(buf, "%u\n", chip->oti_data[chip->channel_id]);
-}
-
-static inline ssize_t ad7816_set_oti(struct device *dev,
-				     struct device_attribute *attr,
-				     const char *buf,
-				     size_t len)
-{
-	struct iio_dev *indio_dev = dev_to_iio_dev(dev);
-	struct ad7816_chip_info *chip = iio_priv(indio_dev);
-	long value;
-	u8 data;
-	int ret;
-
-	ret = kstrtol(buf, 10, &value);
-	if (ret)
-		return ret;
-
-	if (chip->channel_id > AD7816_CS_MAX) {
-		dev_err(dev, "Invalid oti channel id %d.\n", chip->channel_id);
-		return -EINVAL;
-	} else if (chip->channel_id == 0) {
-		if (value < AD7816_BOUND_VALUE_MIN ||
-		    value > AD7816_BOUND_VALUE_MAX)
-			return -EINVAL;
-
-		data = (u8)(value - AD7816_BOUND_VALUE_MIN +
-			AD7816_BOUND_VALUE_BASE);
-	} else {
-		if (value < AD7816_BOUND_VALUE_BASE || value > 255)
-			return -EINVAL;
-
-		data = (u8)value;
-	}
-
-	ret = ad7816_spi_write(chip, data);
-	if (ret)
-		return -EIO;
-
-	chip->oti_data[chip->channel_id] = data;
-
-	return len;
-}
-
-static IIO_DEVICE_ATTR(oti, 0644,
-		       ad7816_show_oti, ad7816_set_oti, 0);
-
-static struct attribute *ad7816_event_attributes[] = {
-	&iio_dev_attr_oti.dev_attr.attr,
-	NULL,
-};
-
-static const struct attribute_group ad7816_event_attribute_group = {
-	.attrs = ad7816_event_attributes,
-	.name = "events",
-};
-
-static const struct iio_info ad7816_info = {
-	.attrs = &ad7816_attribute_group,
-	.event_attrs = &ad7816_event_attribute_group,
-};
-
-/*
- * device probe and remove
- */
-
-static int ad7816_probe(struct spi_device *spi_dev)
-{
-	struct ad7816_chip_info *chip;
-	struct iio_dev *indio_dev;
-	int i, ret;
-
-	indio_dev = devm_iio_device_alloc(&spi_dev->dev, sizeof(*chip));
-	if (!indio_dev)
-		return -ENOMEM;
-	chip = iio_priv(indio_dev);
-
-	ret = devm_mutex_init(&spi_dev->dev, &chip->lock);
-	if (ret)
-		return ret;
-
-	chip->spi_dev = spi_dev;
-	for (i = 0; i <= AD7816_CS_MAX; i++)
-		chip->oti_data[i] = 203;
-
-	chip->id = spi_get_device_id(spi_dev)->driver_data;
-	chip->rdwr_pin = devm_gpiod_get(&spi_dev->dev, "rdwr", GPIOD_OUT_HIGH);
-	if (IS_ERR(chip->rdwr_pin)) {
-		ret = PTR_ERR(chip->rdwr_pin);
-		dev_err(&spi_dev->dev, "Failed to request rdwr GPIO: %d\n",
-			ret);
-		return ret;
-	}
-	chip->convert_pin = devm_gpiod_get(&spi_dev->dev, "convert",
-					   GPIOD_OUT_HIGH);
-	if (IS_ERR(chip->convert_pin)) {
-		ret = PTR_ERR(chip->convert_pin);
-		dev_err(&spi_dev->dev, "Failed to request convert GPIO: %d\n",
-			ret);
-		return ret;
-	}
-	if (chip->id == ID_AD7816 || chip->id == ID_AD7817) {
-		chip->busy_pin = devm_gpiod_get(&spi_dev->dev, "busy",
-						GPIOD_IN);
-		if (IS_ERR(chip->busy_pin)) {
-			ret = PTR_ERR(chip->busy_pin);
-			dev_err(&spi_dev->dev, "Failed to request busy GPIO: %d\n",
-				ret);
-			return ret;
-		}
-	}
-
-	indio_dev->name = spi_get_device_id(spi_dev)->name;
-	indio_dev->info = &ad7816_info;
-	indio_dev->modes = INDIO_DIRECT_MODE;
-
-	if (spi_dev->irq) {
-		/* Only low trigger is supported in ad7816/7/8 */
-		ret = devm_request_threaded_irq(&spi_dev->dev, spi_dev->irq,
-						NULL,
-						&ad7816_event_handler,
-						IRQF_TRIGGER_LOW | IRQF_ONESHOT,
-						indio_dev->name,
-						indio_dev);
-		if (ret)
-			return ret;
-	}
-
-	ret = devm_iio_device_register(&spi_dev->dev, indio_dev);
-	if (ret)
-		return ret;
-
-	dev_info(&spi_dev->dev, "%s temperature sensor and ADC registered.\n",
-		 indio_dev->name);
-
-	return 0;
-}
-
-static const struct of_device_id ad7816_of_match[] = {
-	{ .compatible = "adi,ad7816", },
-	{ .compatible = "adi,ad7817", },
-	{ .compatible = "adi,ad7818", },
-	{ }
-};
-MODULE_DEVICE_TABLE(of, ad7816_of_match);
-
-static const struct spi_device_id ad7816_id[] = {
-	{ .name = "ad7816", .driver_data = ID_AD7816 },
-	{ .name = "ad7817", .driver_data = ID_AD7817 },
-	{ .name = "ad7818", .driver_data = ID_AD7818 },
-	{ }
-};
-
-MODULE_DEVICE_TABLE(spi, ad7816_id);
-
-static struct spi_driver ad7816_driver = {
-	.driver = {
-		.name = "ad7816",
-		.of_match_table = ad7816_of_match,
-	},
-	.probe = ad7816_probe,
-	.id_table = ad7816_id,
-};
-module_spi_driver(ad7816_driver);
-
-MODULE_AUTHOR("Sonic Zhang <sonic.zhang@analog.com>");
-MODULE_DESCRIPTION("Analog Devices AD7816/7/8 digital temperature sensor driver");
-MODULE_LICENSE("GPL v2");
-- 
2.47.3

