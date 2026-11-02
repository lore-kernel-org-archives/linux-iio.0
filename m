Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=209.85.128.47
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1793630959;
	b=v9rjUJINfqYKWwhGGB9aD1YzTmdpEVGeYRz6zbe93Vrr30WgNIT1NM3PQAEA3dWpMlx6
	 KjYYjFn+LbdDH9tD18Umc99oxTlLyCgvGp8G1fIbbMHDvL1KyGSQHjckVU+hDuHPcBYH0
	 StjvjeP30YDuZi7ZNGyL91E3sBKL1iKufo372iUMcAVq3ZjpPxNoT8XhikCUyRTnlJ4Hg
	 vyYnXylY7iDIRAV3pIwzCcswL50dZNUl0mQfc4Hhi4scO2JqlRXalGoJLd9uhEQDKn5Ig
	 v69yK/KOIOsu/+JWm+RE1gOE3OtvTNhFdI8oLFo6GJYxN92hW+y3oGQpNHXXS6ZoIPA==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1793630959;
	h=DMARC-Filter:Received:DKIM-Signature:X-Google-DKIM-Signature:
	 X-Gm-Message-State:X-Gm-Gg:X-Received:Received:From:Date:Subject:
	 MIME-Version:Content-Type:Content-Transfer-Encoding:Message-Id:
	 References:In-Reply-To:To:Cc:X-Mailer:X-Developer-Signature:
	 X-Developer-Key;
	bh=3jhyub1skjnqQEfuE0VF8KLdVkMZdOszTsb2no+pkzU=;
	b=qwFk80qW09tYcf3gCPuz25B3HCQnAOrEhhSVXR8boK3J1JIH7t+gkKk76/C8GJQeJJH0
	 7Dp9bPnfLXOCCW8ps3255hbC5z7N7f25aSXlLmhh9XOe1vI80VxNShWcjM7ANL1XSJoX+
	 bdh6QEai8aWhDhysYEH9ApOdHetziiMIp3LhYu1zb027BRSIGI4jGGrtoJ8z19b3kEog3
	 NCVBkFBbG1Z71j4ijOS5pG1jI9Uds1gwhnxDsgj3UKc2buPk+JYAd36nIsP50zRbTZnWM
	 dECjam7sIgI5+hoVB2d4jPLcIIIIMnslNtADzccpjibVEhTFS1Qymd2CYcbDWpY+7cw==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=linaro.org;
	spf=pass smtp.mailfrom=linaro.org;
	dkim=pass header.d=linaro.org header.i=@linaro.org header.a=rsa-sha256 header.s=google header.b=aqD1z5jP;
	arc=none smtp.remote-ip=209.85.128.47
Received: from mail-wm1-f47.google.com (mail-wm1-f47.google.com [209.85.128.47])
	(using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7CDEF606ABB5
	for <linux-iio@vger.kernel.org>; Mon,  2 Nov 2026 14:49:18 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org 7CDEF606ABB5
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linaro.org
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=linaro.org header.i=@linaro.org header.a=rsa-sha256 header.s=google header.b=aqD1z5jP
Received: by mail-wm1-f47.google.com with SMTP id 5b1f17b1804b1-4a2153c8525so20003365e9.3
        for <linux-iio@vger.kernel.org>; Mon, 02 Nov 2026 06:49:18 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1793630957; x=1794235757; darn=vger.kernel.org;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :content-type:mime-version:subject:date:from:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=3jhyub1skjnqQEfuE0VF8KLdVkMZdOszTsb2no+pkzU=;
        b=aqD1z5jPLmVCeDvIp8At9cxAju6HSBqdgPKcfcvut+3lodPAqP9QQ126WGy+pz02bI
         OWSNndLWesVqqKgJBtySAjPYU1fuwsdzwIe8mPPgKY1mkZ5yMW8x/yMXlFmnJ0udx8yA
         l0NzhHkhWcZ9I6LxT7M5pQPagxQ8jEoUYsdLo0qcLe/N7KlGQhkMh2LZ2RhpUTiDlwI2
         W5ASFXJQxnG1O2nsGaZMmpOEcYFsZq+lwuuFpQbe0q1vjsg2RuJBSZcY821o9zcUZXtU
         9Zob2cRye4ioLvvRH9rkMffpZvnk/IT61hClV9ZYqLKp8Oc/J+Zy7FVuVzXSeI0rDoQe
         cSkg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1793630957; x=1794235757;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :content-type:mime-version:subject:date:from:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=3jhyub1skjnqQEfuE0VF8KLdVkMZdOszTsb2no+pkzU=;
        b=pJ4MIlXgzsIb3KXzZ+Ldyfz/fyVr5wsLTX2NmTkWm0/WzSFTg+qm5p7FuAQm04xXAH
         NzBLuJjo4bN7kN4ezBao/SrB9auP1oxN+U9dCMmUSqwgDld+6vA+Ls/8sB4ZP02GZYvr
         IIC4HJ8fmsopzufxoq8rhLyrfiDcGfFJfPlPSyYMIuMavFbQT5RGRUQVd+ligP104Qdm
         p5G4k3LLxwsIzCsae6AS6lA7TkwNFcAlHs0rbVAQ33jRSIzfRvfa/oJyFc546Ni54yQO
         AnZDnI4b+9DUW9mTpNHSMzFHVe1mK9fjZWjC2W8PIrNeq67b1dSAVSDFkixfhJU65HIr
         5QDQ==
X-Gm-Message-State: AFq9FYI2XNtE6KHmdKCoRPlZ7mfqv2OOxGIKkEoYmIE9lkjkCosC/DkV
	L9L830+62+gOMvaf4sZrBY9/RwvEFG355pzlHVwqsrTkTStCwh/JKePDZlTulSpgmPc=
X-Gm-Gg: AYBFou08BHKVNzz0ex1oygC0IHBIak5vPTPhGY+MfK24MB9USTP6JkrHUIqjm3GapsD
	o7/mNYl8Nsiit77IkKwL6sXhyqndDMeWfQSDd3Xk+ANb2UhW/eVkPpy3yISBRgsnXqIEywsSVi1
	tvXn9otjCM9AVLxT7l09teq56Yi0xOP16GAONRn8msjwule8TFz53MjSCiM8wLLyQ1InBlK3nZE
	36usLLxZqoe9X7OR/hzIX/zbAcJQkviB9Mx6poPi7ig6xoBPQqxHg0SOmUSJiQeYWOkM7Hsd0+O
	UXg+da3E6TwZFnj2nJLbZ1q/0SI3TNOJrNdk002AtT6ua/66qZ80afFC+6e1TmTJZC5bQ9XXjrH
	X2KnqlPtFDJH3EdsQ1HLOPgFZ60reCtikGmSHpBpvh5eywfHvBIZY68uSTgQmsyNrGoF0V/IJG6
	Gh4JahyBLl2XUqyEsgVFiA8NYLifPj4eXmbK5McCdNPjqTM87+SfQ8BzKjWsKKjqMp1mSZXB4Yz
	pn7xZjwzQF9JH11Ca2UH4ZwCJfnNDs5EgxLNGHc1d3FfoRTcgwPJEkCLRSjjyGyNvOM9Bzirr8J
	2ZUOthdY7D4bllV3yisXnnACdw9BH62zd3qhCPlE6ihc6kpKv7U=
X-Received: by 2002:a05:600c:4e02:b0:4a1:e6a9:4086 with SMTP id 5b1f17b1804b1-4ac1228b10amr249544265e9.0.1793630956363;
        Mon, 02 Nov 2026 06:49:16 -0800 (PST)
Received: from arrakeen.starnux.net ([2a01:e0a:106d:1080:8261:5fff:fe11:bdda])
        by smtp.gmail.com with ESMTPSA id 5b1f17b1804b1-4abf5b27e46sm447287005e9.3.2026.11.02.06.49.15
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 02 Nov 2026 06:49:16 -0800 (PST)
From: Neil Armstrong <neil.armstrong@linaro.org>
Date: Mon, 02 Nov 2026 15:49:06 +0100
Subject: [PATCH v5 3/3] iio: adc: add driver for the MAX34417 Four-Channel
 High Dynamic Range Power Accumulator
X-Mailing-List: linux-iio@vger.kernel.org
List-Id: <linux-iio.vger.kernel.org>
List-Post: <mailto:linux-iio@vger.kernel.org>
List-Help: <mailto:linux-iio+help@vger.kernel.org>
List-Subscribe: <mailto:linux-iio+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-iio+unsubscribe@vger.kernel.org>
List-Owner: <mailto:linux-iio+owner@vger.kernel.org>
Precedence: list
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20261102-topic-sm8x50-iio-max34417-adc-v5-3-0ffa5e5f2d5c@linaro.org>
References: <20261102-topic-sm8x50-iio-max34417-adc-v5-0-0ffa5e5f2d5c@linaro.org>
In-Reply-To: <20261102-topic-sm8x50-iio-max34417-adc-v5-0-0ffa5e5f2d5c@linaro.org>
To: Jonathan Cameron <jic23@kernel.org>, 
 David Lechner <dlechner@baylibre.com>, 
 =?utf-8?q?Nuno_S=C3=A1?= <nuno.sa@analog.com>, 
 Andy Shevchenko <andy@kernel.org>, Rob Herring <robh@kernel.org>, 
 Krzysztof Kozlowski <krzk+dt@kernel.org>, 
 Conor Dooley <conor+dt@kernel.org>, 
 Michael Hennerich <Michael.Hennerich@analog.com>
Cc: linux-iio@vger.kernel.org, devicetree@vger.kernel.org, 
 linux-kernel@vger.kernel.org, linux-hwmon@vger.kernel.org, 
 Neil Armstrong <neil.armstrong@linaro.org>, linux@analog.com
X-Mailer: b4 0.15.2
X-Developer-Signature: v=1; a=openpgp-sha256; l=25106;
 i=neil.armstrong@linaro.org; h=from:subject:message-id;
 bh=HKK/09G/0r1P9Q4qAkucyG/oD1vokbVqhHmOCzRiKPE=;
 b=owEBbQKS/ZANAwAKAXfc29rIyEnRAcsmYgBq6KLo1+U6B08ISZ4kW87LmVSRmdGTuEPf0RY+3kU9
 UiHXHiiJAjMEAAEKAB0WIQQ9U8YmyFYF/h30LIt33NvayMhJ0QUCauii6AAKCRB33NvayMhJ0VmHD/
 0aWeJx1Ee6S2f7MkBDyo+lW3njk5g2FnsU55qG6bN2xMu9G7y6K4asTKpn1zE5zUCDC9GrJ2LbUDLj
 Pb3IevYyIt/TgFfTZWTkS/gY0xxt4VgEvilmXeLSI1Y7FyNnVifCJW0By2yAb0Cfzo1/ZpsVE0p4e7
 qhngE91w/5f21z0FGcn4jKv30g0Ny74bKdw4ktcim/4OjgE0QN8H2tpVut6C1MDXnPhpJboR7N5/rF
 Nd0CB/N5jbtgtcZaUwX976BNiSeBx0muDIMDTXPxn80z2Aq0mhxF0joOhpcnVGfHRAq3T51swJHDSi
 iz3jnisnAgvbAxs6Qy1kDeJJxPGn7ev4DE1IX/O6+DqzT6lRgQotCegPPkreeHlNKHWosL48MJxNDI
 R+aFpqZGxioemhIqc+s2741T3ospmFZgZT2AiIOesdREloaVt5EB0oxgjCyLq4hhXriW60ZOltOwcC
 n4G+8beEMTFkar0aufCtFBX5RTBjs4ewnb2tbb6DjPuhTszahfpcBQWDYDDBpI2wDLEcpguiLbXsIf
 foMtXN2njl5vk3yeKRyPKXkr4XmYr0vY8qfP3eMpUH/aO13cWwWAYcJfdyIcZ8u8eXuIxXEA1MG6Hk
 q5bETsFcqh7lj4zVvX1aA9cXX/BcfUFmy0cWiUKFSDIYrZK+sCEYmKZxDbBA==
X-Developer-Key: i=neil.armstrong@linaro.org; a=openpgp;
 fpr=89EC3D058446217450F22848169AB7B1A4CFF8AE

The MAX34417 is a specialized current and voltage monitor used to
determine power consumption of portable systems. The driver support
getting the channels voltage, average power, accumulated average
power and energy over an I2C/SMBUS serial interface.

The MAX34417 datasheet only specified on how to calculate the
accumulated average power, but with the Sample Per Second rate
we can easily get accumulated Energy in mJ.

By default the IIO driver only supports single-shot Voltage
and Power sensing, but the accumulation can be enabled by
enabling the Energy IIO channel which then enables the
Continuous Accumulation Mode.

The counter is common to all channels, so when reading a single
channel we will copy all accumulators to registers, so in order
to permit reading individual channels we must accumulate the
other channels in the driver when Continuous Accumulation Mode
is enabled.

Signed-off-by: Neil Armstrong <neil.armstrong@linaro.org>
---
 drivers/iio/adc/Kconfig    |  11 +
 drivers/iio/adc/Makefile   |   1 +
 drivers/iio/adc/max34417.c | 787 +++++++++++++++++++++++++++++++++++++++++++++
 3 files changed, 799 insertions(+)

diff --git a/drivers/iio/adc/Kconfig b/drivers/iio/adc/Kconfig
index a802d8ee4dd9..b7d66dffdb89 100644
--- a/drivers/iio/adc/Kconfig
+++ b/drivers/iio/adc/Kconfig
@@ -1144,6 +1144,17 @@ config MAX34408
 	  To compile this driver as a module, choose M here: the module will be
 	  called max34408.
 
+config MAX34417
+	tristate "Maxim MAX34417 ADC driver"
+	depends on I2C
+	select REGMAP_I2C
+	help
+	  Say yes here to build ADC support for Maxim MAX34417 Four-Channel High
+	  Dynamic Range Power Accumulator.
+
+	  To compile this driver as a module, choose M here: the module will be
+	  called max34417.
+
 config MAX40080
 	tristate "Analog Devices MAX40080 Current Sense Amplifier"
 	depends on I2C
diff --git a/drivers/iio/adc/Makefile b/drivers/iio/adc/Makefile
index 9e82c21dbd37..26ddf3828fe4 100644
--- a/drivers/iio/adc/Makefile
+++ b/drivers/iio/adc/Makefile
@@ -97,6 +97,7 @@ obj-$(CONFIG_MAX1241) += max1241.o
 obj-$(CONFIG_MAX1363) += max1363.o
 obj-$(CONFIG_MAX14001) += max14001.o
 obj-$(CONFIG_MAX34408) += max34408.o
+obj-$(CONFIG_MAX34417) += max34417.o
 obj-$(CONFIG_MAX40080) += max40080.o
 obj-$(CONFIG_MAX77541_ADC) += max77541-adc.o
 obj-$(CONFIG_MAX9611) += max9611.o
diff --git a/drivers/iio/adc/max34417.c b/drivers/iio/adc/max34417.c
new file mode 100644
index 000000000000..e679cf142141
--- /dev/null
+++ b/drivers/iio/adc/max34417.c
@@ -0,0 +1,787 @@
+// SPDX-License-Identifier: GPL-2.0
+/*
+ * IIO driver for Analog Devices MAX34417 ADC, 4-Channels High Dynamic Range Power Accumulator
+ *
+ * Datasheet: https://www.analog.com/en/products/max34417.html
+ *
+ * TODO: Slow Mode, Park Feature, Bulk Update, Perr_Verr Correction
+ */
+
+#include <linux/array_size.h>
+#include <linux/bitfield.h>
+#include <linux/bits.h>
+#include <linux/cleanup.h>
+#include <linux/err.h>
+#include <linux/i2c.h>
+#include <linux/iio/iio.h>
+#include <linux/init.h>
+#include <linux/math64.h>
+#include <linux/module.h>
+#include <linux/mutex.h>
+#include <linux/property.h>
+#include <linux/regmap.h>
+#include <linux/regulator/consumer.h>
+#include <linux/sysfs.h>
+#include <linux/unaligned.h>
+#include <linux/units.h>
+
+#define MAX34417_UPDATE_REG		0x0
+#define MAX34417_CONTROL_REG		0x1
+#define MAX34417_ACC_COUNT_REG		0x2
+
+#define MAX34417_PWR_ACC_1_REG		0x3
+#define MAX34417_PWR_ACC_2_REG		0x4
+#define MAX34417_PWR_ACC_3_REG		0x5
+#define MAX34417_PWR_ACC_4_REG		0x6
+
+#define MAX34417_V_CH1_REG		0x7
+#define MAX34417_V_CH2_REG		0x8
+#define MAX34417_V_CH3_REG		0x9
+#define MAX34417_V_CH4_REG		0xa
+
+#define MAX34417_DID_REG		0xf
+
+#define MAX34417_BULK_POWER_READOUT_REG		0x10
+#define MAX34417_BULK_VOLTAGE_READOUT_REG	0x11
+
+#define MAX34417_BULK_UPDATE_ADDRESS	0x2c
+#define MAX34417_BULK_UPDATE_REG	0x0
+
+/* Bit masks for control register */
+#define MAX34417_CONTROL_OVF		BIT(0)
+#define MAX34417_CONTROL_SLOW		BIT(1)
+#define MAX34417_CONTROL_PARK0		BIT(2)
+#define MAX34417_CONTROL_PARK1		BIT(3)
+#define MAX34417_CONTROL_PARK_EN	BIT(4)
+#define MAX34417_CONTROL_SMM		BIT(5)
+#define MAX34417_CONTROL_CAM		BIT(6)
+#define MAX34417_CONTROL_MODE		BIT(7)
+
+#define MAX34417_ACC_COUNT_READ_LENGTH	4
+#define MAX34417_ACC_COUNT_READ_OFFSET	1
+
+#define MAX34417_POWER_READ_LENGTH	8
+#define MAX34417_POWER_READ_OFFSET	1
+
+#define MAX34417_VOLTAGE_READ_LENGTH	3
+#define MAX34417_VOLTAGE_READ_OFFSET	1
+
+#define MAX34417_MIN_RSENSE		(1 * MILLI) /* 1000 microOhm */
+#define MAX34417_MAX_RSENSE		(100 * MILLI) /* 100000 microOhm */
+#define MAX34417_DEFAULT_RSENSE		(1 * MILLI) /* 1000 microOhm */
+
+#define MAX34417_PWR_CORRECTION_SCALE		24
+#define MAX34417_PWR_AVG_FULL_SCALE_BITS	30
+
+#define MAX34417_VOLTAGE_CORRECTION_SCALE	24
+#define MAX34417_VOLTAGE_FULL_SCALE_BITS	14
+
+/* TODO implement IIO_CHAN_INFO_SAMP_FREQ for slow mode */
+#define MAX34417_SLOW_SPS_BIT			3 /* 8 SPS */
+#define MAX34417_FAST_SPS_BIT			10 /* 1024 SPS */
+#define MAX34417_FAST_SPS_CAM			1536 /* 1.5 * 1024 SPS */
+
+#define MAX34417_CHANNEL_COUNT			4
+
+/**
+ * struct max34417_data - MAX34417 specific data.
+ * @indio_dev:  IIO Device.
+ * @regmap:	Device register map.
+ * @lock:	Lock for protecting access to device hardware registers, mostly
+ *		for reading common accumulator count and control register.
+ * @input_correction:	Correction based on the Rsense value from channel nodes.
+ * @input_label:	Channel label from channel nodes.
+ * @cam_mode:		State of the Continuous Accumulate Mode feature.
+ * @acc_power:		Saved power accumulator for each channel when in CAM mode.
+ * @acc_count:		Saved counter for each channel when in CAM mode.
+ */
+struct max34417_data {
+	struct iio_dev *indio_dev;
+	struct regmap *regmap;
+	struct mutex lock;
+	u32 input_correction[MAX34417_CHANNEL_COUNT];
+	const char *input_label[MAX34417_CHANNEL_COUNT];
+	bool cam_mode;
+	u64 acc_power[MAX34417_CHANNEL_COUNT];
+	u64 acc_count[MAX34417_CHANNEL_COUNT];
+};
+
+static bool max34417_writeable_reg(struct device *dev, unsigned int reg)
+{
+	switch (reg) {
+	case MAX34417_UPDATE_REG:
+	case MAX34417_CONTROL_REG:
+		return true;
+	default:
+		return false;
+	}
+}
+
+static bool max34417_readable_reg(struct device *dev, unsigned int reg)
+{
+	switch (reg) {
+	case MAX34417_UPDATE_REG:
+		return false;
+	default:
+		return true;
+	}
+}
+
+static bool max34417_volatile_reg(struct device *dev, unsigned int reg)
+{
+	switch (reg) {
+	case MAX34417_DID_REG:
+		return false;
+	/* MAX34417_CONTROL_REG field OVF is volatile */
+	case MAX34417_CONTROL_REG:
+	default:
+		return true;
+	}
+}
+
+static const struct regmap_config max34417_regmap_config = {
+	.reg_bits	= 8,
+	.val_bits	= 8,
+	.max_register	= MAX34417_BULK_VOLTAGE_READOUT_REG,
+	.writeable_reg	= max34417_writeable_reg,
+	.readable_reg	= max34417_readable_reg,
+	.volatile_reg	= max34417_volatile_reg,
+	/* No cache since the only non-volatile register is read-only */
+};
+
+#define MAX34417_CHANNEL(_index, _v_address, _power_address)	\
+	{							\
+		.type = IIO_VOLTAGE,				\
+		.info_mask_separate =				\
+			BIT(IIO_CHAN_INFO_RAW) |		\
+			BIT(IIO_CHAN_INFO_SCALE),		\
+		.channel = (_index),				\
+		.address = (_v_address),			\
+		.indexed = 1,					\
+	},							\
+	{							\
+		.type = IIO_POWER,				\
+		.info_mask_separate =				\
+			BIT(IIO_CHAN_INFO_RAW) |		\
+			BIT(IIO_CHAN_INFO_AVERAGE_RAW) |	\
+			BIT(IIO_CHAN_INFO_SCALE),		\
+		.channel = (_index),				\
+		.address = (_power_address),			\
+		.indexed = 1,					\
+	},							\
+	{							\
+		.type = IIO_ENERGY,				\
+		.info_mask_separate =				\
+			BIT(IIO_CHAN_INFO_RAW) |		\
+			BIT(IIO_CHAN_INFO_SCALE),		\
+		.info_mask_shared_by_type =			\
+			BIT(IIO_CHAN_INFO_ENABLE),		\
+		.channel = (_index),				\
+		.address = (_power_address),			\
+		.indexed = 1,					\
+	}
+
+static const struct iio_chan_spec max34417_channels[] = {
+	MAX34417_CHANNEL(0, MAX34417_V_CH1_REG, MAX34417_PWR_ACC_1_REG),
+	MAX34417_CHANNEL(1, MAX34417_V_CH2_REG, MAX34417_PWR_ACC_2_REG),
+	MAX34417_CHANNEL(2, MAX34417_V_CH3_REG, MAX34417_PWR_ACC_3_REG),
+	MAX34417_CHANNEL(3, MAX34417_V_CH4_REG, MAX34417_PWR_ACC_4_REG),
+};
+
+/* TODO Implement trigger to update accumulator once and get all channels at once */
+
+static int max34417_reset_smm(struct max34417_data *max34417)
+{
+	struct regmap *map = max34417->regmap;
+	int rc;
+
+	/* Set SMM=0 to re-init the SMM mode */
+	rc = regmap_clear_bits(map, MAX34417_CONTROL_REG, MAX34417_CONTROL_SMM);
+	if (rc)
+		return rc;
+
+	/* Reset accumulators after setting SMM=0 */
+	return regmap_write(map, MAX34417_UPDATE_REG, 1);
+}
+
+static int max34417_trigger_smm(struct max34417_data *max34417)
+{
+	struct regmap *map = max34417->regmap;
+	u32 control;
+	int rc;
+
+	rc = regmap_read(map, MAX34417_CONTROL_REG, &control);
+	if (rc)
+		return rc;
+
+	if (control & MAX34417_CONTROL_SMM) {
+		/* Set SMM=0 to re-init the SMM mode */
+		rc = regmap_clear_bits(map, MAX34417_CONTROL_REG,
+				       MAX34417_CONTROL_SMM);
+		if (rc)
+			return rc;
+
+		/* Reset accumulators after setting SMM=0 */
+		rc = regmap_write(map, MAX34417_UPDATE_REG, 1);
+		if (rc)
+			return rc;
+	}
+
+	/* Enable SMM to do a single accumulation */
+	rc = regmap_set_bits(map, MAX34417_CONTROL_REG, MAX34417_CONTROL_SMM);
+	if (rc)
+		return rc;
+
+	/*
+	 * After the SMM bit is changed, the UPDATE command should be sent
+	 * to reset the accumulators and perform the selected scan operation.
+	 */
+	rc = regmap_write(map, MAX34417_UPDATE_REG, 1);
+	if (rc)
+		return rc;
+	/*
+	 * UPDATE commands should be no less than 1msec apart for reliable
+	 * measurements, since in Manual mode the SPS is 1kHz, we need wait
+	 * for the measurement to finish before moving the data in the SMbus
+	 * registers.
+	 */
+	fsleep(1 * USEC_PER_MSEC);
+
+	return 0;
+}
+
+static int max34417_read_acc_count(struct max34417_data *max34417, u32 *acc_count)
+{
+	u8 buf[MAX34417_ACC_COUNT_READ_LENGTH];
+	struct regmap *map = max34417->regmap;
+	int rc;
+
+	rc = regmap_noinc_read(map, MAX34417_ACC_COUNT_REG, &buf, sizeof(buf));
+	if (rc)
+		return rc;
+
+	/* Ignore byte0 */
+	*acc_count = get_unaligned_be24(&buf[MAX34417_ACC_COUNT_READ_OFFSET]);
+
+	return 0;
+}
+
+static int max34417_read_acc_power(struct max34417_data *max34417, unsigned int address,
+				   u64 *acc_power)
+{
+	struct regmap *map = max34417->regmap;
+	u8 buf[MAX34417_POWER_READ_LENGTH];
+	int rc;
+
+	rc = regmap_noinc_read(map, address, &buf, sizeof(buf));
+	if (rc)
+		return rc;
+
+	/* Ignore byte0 */
+	*acc_power = get_unaligned_be56(&buf[MAX34417_POWER_READ_OFFSET]);
+
+	return 0;
+}
+
+static int max34417_check_ovf(struct max34417_data *max34417)
+{
+	struct regmap *map = max34417->regmap;
+	u32 control;
+	int rc;
+
+	rc = regmap_read(map, MAX34417_CONTROL_REG, &control);
+	if (rc)
+		return rc;
+
+	if (!(control & MAX34417_CONTROL_OVF))
+		return 0;
+
+	rc = regmap_clear_bits(map, MAX34417_CONTROL_REG,
+			       MAX34417_CONTROL_OVF);
+	if (rc)
+		return rc;
+
+	return regmap_write(map, MAX34417_UPDATE_REG, 1);
+}
+
+/*
+ * Save all power accumulators and counter after each UPDATE command
+ * since it will reset the internal registers for ALL channels,
+ * so in order to not loose any captured data we retrieve all registers
+ * and accumulate them in the context variables.
+ * When user gets either power or energy, those variables content
+ * will be returned and zero-ed to return the power accumulated
+ * since last read for each separate channel.
+ */
+static int max34417_save_accumulators(struct max34417_data *max34417)
+{
+	u64 acc_power;
+	u32 acc_count;
+	int rc;
+
+	rc = max34417_read_acc_count(max34417, &acc_count);
+	if (rc)
+		return rc;
+
+	for (int i = 0; i < MAX34417_CHANNEL_COUNT; i++) {
+		rc = max34417_read_acc_power(max34417, MAX34417_PWR_ACC_1_REG + i,
+					     &acc_power);
+		if (rc)
+			return rc;
+
+		/* TODO sanitize accumulators in case of overflow */
+		max34417->acc_power[i] += acc_power;
+		max34417->acc_count[i] += acc_count;
+	}
+
+	/* Check for overflow */
+	return max34417_check_ovf(max34417);
+}
+
+static int max34417_read_voltage(struct max34417_data *max34417,
+				 const struct iio_chan_spec *chan, int *val)
+{
+	struct regmap *map = max34417->regmap;
+	u8 buf[MAX34417_VOLTAGE_READ_LENGTH];
+	int rc;
+
+	/* In SMM mode, trigger a measurement cycle manually */
+	if (!max34417->cam_mode) {
+		rc = max34417_trigger_smm(max34417);
+		if (rc)
+			return rc;
+	}
+
+	/* Move the new UPDATE data into the SMBus read registers */
+	rc = regmap_write(map, MAX34417_UPDATE_REG, 1);
+	if (rc)
+		return rc;
+
+	if (max34417->cam_mode) {
+		/* Retrieve all channels to avoid missing data for other channels */
+		rc = max34417_save_accumulators(max34417);
+		if (rc)
+			return rc;
+	}
+
+	rc = regmap_noinc_read(map, chan->address, &buf, sizeof(buf));
+	if (rc)
+		return rc;
+
+	if (!max34417->cam_mode) {
+		rc = max34417_reset_smm(max34417);
+		if (rc)
+			return rc;
+	}
+
+	*val = get_unaligned_be16(&buf[MAX34417_VOLTAGE_READ_OFFSET]) >> 2;
+
+	return IIO_VAL_INT;
+}
+
+static int max34417_read_power(struct max34417_data *max34417,
+			       const struct iio_chan_spec *chan,
+			       int *val, int *val2)
+{
+	struct regmap *map = max34417->regmap;
+	u64 power;
+	int rc;
+
+	/* In SMM mode, trigger a measurement cycle manually */
+	if (!max34417->cam_mode) {
+		rc = max34417_trigger_smm(max34417);
+		if (rc)
+			return rc;
+	}
+
+	/*
+	 * Move the new UPDATE data into the SMBus read registers.
+	 * In CAM mode this will also reset the accumulators, returning
+	 * the power accumulated since the last UPDATE.
+	 */
+	rc = regmap_write(map, MAX34417_UPDATE_REG, 1);
+	if (rc)
+		return rc;
+
+	/*
+	 * Only get the accumulator counter in CAM mode, in SMM mode
+	 * we only accumulate once, so the counter is 1
+	 */
+	if (max34417->cam_mode) {
+		u64 acc_count;
+		u64 acc_power;
+
+		/* Retrieve all channels to avoid missing data for other channels */
+		rc = max34417_save_accumulators(max34417);
+		if (rc)
+			return rc;
+
+		/* Get current channel power, counter and reset them */
+		acc_power = max34417->acc_power[chan->channel];
+		acc_count = max34417->acc_count[chan->channel];
+		max34417->acc_power[chan->channel] = 0;
+		max34417->acc_count[chan->channel] = 0;
+
+		if (acc_count == 0) {
+			dev_warn_ratelimited(&max34417->indio_dev->dev,
+					     "unexpected zero accumulator count\n");
+			power = 0;
+		} else {
+			power = div64_u64(acc_power, acc_count);
+		}
+	} else {
+		rc = max34417_read_acc_power(max34417, chan->address, &power);
+		if (rc)
+			return rc;
+
+		rc = max34417_reset_smm(max34417);
+		if (rc)
+			return rc;
+	}
+
+	iio_val_s64_decompose(power, val, val2);
+
+	return IIO_VAL_INT_64;
+}
+
+static int max34417_read_energy(struct max34417_data *max34417,
+			       const struct iio_chan_spec *chan,
+			       int *val, int *val2)
+{
+	struct regmap *map = max34417->regmap;
+	u64 acc_power;
+	int rc;
+
+	/* Move the data to the SMBus registers */
+	rc = regmap_write(map, MAX34417_UPDATE_REG, 1);
+	if (rc)
+		return rc;
+
+	/* Retrieve all channels to avoid missing data for other channels */
+	rc = max34417_save_accumulators(max34417);
+	if (rc)
+		return rc;
+
+	/* Get current channel power and reset them */
+	acc_power = max34417->acc_power[chan->channel];
+	max34417->acc_power[chan->channel] = 0;
+	max34417->acc_count[chan->channel] = 0;
+
+	iio_val_s64_decompose(acc_power, val, val2);
+
+	return IIO_VAL_INT_64;
+}
+
+static int max34417_setup_cam_mode(struct max34417_data *max34417, int val)
+{
+	struct regmap *map = max34417->regmap;
+	int rc;
+
+	if (max34417->cam_mode && !val) {
+		rc = regmap_clear_bits(map, MAX34417_CONTROL_REG,
+				       MAX34417_CONTROL_CAM | MAX34417_CONTROL_SMM);
+		if (rc)
+			return rc;
+
+		/*
+		 * If CAM mode must be set, the Control byte must be set to
+		 * desired values with CAM = 0, then followed by an UPDATE
+		 */
+		rc = regmap_write(map, MAX34417_UPDATE_REG, 1);
+		if (rc)
+			return rc;
+	} else if (!max34417->cam_mode && val) {
+		/*
+		 * After this, the CAM mode bit can be set and another
+		 * UPDATE must be sent.
+		 */
+		rc = regmap_update_bits(map, MAX34417_CONTROL_REG,
+					MAX34417_CONTROL_SMM | MAX34417_CONTROL_CAM,
+					MAX34417_CONTROL_CAM);
+		if (rc)
+			return rc;
+
+		rc = regmap_write(map, MAX34417_UPDATE_REG, 1);
+		if (rc)
+			return rc;
+
+		/* Reset counters and accumulators */
+		for (int i = 0; i < MAX34417_CHANNEL_COUNT; i++) {
+			max34417->acc_power[i] = 0;
+			max34417->acc_count[i] = 0;
+		}
+	}
+
+	max34417->cam_mode = val;
+
+	return 0;
+}
+
+static int max34417_read_raw(struct iio_dev *indio_dev,
+			     struct iio_chan_spec const *chan,
+			     int *val, int *val2, long mask)
+{
+	struct max34417_data *max34417 = iio_priv(indio_dev);
+
+	guard(mutex)(&max34417->lock);
+
+	switch (mask) {
+	case IIO_CHAN_INFO_RAW:
+		switch (chan->type) {
+		case IIO_VOLTAGE:
+			return max34417_read_voltage(max34417, chan, val);
+		case IIO_POWER:
+			/* In default mode, we return a single measurement */
+			if (max34417->cam_mode)
+				return -EINVAL;
+
+			return max34417_read_power(max34417, chan, val, val2);
+		case IIO_ENERGY:
+			if (!max34417->cam_mode)
+				return -EINVAL;
+
+			return max34417_read_energy(max34417, chan, val, val2);
+		default:
+			return -EINVAL;
+		}
+	case IIO_CHAN_INFO_AVERAGE_RAW:
+		if (chan->type != IIO_POWER)
+			return -EINVAL;
+
+		/* In CAM mode, we return an average measurement */
+		if (!max34417->cam_mode)
+			return -EINVAL;
+
+		return max34417_read_power(max34417, chan, val, val2);
+	case IIO_CHAN_INFO_SCALE:
+		switch (chan->type) {
+		case IIO_VOLTAGE:
+			/* Scale to mV */
+			*val = MAX34417_VOLTAGE_CORRECTION_SCALE * MILLI;
+			*val2 = MAX34417_VOLTAGE_FULL_SCALE_BITS;
+
+			return IIO_VAL_FRACTIONAL_LOG2;
+		case IIO_POWER:
+			/*
+			 * Scale to mW
+			 * (1000 * (Power Accumulation / Counter) * Correction) / 2^30
+			 */
+			*val = max34417->input_correction[chan->channel] * MILLIWATT_PER_WATT;
+			*val2 = MAX34417_PWR_AVG_FULL_SCALE_BITS;
+
+			return IIO_VAL_FRACTIONAL_LOG2;
+		case IIO_ENERGY:
+			/*
+			 * Scale to mJ
+			 * P=(1000 * (Power Accumulation / Counter) * Correction) / 2^30
+			 * t=(Counter / Samples per Second)
+			 * E=(P * t)
+			 * Can be simplified to:
+			 * (1000 * Power Accumulation * Correction) / (2^30 * SPS)
+			 * The denominator doesn't fit in 32bit so scale down both terms.
+			 */
+			*val = max34417->input_correction[chan->channel];
+			*val2 = div_u64(BIT_ULL(MAX34417_PWR_AVG_FULL_SCALE_BITS) *
+					MAX34417_FAST_SPS_CAM, MILLI);
+
+			return IIO_VAL_FRACTIONAL;
+		default:
+			return -EINVAL;
+		}
+	case IIO_CHAN_INFO_ENABLE:
+		*val = max34417->cam_mode;
+
+		return IIO_VAL_INT;
+	default:
+		return -EINVAL;
+	}
+}
+
+static int max34417_write_raw(struct iio_dev *indio_dev,
+			      struct iio_chan_spec const *chan,
+			      int val, int val2, long mask)
+{
+	struct max34417_data *max34417 = iio_priv(indio_dev);
+
+	guard(mutex)(&max34417->lock);
+
+	switch (mask) {
+	case IIO_CHAN_INFO_ENABLE:
+		/* Setup the CAM mode for the 4 channels */
+		return max34417_setup_cam_mode(max34417, val);
+	default:
+		return -EINVAL;
+	}
+}
+
+static int max34417_read_label(struct iio_dev *indio_dev,
+			       struct iio_chan_spec const *chan,
+			       char *label)
+{
+	struct max34417_data *max34417 = iio_priv(indio_dev);
+	const char *input_label = max34417->input_label[chan->channel];
+
+	if (input_label) {
+		switch (chan->type) {
+		case IIO_VOLTAGE:
+			return sysfs_emit(label, "%s-voltage\n", input_label);
+		case IIO_POWER:
+			return sysfs_emit(label, "%s-power\n", input_label);
+		case IIO_ENERGY:
+			return sysfs_emit(label, "%s-energy\n", input_label);
+		default:
+			return 0;
+		}
+	}
+
+	switch (chan->type) {
+	case IIO_VOLTAGE:
+		return sysfs_emit(label, "channel%d-voltage\n", chan->channel);
+	case IIO_POWER:
+		return sysfs_emit(label, "channel%d-power\n", chan->channel);
+	case IIO_ENERGY:
+		return sysfs_emit(label, "channel%d-energy\n", chan->channel);
+	default:
+		return 0;
+	}
+}
+
+static const struct iio_info max34417_info = {
+	.read_raw	= max34417_read_raw,
+	.write_raw	= max34417_write_raw,
+	.read_label	= max34417_read_label,
+};
+
+static u32 max34417_calc_input_correction(u32 rsense_uOhm)
+{
+	/* Derived from Table 14. Correction Factors for Various Current-Sense Resistor Values */
+	return (MAX34417_MAX_RSENSE * MAX34417_PWR_CORRECTION_SCALE) / rsense_uOhm;
+}
+
+static int max34417_probe(struct i2c_client *client)
+{
+	struct device *dev = &client->dev;
+	struct max34417_data *max34417;
+	struct iio_dev *indio_dev;
+	struct regmap *map;
+	int rc;
+
+	map = devm_regmap_init_i2c(client, &max34417_regmap_config);
+	if (IS_ERR(map))
+		return dev_err_probe(dev, PTR_ERR(map), "regmap_init failed\n");
+
+	indio_dev = devm_iio_device_alloc(dev, sizeof(*max34417));
+	if (!indio_dev)
+		return -ENOMEM;
+
+	rc = devm_regulator_get_enable(dev, "vdd");
+	if (rc)
+		return dev_err_probe(dev, rc, "failed to get vdd regulator\n");
+
+	rc = devm_regulator_get_enable(dev, "vio");
+	if (rc)
+		return dev_err_probe(dev, rc, "failed to get vio regulator\n");
+
+	max34417 = iio_priv(indio_dev);
+	max34417->regmap = map;
+	max34417->indio_dev = indio_dev;
+
+	rc = devm_mutex_init(dev, &max34417->lock);
+	if (rc)
+		return rc;
+
+	/* Set default input correction for all channels */
+	for (int i = 0; i < MAX34417_CHANNEL_COUNT; i++)
+		max34417->input_correction[i] =
+			max34417_calc_input_correction(MAX34417_DEFAULT_RSENSE);
+
+	device_for_each_child_node_scoped(dev, node) {
+		u32 rsense_uOhm, index;
+
+		rc = fwnode_property_read_u32(node, "reg", &index);
+		if (rc)
+			return dev_err_probe(dev, rc, "failure reading reg property of %pfwP\n",
+					     node);
+
+		if (index >= MAX34417_CHANNEL_COUNT)
+			return dev_err_probe(dev, -ECHRNG, "invalid reg %d of %pfwP\n",
+					     index, node);
+
+		if (fwnode_property_present(node, "label")) {
+			rc = fwnode_property_read_string(node, "label",
+							 &max34417->input_label[index]);
+			if (rc)
+				return dev_err_probe(dev, rc,
+						"failure reading label property of %pfwP\n",
+						node);
+		}
+
+		if (fwnode_property_present(node, "shunt-resistor-micro-ohms")) {
+			rc = fwnode_property_read_u32(node, "shunt-resistor-micro-ohms",
+						      &rsense_uOhm);
+			if (rc)
+				return dev_err_probe(dev, rc,
+						"failure reading shunt property of %pfwP\n",
+						node);
+
+			if (rsense_uOhm < MAX34417_MIN_RSENSE ||
+			    rsense_uOhm > MAX34417_MAX_RSENSE)
+				return dev_err_probe(dev, -EINVAL,
+						     "invalid shunt value %d of %pfwP\n",
+						     rsense_uOhm, node);
+
+			max34417->input_correction[index] =
+				max34417_calc_input_correction(rsense_uOhm);
+		}
+	}
+
+	indio_dev->channels = max34417_channels;
+	indio_dev->num_channels = ARRAY_SIZE(max34417_channels);
+	indio_dev->name = "max34417";
+	indio_dev->info = &max34417_info;
+	indio_dev->modes = INDIO_DIRECT_MODE;
+
+	/*
+	 * Reset mode and set accumulator width to Wide
+	 *
+	 * The MAX34407 variant could be supported by setting the
+	 * MAX34417_CONTROL_MODE field to 0 and handling a smaller
+	 * accumulator width.
+	 */
+	rc = regmap_write(map, MAX34417_CONTROL_REG, MAX34417_CONTROL_MODE);
+	if (rc)
+		return dev_err_probe(dev, rc, "Error writing control register\n");
+
+	/* Reset the accumulators */
+	rc = regmap_write(map, MAX34417_UPDATE_REG, 1);
+	if (rc)
+		return rc;
+
+	return devm_iio_device_register(dev, indio_dev);
+}
+
+static const struct of_device_id max34417_of_match[] = {
+	{ .compatible = "adi,max34417" },
+	{ }
+};
+MODULE_DEVICE_TABLE(of, max34417_of_match);
+
+static const struct i2c_device_id max34417_id[] = {
+	{ .name = "max34417" },
+	{ }
+};
+MODULE_DEVICE_TABLE(i2c, max34417_id);
+
+static struct i2c_driver max34417_driver = {
+	.driver = {
+		.name   = "max34417",
+		.of_match_table = max34417_of_match,
+	},
+	.probe = max34417_probe,
+	.id_table = max34417_id,
+};
+module_i2c_driver(max34417_driver);
+
+MODULE_AUTHOR("Neil Armstrong <neil.armstrong@linaro.org>");
+MODULE_DESCRIPTION("Analog Devices MAX34417 ADC driver");
+MODULE_LICENSE("GPL");

-- 
2.34.1

