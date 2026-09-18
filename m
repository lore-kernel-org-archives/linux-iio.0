Received: from mail-oi2-f5.google.com (mail-oi2-f5.google.com [74.125.231.197])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5650C2222AC
	for <linux-iio@vger.kernel.org>; Fri, 18 Sep 2026 02:20:16 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=74.125.231.197
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1789698024; cv=none; b=Rc9cESQE9FcVlD7Hz82+LU1emGRnueehfpAsHeLjNg0mFnKMX5bf3WTfQA0uOtfbfvKDIO9s2RqHutplEPqLVqwH6nLyPic0uLsqhU0WPhP0cClPBQbFJSCW4pj/s6HnzClSMtQSBQ2YYMDkOoF1EkHJhZ6IIV+NSZ0CXBjMHVc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1789698024; c=relaxed/simple;
	bh=py13jmZTlDFDv7LmHUQxaS9KYrwrWTixvlH+6RvrnTc=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=BTLOULksJQmM8mgS8cEs4U+2L5ZTzHV+XXJZVrE1fMAR6znkSwgaO5jnamvPb4Qsz4eKrEvk3WnhD4phwmUJU6okYJid7RW5ccqkvFZCvHFMioUR7xjcjFzrLG5xvtmXBWfXcpCU/IYGAcSXbjART0SLuiRNMJDuBJ8YudNPL+4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=GrfYSTE1; arc=none smtp.client-ip=74.125.231.197
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="GrfYSTE1"
Received: by mail-oi2-f5.google.com with SMTP id 46e09a7af769-7f4e2118db8so82006a34.1
        for <linux-iio@vger.kernel.org>; Thu, 17 Sep 2026 19:20:15 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1789698014; x=1790302814; darn=vger.kernel.org;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :content-type:mime-version:subject:date:from:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=WltbUUO0H/gWQbPZN0V3nXHroyZIGsih8i5C3g2CxGs=;
        b=GrfYSTE16eWLzXBFvRxepSB8GfTVCx15LlhUp5anhraEA9vi0tqMjfQLAmT3e9+dVB
         /rP1Mn+W4hObiq+9n5M2mbYGbqdg+VSrSREUBDMWLqK/51lrU4Li0VAwWOV2I5cqpC02
         +Lh2zYHKB6sJuGoISAQIEOaMF//K+2ZFR3rGAgxWCI4mwg+CavQJKIXEeIIDoXtvy53o
         SGpZg1iOPodvzZYLRkE8V5dLPHN3VYneRQwgFhytrsh2WmJoBLGUh6zPvsDHuLQAGdIB
         q7ScKnwhAMNxdBLbBmg6zLSoSC3U+JLxy2ih5+KRmCySn6XACmFHd13vJJwoyPZdytLW
         3vjw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1789698014; x=1790302814;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :content-type:mime-version:subject:date:from:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=WltbUUO0H/gWQbPZN0V3nXHroyZIGsih8i5C3g2CxGs=;
        b=GbvKVJFGvqa2mytHT65Nsv57WUSuHq4pOcNKTppqfEwvSMEInPdKwGBFBOOZTmDeHy
         sO3J9gH7cmmdr/Of42ukvy1qNpZ3h5c9I3j7WEQ0Ole1CZDPM5TKukydNpS2g1bPlfFD
         0b+Z3+TcDoDhMfn/M7fPbjjobSBiiyosRwsd2IEGVhz4rfVBZ0D7uxx+RkF77GuvEVQP
         tSyBapIbI8ExDvoFWKa4/9IuPCeuo9HmvGwEnSKgC2Kc41WuHaupNXa3TWkXOJI3Y5tC
         jU2OOIzrcWXSOBWyhZCAfdGV7LoJgg6qmRUhnnp1zmKJbWcf06DyPzCgpEfsax5pw0iC
         qsSQ==
X-Gm-Message-State: AFuF++mgEoTK5K6HcMwSKWtC495O7eBnvhihqtii5Mpu9WO0+Rp2yt9O
	Ae3NSP6jhhFakGGTDT4LSE4OaYHoSuFLKaKp6KnuabYCxdo21ILII86f
X-Gm-Gg: AYBFou0Br53ivbwkBubpiRZpchu0aalDCyNdi1YGgvapOmNVhg4tQl7NL2jZxuZB19V
	e53yr2JiW5Fh8sqUWxbntPqmMthzI513JxBz/jtvb6smBwRQIuRc0DBBmZp9xSbliMoG69AJKtB
	KKUC38gqwblWihlFX3gG8i6lj3l593wooc3jzqnbXfxOaghwz6udYyGm4Kbd8qzxftNdNWjgcIl
	ydDnIKowh3MqUOGQ9i/zY1a84csMYeq2FaZ+GbJE2oz58nxBcWTOVPQvX+kT5uTwLgB8WxF0VSn
	zcd6zw77PP50dzJD14v/vUK/D+22Qv2kkF/UAVMe8v8FSxO7WbYg+3XNGaimAFaqOOtaXTT6eO4
	hUk3RFS6n1HY7dJpo+El8ylQUZARLfpsMU+GMSdF9Y7F9Eym8p8L0CzEb74Tlm1N2uDmHVR9f3J
	KIYOMwywaRXidXKKtHQd5o5Tdy0gz6LgIE/0PO+Nfu41kFsdRWsB8s+mHMNfjkYZuiks4=
X-Received: by 2002:a05:6830:6d12:b0:80c:d30f:97e with SMTP id 46e09a7af769-80de34f4540mr1518364a34.31.1789698013755;
        Thu, 17 Sep 2026 19:20:13 -0700 (PDT)
Received: from [192.168.18.164] ([2600:8804:5716:d800::b712])
        by smtp.gmail.com with ESMTPSA id 46e09a7af769-80e5226786csm295476a34.22.2026.09.17.19.20.11
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 17 Sep 2026 19:20:13 -0700 (PDT)
From: Ryan Brue <ryanbrue.dev@gmail.com>
Date: Thu, 17 Sep 2026 21:19:51 -0500
Subject: [PATCH v2 2/3] iio: adc: mt6397-auxadc: add mt6397 PMIC AUXADC
 driver
Precedence: bulk
X-Mailing-List: linux-iio@vger.kernel.org
List-Id: <linux-iio.vger.kernel.org>
List-Subscribe: <mailto:linux-iio+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-iio+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20260917-rbrue-suez-upstreaming-mt6397-auxadc-v2-2-db35882a6080@gmail.com>
References: <20260917-rbrue-suez-upstreaming-mt6397-auxadc-v2-0-db35882a6080@gmail.com>
In-Reply-To: <20260917-rbrue-suez-upstreaming-mt6397-auxadc-v2-0-db35882a6080@gmail.com>
To: Jonathan Cameron <jic23@kernel.org>, 
 David Lechner <dlechner@baylibre.com>, 
 =?utf-8?q?Nuno_S=C3=A1?= <nuno.sa@analog.com>, 
 Andy Shevchenko <andy@kernel.org>, Rob Herring <robh@kernel.org>, 
 Krzysztof Kozlowski <krzk+dt@kernel.org>, 
 Conor Dooley <conor+dt@kernel.org>, 
 Matthias Brugger <matthias.bgg@gmail.com>, 
 AngeloGioacchino Del Regno <angelogioacchino.delregno@collabora.com>, 
 Lee Jones <lee@kernel.org>
Cc: linux-iio@vger.kernel.org, devicetree@vger.kernel.org, 
 linux-kernel@vger.kernel.org, linux-arm-kernel@lists.infradead.org, 
 linux-mediatek@lists.infradead.org, mfd@lists.linux.dev, 
 Roman Vivchar <rva333@protonmail.com>, 
 Luca Leonardo Scorcia <l.scorcia@gmail.com>, 
 Andy Shevchenko <andriy.shevchenko@intel.com>, 
 Ryan Brue <ryanbrue.dev@gmail.com>
X-Mailer: b4 0.16.0
X-Developer-Signature: v=1; a=ed25519-sha256; t=1789698008; l=16420;
 i=ryanbrue.dev@gmail.com; s=20260906; h=from:subject:message-id;
 bh=py13jmZTlDFDv7LmHUQxaS9KYrwrWTixvlH+6RvrnTc=;
 b=uSi2PrKLhfKPY+pA/Is7atei9o5kagaQheXNvZvA0E+Cb9x5XKus3XwadGi0X2Ev5RCXT2FHc
 KJhhcCpz6+xDTpgnZhxJ9pMtXdnjukGD25AJEONaZ9Cu5SOwyo+slX1
X-Developer-Key: i=ryanbrue.dev@gmail.com; a=ed25519;
 pk=KsUvVaP//v/2q+ZBuacc7cLbsyEYn+AD71Sn28oZWKo=

The mt6397 AUXADC is a 10-bit ADC behind the SoC's PMIC wrapper. On boards
built around this PMIC it is the only way to read the battery: the SoC's
AUXADC is wired to board thermistors and the charger ICs these boards use
have no ADC of their own.

Add a driver exposing the battery voltage and battery temperature
channels. Only those two are described, so a channel ID in the device tree
is an index into the driver's channel array rather than the PMIC's channel
number, as mt6323-auxadc does. The ready bit lives in a channel's raw
result register, but the value comes from the chip's trimmed copy of it,
which is what the vendor driver reads for a measurement.

Both channels need more than that, as the vendor programs them. The
battery voltage is measured through ISENSE, because a board with a
switching charger in the power path leaves BATSNS on the charger's system
rail instead of on the pack. The thermistor only reads correctly with the
PMIC's battery-detect bias and input buffer enabled, which take 20 ms to
settle. Both are switched back off afterwards.

Reads average sixteen conversions in software; the chip's sample
accumulator makes no measurable difference at any setting, so it is left
at one sample per conversion.

A new driver was created here, instead of modifying an existing driver
such as mt6323-auxadc or mt6359-auxadc, for the following reasons:

 - Both mt6323-auxadc and mt6359-auxadc select channels through a request
   register (1 bit per channel), while mt6397 uses a 4-bit numeric field
   CHSEL in CON1 (10:7), and then pulses a START bit (CON1 bit 0).

 - For mt6323-auxadc, which is the closest I could find to the mt6397
   (CON0..CON27), it has 13 more registers than the mt6397 (CON0..CON14).
   It uses CON22 for its request register, and reads the result value
   from the same register as the ready bit. We don't do that - the mt6397
   has a factory calibrated value for each channel at 0x16 higher than the
   raw value. mt6323 also has a 1800 mV / 15 bit scale / resolution while
   we have 1200 mV / 10 bits. We also have some per-channel preparation
   that we have to do before the burst, that the mt6323 doesn't have to
   do.

 - For mt6359-auxadc, it has a more generic framework for describing the
   AUXADC, but it assumes requests are channel-per-bit, and so we would
   have to basically ignore req_idx, req_mask, rdy_idx, and rdy_mask.

 - We also have our own software sampling, which the vendor does too
   (Amazon Fire OS based on Linux 3.18). We'd have to have our own
   sampling callback to do it.

Assisted-by: LLM
Signed-off-by: Ryan Brue <ryanbrue.dev@gmail.com>
---
 MAINTAINERS                     |   1 +
 drivers/iio/adc/Kconfig         |  11 ++
 drivers/iio/adc/Makefile        |   1 +
 drivers/iio/adc/mt6397-auxadc.c | 378 ++++++++++++++++++++++++++++++++++++++++
 4 files changed, 391 insertions(+)

diff --git a/MAINTAINERS b/MAINTAINERS
index 41d7b3a67415..9b254f98b5d7 100644
--- a/MAINTAINERS
+++ b/MAINTAINERS
@@ -16717,6 +16717,7 @@ MEDIATEK MT6397 PMIC AUXADC DRIVER
 M:	Ryan Brue <ryanbrue.dev@gmail.com>
 L:	linux-iio@vger.kernel.org
 S:	Maintained
+F:	drivers/iio/adc/mt6397-auxadc.c
 F:	include/dt-bindings/iio/adc/mediatek,mt6397-auxadc.h
 
 MEDIATEK MT6735 CLOCK & RESET DRIVERS
diff --git a/drivers/iio/adc/Kconfig b/drivers/iio/adc/Kconfig
index 415e519ad4eb..9a1d36ed53cb 100644
--- a/drivers/iio/adc/Kconfig
+++ b/drivers/iio/adc/Kconfig
@@ -1233,6 +1233,17 @@ config MEDIATEK_MT6370_ADC
 	  This driver can also be built as a module. If so, the module
 	  will be called "mt6370-adc".
 
+config MEDIATEK_MT6397_AUXADC
+	tristate "MediaTek MT6397 PMIC AUXADC driver"
+	depends on MFD_MT6397
+	help
+	  Say yes here to enable support for MediaTek MT6397 PMIC Auxiliary ADC.
+	  This driver provides the battery voltage and battery temperature
+	  channels used by the fuel gauge on boards built around this PMIC.
+
+	  This driver can also be built as a module. If so, the module will be
+	  called mt6397-auxadc.
+
 config MEDIATEK_MT6577_AUXADC
 	tristate "MediaTek AUXADC driver"
 	depends on ARCH_MEDIATEK || COMPILE_TEST
diff --git a/drivers/iio/adc/Makefile b/drivers/iio/adc/Makefile
index dcec0abb03b7..13cb4206bdb7 100644
--- a/drivers/iio/adc/Makefile
+++ b/drivers/iio/adc/Makefile
@@ -105,6 +105,7 @@ obj-$(CONFIG_MEDIATEK_MT6323_AUXADC) += mt6323-auxadc.o
 obj-$(CONFIG_MEDIATEK_MT6359_AUXADC) += mt6359-auxadc.o
 obj-$(CONFIG_MEDIATEK_MT6360_ADC) += mt6360-adc.o
 obj-$(CONFIG_MEDIATEK_MT6370_ADC) += mt6370-adc.o
+obj-$(CONFIG_MEDIATEK_MT6397_AUXADC) += mt6397-auxadc.o
 obj-$(CONFIG_MEDIATEK_MT6577_AUXADC) += mt6577_auxadc.o
 obj-$(CONFIG_MEN_Z188_ADC) += men_z188_adc.o
 obj-$(CONFIG_MESON_SARADC) += meson_saradc.o
diff --git a/drivers/iio/adc/mt6397-auxadc.c b/drivers/iio/adc/mt6397-auxadc.c
new file mode 100644
index 000000000000..2f602e16e4f0
--- /dev/null
+++ b/drivers/iio/adc/mt6397-auxadc.c
@@ -0,0 +1,378 @@
+// SPDX-License-Identifier: GPL-2.0-only
+/*
+ * MediaTek MT6397 PMIC AUXADC IIO driver
+ *
+ * Copyright (c) 2026 Ryan Brue <ryanbrue.dev@gmail.com>
+ *
+ * Based on drivers/iio/adc/mt6323-auxadc.c
+ */
+
+#include <linux/array_size.h>
+#include <linux/bitfield.h>
+#include <linux/bits.h>
+#include <linux/cleanup.h>
+#include <linux/delay.h>
+#include <linux/iio/iio.h>
+#include <linux/math.h>
+#include <linux/module.h>
+#include <linux/mutex.h>
+#include <linux/platform_device.h>
+#include <linux/regmap.h>
+#include <linux/time.h>
+#include <linux/types.h>
+
+#include <linux/mfd/mt6397/core.h>
+
+#include <dt-bindings/iio/adc/mediatek,mt6397-auxadc.h>
+
+/* The ready bit is in the raw result register, the value in the trimmed one. */
+#define MT6397_AUXADC_ADC(n)			(0x0514 + 2 * (n))
+#define   MT6397_AUXADC_ADC_RDY			BIT(15)
+#define   MT6397_AUXADC_ADC_VAL			GENMASK(9, 0)
+/* The trimmed copy of ADC(n), which is ADC11 + n. */
+#define MT6397_AUXADC_ADC_TRIM(n)		(0x052a + 2 * (n))
+
+/* The thermistor needs the battery-detect bias and the input buffer on. */
+#define MT6397_AUXADC_CON0			0x0542
+#define   MT6397_AUXADC_CON0_BUF_PWD_B		BIT(1)
+#define   MT6397_AUXADC_CON0_BUF_PWD_ON		BIT(3)
+/* Samples accumulated per conversion; the chip's accumulator is left off. */
+#define   MT6397_AUXADC_CON0_SPL_NUM		GENMASK(11, 7)
+#define MT6397_CHR_CON7				0x000e
+#define   MT6397_CHR_CON7_BATON_TDET_EN		BIT(2)
+
+#define MT6397_AUXADC_BATTEMP_SETTLE_US		(20 * USEC_PER_MSEC)
+
+#define MT6397_AUXADC_CON1			0x0544
+#define   MT6397_AUXADC_CON1_CHSEL		GENMASK(10, 7)
+#define   MT6397_AUXADC_CON1_START		BIT(0)
+
+/*
+ * CHR_CON16 and the two SOURCE_CH0 selects route either BATSNS or ISENSE onto
+ * the battery channel. Only ISENSE is used: with a switching charger in the
+ * power path BATSNS sits on the system rail rather than on the pack. All five
+ * ADCIN bits are written out because they are one enable per analog input
+ * and not a select field; the driver touches only the two it needs.
+ */
+#define MT6397_CHR_CON16			0x0020
+#define   MT6397_CHR_CON16_ADCIN_VCHR_EN	BIT(12)
+#define   MT6397_CHR_CON16_ADCIN_VSEN_EN	BIT(11)
+#define   MT6397_CHR_CON16_ADCIN_VBAT_EN	BIT(10)
+#define   MT6397_CHR_CON16_ADCIN_VSEN_EXT_BATON_EN	BIT(9)
+#define   MT6397_CHR_CON16_ADCIN_VSEN_MUX_EN	BIT(8)
+#define MT6397_AUXADC_CON14			0x055e
+#define   MT6397_AUXADC_CON14_CH0_NORM_SEL	BIT(2)
+#define   MT6397_AUXADC_CON14_CH0_LBAT_SEL	BIT(0)
+
+#define MT6397_AUXADC_ISENSE_SETTLE_US		(1 * USEC_PER_MSEC)
+
+/* Conversions averaged in software per read. */
+#define MT6397_AUXADC_SAMPLES			16
+
+/* Hardware limitation: the result is not ready for this long after START. */
+#define MT6397_AUXADC_START_US			30
+
+/* The battery channel is divided down by 4; the thermistor is not divided. */
+#define MT6397_AUXADC_ISENSE_DIVIDER		4
+
+/* The PMIC's channel numbers, as the CON1 select field takes them. */
+#define MT6397_AUXADC_HWCHAN_BATSNS		0
+#define MT6397_AUXADC_HWCHAN_BAT_TEMP		3
+
+struct mt6397_auxadc {
+	struct regmap *regmap;
+	/*
+	 * A read is a multi-register sequence: analog setup, then a channel
+	 * select and an edge-triggered start per conversion. Interleaving two
+	 * of them steals the select and tears down the setup, so a read holds
+	 * this for its whole burst.
+	 */
+	struct mutex lock;
+};
+
+/*
+ * A device tree channel ID indexes this array; .address holds the PMIC channel
+ * number. The thermistor reports as a voltage because that is all the PMIC
+ * measures: the divider across an NTC whose curve belongs to the board.
+ */
+static const struct iio_chan_spec mt6397_auxadc_channels[] = {
+	{
+		.type = IIO_VOLTAGE,
+		.indexed = 1,
+		.channel = MT6397_AUXADC_ISENSE,
+		.address = MT6397_AUXADC_HWCHAN_BATSNS,
+		.datasheet_name = "isense",
+		.info_mask_separate = BIT(IIO_CHAN_INFO_RAW) |
+				      BIT(IIO_CHAN_INFO_SCALE),
+	}, {
+		.type = IIO_VOLTAGE,
+		.indexed = 1,
+		.channel = MT6397_AUXADC_BAT_TEMP,
+		.address = MT6397_AUXADC_HWCHAN_BAT_TEMP,
+		.datasheet_name = "bat_temp",
+		.info_mask_separate = BIT(IIO_CHAN_INFO_RAW) |
+				      BIT(IIO_CHAN_INFO_SCALE),
+	},
+};
+
+static int mt6397_auxadc_read_once(struct mt6397_auxadc *adc,
+				   const struct iio_chan_spec *chan, int *val)
+{
+	struct regmap *map = adc->regmap;
+	unsigned int reg;
+	int ret;
+
+	ret = regmap_update_bits(map, MT6397_AUXADC_CON1,
+				 MT6397_AUXADC_CON1_CHSEL,
+				 FIELD_PREP(MT6397_AUXADC_CON1_CHSEL,
+					    chan->address));
+	if (ret)
+		return ret;
+
+	/* START is edge triggered: it has to be lowered before being raised. */
+	ret = regmap_clear_bits(map, MT6397_AUXADC_CON1, MT6397_AUXADC_CON1_START);
+	if (ret)
+		return ret;
+
+	ret = regmap_set_bits(map, MT6397_AUXADC_CON1, MT6397_AUXADC_CON1_START);
+	if (ret)
+		return ret;
+
+	fsleep(MT6397_AUXADC_START_US);
+
+	ret = regmap_read_poll_timeout(map, MT6397_AUXADC_ADC(chan->address),
+				       reg, reg & MT6397_AUXADC_ADC_RDY,
+				       100, 100 * USEC_PER_MSEC);
+	if (ret)
+		return ret;
+
+	ret = regmap_read(map, MT6397_AUXADC_ADC_TRIM(chan->address), &reg);
+	if (ret)
+		return ret;
+
+	*val = FIELD_GET(MT6397_AUXADC_ADC_VAL, reg);
+
+	return 0;
+}
+
+static int mt6397_auxadc_battemp_bias(struct mt6397_auxadc *adc, bool on)
+{
+	struct regmap *map = adc->regmap;
+	int ret, err;
+
+	if (on) {
+		ret = regmap_set_bits(map, MT6397_AUXADC_CON0,
+				      MT6397_AUXADC_CON0_BUF_PWD_ON);
+		if (ret)
+			return ret;
+
+		ret = regmap_set_bits(map, MT6397_AUXADC_CON0,
+				      MT6397_AUXADC_CON0_BUF_PWD_B);
+		if (ret)
+			return ret;
+
+		ret = regmap_set_bits(map, MT6397_CHR_CON7,
+				      MT6397_CHR_CON7_BATON_TDET_EN);
+	} else {
+		/*
+		 * Every step of the teardown is attempted even if an earlier
+		 * one failed, so that one failing write cannot leave the bias
+		 * or the input buffer powered. The first error is reported.
+		 */
+		ret = regmap_clear_bits(map, MT6397_CHR_CON7,
+					MT6397_CHR_CON7_BATON_TDET_EN);
+
+		err = regmap_clear_bits(map, MT6397_AUXADC_CON0,
+					MT6397_AUXADC_CON0_BUF_PWD_B);
+		if (!ret)
+			ret = err;
+
+		err = regmap_clear_bits(map, MT6397_AUXADC_CON0,
+					MT6397_AUXADC_CON0_BUF_PWD_ON);
+		if (!ret)
+			ret = err;
+	}
+
+	return ret;
+}
+
+static int mt6397_auxadc_isense_enable(struct mt6397_auxadc *adc)
+{
+	struct regmap *map = adc->regmap;
+	int ret;
+
+	/*
+	 * Two of the five independent input enables, not a select field:
+	 * BATSNS is cleared first so that the two inputs are never enabled
+	 * onto the battery channel at the same time.
+	 */
+	ret = regmap_clear_bits(map, MT6397_CHR_CON16,
+				MT6397_CHR_CON16_ADCIN_VBAT_EN);
+	if (ret)
+		return ret;
+
+	ret = regmap_set_bits(map, MT6397_CHR_CON16,
+			      MT6397_CHR_CON16_ADCIN_VSEN_EN);
+	if (ret)
+		return ret;
+
+	return regmap_set_bits(map, MT6397_AUXADC_CON14,
+			       MT6397_AUXADC_CON14_CH0_NORM_SEL |
+			       MT6397_AUXADC_CON14_CH0_LBAT_SEL);
+}
+
+static int mt6397_auxadc_isense_disable(struct mt6397_auxadc *adc)
+{
+	struct regmap *map = adc->regmap;
+	int ret, err;
+
+	/* As above: the routing is undone even if the select write failed. */
+	ret = regmap_clear_bits(map, MT6397_AUXADC_CON14,
+				MT6397_AUXADC_CON14_CH0_NORM_SEL |
+				MT6397_AUXADC_CON14_CH0_LBAT_SEL);
+
+	err = regmap_clear_bits(map, MT6397_CHR_CON16,
+				MT6397_CHR_CON16_ADCIN_VSEN_EN |
+				MT6397_CHR_CON16_ADCIN_VBAT_EN);
+	if (!ret)
+		ret = err;
+
+	return ret;
+}
+
+static int mt6397_auxadc_read_channel(struct mt6397_auxadc *adc,
+				      const struct iio_chan_spec *chan,
+				      int *val)
+{
+	bool isense = chan->channel == MT6397_AUXADC_ISENSE;
+	unsigned int sum = 0;
+	int sample;
+	int ret;
+
+	/* Held across the whole burst: the channel select is shared state. */
+	guard(mutex)(&adc->lock);
+
+	/*
+	 * Once any part of the per-channel setup has been written, the
+	 * teardown has to run, so every exit below goes through it.
+	 */
+	if (isense) {
+		ret = mt6397_auxadc_isense_enable(adc);
+		if (ret)
+			goto out_teardown;
+		fsleep(MT6397_AUXADC_ISENSE_SETTLE_US);
+	} else {
+		ret = mt6397_auxadc_battemp_bias(adc, true);
+		if (ret)
+			goto out_teardown;
+		fsleep(MT6397_AUXADC_BATTEMP_SETTLE_US);
+	}
+
+	for (unsigned int i = 0; i < MT6397_AUXADC_SAMPLES; i++) {
+		ret = mt6397_auxadc_read_once(adc, chan, &sample);
+		if (ret)
+			goto out_teardown;
+
+		sum += sample;
+	}
+
+	*val = DIV_ROUND_CLOSEST(sum, MT6397_AUXADC_SAMPLES);
+
+out_teardown:
+	/* Lower START so the converter is not left armed between reads. */
+	regmap_clear_bits(adc->regmap, MT6397_AUXADC_CON1,
+			  MT6397_AUXADC_CON1_START);
+
+	if (isense)
+		mt6397_auxadc_isense_disable(adc);
+	else
+		mt6397_auxadc_battemp_bias(adc, false);
+
+	return ret;
+}
+
+static int mt6397_auxadc_read_raw(struct iio_dev *indio_dev,
+				  const struct iio_chan_spec *chan,
+				  int *val, int *val2, long mask)
+{
+	struct mt6397_auxadc *adc = iio_priv(indio_dev);
+	int ret;
+
+	switch (mask) {
+	case IIO_CHAN_INFO_RAW:
+		ret = mt6397_auxadc_read_channel(adc, chan, val);
+		if (ret)
+			return ret;
+
+		return IIO_VAL_INT;
+
+	case IIO_CHAN_INFO_SCALE:
+		/* 1200 mV full range with 10-bit resolution. */
+		*val = 1200;
+		if (chan->channel == MT6397_AUXADC_ISENSE)
+			*val *= MT6397_AUXADC_ISENSE_DIVIDER;
+		*val2 = 10;
+
+		return IIO_VAL_FRACTIONAL_LOG2;
+
+	default:
+		return -EINVAL;
+	}
+}
+
+static const struct iio_info mt6397_auxadc_info = {
+	.read_raw = mt6397_auxadc_read_raw,
+};
+
+static int mt6397_auxadc_probe(struct platform_device *pdev)
+{
+	struct device *dev = &pdev->dev;
+	struct mt6397_chip *chip = dev_get_drvdata(dev->parent);
+	struct mt6397_auxadc *adc;
+	struct iio_dev *indio_dev;
+	int ret;
+
+	indio_dev = devm_iio_device_alloc(dev, sizeof(*adc));
+	if (!indio_dev)
+		return -ENOMEM;
+
+	adc = iio_priv(indio_dev);
+	adc->regmap = chip->regmap;
+
+	ret = devm_mutex_init(dev, &adc->lock);
+	if (ret)
+		return ret;
+
+	ret = regmap_update_bits(adc->regmap, MT6397_AUXADC_CON0,
+				 MT6397_AUXADC_CON0_SPL_NUM,
+				 FIELD_PREP(MT6397_AUXADC_CON0_SPL_NUM, 1));
+	if (ret)
+		return dev_err_probe(dev, ret, "failed to initialize auxadc\n");
+
+	indio_dev->name = "mt6397-auxadc";
+	indio_dev->info = &mt6397_auxadc_info;
+	indio_dev->modes = INDIO_DIRECT_MODE;
+	indio_dev->channels = mt6397_auxadc_channels;
+	indio_dev->num_channels = ARRAY_SIZE(mt6397_auxadc_channels);
+
+	return devm_iio_device_register(dev, indio_dev);
+}
+
+static const struct of_device_id mt6397_auxadc_of_match[] = {
+	{ .compatible = "mediatek,mt6397-auxadc" },
+	{ }
+};
+MODULE_DEVICE_TABLE(of, mt6397_auxadc_of_match);
+
+static struct platform_driver mt6397_auxadc_driver = {
+	.driver = {
+		.name = "mt6397-auxadc",
+		.of_match_table = mt6397_auxadc_of_match,
+	},
+	.probe = mt6397_auxadc_probe,
+};
+module_platform_driver(mt6397_auxadc_driver);
+
+MODULE_LICENSE("GPL");
+MODULE_AUTHOR("Ryan Brue <ryanbrue.dev@gmail.com>");
+MODULE_DESCRIPTION("MediaTek MT6397 PMIC AUXADC Driver");

-- 
2.55.0

