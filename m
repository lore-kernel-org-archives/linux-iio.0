Received: from mail-dy1-f173.google.com (mail-dy1-f173.google.com [74.125.82.173])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D725A1F1534
	for <linux-iio@vger.kernel.org>; Mon, 19 Oct 2026 00:13:32 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=74.125.82.173
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1792368815; cv=none; b=X20Qr58jBNRxBFPfg8MEgTMr4mfdA9/kXGTbRyKJs2rqWkvDtkXfFCHHQd5m+WqNy6uVWgzbEBJk8NPDoq1CuoHWwSU9uZkyJrsjymgJRDDOCplEPmtwjTNOxUmgnGMczK7HlwQFuWqA5/X6rqT1qus4Wlfkqj7ndfLgeWcxJOs=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1792368815; c=relaxed/simple;
	bh=j68oTJTWRdBjDdN/LtwJ7h9fqVeOSzgp5WRzgzFcwdk=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=Xk0zVqy7R1nhznQD+Ns3lunPCyomMoYWIRaKTIUN9yUQxM/Ut9zmWE+mKzRD3C4WoJM0gkplpqOTUv/0qu9i5Vfipl0P9GuUtFiZwt/kBivNvfej6Da9oSQWp7Ww42YzPh3OLfBNkbjPoDKyyYWE1yXUs3+3URfZq6gpAPweBMI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=k9Gh8knn; arc=none smtp.client-ip=74.125.82.173
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="k9Gh8knn"
Received: by mail-dy1-f173.google.com with SMTP id 5a478bee46e88-35aa0cf7c40so3185555eec.1
        for <linux-iio@vger.kernel.org>; Sun, 18 Oct 2026 17:13:32 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1792368812; x=1792973612; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=XjDHVeinVCZ1JYD5QCaIfspt3pmiB/BOZbrF6Zu42+0=;
        b=k9Gh8knnqY1PGjMl26JoRBnmU4oL0KQ0keM3owi4UDHBF4KOepGPFEwN2B/sJKqngF
         4coUfljjP0A4Pty/N0oDZ0RGjLW6GGctnE6ZFADsRxdH1jhtTcwzI4AGvhgLziekdebU
         xZrLF0F6VLlYAxAHbfmwn49Z/5cY8yhMviZDfG1ioskCp6/Xh+7Bd1GaCfcdjO8edb+2
         XJh21BtJONIH13mh3sIvUek0zF6Pb7sKTTM0mivakjQhfo+O+j17s7q4e8GSfiDDCp3i
         LdC8DcKlNQsmhrdUMMn9+Xh/Nj/Xfb+kU+jZG6x7nuZAKZnkuh5Io57MX1suStMAEiJU
         +89Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1792368812; x=1792973612;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to:content-type;
        bh=XjDHVeinVCZ1JYD5QCaIfspt3pmiB/BOZbrF6Zu42+0=;
        b=kH88zBJ1IxcahjNrY9aRrVa2D1xVi2qauykBepGZtx+EERItQ1xFPGcnSuPpjydHZv
         qVbuz4DvQ5VyDdFEOeSRtEnV+AGodzPKc/OnazkmaJ/Kg1Yp3s4iicOtbjrDraSPAq7L
         0r+Q02a6aMrNwoHi1F/MkdCLo1CkbAee9RX3yh80/RXb/ePCnkVxhFJBLnMZM2COaSzn
         SZT6KikPCG5P9FHXsFAeeutQGtSdlLUOKq77nhCQcCAKarpLU+RSluHIWZwP1Ia9iOvl
         k4AcWZ+TFzPU4OmDkDfpL7Qlbw3OadPF0jyERECt0qgpNDwH+/s4OkgoNONKSI+DfOTM
         7C4w==
X-Forwarded-Encrypted: i=1; AKwUvBzQUgzq2XC8a6ugvJjUxYYqrCD6qtGnpPOXuRq7huICzZmDqWqbTkUEgLUJMQFWHSZ5V50w9/d/c5s=@vger.kernel.org
X-Gm-Message-State: AFq9FYIHhu8/sTrNxSfEwCdaMPOaelWZxyJ7/5xjnF+WNE7LfdlogctO
	jPotwzMGWAEt5EB0SL9ad9v98qwtQmILw4I0LnDuuWTenAreibMPE5EF
X-Gm-Gg: AYBFou3bS2DseWM9eDyFL3qeEAVXQjwY0+Mj5/pHscCTYz5uAlnkq+Gzr362FoiYOD1
	42xCwpv5lcNANZu2pkC8XVx4Scbsrwztp72/VFEygtlvrSG3JmxZmZ/83UlDoBXsA7u1XL6YrzY
	BfsZ7/6MwGH9AORFpMHC++AbgkK9klbZiffoEdtGJAljkP56a1hsgzraB18KcftebIDmgyzu9pG
	fSeMmP5C4pr5bvNZGOwCdY5Cj98P5KXV/OZOHuqIJtphxceLayonsvQvqXYhnxtouAaw4Ta9u4Q
	5DqfFM73FKuH1BhD6x2//n9Bb8PpA2rxWOhN9EXiK5aZegrdx9CK9ej1EOQjunR4ZpyVb8Huy+X
	W3rda7NI6oIX3jThYYwclIaBt69FAo0L3zLhlZWcpvPKVk0JfXXYgR2ur0jyc3C14o/M1uKpVML
	G92VjrOTguANobTK234OyHeopU84rzkzpMaDZWRf6TXaMEoZhgJna2iLV6mFaVbQ/Ei9yGRnlQs
	JHz31BL7SuUabrx4+rYynkf9looprCv4g==
X-Received: by 2002:a05:7022:e808:b0:181:7e1a:e3ad with SMTP id a92af1059eb24-185141625fdmr9718100c88.38.1792368811715;
        Sun, 18 Oct 2026 17:13:31 -0700 (PDT)
Received: from stephan-Inspiron-15-3520.. ([2804:5d20:6009:6701:9a49:ae2e:1b25:b04a])
        by smtp.gmail.com with ESMTPSA id 5a478bee46e88-36082f7f6e0sm30631371eec.27.2026.10.18.17.13.26
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sun, 18 Oct 2026 17:13:31 -0700 (PDT)
From: Stephan Costa Barros <stephanbrrs8@gmail.com>
To: Jonathan Cameron <jic23@kernel.org>
Cc: David Lechner <dlechner@baylibre.com>,
	=?UTF-8?q?Nuno=20S=C3=A1?= <nuno.sa@analog.com>,
	Andy Shevchenko <andy@kernel.org>,
	Rob Herring <robh@kernel.org>,
	Krzysztof Kozlowski <krzk+dt@kernel.org>,
	Conor Dooley <conor+dt@kernel.org>,
	Mike Looijmans <mike.looijmans@topic.nl>,
	linux-iio@vger.kernel.org,
	devicetree@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	Stephan Costa Barros <stephanbrrs8@gmail.com>
Subject: [PATCH 2/2] iio: adc: ti-ads1299: add driver for TI ADS1299
Date: Sun, 18 Oct 2026 21:12:47 -0300
Message-ID: <20261019001247.483005-3-stephanbrrs8@gmail.com>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20261019001247.483005-1-stephanbrrs8@gmail.com>
References: <20261019001247.483005-1-stephanbrrs8@gmail.com>
Precedence: bulk
X-Mailing-List: linux-iio@vger.kernel.org
List-Id: <linux-iio.vger.kernel.org>
List-Subscribe: <mailto:linux-iio+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-iio+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Add a driver for the TI ADS1299, ADS1299-6 and ADS1299-4: low-noise
24-bit biopotential (EEG) analog front-ends with eight, six and four
channels, on SPI. It is derived from ti-ads1298.c.

The driver reads each channel on demand, or all of them through a kfifo
buffer fed from the DRDY interrupt. The gain of each channel's PGA is
set through its scale, and the data rate through sampling_frequency.

The channel count is read from the ID register. It sets the length of
each data read, so when it differs from the compatible the part found
is used, with a warning.

The reference is the internal 4.5 V one unless a vref supply is given,
and the clock the internal oscillator unless an external one is given.
Daisy-chained converters are refused.

Signed-off-by: Stephan Costa Barros <stephanbrrs8@gmail.com>
---
 MAINTAINERS                  |   1 +
 drivers/iio/adc/Kconfig      |  14 +
 drivers/iio/adc/Makefile     |   1 +
 drivers/iio/adc/ti-ads1299.c | 897 +++++++++++++++++++++++++++++++++++
 4 files changed, 913 insertions(+)
 create mode 100644 drivers/iio/adc/ti-ads1299.c

diff --git a/MAINTAINERS b/MAINTAINERS
index b4a8e4573..29dcc2c2b 100644
--- a/MAINTAINERS
+++ b/MAINTAINERS
@@ -27375,6 +27375,7 @@ M:	Stephan Costa Barros <stephanbrrs8@gmail.com>
 L:	linux-iio@vger.kernel.org
 S:	Maintained
 F:	Documentation/devicetree/bindings/iio/adc/ti,ads1299.yaml
+F:	drivers/iio/adc/ti-ads1299.c
 
 TI ADS7924 ADC DRIVER
 M:	Hugo Villeneuve <hvilleneuve@dimonoff.com>
diff --git a/drivers/iio/adc/Kconfig b/drivers/iio/adc/Kconfig
index 02de4809a..b9f2d3d6e 100644
--- a/drivers/iio/adc/Kconfig
+++ b/drivers/iio/adc/Kconfig
@@ -1913,6 +1913,20 @@ config TI_ADS1298
 	  This driver can also be built as a module. If so, the module will be
 	  called ti-ads1298.
 
+config TI_ADS1299
+	tristate "Texas Instruments ADS1299"
+	depends on SPI
+	select IIO_BUFFER
+	select IIO_KFIFO_BUF
+	select REGMAP
+	help
+	  Say yes here to build support for Texas Instruments ADS1299,
+	  ADS1299-6 and ADS1299-4 low-noise 24-bit biopotential (EEG)
+	  analog front-ends.
+
+	  This driver can also be built as a module. If so, the module will be
+	  called ti-ads1299.
+
 config TI_ADS131E08
 	tristate "Texas Instruments ADS131E08"
 	depends on SPI
diff --git a/drivers/iio/adc/Makefile b/drivers/iio/adc/Makefile
index 9e82c21db..4bb543b66 100644
--- a/drivers/iio/adc/Makefile
+++ b/drivers/iio/adc/Makefile
@@ -162,6 +162,7 @@ obj-$(CONFIG_TI_ADS112C04) += ti-ads112c04.o
 obj-$(CONFIG_TI_ADS112C14) += ti-ads112c14.o
 obj-$(CONFIG_TI_ADS124S08) += ti-ads124s08.o
 obj-$(CONFIG_TI_ADS1298) += ti-ads1298.o
+obj-$(CONFIG_TI_ADS1299) += ti-ads1299.o
 obj-$(CONFIG_TI_ADS131E08) += ti-ads131e08.o
 obj-$(CONFIG_TI_ADS131M02) += ti-ads131m02.o
 obj-$(CONFIG_TI_ADS7138) += ti-ads7138.o
diff --git a/drivers/iio/adc/ti-ads1299.c b/drivers/iio/adc/ti-ads1299.c
new file mode 100644
index 000000000..f817a86cc
--- /dev/null
+++ b/drivers/iio/adc/ti-ads1299.c
@@ -0,0 +1,897 @@
+// SPDX-License-Identifier: GPL-2.0
+/*
+ * TI ADS1299 4/6/8-channel, 24-bit biopotential ADC
+ *
+ * Copyright (C) 2023 - 2024 Topic Embedded Products
+ * Copyright (C) 2026 Stephan Costa Barros <stephanbrrs8@gmail.com>
+ *
+ * Based on ti-ads1298.c by Mike Looijmans <mike.looijmans@topic.nl>.
+ *
+ * Datasheet: https://www.ti.com/lit/ds/symlink/ads1299.pdf
+ */
+
+#include <linux/array_size.h>
+#include <linux/bitfield.h>
+#include <linux/bitops.h>
+#include <linux/cleanup.h>
+#include <linux/clk.h>
+#include <linux/completion.h>
+#include <linux/delay.h>
+#include <linux/device.h>
+#include <linux/err.h>
+#include <linux/gpio/consumer.h>
+#include <linux/interrupt.h>
+#include <linux/jiffies.h>
+#include <linux/math64.h>
+#include <linux/mod_devicetable.h>
+#include <linux/module.h>
+#include <linux/property.h>
+#include <linux/regmap.h>
+#include <linux/regulator/consumer.h>
+#include <linux/spi/spi.h>
+#include <linux/spinlock.h>
+#include <linux/string.h>
+#include <linux/types.h>
+#include <linux/units.h>
+
+#include <linux/iio/buffer.h>
+#include <linux/iio/iio.h>
+#include <linux/iio/kfifo_buf.h>
+
+#include <linux/unaligned.h>
+
+/* Commands */
+#define ADS1299_CMD_RESET			0x06
+#define ADS1299_CMD_START			0x08
+#define ADS1299_CMD_STOP			0x0a
+#define ADS1299_CMD_SDATAC			0x11
+#define ADS1299_CMD_RDATA			0x12
+#define ADS1299_CMD_RREG			0x20
+#define ADS1299_CMD_WREG			0x40
+
+/* REV_ID[7:5] | 1 | DEV_ID[3:2] | NU_CH[1:0]; REV_ID may change */
+#define ADS1299_REG_ID				0x00
+#define ADS1299_MASK_ID_FAMILY			GENMASK(4, 2)
+#define ADS1299_MASK_ID_CHANNELS		GENMASK(1, 0)
+#define ADS1299_ID_FAMILY_ADS1299		0x7
+
+/* Data rate = f_CLK / 2^(7 + DR); DR = 7 is reserved */
+#define ADS1299_REG_CONFIG1			0x01
+#define ADS1299_MASK_CONFIG1_DR			GENMASK(2, 0)
+#define ADS1299_SHIFT_DR			7
+#define ADS1299_NUM_DR				7
+
+/* PWR_REFBUF is the datasheet's PD_REFBUF: 1 powers the buffer up */
+#define ADS1299_REG_CONFIG3			0x03
+#define ADS1299_MASK_CONFIG3_PWR_REFBUF		BIT(7)
+#define ADS1299_MASK_CONFIG3_RESERVED		GENMASK(6, 5)
+#define ADS1299_CONFIG3_RESERVED_VALUE					\
+	FIELD_PREP(ADS1299_MASK_CONFIG3_RESERVED, 0x3)
+
+#define ADS1299_REG_CHnSET(n)			(0x05 + (n))
+#define ADS1299_MASK_CH_PD			BIT(7)
+#define ADS1299_MASK_CH_PGA			GENMASK(6, 4)
+#define ADS1299_MASK_CH_MUX			GENMASK(2, 0)
+#define ADS1299_MUX_NORMAL			0
+
+#define ADS1299_REG_LOFF_STATP			0x12
+#define ADS1299_REG_LOFF_STATN			0x13
+#define ADS1299_REG_GPIO			0x14
+
+#define ADS1299_REG_CONFIG4			0x17
+#define ADS1299_MASK_CONFIG4_SINGLE_SHOT	BIT(3)
+
+#define ADS1299_MAX_CHANNELS			8
+#define ADS1299_BITS_PER_SAMPLE			24
+#define ADS1299_CLK_RATE_HZ			2048000
+#define ADS1299_CLOCKS_TO_USECS(x)					\
+	(DIV_ROUND_UP((x) * MICROHZ_PER_HZ, ADS1299_CLK_RATE_HZ))
+
+/* Power-up and reference start-up time */
+#define ADS1299_START_UP_MS			150
+
+#define ADS1299_INTERNAL_VREF_UV		4500000
+
+/* A command takes 4 t_CLK to decode, so register access runs at f_CLK */
+#define ADS1299_SPI_BUS_SPEED_SLOW		ADS1299_CLK_RATE_HZ
+#define ADS1299_SPI_CMD_BUFFER_SIZE		3
+
+/* Command byte, 24-bit status word and n 24-bit samples */
+#define ADS1299_SPI_RDATA_BUFFER_SIZE(n)	(((n) + 1) * 3 + 1)
+#define ADS1299_SPI_RDATA_BUFFER_SIZE_MAX				\
+	ADS1299_SPI_RDATA_BUFFER_SIZE(ADS1299_MAX_CHANNELS)
+
+/* Three bytes per sample in RX buffer, starting at offset 4 */
+#define ADS1299_OFFSET_IN_RX_BUFFER(index)	(3 * (index) + 4)
+
+/* PGA field to gain; 111 is reserved */
+static const int ads1299_pga_gain[] = { 1, 2, 4, 6, 8, 12, 24 };
+
+struct ads1299_chip_info {
+	const char *name;
+	unsigned int num_channels;
+};
+
+/* The NU_CH field of the ID register; 3 is reserved */
+enum ads1299_nu_ch {
+	ADS1299_NU_CH_4,
+	ADS1299_NU_CH_6,
+	ADS1299_NU_CH_8,
+};
+
+static const struct ads1299_chip_info ads1299_chip_info_tbl[] = {
+	[ADS1299_NU_CH_4] = { .name = "ads1299-4", .num_channels = 4 },
+	[ADS1299_NU_CH_6] = { .name = "ads1299-6", .num_channels = 6 },
+	[ADS1299_NU_CH_8] = { .name = "ads1299", .num_channels = 8 },
+};
+
+struct ads1299_private {
+	struct spi_device *spi;
+	struct regmap *regmap;
+	struct completion completion;
+	struct spi_transfer rdata_xfer;
+	struct spi_message rdata_msg;
+	spinlock_t irq_busy_lock; /* Handshake between SPI and DRDY irqs */
+	/*
+	 * 0 = idle, 1 = transfer in progress, 2 = a sample became due during
+	 * it; any more were lost.
+	 */
+	unsigned int rdata_xfer_busy;
+	unsigned int num_adc_channels;
+	int samp_freq_avail[ADS1299_NUM_DR];
+	int scale_avail[ARRAY_SIZE(ads1299_pga_gain)][2];
+
+	struct {
+		u32 chan[ADS1299_MAX_CHANNELS];
+		aligned_s64 timestamp;
+	} scan;
+
+	/* For synchronous SPI exchanges (read/write registers) */
+	u8 cmd_buffer[ADS1299_SPI_CMD_BUFFER_SIZE] __aligned(IIO_DMA_MINALIGN);
+
+	u8 rx_buffer[ADS1299_SPI_RDATA_BUFFER_SIZE_MAX];
+	/* Contains the RDATA command and zeroes to clock out */
+	u8 tx_buffer[ADS1299_SPI_RDATA_BUFFER_SIZE_MAX];
+};
+
+#define ADS1299_CHAN(index)						\
+{									\
+	.type = IIO_VOLTAGE,						\
+	.indexed = 1,							\
+	.channel = index,						\
+	.address = ADS1299_OFFSET_IN_RX_BUFFER(index),			\
+	.info_mask_separate =						\
+		BIT(IIO_CHAN_INFO_RAW) |				\
+		BIT(IIO_CHAN_INFO_SCALE),				\
+	.info_mask_shared_by_type_available =				\
+		BIT(IIO_CHAN_INFO_SCALE),				\
+	.info_mask_shared_by_all =					\
+		BIT(IIO_CHAN_INFO_SAMP_FREQ),				\
+	.info_mask_shared_by_all_available =				\
+		BIT(IIO_CHAN_INFO_SAMP_FREQ),				\
+	.scan_index = index,						\
+	.scan_type = {							\
+		.sign = 's',						\
+		.realbits = ADS1299_BITS_PER_SAMPLE,			\
+		.storagebits = 32,					\
+		.endianness = IIO_CPU,					\
+	},								\
+}
+
+static const struct iio_chan_spec ads1299_channels[ADS1299_MAX_CHANNELS] = {
+	ADS1299_CHAN(0),
+	ADS1299_CHAN(1),
+	ADS1299_CHAN(2),
+	ADS1299_CHAN(3),
+	ADS1299_CHAN(4),
+	ADS1299_CHAN(5),
+	ADS1299_CHAN(6),
+	ADS1299_CHAN(7),
+};
+
+static int ads1299_write_cmd(struct ads1299_private *priv, u8 command)
+{
+	struct spi_transfer xfer = {
+		.tx_buf = priv->cmd_buffer,
+		.rx_buf = priv->cmd_buffer,
+		.len = 1,
+		.speed_hz = ADS1299_SPI_BUS_SPEED_SLOW,
+		.delay = {
+			.value = 2,
+			.unit = SPI_DELAY_UNIT_USECS,
+		},
+	};
+
+	priv->cmd_buffer[0] = command;
+
+	return spi_sync_transfer(priv->spi, &xfer, 1);
+}
+
+static int ads1299_read_one(struct ads1299_private *priv, int chan_index)
+{
+	int ret;
+
+	/* Enable the channel */
+	ret = regmap_update_bits(priv->regmap, ADS1299_REG_CHnSET(chan_index),
+				 ADS1299_MASK_CH_PD, 0);
+	if (ret)
+		return ret;
+
+	/* Enable single-shot mode, so we don't need to send a STOP */
+	ret = regmap_update_bits(priv->regmap, ADS1299_REG_CONFIG4,
+				 ADS1299_MASK_CONFIG4_SINGLE_SHOT,
+				 ADS1299_MASK_CONFIG4_SINGLE_SHOT);
+	if (ret)
+		return ret;
+
+	reinit_completion(&priv->completion);
+
+	ret = ads1299_write_cmd(priv, ADS1299_CMD_START);
+	if (ret < 0) {
+		dev_err(&priv->spi->dev, "CMD_START error: %d\n", ret);
+		return ret;
+	}
+
+	/* A conversion takes 4 ms at the lowest rate, plus bus latency */
+	ret = wait_for_completion_timeout(&priv->completion, msecs_to_jiffies(100));
+	if (!ret)
+		return -ETIMEDOUT;
+
+	return 0;
+}
+
+static int ads1299_get_samp_freq(struct ads1299_private *priv, int *val)
+{
+	unsigned int cfg;
+	unsigned int dr;
+	int ret;
+
+	ret = regmap_read(priv->regmap, ADS1299_REG_CONFIG1, &cfg);
+	if (ret)
+		return ret;
+
+	dr = FIELD_GET(ADS1299_MASK_CONFIG1_DR, cfg);
+	if (dr >= ADS1299_NUM_DR)
+		return -EINVAL;
+
+	*val = priv->samp_freq_avail[dr];
+
+	return IIO_VAL_INT;
+}
+
+static int ads1299_set_samp_freq(struct ads1299_private *priv, int val)
+{
+	unsigned int dr;
+
+	/* Exact rates only: the part has nothing in between */
+	for (dr = 0; dr < ADS1299_NUM_DR; dr++) {
+		if (priv->samp_freq_avail[dr] == val)
+			return regmap_update_bits(priv->regmap,
+						  ADS1299_REG_CONFIG1,
+						  ADS1299_MASK_CONFIG1_DR,
+						  FIELD_PREP(ADS1299_MASK_CONFIG1_DR,
+							     dr));
+	}
+
+	return -EINVAL;
+}
+
+static int ads1299_get_scale(struct ads1299_private *priv,
+			     unsigned int channel, int *val, int *val2)
+{
+	unsigned int regval;
+	unsigned int pga;
+	int ret;
+
+	ret = regmap_read(priv->regmap, ADS1299_REG_CHnSET(channel), &regval);
+	if (ret)
+		return ret;
+
+	pga = FIELD_GET(ADS1299_MASK_CH_PGA, regval);
+	if (pga >= ARRAY_SIZE(ads1299_pga_gain))
+		return -EINVAL;
+
+	*val = priv->scale_avail[pga][0];
+	*val2 = priv->scale_avail[pga][1];
+
+	return IIO_VAL_INT_PLUS_NANO;
+}
+
+static int ads1299_set_scale(struct ads1299_private *priv,
+			     unsigned int channel, int val, int val2)
+{
+	unsigned int pga;
+
+	for (pga = 0; pga < ARRAY_SIZE(ads1299_pga_gain); pga++) {
+		if (priv->scale_avail[pga][0] == val &&
+		    priv->scale_avail[pga][1] == val2)
+			return regmap_update_bits(priv->regmap,
+						  ADS1299_REG_CHnSET(channel),
+						  ADS1299_MASK_CH_PGA,
+						  FIELD_PREP(ADS1299_MASK_CH_PGA,
+							     pga));
+	}
+
+	return -EINVAL;
+}
+
+static int ads1299_read_raw(struct iio_dev *indio_dev,
+			    struct iio_chan_spec const *chan,
+			    int *val, int *val2, long mask)
+{
+	struct ads1299_private *priv = iio_priv(indio_dev);
+	int ret;
+
+	switch (mask) {
+	case IIO_CHAN_INFO_RAW:
+		if (!iio_device_claim_direct(indio_dev))
+			return -EBUSY;
+
+		ret = ads1299_read_one(priv, chan->scan_index);
+		if (!ret)
+			*val = sign_extend32(get_unaligned_be24(priv->rx_buffer +
+								chan->address),
+					     ADS1299_BITS_PER_SAMPLE - 1);
+
+		iio_device_release_direct(indio_dev);
+
+		return ret ? ret : IIO_VAL_INT;
+	case IIO_CHAN_INFO_SCALE:
+		return ads1299_get_scale(priv, chan->channel, val, val2);
+	case IIO_CHAN_INFO_SAMP_FREQ:
+		return ads1299_get_samp_freq(priv, val);
+	default:
+		return -EINVAL;
+	}
+}
+
+static int ads1299_read_avail(struct iio_dev *indio_dev,
+			      struct iio_chan_spec const *chan,
+			      const int **vals, int *type, int *length,
+			      long mask)
+{
+	struct ads1299_private *priv = iio_priv(indio_dev);
+
+	switch (mask) {
+	case IIO_CHAN_INFO_SAMP_FREQ:
+		*vals = priv->samp_freq_avail;
+		*length = ARRAY_SIZE(priv->samp_freq_avail);
+		*type = IIO_VAL_INT;
+		return IIO_AVAIL_LIST;
+	case IIO_CHAN_INFO_SCALE:
+		*vals = (const int *)priv->scale_avail;
+		*length = ARRAY_SIZE(priv->scale_avail) * 2;
+		*type = IIO_VAL_INT_PLUS_NANO;
+		return IIO_AVAIL_LIST;
+	default:
+		return -EINVAL;
+	}
+}
+
+static int ads1299_write_raw(struct iio_dev *indio_dev,
+			     struct iio_chan_spec const *chan, int val,
+			     int val2, long mask)
+{
+	struct ads1299_private *priv = iio_priv(indio_dev);
+	int ret;
+
+	if (!iio_device_claim_direct(indio_dev))
+		return -EBUSY;
+
+	switch (mask) {
+	case IIO_CHAN_INFO_SAMP_FREQ:
+		ret = ads1299_set_samp_freq(priv, val);
+		break;
+	case IIO_CHAN_INFO_SCALE:
+		ret = ads1299_set_scale(priv, chan->channel, val, val2);
+		break;
+	default:
+		ret = -EINVAL;
+		break;
+	}
+
+	iio_device_release_direct(indio_dev);
+
+	return ret;
+}
+
+static int ads1299_write_raw_get_fmt(struct iio_dev *indio_dev,
+				     struct iio_chan_spec const *chan,
+				     long mask)
+{
+	switch (mask) {
+	case IIO_CHAN_INFO_SAMP_FREQ:
+		return IIO_VAL_INT;
+	case IIO_CHAN_INFO_SCALE:
+		return IIO_VAL_INT_PLUS_NANO;
+	default:
+		return -EINVAL;
+	}
+}
+
+static int ads1299_reg_write(void *context, unsigned int reg, unsigned int val)
+{
+	struct ads1299_private *priv = context;
+	struct spi_transfer reg_write_xfer = {
+		.tx_buf = priv->cmd_buffer,
+		.rx_buf = priv->cmd_buffer,
+		.len = 3,
+		.speed_hz = ADS1299_SPI_BUS_SPEED_SLOW,
+		.delay = {
+			.value = 2,
+			.unit = SPI_DELAY_UNIT_USECS,
+		},
+	};
+
+	priv->cmd_buffer[0] = ADS1299_CMD_WREG | reg;
+	priv->cmd_buffer[1] = 0; /* Number of registers to be written - 1 */
+	priv->cmd_buffer[2] = val;
+
+	return spi_sync_transfer(priv->spi, &reg_write_xfer, 1);
+}
+
+static int ads1299_reg_read(void *context, unsigned int reg, unsigned int *val)
+{
+	struct ads1299_private *priv = context;
+	struct spi_transfer reg_read_xfer = {
+		.tx_buf = priv->cmd_buffer,
+		.rx_buf = priv->cmd_buffer,
+		.len = 3,
+		.speed_hz = ADS1299_SPI_BUS_SPEED_SLOW,
+		.delay = {
+			.value = 2,
+			.unit = SPI_DELAY_UNIT_USECS,
+		},
+	};
+	int ret;
+
+	priv->cmd_buffer[0] = ADS1299_CMD_RREG | reg;
+	priv->cmd_buffer[1] = 0; /* Number of registers to be read - 1 */
+	priv->cmd_buffer[2] = 0;
+
+	ret = spi_sync_transfer(priv->spi, &reg_read_xfer, 1);
+	if (ret)
+		return ret;
+
+	*val = priv->cmd_buffer[2];
+
+	return 0;
+}
+
+static int ads1299_reg_access(struct iio_dev *indio_dev, unsigned int reg,
+			      unsigned int writeval, unsigned int *readval)
+{
+	struct ads1299_private *priv = iio_priv(indio_dev);
+
+	if (readval)
+		return regmap_read(priv->regmap, reg, readval);
+
+	return regmap_write(priv->regmap, reg, writeval);
+}
+
+static void ads1299_rdata_unmark_busy(struct ads1299_private *priv)
+{
+	guard(spinlock_irqsave)(&priv->irq_busy_lock);
+	priv->rdata_xfer_busy = 0;
+}
+
+static int ads1299_update_scan_mode(struct iio_dev *indio_dev,
+				    const unsigned long *scan_mask)
+{
+	struct ads1299_private *priv = iio_priv(indio_dev);
+	unsigned int val;
+	unsigned int i;
+	int ret;
+
+	/* Make the interrupt routines start with a clean slate */
+	ads1299_rdata_unmark_busy(priv);
+
+	/* Power down the channels that are not captured */
+	for (i = 0; i < priv->num_adc_channels; i++) {
+		val = test_bit(i, scan_mask) ? 0 : ADS1299_MASK_CH_PD;
+		ret = regmap_update_bits(priv->regmap, ADS1299_REG_CHnSET(i),
+					 ADS1299_MASK_CH_PD, val);
+		if (ret)
+			return ret;
+	}
+
+	return 0;
+}
+
+static const struct iio_info ads1299_info = {
+	.read_raw = &ads1299_read_raw,
+	.read_avail = &ads1299_read_avail,
+	.write_raw = &ads1299_write_raw,
+	.write_raw_get_fmt = &ads1299_write_raw_get_fmt,
+	.update_scan_mode = &ads1299_update_scan_mode,
+	.debugfs_reg_access = &ads1299_reg_access,
+};
+
+static void ads1299_rdata_release_busy_or_restart(struct ads1299_private *priv)
+{
+	guard(spinlock_irqsave)(&priv->irq_busy_lock);
+
+	if (priv->rdata_xfer_busy > 1) {
+		/* A sample became due during the transfer: fetch it now */
+		spi_async(priv->spi, &priv->rdata_msg);
+		priv->rdata_xfer_busy = 1;
+	} else {
+		priv->rdata_xfer_busy = 0;
+	}
+}
+
+/* Called from SPI completion interrupt handler */
+static void ads1299_rdata_complete(void *context)
+{
+	struct iio_dev *indio_dev = context;
+	struct ads1299_private *priv = iio_priv(indio_dev);
+	u32 *bounce = priv->scan.chan;
+	int scan_index;
+
+	if (!iio_buffer_enabled(indio_dev)) {
+		/*
+		 * For a single transfer we are kept in direct mode until
+		 * completion, avoiding a race with buffered IO.
+		 */
+		ads1299_rdata_unmark_busy(priv);
+		complete(&priv->completion);
+		return;
+	}
+
+	iio_for_each_active_channel(indio_dev, scan_index) {
+		const struct iio_chan_spec *scan_chan =
+					&indio_dev->channels[scan_index];
+
+		if (scan_chan->type == IIO_TIMESTAMP)
+			continue;
+
+		*bounce++ = get_unaligned_be24(priv->rx_buffer +
+					       scan_chan->address);
+	}
+
+	/* rx_buffer can be overwritten from this point on */
+	ads1299_rdata_release_busy_or_restart(priv);
+
+	iio_push_to_buffers_with_ts(indio_dev, &priv->scan, sizeof(priv->scan),
+				    iio_get_time_ns(indio_dev));
+}
+
+static irqreturn_t ads1299_interrupt(int irq, void *dev_id)
+{
+	struct iio_dev *indio_dev = dev_id;
+	struct ads1299_private *priv = iio_priv(indio_dev);
+	unsigned int wasbusy;
+
+	guard(spinlock_irqsave)(&priv->irq_busy_lock);
+
+	wasbusy = priv->rdata_xfer_busy++;
+	/* When no SPI transfer is in transit, start one now */
+	if (!wasbusy)
+		spi_async(priv->spi, &priv->rdata_msg);
+
+	return IRQ_HANDLED;
+}
+
+static int ads1299_buffer_postenable(struct iio_dev *indio_dev)
+{
+	struct ads1299_private *priv = iio_priv(indio_dev);
+	int ret;
+
+	/* Disable single-shot mode */
+	ret = regmap_update_bits(priv->regmap, ADS1299_REG_CONFIG4,
+				 ADS1299_MASK_CONFIG4_SINGLE_SHOT, 0);
+	if (ret)
+		return ret;
+
+	return ads1299_write_cmd(priv, ADS1299_CMD_START);
+}
+
+static int ads1299_buffer_predisable(struct iio_dev *indio_dev)
+{
+	struct ads1299_private *priv = iio_priv(indio_dev);
+
+	return ads1299_write_cmd(priv, ADS1299_CMD_STOP);
+}
+
+static const struct iio_buffer_setup_ops ads1299_setup_ops = {
+	.postenable = &ads1299_buffer_postenable,
+	.predisable = &ads1299_buffer_predisable,
+};
+
+/* CONFIG3 holds the read-only BIAS_STAT; GPIO reads the pins */
+static const struct regmap_range ads1299_regmap_volatile_range[] = {
+	regmap_reg_range(ADS1299_REG_CONFIG3, ADS1299_REG_CONFIG3),
+	regmap_reg_range(ADS1299_REG_LOFF_STATP, ADS1299_REG_LOFF_STATN),
+	regmap_reg_range(ADS1299_REG_GPIO, ADS1299_REG_GPIO),
+};
+
+static const struct regmap_access_table ads1299_regmap_volatile = {
+	.yes_ranges = ads1299_regmap_volatile_range,
+	.n_yes_ranges = ARRAY_SIZE(ads1299_regmap_volatile_range),
+};
+
+static const struct regmap_range ads1299_regmap_read_only_range[] = {
+	regmap_reg_range(ADS1299_REG_ID, ADS1299_REG_ID),
+	regmap_reg_range(ADS1299_REG_LOFF_STATP, ADS1299_REG_LOFF_STATN),
+};
+
+static const struct regmap_access_table ads1299_regmap_writeable = {
+	.no_ranges = ads1299_regmap_read_only_range,
+	.n_no_ranges = ARRAY_SIZE(ads1299_regmap_read_only_range),
+};
+
+static const struct regmap_config ads1299_regmap_config = {
+	.reg_bits = 8,
+	.val_bits = 8,
+	.reg_read = ads1299_reg_read,
+	.reg_write = ads1299_reg_write,
+	.max_register = ADS1299_REG_CONFIG4,
+	.wr_table = &ads1299_regmap_writeable,
+	.volatile_table = &ads1299_regmap_volatile,
+	.cache_type = REGCACHE_MAPLE,
+};
+
+static int ads1299_init(struct iio_dev *indio_dev, bool internal_vref)
+{
+	struct ads1299_private *priv = iio_priv(indio_dev);
+	const struct ads1299_chip_info *expected, *info;
+	struct device *dev = &priv->spi->dev;
+	unsigned int nu_ch;
+	unsigned int val;
+	unsigned int i;
+	int ret;
+
+	/* The device starts in RDATAC mode, in which it ignores RREG/WREG */
+	ret = ads1299_write_cmd(priv, ADS1299_CMD_SDATAC);
+	if (ret)
+		return ret;
+
+	ret = regmap_read(priv->regmap, ADS1299_REG_ID, &val);
+	if (ret)
+		return ret;
+
+	if (FIELD_GET(ADS1299_MASK_ID_FAMILY, val) != ADS1299_ID_FAMILY_ADS1299)
+		return dev_err_probe(dev, -ENODEV, "Unknown ID: 0x%x\n", val);
+
+	nu_ch = FIELD_GET(ADS1299_MASK_ID_CHANNELS, val);
+	if (nu_ch >= ARRAY_SIZE(ads1299_chip_info_tbl))
+		return dev_err_probe(dev, -ENODEV, "Unknown ID: 0x%x\n", val);
+
+	/*
+	 * The channel count sets the length of each data read, so the part
+	 * found is used even when another one is described.
+	 */
+	info = &ads1299_chip_info_tbl[nu_ch];
+	expected = spi_get_device_match_data(priv->spi);
+	if (expected && expected != info)
+		dev_warn(dev, "Found %s (ID 0x%x) instead of %s\n", info->name,
+			 val, expected->name);
+
+	priv->num_adc_channels = info->num_channels;
+	indio_dev->name = info->name;
+
+	/* Without the reference buffer every channel reads zero */
+	val = ADS1299_CONFIG3_RESERVED_VALUE;
+	if (internal_vref)
+		val |= ADS1299_MASK_CONFIG3_PWR_REFBUF;
+	ret = regmap_write(priv->regmap, ADS1299_REG_CONFIG3, val);
+	if (ret)
+		return ret;
+
+	/* Out of reset the inputs are shorted: connect them */
+	for (i = 0; i < priv->num_adc_channels; i++) {
+		ret = regmap_update_bits(priv->regmap, ADS1299_REG_CHnSET(i),
+					 ADS1299_MASK_CH_MUX,
+					 FIELD_PREP(ADS1299_MASK_CH_MUX,
+						    ADS1299_MUX_NORMAL));
+		if (ret)
+			return ret;
+	}
+
+	return 0;
+}
+
+static int ads1299_setup_channels(struct iio_dev *indio_dev)
+{
+	struct ads1299_private *priv = iio_priv(indio_dev);
+	unsigned int n = priv->num_adc_channels;
+	struct iio_chan_spec *channels;
+
+	channels = devm_kcalloc(&priv->spi->dev, n + 1, sizeof(*channels),
+				GFP_KERNEL);
+	if (!channels)
+		return -ENOMEM;
+
+	memcpy(channels, ads1299_channels, n * sizeof(*channels));
+	channels[n] = (struct iio_chan_spec)IIO_CHAN_SOFT_TIMESTAMP(n);
+
+	indio_dev->channels = channels;
+	indio_dev->num_channels = n + 1;
+
+	return 0;
+}
+
+static int ads1299_probe(struct spi_device *spi)
+{
+	struct device *dev = &spi->dev;
+	struct gpio_desc *powerdown_gpio;
+	struct ads1299_private *priv;
+	struct gpio_desc *reset_gpio;
+	struct iio_dev *indio_dev;
+	unsigned long clk_rate;
+	bool internal_vref;
+	struct clk *clk;
+	unsigned int i;
+	u32 chain = 1;
+	int vref_uv;
+	int ret;
+
+	indio_dev = devm_iio_device_alloc(dev, sizeof(*priv));
+	if (!indio_dev)
+		return -ENOMEM;
+
+	priv = iio_priv(indio_dev);
+
+	/* Reset to be asserted before enabling clock and power */
+	reset_gpio = devm_gpiod_get_optional(dev, "reset", GPIOD_OUT_HIGH);
+	if (IS_ERR(reset_gpio))
+		return dev_err_probe(dev, PTR_ERR(reset_gpio),
+				     "Cannot get reset GPIO\n");
+
+	powerdown_gpio = devm_gpiod_get_optional(dev, "powerdown",
+						 GPIOD_OUT_LOW);
+	if (IS_ERR(powerdown_gpio))
+		return dev_err_probe(dev, PTR_ERR(powerdown_gpio),
+				     "Cannot get powerdown GPIO\n");
+
+	/* VREF can be supplied externally, otherwise use the internal 4.5 V */
+	vref_uv = devm_regulator_get_enable_read_voltage(dev, "vref");
+	if (vref_uv < 0 && vref_uv != -ENODEV)
+		return dev_err_probe(dev, vref_uv, "Failed to get vref voltage\n");
+
+	internal_vref = vref_uv == -ENODEV;
+	if (internal_vref)
+		vref_uv = ADS1299_INTERNAL_VREF_UV;
+
+	clk = devm_clk_get_optional_enabled(dev, "clk");
+	if (IS_ERR(clk))
+		return dev_err_probe(dev, PTR_ERR(clk), "Failed to get clk\n");
+
+	clk_rate = clk ? clk_get_rate(clk) : ADS1299_CLK_RATE_HZ;
+	if (!clk_rate)
+		return dev_err_probe(dev, -EINVAL, "Unknown clock rate\n");
+
+	device_property_read_u32(dev, "#daisy-chained-devices", &chain);
+	if (chain > 1)
+		return dev_err_probe(dev, -EOPNOTSUPP,
+				     "Daisy chain of %u devices not supported\n",
+				     chain);
+
+	if (spi->irq <= 0)
+		return dev_err_probe(dev, -EINVAL, "DRDY interrupt required\n");
+
+	ret = devm_regulator_get_enable(dev, "avdd");
+	if (ret)
+		return dev_err_probe(dev, ret, "Failed to enable avdd regulator\n");
+
+	ret = devm_regulator_get_enable(dev, "dvdd");
+	if (ret)
+		return dev_err_probe(dev, ret, "Failed to enable dvdd regulator\n");
+
+	priv->spi = spi;
+	init_completion(&priv->completion);
+	spin_lock_init(&priv->irq_busy_lock);
+	priv->regmap = devm_regmap_init(dev, NULL, priv, &ads1299_regmap_config);
+	if (IS_ERR(priv->regmap))
+		return PTR_ERR(priv->regmap);
+
+	for (i = 0; i < ADS1299_NUM_DR; i++)
+		priv->samp_freq_avail[i] = clk_rate >> (ADS1299_SHIFT_DR + i);
+
+	/* One code is VREF / (gain * 2^23), in mV with nano precision */
+	for (i = 0; i < ARRAY_SIZE(ads1299_pga_gain); i++) {
+		priv->scale_avail[i][0] = 0;
+		priv->scale_avail[i][1] =
+			div_u64((u64)vref_uv * MICRO,
+				ads1299_pga_gain[i] <<
+				(ADS1299_BITS_PER_SAMPLE - 1));
+	}
+
+	indio_dev->modes = INDIO_DIRECT_MODE | INDIO_BUFFER_SOFTWARE;
+	indio_dev->info = &ads1299_info;
+
+	/* Out of power-down: wait for the oscillator and the reference */
+	if (powerdown_gpio)
+		msleep(ADS1299_START_UP_MS);
+
+	if (reset_gpio) {
+		/* Minimum reset pulse width is 2 clock cycles */
+		fsleep(ADS1299_CLOCKS_TO_USECS(2));
+		gpiod_set_value_cansleep(reset_gpio, 0);
+	} else {
+		ret = ads1299_write_cmd(priv, ADS1299_CMD_RESET);
+		if (ret)
+			return dev_err_probe(dev, ret, "RESET failed\n");
+	}
+	/* Wait 18 clock cycles for the reset to complete */
+	fsleep(ADS1299_CLOCKS_TO_USECS(18));
+
+	ret = ads1299_init(indio_dev, internal_vref);
+	if (ret)
+		return dev_err_probe(dev, ret, "Init failed\n");
+
+	ret = ads1299_setup_channels(indio_dev);
+	if (ret)
+		return ret;
+
+	priv->tx_buffer[0] = ADS1299_CMD_RDATA;
+	priv->rdata_xfer.tx_buf = priv->tx_buffer;
+	priv->rdata_xfer.rx_buf = priv->rx_buffer;
+	priv->rdata_xfer.len =
+		ADS1299_SPI_RDATA_BUFFER_SIZE(priv->num_adc_channels);
+	/* Must keep CS low for 4 clocks */
+	priv->rdata_xfer.delay.value = 2;
+	priv->rdata_xfer.delay.unit = SPI_DELAY_UNIT_USECS;
+	spi_message_init_with_transfers(&priv->rdata_msg, &priv->rdata_xfer, 1);
+	priv->rdata_msg.complete = &ads1299_rdata_complete;
+	priv->rdata_msg.context = indio_dev;
+
+	ret = devm_request_irq(dev, spi->irq, &ads1299_interrupt, 0,
+			       indio_dev->name, indio_dev);
+	if (ret)
+		return ret;
+
+	ret = devm_iio_kfifo_buffer_setup(dev, indio_dev, &ads1299_setup_ops);
+	if (ret)
+		return ret;
+
+	return devm_iio_device_register(dev, indio_dev);
+}
+
+static const struct spi_device_id ads1299_id[] = {
+	{
+		.name = "ads1299",
+		.driver_data = (kernel_ulong_t)&ads1299_chip_info_tbl[ADS1299_NU_CH_8],
+	},
+	{
+		.name = "ads1299-4",
+		.driver_data = (kernel_ulong_t)&ads1299_chip_info_tbl[ADS1299_NU_CH_4],
+	},
+	{
+		.name = "ads1299-6",
+		.driver_data = (kernel_ulong_t)&ads1299_chip_info_tbl[ADS1299_NU_CH_6],
+	},
+	{ }
+};
+MODULE_DEVICE_TABLE(spi, ads1299_id);
+
+static const struct of_device_id ads1299_of_table[] = {
+	{
+		.compatible = "ti,ads1299",
+		.data = &ads1299_chip_info_tbl[ADS1299_NU_CH_8],
+	},
+	{
+		.compatible = "ti,ads1299-4",
+		.data = &ads1299_chip_info_tbl[ADS1299_NU_CH_4],
+	},
+	{
+		.compatible = "ti,ads1299-6",
+		.data = &ads1299_chip_info_tbl[ADS1299_NU_CH_6],
+	},
+	{ }
+};
+MODULE_DEVICE_TABLE(of, ads1299_of_table);
+
+static struct spi_driver ads1299_driver = {
+	.driver = {
+		.name = "ads1299",
+		.of_match_table = ads1299_of_table,
+	},
+	.probe = ads1299_probe,
+	.id_table = ads1299_id,
+};
+module_spi_driver(ads1299_driver);
+
+MODULE_AUTHOR("Stephan Costa Barros <stephanbrrs8@gmail.com>");
+MODULE_DESCRIPTION("TI ADS1299 biopotential ADC driver");
+MODULE_LICENSE("GPL");
-- 
2.43.0

