Received: from mail-qk1-f182.google.com (mail-qk1-f182.google.com [209.85.222.182])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3B140313272
	for <linux-iio@vger.kernel.org>; Mon, 18 May 2026 15:21:21 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.222.182
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1779117683; cv=none; b=qCzF+Anm/YyIY0Bit6IvB52IJ4mxOYCzZNZDvHugCTmesJ/gMGvezVyHUqd37+sS8JA1mjuz1Qt27f9bj4wtEgxFq0yKYthMRSxs4jhhDFRnW+m5ftEQjBveNFyUtuDL0wYlQvyC5bAJUHzVDez3PPMIeCUfw+roDZpmetm/vjY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1779117683; c=relaxed/simple;
	bh=9QB+FL+8fOgHPAf3VOjSBEfCH8eYqep9G1Eqn0HgZ68=;
	h=From:Date:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=iALWHqrnRMV8NSbrq6LprSK6V0mUidq3gnBha4+6TxJJbOlBlXFmEEFFLRFrI7cp6/SD+ga3C86O++SL/QtM74Jo0yHBhmKNpZj+2KxUz99q7XU9OW38f0bPPFYAsOz1ds0ePZYHmEA2BSO6pm00GFapRy9GJE3nY4vv+GUiy1g=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=WgxgF4Kq; arc=none smtp.client-ip=209.85.222.182
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="WgxgF4Kq"
Received: by mail-qk1-f182.google.com with SMTP id af79cd13be357-90d1f03238bso336566885a.1
        for <linux-iio@vger.kernel.org>; Mon, 18 May 2026 08:21:21 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1779117679; x=1779722479; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:date:from:from:to:cc:subject:date:message-id:reply-to;
        bh=7mKc9VNZ1T4lw9dkqyOvvk8GIHq3GkLIAs6uk7WRC3A=;
        b=WgxgF4Kqdx24jdIV5/N3f7BA2liX0IYe1yxCIBnjNr8rT8yVC7e4Oxf50p8Btfc1E1
         6ob3iZdi1+80fO5MT+Ndx7mAhwfa0tTwM68nPs4MRITffUIeH71U6C20a+xl+a7tXuoh
         fShLUc6iWVPEN2pjR3eKxxW3XJL7D3sB+I0/rBhOt299HxLYH3MjWqaRUabjtQtcDZKT
         giDwl37ar+UrdR0lq66YZCKoWy0FH090+QLhx8O/u246cRw1Urm5rRFyuonCUyl2CrF3
         e1Kcm77yb4DDxnyocD4txS6Wfyg/PxR9E0CoWC3uFCa4tP1q1FN+JnzrHorW4aoVee+G
         lhyg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1779117679; x=1779722479;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:date:from:x-gm-gg:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=7mKc9VNZ1T4lw9dkqyOvvk8GIHq3GkLIAs6uk7WRC3A=;
        b=q3LfXd67RBrPSKlqF/MgACTMsH4Oh238Djzi9zi4Q6Lvd2g9PAwokSdghCfaLrUGyg
         qqG+jJLiLwJu4lgQPYq9yukbTTIEY5wRBWVG5Egq31GvtgpBvVIWnJePKNaCGsa58OF4
         A3/RG2WXk90Z9Q2CdOcD+ZfkQMPKv36jVhsqHts+9i/FZ61DxtUE46dulw8cNXlTU7y7
         INqQiS/1Rih/AVBAg9UsSS4lULcBd+LjzTgGTFso9pqn5elhUtqOyhRPfiSY9cmZyn3O
         O08COSiJGFuFZeOGa4zK2oRnwaGG0SMUhJwYHAWAtAGwtxslsmZtFXqwnpAks+/0MLl9
         Sl7Q==
X-Gm-Message-State: AOJu0YzesEvS+KCYe4KIcA9B//uc4mg6/ZSCRG5vbZ/hB9WYHoNvruEB
	UnURsNB4B69OL9hHDjAfLrYmjhhTmfaIPvWCSrXw6IAElr/pf9SQi71AZnCHfumR2so=
X-Gm-Gg: Acq92OHkV35gg93tsvEUC3UHwlBalUn4QkQ9VyCDFVZPDz3i4qCh4tkuVG3zN9AU1V0
	OuicKL9UnLeeURkQqkxjIA4XIWUkAAgDut0/+MyvXodn2l+d1dR0XtEGHj3WdNXDDgT9UBAde/0
	bRzi6SOJiUvz4Didj0MzFLhRvoD2K826HP/+Nw/gnflSDe92rxUI6kr31fhMZOW+oiiU/xTV+bQ
	yoXym8/jWJ7XA0mdqO1XVMwZLAjJUEf39bDO2Q1DCHmHEs6XqMbqFqPMCaH8vxVc8DQF/zzAJli
	bHoANdbfkw4GulbJ/J+MO3Dp74uEl8tedeUiR5m3SWTmcM4eyo08sLfz43eWLbzOCTESK4fHj4G
	Kq8qB6F3bRYSMnFvMPgO63Qq5QYJnWmz1fvnVDnuQFbsZBr6Yq8ZEmj+MLxHFE99FDqAIcHU2oW
	U/FkozOWBCq6cD01ZHmuRl2RHEOnaq136f
X-Received: by 2002:a05:620a:17a6:b0:911:4885:9112 with SMTP id af79cd13be357-91148859a45mr2266099085a.2.1779117679224;
        Mon, 18 May 2026 08:21:19 -0700 (PDT)
Received: from localhost ([2804:30c:1f02:6000:8b59:7c96:762e:9faa])
        by smtp.gmail.com with ESMTPSA id af79cd13be357-91433530506sm425651585a.44.2026.05.18.08.21.17
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 18 May 2026 08:21:18 -0700 (PDT)
From: Marcelo Schmitt <marcelo.schmitt1@gmail.com>
X-Google-Original-From: Marcelo Schmitt <marcelo.schmitt@analog.com>
Date: Mon, 18 May 2026 12:21:33 -0300
To: linux-iio@vger.kernel.org, devicetree@vger.kernel.org,
	linux-kernel@vger.kernel.org
Cc: jic23@kernel.org, nuno.sa@analog.com, Michael.Hennerich@analog.com,
	dlechner@baylibre.com, andy@kernel.org, robh@kernel.org,
	krzk+dt@kernel.org, conor+dt@kernel.org, marcelo.schmitt1@gmail.com
Subject: [PATCH v1 2/4] iio: adc: Add support for LTC2378-20 and similar ADCs
Message-ID: <301e4fc7544a485b56e7a8b91c3b66f5ac98e842.1779117444.git.marcelo.schmitt1@gmail.com>
References: <cover.1779117444.git.marcelo.schmitt1@gmail.com>
Precedence: bulk
X-Mailing-List: linux-iio@vger.kernel.org
List-Id: <linux-iio.vger.kernel.org>
List-Subscribe: <mailto:linux-iio+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-iio+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <cover.1779117444.git.marcelo.schmitt1@gmail.com>

From: Marcelo Schmitt <marcelo.schmitt@analog.com>

Initial support for LTC2378-20 and similar analog-to-digital converters.

Signed-off-by: Marcelo Schmitt <marcelo.schmitt@analog.com>
---
The data union for the sample data and the filling of IIO channel scan_type
struct could probably have been avoided and postponed. Though, that would
probably imply larger git diffs in the buffer patches so I added those earlier
to minimize diff size in the buffer patches.

 MAINTAINERS               |   1 +
 drivers/iio/adc/Kconfig   |  12 ++
 drivers/iio/adc/Makefile  |   1 +
 drivers/iio/adc/ltc2378.c | 352 ++++++++++++++++++++++++++++++++++++++
 drivers/iio/adc/ltc2378.h |  48 ++++++
 5 files changed, 414 insertions(+)
 create mode 100644 drivers/iio/adc/ltc2378.c
 create mode 100644 drivers/iio/adc/ltc2378.h

diff --git a/MAINTAINERS b/MAINTAINERS
index 768f56eea476..d9a772ac599c 100644
--- a/MAINTAINERS
+++ b/MAINTAINERS
@@ -15201,6 +15201,7 @@ L:	linux-iio@vger.kernel.org
 S:	Supported
 W:	https://ez.analog.com/linux-software-drivers
 F:	Documentation/devicetree/bindings/iio/adc/adi,ltc2378.yaml
+F:	drivers/iio/adc/ltc2378*
 
 LTC2664 IIO DAC DRIVER
 M:	Michael Hennerich <michael.hennerich@analog.com>
diff --git a/drivers/iio/adc/Kconfig b/drivers/iio/adc/Kconfig
index 8550917226a1..70fec8e3e891 100644
--- a/drivers/iio/adc/Kconfig
+++ b/drivers/iio/adc/Kconfig
@@ -939,6 +939,18 @@ config LTC2309
 	  This driver can also be built as a module. If so, the module will
 	  be called ltc2309.
 
+config LTC2378
+	tristate "Analog Devices LTC2378 ADC driver"
+	depends on SPI
+	depends on GPIOLIB || PWM
+	select IIO_BUFFER
+	help
+	  Say yes here to build support for Analog Devices LTC2378-20 and
+	  similar analog to digital converters.
+
+	  This driver can also be built as a module. If so, the module will
+	  be called ltc2378.
+
 config LTC2471
 	tristate "Linear Technology LTC2471 and LTC2473 ADC driver"
 	depends on I2C
diff --git a/drivers/iio/adc/Makefile b/drivers/iio/adc/Makefile
index 707dd708912f..1814fb78dde3 100644
--- a/drivers/iio/adc/Makefile
+++ b/drivers/iio/adc/Makefile
@@ -81,6 +81,7 @@ obj-$(CONFIG_LP8788_ADC) += lp8788_adc.o
 obj-$(CONFIG_LPC18XX_ADC) += lpc18xx_adc.o
 obj-$(CONFIG_LPC32XX_ADC) += lpc32xx_adc.o
 obj-$(CONFIG_LTC2309) += ltc2309.o
+obj-$(CONFIG_LTC2378) += ltc2378.o
 obj-$(CONFIG_LTC2471) += ltc2471.o
 obj-$(CONFIG_LTC2485) += ltc2485.o
 obj-$(CONFIG_LTC2496) += ltc2496.o ltc2497-core.o
diff --git a/drivers/iio/adc/ltc2378.c b/drivers/iio/adc/ltc2378.c
new file mode 100644
index 000000000000..7916500c470c
--- /dev/null
+++ b/drivers/iio/adc/ltc2378.c
@@ -0,0 +1,352 @@
+// SPDX-License-Identifier: GPL-2.0+
+/*
+ * Analog Devices LTC2378 ADC series driver
+ *
+ * Copyright (C) 2026 Analog Devices Inc.
+ * Author: Ioan-Daniel Pop <pop.ioan-daniel@analog.com>
+ * Author: Marcelo Schmitt <marcelo.schmitt@analog.com>
+ */
+
+#include <linux/bitops.h>
+#include <linux/delay.h>
+#include <linux/err.h>
+#include <linux/module.h>
+#include <linux/regulator/consumer.h>
+
+#include "ltc2378.h"
+
+enum ltc2378_supported_device_ids {
+	ID_LTC2338_18,
+	ID_LTC2364_16,
+	ID_LTC2364_18,
+	ID_LTC2367_16,
+	ID_LTC2367_18,
+	ID_LTC2368_16,
+	ID_LTC2368_18,
+	ID_LTC2369_18,
+	ID_LTC2370_16,
+	ID_LTC2376_16,
+	ID_LTC2376_18,
+	ID_LTC2376_20,
+	ID_LTC2377_16,
+	ID_LTC2377_18,
+	ID_LTC2377_20,
+	ID_LTC2378_16,
+	ID_LTC2378_18,
+	ID_LTC2378_20,
+	ID_LTC2379_18,
+	ID_LTC2380_16,
+};
+
+static const struct ltc2378_chip_info ltc2378_chip_info[] = {
+	[ID_LTC2338_18] = {
+		.name = "ltc2338-18",
+		.resolution = 18,
+		.out_format = IIO_SCAN_FORMAT_SIGNED_INT,
+	},
+	[ID_LTC2364_16] = {
+		.name = "ltc2364-16",
+		.resolution = 16,
+		.out_format = IIO_SCAN_FORMAT_UNSIGNED_INT,
+	},
+	[ID_LTC2364_18] = {
+		.name = "ltc2364-18",
+		.resolution = 18,
+		.out_format = IIO_SCAN_FORMAT_UNSIGNED_INT,
+	},
+	[ID_LTC2367_16] = {
+		.name = "ltc2367-16",
+		.resolution = 16,
+		.out_format = IIO_SCAN_FORMAT_UNSIGNED_INT,
+	},
+	[ID_LTC2367_18] = {
+		.name = "ltc2367-18",
+		.resolution = 18,
+		.out_format = IIO_SCAN_FORMAT_UNSIGNED_INT,
+	},
+	[ID_LTC2368_16] = {
+		.name = "ltc2368-16",
+		.resolution = 16,
+		.out_format = IIO_SCAN_FORMAT_UNSIGNED_INT,
+	},
+	[ID_LTC2368_18] = {
+		.name = "ltc2368-18",
+		.resolution = 18,
+		.out_format = IIO_SCAN_FORMAT_UNSIGNED_INT,
+	},
+	[ID_LTC2369_18] = {
+		.name = "ltc2369-18",
+		.resolution = 18,
+		.out_format = IIO_SCAN_FORMAT_UNSIGNED_INT,
+	},
+	[ID_LTC2370_16] = {
+		.name = "ltc2370-16",
+		.resolution = 16,
+		.out_format = IIO_SCAN_FORMAT_UNSIGNED_INT,
+	},
+	[ID_LTC2376_16] = {
+		.name = "ltc2376-16",
+		.resolution = 16,
+		.out_format = IIO_SCAN_FORMAT_SIGNED_INT,
+	},
+	[ID_LTC2376_18] = {
+		.name = "ltc2376-18",
+		.resolution = 18,
+		.out_format = IIO_SCAN_FORMAT_SIGNED_INT,
+	},
+	[ID_LTC2376_20] = {
+		.name = "ltc2376-20",
+		.resolution = 20,
+		.out_format = IIO_SCAN_FORMAT_SIGNED_INT,
+	},
+	[ID_LTC2377_16] = {
+		.name = "ltc2377-16",
+		.resolution = 16,
+		.out_format = IIO_SCAN_FORMAT_SIGNED_INT,
+	},
+	[ID_LTC2377_18] = {
+		.name = "ltc2377-18",
+		.resolution = 18,
+		.out_format = IIO_SCAN_FORMAT_SIGNED_INT,
+	},
+	[ID_LTC2377_20] = {
+		.name = "ltc2377-20",
+		.resolution = 20,
+		.out_format = IIO_SCAN_FORMAT_SIGNED_INT,
+	},
+	[ID_LTC2378_16] = {
+		.name = "ltc2378-16",
+		.resolution = 16,
+		.out_format = IIO_SCAN_FORMAT_SIGNED_INT,
+	},
+	[ID_LTC2378_18] = {
+		.name = "ltc2378-18",
+		.resolution = 18,
+		.out_format = IIO_SCAN_FORMAT_SIGNED_INT,
+	},
+	[ID_LTC2378_20] = {
+		.name = "ltc2378-20",
+		.resolution = 20,
+		.out_format = IIO_SCAN_FORMAT_SIGNED_INT,
+	},
+	[ID_LTC2379_18] = {
+		.name = "ltc2379-18",
+		.resolution = 18,
+		.out_format = IIO_SCAN_FORMAT_SIGNED_INT,
+	},
+	[ID_LTC2380_16] = {
+		.name = "ltc2380-16",
+		.resolution = 16,
+		.out_format = IIO_SCAN_FORMAT_SIGNED_INT,
+	},
+};
+
+static int ltc2378_convert_and_acquire(struct ltc2378_state *st)
+{
+	int ret;
+
+	/* Cause a rising edge of CNV to initiate a new ADC conversion */
+	gpiod_set_value_cansleep(st->cnv_gpio, 1);
+	ret = spi_sync_transfer(st->spi, &st->xfer, 1);
+	gpiod_set_value_cansleep(st->cnv_gpio, 0);
+
+	return ret;
+}
+
+static int ltc2378_channel_single_read(const struct iio_chan_spec *chan,
+				       struct ltc2378_state *st, int *val)
+{
+	const struct iio_scan_type *scan_type = &chan->scan_type;
+	u32 sample;
+	int ret;
+
+	ret = ltc2378_convert_and_acquire(st);
+	if (ret)
+		return ret;
+
+	if (scan_type->endianness == IIO_BE) {
+		if (scan_type->realbits > 16)
+			sample = be32_to_cpu(st->scan.data.sample_buf32_be);
+		else
+			sample = be16_to_cpu(st->scan.data.sample_buf16_be);
+	} else {
+		if (scan_type->realbits > 16)
+			sample = st->scan.data.sample_buf32;
+		else
+			sample = st->scan.data.sample_buf16;
+	}
+
+	sample >>= scan_type->shift;
+
+	if (scan_type->format == IIO_SCAN_FORMAT_SIGNED_INT)
+		*val = sign_extend32(sample, scan_type->realbits - 1);
+	else
+		*val = sample;
+
+	return 0;
+}
+
+static int ltc2378_read_raw(struct iio_dev *indio_dev,
+			    const struct iio_chan_spec *chan,
+			int *val, int *val2, long info)
+{
+	struct ltc2378_state *st = iio_priv(indio_dev);
+	int ret;
+
+	switch (info) {
+	case IIO_CHAN_INFO_RAW:
+		IIO_DEV_ACQUIRE_DIRECT_MODE(indio_dev, claim);
+		if (IIO_DEV_ACQUIRE_FAILED(claim))
+			return -EBUSY;
+
+		ret = ltc2378_channel_single_read(chan, st, val);
+		if (ret)
+			return ret;
+
+		return IIO_VAL_INT;
+
+	case IIO_CHAN_INFO_SCALE:
+		*val = st->ref_uV / MILLI;
+		/*
+		 * For all LTC2378-like devices, the amount of bits that express
+		 * voltage magnitude depend on the output code format:
+		 * - straight binary: All precision/resolution bits are used.
+		 * - 2's complement: One of the precision bits is used for sign.
+		 */
+		if (st->info->out_format == IIO_SCAN_FORMAT_SIGNED_INT)
+			*val2 = st->info->resolution - 1;
+		else
+			*val2 = st->info->resolution;
+
+		return IIO_VAL_FRACTIONAL_LOG2;
+
+	default:
+		return -EINVAL;
+	}
+}
+
+static const struct iio_info ltc2378_iio_info = {
+	.read_raw = &ltc2378_read_raw,
+};
+
+static int ltc2378_probe(struct spi_device *spi)
+{
+	struct iio_chan_spec *ltc2378_chan;
+	struct device *dev = &spi->dev;
+	unsigned int num_iio_chans = 1;
+	struct iio_dev *indio_dev;
+	struct ltc2378_state *st;
+
+	indio_dev = devm_iio_device_alloc(&spi->dev, sizeof(*st));
+	if (!indio_dev)
+		return -ENOMEM;
+
+	st = iio_priv(indio_dev);
+	st->spi = spi;
+
+	st->ref_uV = devm_regulator_get_enable_read_voltage(dev, "ref");
+	if (st->ref_uV < 0)
+		return dev_err_probe(dev, -ENODEV, "failed to read ref regulator\n");
+
+	st->info = spi_get_device_match_data(spi);
+	if (!st->info)
+		return -EINVAL;
+
+	indio_dev->name = st->info->name;
+	indio_dev->info = &ltc2378_iio_info;
+	indio_dev->modes = INDIO_DIRECT_MODE;
+
+	st->cnv_gpio = devm_gpiod_get_optional(dev, "cnv", GPIOD_OUT_LOW);
+	if (st->cnv_gpio && IS_ERR(st->cnv_gpio))
+		return dev_err_probe(dev, PTR_ERR(st->cnv_gpio),
+				     "failed to get CNV GPIO");
+
+	ltc2378_chan = devm_kzalloc(&spi->dev, sizeof(struct iio_chan_spec), GFP_KERNEL);
+	if (!ltc2378_chan)
+		return -ENOMEM;
+
+	*ltc2378_chan = (struct iio_chan_spec) {
+		.type = IIO_VOLTAGE,
+		.info_mask_separate = BIT(IIO_CHAN_INFO_RAW) |
+				      BIT(IIO_CHAN_INFO_SCALE),
+		.scan_type = {
+			.format = st->info->out_format,
+			.realbits = st->info->resolution,
+			.storagebits = st->info->resolution > 16 ? 32 : 16,
+			.shift = st->info->resolution > 16 ? 8 : 0,
+			.endianness = IIO_BE,
+		},
+	};
+	st->xfer.rx_buf = &st->scan.data;
+	st->xfer.len = BITS_TO_BYTES(ltc2378_chan->scan_type.storagebits);
+
+	indio_dev->channels = ltc2378_chan;
+	indio_dev->num_channels = num_iio_chans;
+
+	return devm_iio_device_register(&spi->dev, indio_dev);
+}
+
+static const struct of_device_id ltc2378_of_match[] = {
+	{ .compatible = "adi,ltc2338-18", .data = &ltc2378_chip_info[ID_LTC2338_18] },
+	{ .compatible = "adi,ltc2364-16", .data = &ltc2378_chip_info[ID_LTC2364_16] },
+	{ .compatible = "adi,ltc2364-18", .data = &ltc2378_chip_info[ID_LTC2364_18] },
+	{ .compatible = "adi,ltc2367-16", .data = &ltc2378_chip_info[ID_LTC2367_16] },
+	{ .compatible = "adi,ltc2367-18", .data = &ltc2378_chip_info[ID_LTC2367_18] },
+	{ .compatible = "adi,ltc2368-16", .data = &ltc2378_chip_info[ID_LTC2368_16] },
+	{ .compatible = "adi,ltc2368-18", .data = &ltc2378_chip_info[ID_LTC2368_18] },
+	{ .compatible = "adi,ltc2369-18", .data = &ltc2378_chip_info[ID_LTC2369_18] },
+	{ .compatible = "adi,ltc2370-16", .data = &ltc2378_chip_info[ID_LTC2370_16] },
+	{ .compatible = "adi,ltc2376-16", .data = &ltc2378_chip_info[ID_LTC2376_16] },
+	{ .compatible = "adi,ltc2376-18", .data = &ltc2378_chip_info[ID_LTC2376_18] },
+	{ .compatible = "adi,ltc2376-20", .data = &ltc2378_chip_info[ID_LTC2376_20] },
+	{ .compatible = "adi,ltc2377-16", .data = &ltc2378_chip_info[ID_LTC2377_16] },
+	{ .compatible = "adi,ltc2377-18", .data = &ltc2378_chip_info[ID_LTC2377_18] },
+	{ .compatible = "adi,ltc2377-20", .data = &ltc2378_chip_info[ID_LTC2377_20] },
+	{ .compatible = "adi,ltc2378-16", .data = &ltc2378_chip_info[ID_LTC2378_16] },
+	{ .compatible = "adi,ltc2378-18", .data = &ltc2378_chip_info[ID_LTC2378_18] },
+	{ .compatible = "adi,ltc2378-20", .data = &ltc2378_chip_info[ID_LTC2378_20] },
+	{ .compatible = "adi,ltc2379-18", .data = &ltc2378_chip_info[ID_LTC2379_18] },
+	{ .compatible = "adi,ltc2380-16", .data = &ltc2378_chip_info[ID_LTC2380_16] },
+	{ },
+};
+MODULE_DEVICE_TABLE(of, ltc2378_of_match);
+
+static const struct spi_device_id ltc2378_spi_id[] = {
+	{ "ltc2338-18", (kernel_ulong_t)&ltc2378_chip_info[ID_LTC2338_18] },
+	{ "ltc2364-16", (kernel_ulong_t)&ltc2378_chip_info[ID_LTC2364_16] },
+	{ "ltc2364-18", (kernel_ulong_t)&ltc2378_chip_info[ID_LTC2364_18] },
+	{ "ltc2367-16", (kernel_ulong_t)&ltc2378_chip_info[ID_LTC2367_16] },
+	{ "ltc2367-18", (kernel_ulong_t)&ltc2378_chip_info[ID_LTC2367_18] },
+	{ "ltc2368-16", (kernel_ulong_t)&ltc2378_chip_info[ID_LTC2368_16] },
+	{ "ltc2368-18", (kernel_ulong_t)&ltc2378_chip_info[ID_LTC2368_18] },
+	{ "ltc2369-18", (kernel_ulong_t)&ltc2378_chip_info[ID_LTC2369_18] },
+	{ "ltc2370-16", (kernel_ulong_t)&ltc2378_chip_info[ID_LTC2370_16] },
+	{ "ltc2376-16", (kernel_ulong_t)&ltc2378_chip_info[ID_LTC2376_16] },
+	{ "ltc2376-18", (kernel_ulong_t)&ltc2378_chip_info[ID_LTC2376_18] },
+	{ "ltc2376-20", (kernel_ulong_t)&ltc2378_chip_info[ID_LTC2376_20] },
+	{ "ltc2377-16", (kernel_ulong_t)&ltc2378_chip_info[ID_LTC2377_16] },
+	{ "ltc2377-18", (kernel_ulong_t)&ltc2378_chip_info[ID_LTC2377_18] },
+	{ "ltc2377-20", (kernel_ulong_t)&ltc2378_chip_info[ID_LTC2377_20] },
+	{ "ltc2378-16", (kernel_ulong_t)&ltc2378_chip_info[ID_LTC2378_16] },
+	{ "ltc2378-18", (kernel_ulong_t)&ltc2378_chip_info[ID_LTC2378_18] },
+	{ "ltc2378-20", (kernel_ulong_t)&ltc2378_chip_info[ID_LTC2378_20] },
+	{ "ltc2379-18", (kernel_ulong_t)&ltc2378_chip_info[ID_LTC2379_18] },
+	{ "ltc2380-16", (kernel_ulong_t)&ltc2378_chip_info[ID_LTC2380_16] },
+	{ },
+};
+MODULE_DEVICE_TABLE(spi, ltc2378_spi_id);
+
+static struct spi_driver ltc2378_driver = {
+	.driver = {
+		.name = "ltc2378",
+		.of_match_table = ltc2378_of_match
+	},
+	.probe = ltc2378_probe,
+	.id_table = ltc2378_spi_id,
+};
+module_spi_driver(ltc2378_driver);
+
+MODULE_AUTHOR("Ioan-Daniel Pop <pop.ioan-daniel@analog.com>");
+MODULE_AUTHOR("Marcelo Schmitt <marcelo.schmitt@analog.com>");
+MODULE_DESCRIPTION("Analog Devices LTC2378 ADC series driver");
+MODULE_LICENSE("GPL");
diff --git a/drivers/iio/adc/ltc2378.h b/drivers/iio/adc/ltc2378.h
new file mode 100644
index 000000000000..515f7e8a4f2e
--- /dev/null
+++ b/drivers/iio/adc/ltc2378.h
@@ -0,0 +1,48 @@
+/* SPDX-License-Identifier: GPL-2.0 */
+/*
+ * Analog Devices LTC2378 and similar ADCs common definitions and properties
+ * Copyright (C) 2026 Analog Devices, Inc.
+ * Author: Marcelo Schmitt <marcelo.schmitt@analog.com>
+ */
+
+#ifndef __DRIVERS_IIO_ADC_LTC2378_H__
+#define __DRIVERS_IIO_ADC_LTC2378_H__
+
+#include <linux/iio/iio.h>
+#include <linux/spi/spi.h>
+#include <linux/types.h>
+#include <linux/units.h>
+
+#define LTC2378_TDSDOBUSYL_NS		5
+#define LTC2378_TBUSYLH_NS		13
+#define LTC2378_TCNV_HIGH_NS		20
+
+struct ltc2378_chip_info {
+	const char *name;
+	int resolution;
+	const char out_format;
+};
+
+struct ltc2378_state {
+	const struct ltc2378_chip_info *info;
+	struct gpio_desc *cnv_gpio;
+	struct spi_device *spi;
+	struct spi_transfer xfer;
+	int ref_uV;
+
+	/*
+	 * DMA (thus cache coherency maintenance) requires the
+	 * transfer buffers to live in their own cache lines.
+	 */
+	struct {
+		union {
+			__be16 sample_buf16_be;
+			__be32 sample_buf32_be;
+			u16 sample_buf16;
+			u32 sample_buf32;
+		} data;
+		aligned_s64 timestamp;
+	} scan __aligned(IIO_DMA_MINALIGN);
+};
+
+#endif /* __DRIVERS_IIO_ADC_LTC2378_H__ */
-- 
2.53.0

