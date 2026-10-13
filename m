Received: from mail-wm1-f45.google.com (mail-wm1-f45.google.com [209.85.128.45])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 19A303CFF46
	for <linux-iio@vger.kernel.org>; Tue, 13 Oct 2026 14:07:19 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.45
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1791900444; cv=none; b=MoRxH8wUcCFoX3aQoQ0JduOXIFlEaBZGv+0XhKEVFdfMo3NPEfT4hykcskxyomBEPNxby3AStUXm7Tr/jAAbNoD63aB7/hv9FAWOmkoUbyR84X4JSFVNCEaGT6XlpEf5v/js67lUvpkFG3tFevqzofbIYR7pb8Fhuup1P/N+n1U=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1791900444; c=relaxed/simple;
	bh=tNp6En8FvOiCcAZvIn5y+mniuSFGUBEol8rmv6TLwvE=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=MblwWyNM3S5051RXM9PxIId7aUTEpme+A8lKOUYdEZRdPLus+Wwyzd1qiEdzqqY6FAYpeAqRkVtxWV6sTHkCc1rWjr9paf9+zlWLC0uqXeGRSvTywCEoEE1gYOT7w+ad+Y8k/GAfP3U3SRkgkXN4x360O3WeV3RQAfNVZNuaSZE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org; spf=pass smtp.mailfrom=linaro.org; dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b=Z7Srg6dZ; arc=none smtp.client-ip=209.85.128.45
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linaro.org
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="Z7Srg6dZ"
Received: by mail-wm1-f45.google.com with SMTP id 5b1f17b1804b1-4a1b07c3c5fso2793035e9.1
        for <linux-iio@vger.kernel.org>; Tue, 13 Oct 2026 07:07:19 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1791900438; x=1792505238; darn=vger.kernel.org;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :content-type:mime-version:subject:date:from:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=knD+5tM1VEvQznYHe5TiDSTnqpNXWEsxqtZpYAz3cWM=;
        b=Z7Srg6dZE4Efhj9/JLp2s0kvR35JdRxCS0/OyeIPKrailzGfSEANDW7z12mZ5vHD1A
         beacDZeRsdpVxECBD6XNyvl94+XQOijgKIIneQ+OGvsS+98hk3T3yxLYq81npKKoGA1f
         kWU7uNsdvNtySG/qgiCAXsbjCrXqh2dHfFchGy1t6UYS188wVTwN4xWizWScXEMPsQ/V
         kCM4y4rU5mTqBSCWhPqE4yycZRaqV1lqfVx28IWge9jxNnTIWy9xO+KvNQIXO411qPjY
         3hXYaQook3hqUOxlrIYgGy/qNxZRXYHeZViZ2jBLfMqzaKGoHgIxtIW+paCSeYLIBWOt
         GZUA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1791900438; x=1792505238;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :content-type:mime-version:subject:date:from:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=knD+5tM1VEvQznYHe5TiDSTnqpNXWEsxqtZpYAz3cWM=;
        b=mrKJX9T4BYMeU4X5qPgmHw5pqW/WE22VzDyalAlMvjTrnfKwqyb1OEzfEebfai78L+
         cysksbodnWqT3ZsdUvIy5S/ucP98UrSKIIhp9OYeGLj5apONqjdAY5BVbWjQ9PQJa6Nx
         siGESUK9r099j6SSVcrKmsS0+Yf44wy+VVgrL87vAz6UFipwDm4jPAAvOef7hvO3Po1u
         RChhsJRwyXgSMptTSLI/BQDMbm0lDZwGjiXhYUzj9c/tX+S9JTkAbZOpdf/jeWeDDtlL
         YFHJZrcxhAboSuwCArpFX/QyXX46NvLXSolmvsuI9G31ogG5Nt8J9IJhnVnqUPCRMgG9
         B63w==
X-Gm-Message-State: AFq9FYKl2MFWXe27+71JP2OpM5LkEVxRRuQD7/0Sfi16u2qHaNIC5SPt
	3VkkS9tNd8wEdlHYk6amAf14vhXJ7/mgOCtMuNktS7wqxmUDpXEmhCYVlszZyaOhuBI7+PVCFM5
	jJ4kY
X-Gm-Gg: AYBFou2KFy8fDkP+0prYLFAFotGWlLGHwyLPcs4GV7pG5Gihxv6d0f0Y9o2H4nfBQt7
	yRQ0Shg7aatNPk1upsuPu1SYZ6nLmEwXRpRW0+dUzbXt5YkbaoKLbsjg/o/JWKoAMQ/oetthOPT
	dyECiQs80eec2NhCNTJf8AwftZcqwKhx42fSfqPTE7ctChwNGIsxTkbPzRkvtjhVMc6Cf7bNQxX
	UCfB43fJQZ/6FsBBgWZoXiTkTSe9+uQY9M2WoxYxOLB+mcMD0ALRmOPlFubbWB3DFlu+eO4e1gV
	+ke3M4zqURrV+bMTJzFo57fv1OetLqMRUCeXl3RuyRqX4Ah3p/K4i4038U1JrTIhmLp0uHlR0WT
	3E8IIHHubk3oZ3e+iQOaWvlXxsmChODf4y01dMQSNJmBcNE9IRU0M3u0IGYdinGmDS1awbH10w2
	VNPp0mxOFeNaqHkxx2Ku+JzscrH7znrLIOzIWDO2gaofTsWBRHaIQWIlYWtHmDZEt0OTEpLMrXb
	+smmvK6O1MSCr0PSXU=
X-Received: by 2002:a05:600d:1:b0:4a1:9438:71a8 with SMTP id 5b1f17b1804b1-4a1943873cfmr158537905e9.26.1791900437782;
        Tue, 13 Oct 2026 07:07:17 -0700 (PDT)
Received: from arrakeen.starnux.net ([2a01:e0a:106d:1080:52eb:f6ff:feb3:451a])
        by smtp.gmail.com with ESMTPSA id 5b1f17b1804b1-4a18bead84esm364625305e9.13.2026.10.13.07.07.17
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 13 Oct 2026 07:07:17 -0700 (PDT)
From: Neil Armstrong <neil.armstrong@linaro.org>
Date: Tue, 13 Oct 2026 16:07:13 +0200
Subject: [PATCH v3 3/3] iio: adc: add driver for the MAX34417 Four-Channel
 High Dynamic Range Power Accumulator
Precedence: bulk
X-Mailing-List: linux-iio@vger.kernel.org
List-Id: <linux-iio.vger.kernel.org>
List-Subscribe: <mailto:linux-iio+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-iio+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20261013-topic-sm8x50-iio-max34417-adc-v3-3-d3604ae4a229@linaro.org>
References: <20261013-topic-sm8x50-iio-max34417-adc-v3-0-d3604ae4a229@linaro.org>
In-Reply-To: <20261013-topic-sm8x50-iio-max34417-adc-v3-0-d3604ae4a229@linaro.org>
To: Jonathan Cameron <jic23@kernel.org>, 
 David Lechner <dlechner@baylibre.com>, 
 =?utf-8?q?Nuno_S=C3=A1?= <nuno.sa@analog.com>, 
 Andy Shevchenko <andy@kernel.org>, Rob Herring <robh@kernel.org>, 
 Krzysztof Kozlowski <krzk+dt@kernel.org>, 
 Conor Dooley <conor+dt@kernel.org>
Cc: linux-iio@vger.kernel.org, devicetree@vger.kernel.org, 
 linux-kernel@vger.kernel.org, linux-hwmon@vger.kernel.org, 
 Neil Armstrong <neil.armstrong@linaro.org>
X-Mailer: b4 0.15.2
X-Developer-Signature: v=1; a=openpgp-sha256; l=24707;
 i=neil.armstrong@linaro.org; h=from:subject:message-id;
 bh=tNp6En8FvOiCcAZvIn5y+mniuSFGUBEol8rmv6TLwvE=;
 b=owEBbQKS/ZANAwAKAXfc29rIyEnRAcsmYgBqzjsSpO9cAxCmztKyO+SB4vgfboMaMAaZ04DDSdPE
 aDv1pS+JAjMEAAEKAB0WIQQ9U8YmyFYF/h30LIt33NvayMhJ0QUCas47EgAKCRB33NvayMhJ0XDBD/
 91dXwtXPAPQbmWuoeLOiOaIXNs6J9K8RPGUeBzq1coYPAUFNfqKwFpK64R/2Z0Bc01Y7fQi5RmDqG9
 FyBexqGAINN7IE4lX/HfBRslmhWdXSp43cwcRRjVsLGDXPu2U8zA6j2QH+E75k8/T0O/Gh8apL1zZV
 EtB/rwsoqcPDq9Zhd64Z9/rVUFQVAcG9b2LVbNZcGL+Xhpezl+KMQeT1RXyD+B2AdKDiaKr6G39ixD
 J6EQIJ6JRHVAjWZs8zLsQvPPFfY6MgloimiXXjbJJZ32iewCANN50HLmONZOjEoF5O781kd7ELdKnh
 sXqjhzQqvcHXMvVPMO43I6P3jw7w8Is1dQyhgSUzuAkSRiMif3uucyUViB6ZWVLD4Q8Ya20fHimwVD
 tckcvaJ2jnI8a1gpGn/KVEF0eBWdyFq2LEfJWMVvkof7D0G6P0aOkwrWaR2ZM01SZhtI31IlZsQXCg
 s/TKbHcq2ZvLKMtMVkclmpqqGpc4u6xOitLjm1YhLjjim8s0+f6EkTVFefux0zLtr66GbVOqfLl7UD
 H5cIt8zbedrqiRrPXRTlFP2bpe/s+uOBHrqrcfAj57rrBLpjf0Ao4Z1S157bHmOkH6NrSvh4RrQG29
 RmZwKYe6314ReBlrT5dQW2X+ZBh63Ds7S1jhLRNjaftCdrs96QBCg7GuXF3w==
X-Developer-Key: i=neil.armstrong@linaro.org; a=openpgp;
 fpr=89EC3D058446217450F22848169AB7B1A4CFF8AE

The MAX34417 is a specialized current and voltage monitor used to
determine power consumption of portable systems. The driver support
getting the channels voltage, average power and accumulated average
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
 drivers/iio/adc/max34417.c | 777 +++++++++++++++++++++++++++++++++++++++++++++
 3 files changed, 789 insertions(+)

diff --git a/drivers/iio/adc/Kconfig b/drivers/iio/adc/Kconfig
index 415e519ad4eb..15360c78d3e5 100644
--- a/drivers/iio/adc/Kconfig
+++ b/drivers/iio/adc/Kconfig
@@ -1116,6 +1116,17 @@ config MAX34408
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
 config MAX77541_ADC
 	tristate "Analog Devices MAX77541 ADC driver"
 	depends on MFD_MAX77541
diff --git a/drivers/iio/adc/Makefile b/drivers/iio/adc/Makefile
index dcec0abb03b7..c667e7ecbc53 100644
--- a/drivers/iio/adc/Makefile
+++ b/drivers/iio/adc/Makefile
@@ -95,6 +95,7 @@ obj-$(CONFIG_MAX1241) += max1241.o
 obj-$(CONFIG_MAX1363) += max1363.o
 obj-$(CONFIG_MAX14001) += max14001.o
 obj-$(CONFIG_MAX34408) += max34408.o
+obj-$(CONFIG_MAX34417) += max34417.o
 obj-$(CONFIG_MAX77541_ADC) += max77541-adc.o
 obj-$(CONFIG_MAX9611) += max9611.o
 obj-$(CONFIG_MCP320X) += mcp320x.o
diff --git a/drivers/iio/adc/max34417.c b/drivers/iio/adc/max34417.c
new file mode 100644
index 000000000000..00d7f20cd953
--- /dev/null
+++ b/drivers/iio/adc/max34417.c
@@ -0,0 +1,777 @@
+// SPDX-License-Identifier: GPL-2.0
+/*
+ * IIO driver for Maxim MAX34417 ADC, 4-Channels High Dynamic Range Power Accumulator
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
+#define MAX34417_MIN_RSENSE		(MILLI)	/* 1 milliOhm */
+#define MAX34417_MAX_RSENSE		(100 * MILLI) /* 100 milliOhm */
+#define MAX34417_DEFAULT_RSENSE		MAX34417_MIN_RSENSE
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
+ * @dev:	MAX34417 device.
+ * @lock:	Lock for protecting access to device hardware registers, mostly
+ *		for reading common accumulator count and control register.
+ * @input_correction:	Correction based on the Rsense value from channel nodes.
+ * @input_label:	Channel label from channel nodes.
+ * @cam_mode:		State of the Continuous Accumulate Mode feature
+ * @acc_power:		Saved power accumulator for each channel when in CAM mode
+ * @acc_count:		Saved counter for each channel when in CAM mode
+ */
+struct max34417_data {
+	struct iio_dev *indio_dev;
+	struct regmap *regmap;
+	struct device *dev;
+	struct mutex lock;
+	u32 input_correction[MAX34417_CHANNEL_COUNT];
+	const char *input_label[MAX34417_CHANNEL_COUNT];
+	bool cam_mode;
+	u64 acc_power[MAX34417_CHANNEL_COUNT];
+	u32 acc_count[MAX34417_CHANNEL_COUNT];
+};
+
+static const struct regmap_config max34417_regmap_config = {
+	.reg_bits	= 8,
+	.val_bits	= 8,
+	.max_register	= MAX34417_BULK_VOLTAGE_READOUT_REG,
+};
+
+#define MAX34417_CHANNEL(_index, _v_address, _power_address)	\
+	{							\
+		.type = IIO_VOLTAGE,				\
+		.info_mask_separate	= BIT(IIO_CHAN_INFO_RAW) | \
+					  BIT(IIO_CHAN_INFO_SCALE), \
+		.channel = (_index),				\
+		.address = (_v_address),			\
+		.indexed = 1,					\
+	},							\
+	{							\
+		.type = IIO_POWER,				\
+		.info_mask_separate	= BIT(IIO_CHAN_INFO_RAW) | \
+					  BIT(IIO_CHAN_INFO_AVERAGE_RAW) | \
+					  BIT(IIO_CHAN_INFO_SCALE), \
+		.channel = (_index),				\
+		.address = (_power_address),			\
+		.indexed = 1,					\
+	},							\
+	{							\
+		.type = IIO_ENERGY,				\
+		.info_mask_separate	= BIT(IIO_CHAN_INFO_RAW) | \
+					  BIT(IIO_CHAN_INFO_SCALE), \
+		.info_mask_shared_by_type = BIT(IIO_CHAN_INFO_ENABLE), \
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
+	u32 control;
+	int rc;
+
+	rc = regmap_read(max34417->regmap, MAX34417_CONTROL_REG, &control);
+	if (rc)
+		return rc;
+
+	/* Set SMM=0 to re-init the SMM mode */
+	control &= ~(MAX34417_CONTROL_SMM);
+	rc = regmap_write(max34417->regmap, MAX34417_CONTROL_REG, control);
+	if (rc)
+		return rc;
+
+	/* Reset accumulators after setting SMM=0 */
+	rc = regmap_write(max34417->regmap, MAX34417_UPDATE_REG, 1);
+	if (rc)
+		return rc;
+
+	return 0;
+}
+
+static int max34417_trigger_smm(struct max34417_data *max34417)
+{
+	u32 control;
+	int rc;
+
+	rc = regmap_read(max34417->regmap, MAX34417_CONTROL_REG, &control);
+	if (rc)
+		return rc;
+
+	if (control & MAX34417_CONTROL_SMM) {
+		/* Set SMM=0 to re-init the SMM mode */
+		control &= ~(MAX34417_CONTROL_SMM);
+		rc = regmap_write(max34417->regmap, MAX34417_CONTROL_REG, control);
+		if (rc)
+			return rc;
+
+		/* Reset accumulators after setting SMM=0 */
+		rc = regmap_write(max34417->regmap, MAX34417_UPDATE_REG, 1);
+		if (rc)
+			return rc;
+	}
+
+	/* Enable SMM to do a single accumulation */
+	control |= MAX34417_CONTROL_SMM;
+	rc = regmap_write(max34417->regmap, MAX34417_CONTROL_REG, control);
+	if (rc)
+		return rc;
+
+	/*
+	 * After the SMM bit is changed, the UPDATE command should be sent
+	 * to reset the accumulators and perform the selected scan operation.
+	 */
+	rc = regmap_write(max34417->regmap, MAX34417_UPDATE_REG, 1);
+	if (rc)
+		return rc;
+	/*
+	 * UPDATE commands should be no less than 1msec apart for reliable
+	 * measurements.
+	 */
+	fsleep(1000);
+
+	return 0;
+}
+
+static int max34417_read_acc_count(struct max34417_data *max34417, u32 *acc_count)
+{
+	u8 buf[MAX34417_ACC_COUNT_READ_LENGTH];
+	int rc;
+
+	rc = regmap_noinc_read(max34417->regmap, MAX34417_ACC_COUNT_REG,
+			       &buf, sizeof(buf));
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
+	u8 buf[MAX34417_POWER_READ_LENGTH];
+	int rc;
+
+	rc = regmap_noinc_read(max34417->regmap, address, &buf, sizeof(buf));
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
+	u32 control;
+	int rc;
+
+	/* Check for overflow */
+	rc = regmap_read(max34417->regmap, MAX34417_CONTROL_REG, &control);
+	if (rc)
+		return rc;
+
+	if (control & MAX34417_CONTROL_OVF) {
+		rc = regmap_write(max34417->regmap, MAX34417_CONTROL_REG,
+				  control & ~MAX34417_CONTROL_OVF);
+		if (rc)
+			return rc;
+
+		rc = regmap_write(max34417->regmap, MAX34417_UPDATE_REG, 1);
+		if (rc)
+			return rc;
+	}
+
+	return 0;
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
+	unsigned int i;
+	u64 acc_power;
+	u32 acc_count;
+	int rc;
+
+	rc = max34417_read_acc_count(max34417, &acc_count);
+	if (rc)
+		return rc;
+
+	for (i = 0; i < MAX34417_CHANNEL_COUNT; ++i) {
+		rc = max34417_read_acc_power(max34417, MAX34417_PWR_ACC_1_REG + i,
+					     &acc_power);
+		if (rc)
+			return rc;
+
+		max34417->acc_power[i] += acc_power;
+		max34417->acc_count[i] += acc_count;
+	}
+
+	/* Check for overflow */
+	rc = max34417_check_ovf(max34417);
+	if (rc)
+		return rc;
+
+	return 0;
+}
+
+static int max34417_read_voltage(struct max34417_data *max34417,
+				 const struct iio_chan_spec *chan, int *val)
+{
+	u8 buf[MAX34417_VOLTAGE_READ_LENGTH];
+	u16 voltage;
+	int rc;
+
+	guard(mutex)(&max34417->lock);
+
+	/* In SMM mode, trigger a measurement cycle manually */
+	if (!max34417->cam_mode) {
+		rc = max34417_trigger_smm(max34417);
+		if (rc)
+			return rc;
+	}
+
+	/* Move the new UPDATE data into the SMBus read registers */
+	rc = regmap_write(max34417->regmap, MAX34417_UPDATE_REG, 1);
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
+	rc = regmap_noinc_read(max34417->regmap, chan->address, &buf, sizeof(buf));
+	if (rc)
+		return rc;
+
+	if (!max34417->cam_mode) {
+		rc = max34417_reset_smm(max34417);
+		if (rc)
+			return rc;
+	}
+
+	/* Ignore byte0 */
+	voltage = get_unaligned_be16(&buf[MAX34417_VOLTAGE_READ_OFFSET]);
+	voltage >>= 2;
+
+	*val = voltage;
+
+	return IIO_VAL_INT;
+}
+
+static int max34417_read_power(struct max34417_data *max34417,
+			       const struct iio_chan_spec *chan,
+			       int *val, int *val2)
+{
+	u64 power;
+	int rc;
+
+	guard(mutex)(&max34417->lock);
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
+	rc = regmap_write(max34417->regmap, MAX34417_UPDATE_REG, 1);
+	if (rc)
+		return rc;
+
+	/*
+	 * Only get the accumulator counter in CAM mode, in SMM mode
+	 * we only accumulate only once, so the counter is 1
+	 */
+	if (max34417->cam_mode) {
+		u32 acc_count;
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
+		if (unlikely(acc_count == 0)) {
+			dev_warn(max34417->dev, "unexpected zero accumulator count\n");
+
+			*val = 0;
+			*val2 = 0;
+
+			return IIO_VAL_INT_64;
+		}
+
+		power = div_u64(acc_power, acc_count);
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
+	*val = FIELD_GET(GENMASK_ULL(31, 0), power);
+	*val2 = FIELD_GET(GENMASK_ULL(55, 32), power);
+
+	return IIO_VAL_INT_64;
+}
+
+static int max34417_read_energy(struct max34417_data *max34417,
+			       const struct iio_chan_spec *chan,
+			       int *val, int *val2)
+{
+	u64 acc_power;
+	int rc;
+
+	guard(mutex)(&max34417->lock);
+
+	/*
+	 * Move the data to the SMBus registers
+	 */
+	rc = regmap_write(max34417->regmap, MAX34417_UPDATE_REG, 1);
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
+	*val = FIELD_GET(GENMASK_ULL(31, 0), acc_power);
+	*val2 = FIELD_GET(GENMASK_ULL(55, 32), acc_power);
+
+	return IIO_VAL_INT_64;
+}
+
+static int max34417_setup_cam_mode(struct max34417_data *max34417, int val)
+{
+	u32 control;
+	int rc, i;
+
+	guard(mutex)(&max34417->lock);
+
+	rc = regmap_read(max34417->regmap, MAX34417_CONTROL_REG, &control);
+	if (rc)
+		return rc;
+
+	if (max34417->cam_mode && !val) {
+		/* SMM and CAM modes should not be enabled at the same time */
+		control &= ~(MAX34417_CONTROL_CAM | MAX34417_CONTROL_SMM);
+		rc = regmap_write(max34417->regmap, MAX34417_CONTROL_REG, control);
+		if (rc)
+			return rc;
+
+		/*
+		 * If CAM mode must be set, the Control byte must be set to
+		 * desired values with CAM = 0, then followed by an UPDATE
+		 */
+		rc = regmap_write(max34417->regmap, MAX34417_UPDATE_REG, 1);
+		if (rc)
+			return rc;
+	} else if (!max34417->cam_mode && val) {
+		/*
+		 * After this, the CAM mode bit can be set and another
+		 * UPDATE must be sent.
+		 */
+		control |= MAX34417_CONTROL_CAM;
+		/* SMM and CAM modes should not be enabled at the same time */
+		control &= ~(MAX34417_CONTROL_SMM);
+		rc = regmap_write(max34417->regmap, MAX34417_CONTROL_REG, control);
+		if (rc)
+			return rc;
+
+		rc = regmap_write(max34417->regmap, MAX34417_UPDATE_REG, 1);
+		if (rc)
+			return rc;
+
+		/* Reset counters and accumulators */
+		for (i = 0; i < MAX34417_CHANNEL_COUNT; ++i) {
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
+		if (chan->type == IIO_VOLTAGE) {
+			/* Scale to mV */
+			*val = MAX34417_VOLTAGE_CORRECTION_SCALE * MILLI;
+			*val2 = MAX34417_VOLTAGE_FULL_SCALE_BITS;
+
+			return IIO_VAL_FRACTIONAL_LOG2;
+		} else if (chan->type == IIO_POWER) {
+			/*
+			 * Scale to mW
+			 * (1000 * (Power Accumulation / Counter) * Correction) / 2^30
+			 */
+			*val = max34417->input_correction[chan->channel] * MILLI;
+			*val2 = MAX34417_PWR_AVG_FULL_SCALE_BITS;
+
+			return IIO_VAL_FRACTIONAL_LOG2;
+		} else if (chan->type == IIO_ENERGY) {
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
+			*val2 = ((u64)(1 << MAX34417_PWR_AVG_FULL_SCALE_BITS) *
+				 MAX34417_FAST_SPS_CAM) / MILLI;
+
+			return IIO_VAL_FRACTIONAL;
+		}
+
+		return -EINVAL;
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
+	if (chan->type == IIO_VOLTAGE) {
+		if (input_label)
+			return sysfs_emit(label, "%s-voltage\n", input_label);
+
+		return sysfs_emit(label, "channel%d-voltage\n", chan->channel);
+	}
+
+	if (chan->type == IIO_POWER) {
+		if (input_label)
+			return sysfs_emit(label, "%s-power\n", input_label);
+
+		return sysfs_emit(label, "channel%d-power\n", chan->channel);
+	}
+
+	if (chan->type == IIO_ENERGY) {
+		if (input_label)
+			return sysfs_emit(label, "%s-energy\n", input_label);
+
+		return sysfs_emit(label, "channel%d-energy\n", chan->channel);
+	}
+
+	return 0;
+}
+
+static const struct iio_info max34417_info = {
+	.read_raw	= max34417_read_raw,
+	.write_raw	= max34417_write_raw,
+	.read_label	= max34417_read_label,
+};
+
+static unsigned int max34417_calc_input_correction(u32 rsense)
+{
+	/* (100 milliOhm / rsense) * MAX34417_PWR_CORRECTION_SCALE */
+	return (MAX34417_MAX_RSENSE * MAX34417_PWR_CORRECTION_SCALE) / rsense;
+}
+
+static int max34417_probe(struct i2c_client *client)
+{
+	struct device *dev = &client->dev;
+	struct max34417_data *max34417;
+	struct iio_dev *indio_dev;
+	struct regmap *regmap;
+	int rc, i;
+
+	regmap = devm_regmap_init_i2c(client, &max34417_regmap_config);
+	if (IS_ERR(regmap))
+		return dev_err_probe(dev, PTR_ERR(regmap), "regmap_init failed\n");
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
+	max34417->regmap = regmap;
+	max34417->dev = dev;
+	max34417->indio_dev = indio_dev;
+	mutex_init(&max34417->lock);
+
+	/* Set default input correction for all channels */
+	for (i = 0; i < MAX34417_CHANNEL_COUNT; ++i)
+		max34417->input_correction[i] =
+			max34417_calc_input_correction(MAX34417_DEFAULT_RSENSE);
+
+	device_for_each_child_node_scoped(dev, node) {
+		u32 rsense, index;
+
+		if (!fwnode_property_present(node, "reg"))
+			return dev_err_probe(dev, -EINVAL, "missing reg property of %pfwP\n",
+					     node);
+
+		rc = fwnode_property_read_u32(node, "reg", &index);
+		if (rc)
+			return dev_err_probe(dev, rc, "failure reading reg property of %pfwP\n",
+					     node);
+
+		if (index >= MAX34417_CHANNEL_COUNT)
+			return dev_err_probe(dev, -EINVAL, "invalid reg %d of %pfwP\n",
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
+						      &rsense);
+			if (rc)
+				return dev_err_probe(dev, rc,
+						"failure reading shunt property of %pfwP\n",
+						node);
+
+			if (!rsense || rsense < MAX34417_MIN_RSENSE ||
+			    rsense > MAX34417_MAX_RSENSE)
+				return dev_err_probe(dev, -EINVAL,
+						     "invalid shunt value %d of %pfwP\n",
+						     rsense, node);
+
+			max34417->input_correction[index] =
+				max34417_calc_input_correction(rsense);
+		}
+	}
+
+	indio_dev->channels = max34417_channels;
+	indio_dev->num_channels = ARRAY_SIZE(max34417_channels);
+	indio_dev->name = "max34417";
+	indio_dev->info = &max34417_info;
+	indio_dev->modes = INDIO_DIRECT_MODE;
+
+	rc = devm_iio_device_register(dev, indio_dev);
+	if (rc)
+		return rc;
+
+	/* Reset mode and set accumulator width to Wide */
+	rc = regmap_write(max34417->regmap, MAX34417_CONTROL_REG, MAX34417_CONTROL_MODE);
+	if (rc)
+		return dev_err_probe(max34417->dev, rc, "Error writing control register\n");
+
+	/* Reset the accumulators */
+	rc = regmap_write(max34417->regmap, MAX34417_UPDATE_REG, 1);
+	if (rc)
+		return rc;
+
+	return 0;
+}
+
+static const struct of_device_id max34417_of_match[] = {
+	{ .compatible = "maxim,max34417" },
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
+MODULE_DESCRIPTION("Maxim MAX34417 ADC driver");
+MODULE_LICENSE("GPL");

-- 
2.34.1

