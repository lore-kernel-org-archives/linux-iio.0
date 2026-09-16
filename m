Received: from mail-oo2-f5.google.com (mail-oo2-f5.google.com [74.125.231.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 321DA399892
	for <linux-iio@vger.kernel.org>; Wed, 16 Sep 2026 04:15:33 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=74.125.231.133
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1789532136; cv=none; b=d3MQWHSWx7tg3AtzfK3TR9eQ3CQ4yMPq5O0kx2NSdYqrG6hehtzU96HbsR6PPgfON435Cxqw69hodCSpcDAldWScCzjbl6rembf1PZJzUYaSfy36RUSbYpE7YFjIyznldWrEjC3WGOA18wDQm7qpKNzK+TsU/UhP7qfgPmR8Otk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1789532136; c=relaxed/simple;
	bh=eMXlSZo1VOCw8RXDlIOWEe10ScLpRFrd7gnttzf71Ac=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=jtSLtYx+6ZPFH9FcwINFJlKehPDeqbATtQosstqIlGCCy6uCb/hQHY6MfV4CJQ2UuvO65CKQutXy8uLMq2XGd5u+RQUDZFpAEFYRPAhpuN8N/qoLQg+ILPaHHkeHWGLisEI3Ot6KEHh+bGi67oeX85c9GZACp2BzpkwzUbYLEak=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=PYti3eaI; arc=none smtp.client-ip=74.125.231.133
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="PYti3eaI"
Received: by mail-oo2-f5.google.com with SMTP id 46e09a7af769-7f4e6693089so1856456a34.0
        for <linux-iio@vger.kernel.org>; Tue, 15 Sep 2026 21:15:33 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1789532132; x=1790136932; darn=vger.kernel.org;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :content-type:mime-version:subject:date:from:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=kv7K+NQDwkzVit4t1U8RT9Xbw/6Dvr8ewgY1vIfRASQ=;
        b=PYti3eaICVlLTmUh9IULbqdfTSeqr/DK18SRK98KGmUTCeetmuIIKDL6RgPqPqGyOK
         bNt88PQoh9Eprpb5s90PXX4G7/97RvbS0YtedQWjNBy6Gsb1Xu8qgfgxc06FKxrWHD+D
         poJ538Z96wgXTQ2T5dSkTDUq8j44xgKRQ9pYm9dr28ExnWY4kdiOJkawl3WEiib8QlZS
         TbXZTvXQRCUaL3EO3RVuGdg8Wkoe+UuF6hax7zTtJeYxBmwDVEFGzRNjsOiHdMzPiL2m
         8DsH7x3UX9Hr22dDt7p7IJfDcrdptt4nqdq+fd/CIhsP4uPCgT6Y1RETBj7OORSsUUB4
         Sk1Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1789532132; x=1790136932;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :content-type:mime-version:subject:date:from:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=kv7K+NQDwkzVit4t1U8RT9Xbw/6Dvr8ewgY1vIfRASQ=;
        b=w+3+9wzy+M0q7spKP8Ysz1OyDHCmVzZuracQZ6lvT/aIeFNschSUUvGejU705scBpB
         2JMdfBDcztvpLsVkO8J5zUFjc0/YwjvwX81YY5QvFsKonKJpj8grbXo/kFC8kimz3Wfw
         Ny3noqUtIk0U9BKceJkHUqWeMItWnqoh5lm+1mXRvsvEFuWQu22wqOPvYZUL6aBEEM8s
         vTzHH1yZ6WAcUva2K01pBcpvOw0ZvlH/rG/RlX5cp2Byzdi9zjTHVCm35QC9b1YYXld9
         tiOsIh4HjYM+GNSRIThsHzyG6HFZS+L3Pme2HQ38H5dozf5QgGuMaMJxZMSmJXOlqQZ9
         xlIA==
X-Gm-Message-State: AFuF++lYZP2Jpi240jU3uN3Yik6XrSMy0xel8y5129Xo/2gBVVV56WmO
	F/xDIJ1xL4UrsJ+tojNlnH3nr0RaJ4BFBLmpRWwdOw9sT0jR6ExYqsMY
X-Gm-Gg: AYBFou28RBjaGYh/COOsS+OJ0XneuK8JASuy+AMV+b5tUzuad29xIcTaiYRVvgzzwGr
	cVs47bb3rZqgtgc3fb8/uGGOO516yy9Ys847IMWsHDIpkC7wOHPseM/mt9UNsnL/MX0G7/Udd6e
	1uvlp9AWYUelhEXoVnwzVKTpkm+MjEduNwADSOlbijvp7B/NNK0Z64cPHY8uNp2rVC8KY4NrPx1
	pr1qLb7FjjLP+mEbkfab4NwjKICKIk9sRxvTXQMaybsA1icC13MLy1iecLSxAVliNFqMTC9inq7
	PKj68qVMEZyeXLdrR5Dfusll5F8PqCtl7aEv2kkNceL28vBI+xVKt2baUyTeWEJuH1h0n+TqUJk
	e6k9s0ZPhMt1fSz2FQmWV1Qzf3hhuTIS1tV6qBKezo628mJa9QBp651E5E4/sINRDY0/We/n8CY
	fMfV7PMIyV9fLtVGr/YJRy74Rbbw4l6jDtCtd/EVYA/T4rzJ8PpXRpFGpdkej+Ids6ANvMDM/0p
	4yAbw==
X-Received: by 2002:a05:6830:6105:b0:7f8:4ac8:bd2a with SMTP id 46e09a7af769-80b2e558715mr3543149a34.12.1789532132103;
        Tue, 15 Sep 2026 21:15:32 -0700 (PDT)
Received: from [192.168.18.164] ([2600:8804:5716:d800::b712])
        by smtp.gmail.com with ESMTPSA id 46e09a7af769-80b07ad0373sm1440484a34.26.2026.09.15.21.15.30
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 15 Sep 2026 21:15:31 -0700 (PDT)
From: Ryan Brue <ryanbrue.dev@gmail.com>
Date: Tue, 15 Sep 2026 23:15:27 -0500
Subject: [PATCH 2/3] iio: adc: mt6397-auxadc: add mt6397 PMIC AUXADC driver
Precedence: bulk
X-Mailing-List: linux-iio@vger.kernel.org
List-Id: <linux-iio.vger.kernel.org>
List-Subscribe: <mailto:linux-iio+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-iio+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20260915-rbrue-suez-upstreaming-mt6397-auxadc-v1-2-d35d2ac3d6f0@gmail.com>
References: <20260915-rbrue-suez-upstreaming-mt6397-auxadc-v1-0-d35d2ac3d6f0@gmail.com>
In-Reply-To: <20260915-rbrue-suez-upstreaming-mt6397-auxadc-v1-0-d35d2ac3d6f0@gmail.com>
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
 Ryan Brue <ryanbrue.dev@gmail.com>
X-Mailer: b4 0.16.0
X-Developer-Signature: v=1; a=ed25519-sha256; t=1789532127; l=14253;
 i=ryanbrue.dev@gmail.com; s=20260906; h=from:subject:message-id;
 bh=eMXlSZo1VOCw8RXDlIOWEe10ScLpRFrd7gnttzf71Ac=;
 b=0u2/Akbf2ysKhB6fTs57++wLo5QOOioVh1JTcrpvIUVHzF0WcH9IzQUB4W9MZgVlp4+hFTAFa
 Gayu3Z55t2tBvFvV5tZJF6KAb7aIpbF2tRBEIWvC6nuqoqcp4bKDJ8N
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

Assisted-by: LLM
Signed-off-by: Ryan Brue <ryanbrue.dev@gmail.com>
---
 MAINTAINERS                     |   7 +
 drivers/iio/adc/Kconfig         |  11 ++
 drivers/iio/adc/Makefile        |   1 +
 drivers/iio/adc/mt6397-auxadc.c | 340 ++++++++++++++++++++++++++++++++++++++++
 4 files changed, 359 insertions(+)

diff --git a/MAINTAINERS b/MAINTAINERS
index c2414447892c..9b254f98b5d7 100644
--- a/MAINTAINERS
+++ b/MAINTAINERS
@@ -16713,6 +16713,13 @@ S:	Maintained
 F:	drivers/iio/adc/mt6323-auxadc.c
 F:	include/dt-bindings/iio/adc/mediatek,mt6323-auxadc.h
 
+MEDIATEK MT6397 PMIC AUXADC DRIVER
+M:	Ryan Brue <ryanbrue.dev@gmail.com>
+L:	linux-iio@vger.kernel.org
+S:	Maintained
+F:	drivers/iio/adc/mt6397-auxadc.c
+F:	include/dt-bindings/iio/adc/mediatek,mt6397-auxadc.h
+
 MEDIATEK MT6735 CLOCK & RESET DRIVERS
 M:	Yassine Oudjana <y.oudjana@protonmail.com>
 L:	linux-clk@vger.kernel.org
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
index 000000000000..dbfa82341d6c
--- /dev/null
+++ b/drivers/iio/adc/mt6397-auxadc.c
@@ -0,0 +1,340 @@
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
+#include <linux/stringify.h>
+#include <linux/time.h>
+#include <linux/types.h>
+
+#include <linux/mfd/mt6397/core.h>
+
+#include <dt-bindings/iio/adc/mediatek,mt6397-auxadc.h>
+
+/* The ready bit is in the raw result register, the value in the trimmed one. */
+#define MT6397_AUXADC_ADC(n)		(0x0514 + 2 * (n))
+#define MT6397_AUXADC_ADC_RDY		BIT(15)
+#define MT6397_AUXADC_ADC_VAL		GENMASK(9, 0)
+#define MT6397_AUXADC_ADC_TRIM(n)	(0x052a + 2 * (n))	/* ADC11 + n */
+
+/* The thermistor needs the battery-detect bias and the input buffer on. */
+#define MT6397_AUXADC_CON0		0x0542
+#define MT6397_AUXADC_CON0_BUF_PWD_B	BIT(1)
+#define MT6397_AUXADC_CON0_BUF_PWD_ON	BIT(3)
+#define MT6397_CHR_CON7			0x000e
+#define MT6397_CHR_CON7_BATON_TDET_EN	BIT(2)
+#define MT6397_AUXADC_BATTEMP_SETTLE_US	(20 * USEC_PER_MSEC)
+
+#define MT6397_AUXADC_CON1		0x0544
+#define MT6397_AUXADC_CON1_CHSEL	GENMASK(10, 7)
+#define MT6397_AUXADC_CON1_START	BIT(0)
+
+/*
+ * CHR_CON16 and the two SOURCE_CH0 selects route either BATSNS or ISENSE onto
+ * the battery channel. Only ISENSE is used: with a switching charger in the
+ * power path BATSNS sits on the system rail rather than on the pack.
+ */
+#define MT6397_CHR_CON16		0x0020
+#define MT6397_CHR_CON16_ADCIN_VSEN_EN	BIT(11)
+#define MT6397_CHR_CON16_ADCIN_VBAT_EN	BIT(10)
+#define MT6397_CHR_CON16_ADCIN_SEL	(MT6397_CHR_CON16_ADCIN_VSEN_EN | \
+					 MT6397_CHR_CON16_ADCIN_VBAT_EN)
+#define MT6397_AUXADC_CON14		0x055e
+#define MT6397_AUXADC_CON14_CH0_NORM_SEL BIT(2)
+#define MT6397_AUXADC_CON14_CH0_LBAT_SEL BIT(0)
+#define MT6397_AUXADC_ISENSE_SETTLE_US	USEC_PER_MSEC
+
+/* Samples accumulated per conversion; the chip's accumulator is left off. */
+#define MT6397_AUXADC_CON0_SPL_NUM	GENMASK(11, 7)
+
+/* Conversions averaged in software per read. */
+#define MT6397_AUXADC_SAMPLES		16
+
+/* Hardware limitation: the result is not ready for this long after START. */
+#define MT6397_AUXADC_START_US		30
+
+/* The battery channel is divided down by 4; the thermistor is not divided. */
+#define MT6397_AUXADC_ISENSE_DIVIDER	4
+
+/* The PMIC's own channel numbers, as the CON1 select field takes them. */
+#define MT6397_AUXADC_HWCHAN_BATSNS	0
+#define MT6397_AUXADC_HWCHAN_BAT_TEMP	3
+
+struct mt6397_auxadc {
+	struct regmap *regmap;
+	/* AUXADC doesn't support reading multiple channels simultaneously. */
+	struct mutex lock;
+};
+
+#define MTK_PMIC_IIO_CHAN(_name, _chan, _hwchan)                \
+{                                                               \
+	.type = IIO_VOLTAGE,                                    \
+	.indexed = 1,                                           \
+	.channel = _chan,                                       \
+	.address = _hwchan,                                     \
+	.datasheet_name = __stringify(_name),                   \
+	.info_mask_separate = BIT(IIO_CHAN_INFO_RAW) |          \
+			      BIT(IIO_CHAN_INFO_SCALE),         \
+}
+
+/*
+ * A device tree channel ID indexes this array; .address holds the PMIC channel
+ * number. The thermistor reports as a voltage because that is all the PMIC
+ * measures: the divider across an NTC whose curve belongs to the board.
+ */
+static const struct iio_chan_spec mt6397_auxadc_channels[] = {
+	MTK_PMIC_IIO_CHAN(isense,   MT6397_AUXADC_ISENSE,
+			  MT6397_AUXADC_HWCHAN_BATSNS),
+	MTK_PMIC_IIO_CHAN(bat_temp, MT6397_AUXADC_BAT_TEMP,
+			  MT6397_AUXADC_HWCHAN_BAT_TEMP),
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
+	ret = regmap_clear_bits(map, MT6397_AUXADC_CON1,
+				MT6397_AUXADC_CON1_START);
+	if (ret)
+		return ret;
+
+	ret = regmap_set_bits(map, MT6397_AUXADC_CON1,
+			      MT6397_AUXADC_CON1_START);
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
+	int ret;
+
+	if (on) {
+		ret = regmap_set_bits(map, MT6397_AUXADC_CON0,
+				      MT6397_AUXADC_CON0_BUF_PWD_ON);
+		if (ret)
+			return ret;
+		ret = regmap_set_bits(map, MT6397_AUXADC_CON0,
+				      MT6397_AUXADC_CON0_BUF_PWD_B);
+		if (ret)
+			return ret;
+		return regmap_set_bits(map, MT6397_CHR_CON7,
+				       MT6397_CHR_CON7_BATON_TDET_EN);
+	}
+
+	ret = regmap_clear_bits(map, MT6397_CHR_CON7,
+				MT6397_CHR_CON7_BATON_TDET_EN);
+	ret = ret ?: regmap_clear_bits(map, MT6397_AUXADC_CON0,
+				       MT6397_AUXADC_CON0_BUF_PWD_B);
+	return ret ?: regmap_clear_bits(map, MT6397_AUXADC_CON0,
+					MT6397_AUXADC_CON0_BUF_PWD_ON);
+}
+
+static int mt6397_auxadc_isense_enable(struct mt6397_auxadc *adc)
+{
+	struct regmap *map = adc->regmap;
+	int ret;
+
+	ret = regmap_update_bits(map, MT6397_CHR_CON16,
+				 MT6397_CHR_CON16_ADCIN_SEL,
+				 MT6397_CHR_CON16_ADCIN_VSEN_EN);
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
+	int ret;
+
+	ret = regmap_clear_bits(map, MT6397_AUXADC_CON14,
+				MT6397_AUXADC_CON14_CH0_NORM_SEL |
+				MT6397_AUXADC_CON14_CH0_LBAT_SEL);
+
+	return ret ?: regmap_clear_bits(map, MT6397_CHR_CON16,
+					MT6397_CHR_CON16_ADCIN_SEL);
+}
+
+static int mt6397_auxadc_read_channel(struct mt6397_auxadc *adc,
+				      const struct iio_chan_spec *chan,
+				      int *val)
+{
+	unsigned int i, sum = 0;
+	int ret, sample;
+
+	/* Held across the whole burst: the channel select is shared state. */
+	guard(mutex)(&adc->lock);
+
+	if (chan->channel == MT6397_AUXADC_ISENSE) {
+		ret = mt6397_auxadc_isense_enable(adc);
+		if (ret)
+			return ret;
+		fsleep(MT6397_AUXADC_ISENSE_SETTLE_US);
+	} else {
+		ret = mt6397_auxadc_battemp_bias(adc, true);
+		if (ret)
+			return ret;
+		fsleep(MT6397_AUXADC_BATTEMP_SETTLE_US);
+	}
+
+	for (i = 0; i < MT6397_AUXADC_SAMPLES; i++) {
+		ret = mt6397_auxadc_read_once(adc, chan, &sample);
+		if (ret)
+			break;
+
+		sum += sample;
+	}
+
+	/* Lower START so the converter is not left armed between reads. */
+	regmap_clear_bits(adc->regmap, MT6397_AUXADC_CON1,
+			  MT6397_AUXADC_CON1_START);
+
+	if (chan->channel == MT6397_AUXADC_ISENSE)
+		mt6397_auxadc_isense_disable(adc);
+	else
+		mt6397_auxadc_battemp_bias(adc, false);
+
+	if (ret)
+		return ret;
+
+	*val = DIV_ROUND_CLOSEST(sum, MT6397_AUXADC_SAMPLES);
+
+	return 0;
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
+static int mt6397_auxadc_init(struct mt6397_auxadc *adc)
+{
+	return regmap_update_bits(adc->regmap, MT6397_AUXADC_CON0,
+				  MT6397_AUXADC_CON0_SPL_NUM,
+				  FIELD_PREP(MT6397_AUXADC_CON0_SPL_NUM, 1));
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
+	ret = mt6397_auxadc_init(adc);
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
+	{ /* sentinel */ }
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

