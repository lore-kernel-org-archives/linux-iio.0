Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=209.85.128.46
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1793193556;
	b=g6GnIsm6N0CGVj/iSVdOfEVsDD3gFxOb5hQMIakniyh0mgwlEhsuSPUcO/nWBmSlgX8o
	 qYJOcUHz0x6VyUBVCnQB0g6UUSs2a2VRgtSL2lYM0GMAp8DGU25pWrRTk8GtKF9P32AXR
	 xnm4RmIAjGq2Y8LD7RzCKB5SHsaA5J2i+Q0n7Mmau30HcRMY3etRzNt52TuAcfkTcOhVr
	 yvAVbjwU1RInnpENACIiwVm/sMHEhsJXIfiiqjkZul19BiJQUKsCy9zhvezpFr03PWJ+X
	 bVeDGGRXzHTi7eoidfHjHPZNLFQ2nZSe+N4hg+lmmOPMp9GbBIvjG/bjmZXymIbssXg==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1793193556;
	h=DMARC-Filter:Received:DKIM-Signature:X-Google-DKIM-Signature:
	 X-Gm-Message-State:X-Gm-Gg:X-Received:Received:From:Date:Subject:
	 MIME-Version:Content-Type:Content-Transfer-Encoding:Message-Id:
	 References:In-Reply-To:To:Cc:X-Mailer:X-Developer-Signature:
	 X-Developer-Key;
	bh=CLbW+d+w8rkcBCgCHYGHaNdAu7YP6Fdg520B2FD8QnQ=;
	b=Hf5l5Gcwbk0j3a3+vHqbD4TyPzUuIlWvFn4ESa0yhNjenMPsvHz8rtn5LKGrhyxhSzVU
	 lO+ptqO9N+DURiIdLRjisIOoCl6TH+ZNZPguFNOpob+fjJi2s5MsCic53S4UsLPLZ1LLG
	 8H3jpQO9lVNaSdrPZNq5AWerMUPiEJu6rJfUeAD5MEqL2IsCZl9PaNIr37f3kCKvGIDK+
	 /TrEbrqRvkUZyxbgliIal+DzQXz1fhpOkUuqY2OIeIcPxIGP3tOVmYTlaX9McNBkic3vG
	 rF7OIHYjbO4oJ+1jrir9OYk7dyRuHLJX7FZyy80WYEyKj1aYGJTKEL9SuIm2P5JqEAA==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=linaro.org;
	spf=pass smtp.mailfrom=linaro.org;
	dkim=pass header.d=linaro.org header.i=@linaro.org header.a=rsa-sha256 header.s=google header.b=A8c25nDW;
	arc=none smtp.remote-ip=209.85.128.46
Received: from mail-wm1-f46.google.com (mail-wm1-f46.google.com [209.85.128.46])
	(using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3A54860A2616
	for <linux-iio@vger.kernel.org>; Wed, 28 Oct 2026 13:19:15 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org 3A54860A2616
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linaro.org
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=linaro.org header.i=@linaro.org header.a=rsa-sha256 header.s=google header.b=A8c25nDW
Received: by mail-wm1-f46.google.com with SMTP id 5b1f17b1804b1-4a210470b49so7495075e9.2
        for <linux-iio@vger.kernel.org>; Wed, 28 Oct 2026 06:19:14 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1793193553; x=1793798353; darn=vger.kernel.org;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :content-type:mime-version:subject:date:from:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=CLbW+d+w8rkcBCgCHYGHaNdAu7YP6Fdg520B2FD8QnQ=;
        b=A8c25nDWlRT5e8+IcX+xCE6mGScs6DA9YmvhgtMeOlUft8PlzheeSTnCcVEVNw5sqo
         daz3/PKVcm1O2cJS72WBXYFTYfvWDtqwmvapiZKyb4eYJeY0m1fR33RqjnMMrRHal8dq
         +yHKvatHo4H8mau3ogwLJyqoHNHu+8v7a+MLU7oFnb6vsVF0A42ePkf3rmu9gl2CYg2L
         W7uSwLn7FAEsmbwmxEQ2y+gef4D9m7cT8Yl/d8FEXM/8XmiSQAxTsh/pweUFY5crEYql
         W0EqcEstr5HBM+OoOduEOOluVEjRKmSXymUkd6WTaWwFvd8+86LiwKMiJ82V9/wepx/S
         9xsw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1793193553; x=1793798353;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :content-type:mime-version:subject:date:from:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=CLbW+d+w8rkcBCgCHYGHaNdAu7YP6Fdg520B2FD8QnQ=;
        b=tYfuTOuFoDQGKDJ3Xkb0T7b+MWyGJ38kio5XhFue7KIoBqgadn+euslGMCTfUOqmsk
         VPDQsg2wvPRQGwW42edmd1MEbwvNKl/mzlJxoGpsN3106BDuOnOuPBevwKBo2s/+0l04
         0kRbuBtsn6IpAdRMEEzfoF1RV2siLrT77RTQ5LxI3lbKo4wGufqC/n3r719Y3Ld7Fv1G
         6OhJhaO7W2Vy4XxFF5bm+cOCIKY5hU2MQuFmqo/n91/1SLt06nQ1bicjbgJUlTFOsC65
         JIVf3PJTa5Lj1ob2Z/WhmBgqvaMFnIgvlLWsacNHqcdRn04AoAqK86nh6+fXoqJBRANe
         Lpfg==
X-Gm-Message-State: AFq9FYI8NFqohNmUT8tKei4/bszfoHsFjSbvvgxotoK/4dDDTi09EaVd
	eLQn9Wd3uE/GoFaHlpOLFxul9teOrjFxBDdHSFMBHZnDeF/QVWvO8SWhQXWUHDTNE7lzJ3voM/N
	Bq8NuFnc=
X-Gm-Gg: AYBFou2z3Tb+cXR40jh/4Hk8J00B96GfnDWODI6JFm4m+ObTfvj572tVuXGPEvtNxJ4
	Envd1vUI3fKDYCzz3H+gLFfK7uNVSKnXVZlfbYhvsLo5z3HVbGIeZpJ+rB/C30M3jjczevlTaa3
	eIOgc+ISVy8QTe3WWOC+84X9NBDaIpqS/sHhxSYYWZ7D/saAwxn6iHaoHIjBGQoRiQYxYq1FDuA
	sMzFSeNKrL0ORM6ZEE1XkCEjyZOEmym7CiskDhyFIVNQuBsVxT0MaDIPHiJxQZtnm+A2R5Y0QCb
	1wUKi3wF9FwHtWpvw1CeSAp2TJklHr1EpYu0LZKUZAvU/mKrtn5ISJ2lXcgnuBr6SYrdSS6yS3S
	lKZTluIOOLU+QlUw6tod8iRGlYINgeXWV6+c1xQXCRNTizksxKZSz/VJSgtCBYcDhguVhDK6XJT
	3WABiLchRMRr3qCbIkra8b7H2bItKWnVYv5gVaCQcN/oZpXoKVqmLKDAKqP1O1Scs8qHCwtqpvI
	eX9xHO6vrWec+rVmtv/qqMsGm1GHfORl3AbOm7AHdwBKkt9/1Bx8BQU9CJLKFkDoEvXkz5bk48t
	SyVZpeg/MqdPmPMpjhdgIBuLMhotQaddTpVGtURg9Ww=
X-Received: by 2002:a05:600c:3556:b0:4a2:1cc:6551 with SMTP id 5b1f17b1804b1-4a9678c3cadmr52291625e9.35.1793193553253;
        Wed, 28 Oct 2026 06:19:13 -0700 (PDT)
Received: from arrakeen-2.home ([2a01:e0a:106d:1080:52eb:f6ff:feb3:451a])
        by smtp.gmail.com with ESMTPSA id 5b1f17b1804b1-4a996aa0ff3sm19869395e9.1.2026.10.28.06.19.12
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 28 Oct 2026 06:19:12 -0700 (PDT)
From: Neil Armstrong <neil.armstrong@linaro.org>
Date: Wed, 28 Oct 2026 14:19:06 +0100
Subject: [PATCH v4 3/3] iio: adc: add driver for the MAX34417 Four-Channel
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
Message-Id: <20261028-topic-sm8x50-iio-max34417-adc-v4-3-d4baaf3ee903@linaro.org>
References: <20261028-topic-sm8x50-iio-max34417-adc-v4-0-d4baaf3ee903@linaro.org>
In-Reply-To: <20261028-topic-sm8x50-iio-max34417-adc-v4-0-d4baaf3ee903@linaro.org>
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
X-Developer-Signature: v=1; a=openpgp-sha256; l=25101;
 i=neil.armstrong@linaro.org; h=from:subject:message-id;
 bh=C61JwAHP6QQsU/mnxDygoLMQ10a+Cqu5FkcYuyGriT8=;
 b=owEBbQKS/ZANAwAKAXfc29rIyEnRAcsmYgBq4fZLtzbrNGcEYJJ1FA4cq/qXaLE2hSag6Hl1tp6J
 hcGN5WGJAjMEAAEKAB0WIQQ9U8YmyFYF/h30LIt33NvayMhJ0QUCauH2SwAKCRB33NvayMhJ0cEGEA
 ChGLZHSdkERN3qVAu1XZd2TFHbYdlW4us2mA0WbPy2p92wUC9TzKwPuBnBThjI2sTh31yheHsdCy+I
 PnpJTbsOYxmV7vFlGhcdqK8bUhwKmyM218P4QJKwWmRVqTfm6Vtqt9EEnVPhmJn4kd8Wxy1KTMR6Uf
 n79hPqusygqTIJNkdDCB366TjeUVS4+HLIOMqaEIfORUxXOJFz+4XItwN6LptgOOWTyvP8AUmeOmQ2
 Pdyk2nY9QI874ttWfkRxqUkaW/FBQ2oPkjRwlM7XU8bXJ5d3BEj17BTYfVKhbX5HdnD4M5678irHA1
 oOOdeOnPq/LJtuEzZxM5RHJV4xBJqjmv5rAePJ5Rkg4Vp+xMgZDmX1QOTlwvcgeO5VVePG4AgH3vRm
 ks05pRq9pqHAiskAVQuhfUbTtSvdXd9pLvjZmr7dfG573QayocoUudB19M41k+cYoRVw9qoWMsh5q/
 +lwvipquOLFJT5xY6E9dI2swiWpw+YaWZEB9mazF8zzOIh4CJlXfGnVjg1FNe0ST9VGGYw1P73drxn
 ltUPotPeXfpMwX7k5ABuRJx1tpkcN8gWlcEN+mOq8hFRtM45S8RIKMGw6vbz5bs3WjYFeyQgUrHLjX
 i2G8l66cS8H7By6JuRsj9gz9ewdnVSrtOpos5wxQ1UoGtkcl/YcZW94n5VSg==
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
 drivers/iio/adc/max34417.c | 788 +++++++++++++++++++++++++++++++++++++++++++++
 3 files changed, 800 insertions(+)

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
index 000000000000..b1064cf631b5
--- /dev/null
+++ b/drivers/iio/adc/max34417.c
@@ -0,0 +1,788 @@
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
+ * @cam_mode:		State of the Continuous Accumulate Mode feature
+ * @acc_power:		Saved power accumulator for each channel when in CAM mode
+ * @acc_count:		Saved counter for each channel when in CAM mode
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
+	default:
+	/* MAX34417_CONTROL_REG field OVF is volatile */
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
+	int rc;
+
+	/* Set SMM=0 to re-init the SMM mode */
+	rc = regmap_clear_bits(max34417->regmap, MAX34417_CONTROL_REG,
+			       MAX34417_CONTROL_SMM);
+	if (rc)
+		return rc;
+
+	/* Reset accumulators after setting SMM=0 */
+	return regmap_write(max34417->regmap, MAX34417_UPDATE_REG, 1);
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
+		rc = regmap_clear_bits(max34417->regmap, MAX34417_CONTROL_REG,
+				       MAX34417_CONTROL_SMM);
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
+	rc = regmap_set_bits(max34417->regmap, MAX34417_CONTROL_REG,
+			     MAX34417_CONTROL_SMM);
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
+	fsleep(1 * USEC_PER_MSEC);
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
+	rc = regmap_read(max34417->regmap, MAX34417_CONTROL_REG, &control);
+	if (rc)
+		return rc;
+
+	if (control & MAX34417_CONTROL_OVF) {
+		rc = regmap_clear_bits(max34417->regmap, MAX34417_CONTROL_REG,
+				       MAX34417_CONTROL_OVF);
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
+	*val = get_unaligned_be16(&buf[MAX34417_VOLTAGE_READ_OFFSET]) >> 2;
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
+
+			*val = 0;
+			*val2 = 0;
+
+			return IIO_VAL_INT_64;
+		}
+
+		power = div64_u64(acc_power, acc_count);
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
+	*val = lower_32_bits(power);
+	*val2 = upper_32_bits(power);
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
+	/* Move the data to the SMBus registers */
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
+	*val = lower_32_bits(acc_power);
+	*val2 = upper_32_bits(acc_power);
+
+	return IIO_VAL_INT_64;
+}
+
+static int max34417_setup_cam_mode(struct max34417_data *max34417, int val)
+{
+	int rc;
+
+	if (max34417->cam_mode && !val) {
+		rc = regmap_clear_bits(max34417->regmap, MAX34417_CONTROL_REG,
+				       MAX34417_CONTROL_CAM | MAX34417_CONTROL_SMM);
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
+		rc = regmap_clear_bits(max34417->regmap, MAX34417_CONTROL_REG,
+				       MAX34417_CONTROL_SMM);
+		if (rc)
+			return rc;
+		rc = regmap_set_bits(max34417->regmap, MAX34417_CONTROL_REG,
+				     MAX34417_CONTROL_CAM);
+		if (rc)
+			return rc;
+
+		rc = regmap_write(max34417->regmap, MAX34417_UPDATE_REG, 1);
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
+			*val = max34417->input_correction[chan->channel] * MILLIWATT_PER_WATT;
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
+			*val2 = div_u64(BIT_ULL(MAX34417_PWR_AVG_FULL_SCALE_BITS) *
+					MAX34417_FAST_SPS_CAM, MILLI);
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
+static unsigned int max34417_calc_input_correction(u32 rsense_microOhm)
+{
+	/* (100 milliOhm / rsense) * MAX34417_PWR_CORRECTION_SCALE */
+	return (MAX34417_MAX_RSENSE * MAX34417_PWR_CORRECTION_SCALE) / rsense_microOhm;
+}
+
+static int max34417_probe(struct i2c_client *client)
+{
+	struct device *dev = &client->dev;
+	struct max34417_data *max34417;
+	struct iio_dev *indio_dev;
+	struct regmap *regmap;
+	int rc;
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
+		u32 rsense_microOhm, index;
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
+						      &rsense_microOhm);
+			if (rc)
+				return dev_err_probe(dev, rc,
+						"failure reading shunt property of %pfwP\n",
+						node);
+
+			if (rsense_microOhm < MAX34417_MIN_RSENSE ||
+			    rsense_microOhm > MAX34417_MAX_RSENSE)
+				return dev_err_probe(dev, -EINVAL,
+						     "invalid shunt value %d of %pfwP\n",
+						     rsense_microOhm, node);
+
+			max34417->input_correction[index] =
+				max34417_calc_input_correction(rsense_microOhm);
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
+	rc = regmap_write(max34417->regmap, MAX34417_CONTROL_REG, MAX34417_CONTROL_MODE);
+	if (rc)
+		return dev_err_probe(dev, rc, "Error writing control register\n");
+
+	/* Reset the accumulators */
+	rc = regmap_write(max34417->regmap, MAX34417_UPDATE_REG, 1);
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

