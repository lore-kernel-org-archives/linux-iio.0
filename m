Received: from mail-qk2-f2.google.com (mail-qk2-f2.google.com [74.125.230.194])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 102514FC349
	for <linux-iio@vger.kernel.org>; Mon, 28 Sep 2026 20:57:33 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=74.125.230.194
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1790629059; cv=none; b=HC2c+YaHWTnXavIIJTnnZyiBnHRoh66nf3BpYtZKn2rMoNiuIO+xoePZfbBQvXaV64xt8KXiJBaGlqNLxobZfnXMMkAxU2VNVR3XWvFFSMnEyi81X3jtwdJT+lowg1IIVJ4wW2CDU3/BPnbxudTiBBdg9X7CfR4m/MutM/phd1U=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1790629059; c=relaxed/simple;
	bh=PeaPssOcLq6rmmUwXstMV/bMoZzVRdhCCPuKpYzSTG8=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=k/4+Waxp+ttFJoh9eNR4dHttsb3fxzBJuszeyJRDzk6lZ1+J64X/gUj8TtGvErh4p9NJX43449WGac2/kPOjWgydVpcePobHnBj4gdTi8CuX3SuboovDHznvDybvidnjcjaUzK5PWUgvZVhdBlAcQS/wZLpOwSkxEifn/UYdfSI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=K0IG/5KX; arc=none smtp.client-ip=74.125.230.194
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="K0IG/5KX"
Received: by mail-qk2-f2.google.com with SMTP id d75a77b69052e-533239e6e1fso16112751cf.0
        for <linux-iio@vger.kernel.org>; Mon, 28 Sep 2026 13:57:33 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1790629052; x=1791233852; darn=vger.kernel.org;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :content-type:mime-version:subject:date:from:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=GxH2kWLA46LLxQoALtYVXdvyTmVLLZllL9llUYcqwnw=;
        b=K0IG/5KX3p2jlP2LN18iUKy/Qh+QdzLFVS7GbGvR3xk+0m9XynK9EfvYc3l2l1hnfc
         ZBiemaXgxeowI+pKY+Jb9XZq9cHbN+pNDdGKPu62eoGazel6lvPCrfXq5CosGyDpIbxB
         chYt4WSt0YV0BiR2tpfWXvWxC1bNZtOVFRgk/aIr5WHf3cb6x3qYhHLoFX8Y4DIN05QG
         Pb0flwCcmOP7N+Sy/v/l7PzqFfImbXVI5OMe+ncKqclrRit/7UcVk2i5VeUBr34bNNXO
         NM0mVLWFlLDnM1wKTtm/z77DSnQTBwO4R30OSUiuAHZJm6ZHl/uq2x3Gmh3PTCs8no4w
         sZog==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1790629052; x=1791233852;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :content-type:mime-version:subject:date:from:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=GxH2kWLA46LLxQoALtYVXdvyTmVLLZllL9llUYcqwnw=;
        b=ichkQG+oHvyeYxvvTVMg1DvIJu6aAkQYvlPYCNZC+eNvSepqNGD8YbEJWfP/MMJuc2
         7kyTsgyouxPRdA9Tu6be6xV4Fo92NYk3OPSmQAfQ8Na+4nq+AW6Ffh/jzm9McQ46bLFf
         XErHT3shRYsTjgIx41imzkmZOYBw4z+Z0uaCfcmai1fjGPpmP5z1ZPE+ad+FFpFuChm/
         g6p8rIywaH2sBPYfbOMj9nBYuZXPiO4JjrDHbmxVEA1RIacPa9j/tuNSyPvlRjfzNNEx
         FEefCtzavHoPcimM/gRSujIVW5We4j6Unlr36h0rCQMnykNhYCOoj5ORwBVNnzAdQlsk
         wZpQ==
X-Gm-Message-State: AFuF++nU2IVblvPVenBxaRQj0yTTyoHnnrt633SlWP47+/O7Lk/giZ3H
	rojUQg3/dHX3MQrUOPM5eqxRS/yF6sO/J1gR0ceIZej7R25txZVoGxuO
X-Gm-Gg: AYBFou3/rnsLwDx08f5GaH3SWLVoFBEZ5yw4dP/AB593lMjwcsxbceS2213H+VfWZEB
	2o2wR7izf1b/KBuokOoYriDXvd2V/VdehvlSmz7zmut9JhTDDCJvPxQ7Jx2SU7GV6+jSlBEchhP
	iwbJtbIq9uljzjGpJpw4W3lRQvZrKekaQuwcYdu5fgAS5FZTZ0Uh47Qva4gYEW6MtRIxUG1DVNT
	SVDyD+VLHhVBjQE/5uiwxySmkIWnlpwwsZzsy+0sMkgkWQI0BaB4ldbf/eAy5hoVsBNOhoHJcxZ
	PxumM39+ppEEWoCVZS/PnFsHRWN7N8YBsnDhSpzVYyXyXdtSr1qot+6Dt8441hLZcY/3rZ076WV
	SYhDLw0txhr/UNEPsglGyzYfnKHgmuiaUOF2jlLtIQB3fsG/U/ZPHeUo1gOU5qexAb+iZ2onyGV
	Os0lypc6/q1yAlbMmLSEgr0Die6MyJRE4fBX3gLARsAoLyrEadaM2tuho8IZJ8DzXakCQGNxXc6
	wN3Ur5wbQD5esXRuTW5HMHpAcKVt/jtaTp02gvzNyhiV7yewawlru/d3HN1x8ah
X-Received: by 2002:a05:622a:8c8:b0:533:415f:4290 with SMTP id d75a77b69052e-533415f4748mr101624841cf.25.1790629052200;
        Mon, 28 Sep 2026 13:57:32 -0700 (PDT)
Received: from [10.10.18.223] (wsip-64-207-253-118.tu.ok.cox.net. [64.207.253.118])
        by smtp.gmail.com with ESMTPSA id d75a77b69052e-533223c6d82sm71443421cf.21.2026.09.28.13.57.29
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 28 Sep 2026 13:57:31 -0700 (PDT)
From: Ryan Brue <ryanbrue.dev@gmail.com>
Date: Mon, 28 Sep 2026 15:57:20 -0500
Subject: [PATCH v4 2/3] iio: adc: mt6397-auxadc: add mt6397 PMIC AUXADC
 driver
Precedence: bulk
X-Mailing-List: linux-iio@vger.kernel.org
List-Id: <linux-iio.vger.kernel.org>
List-Subscribe: <mailto:linux-iio+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-iio+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20260928-rbrue-suez-upstreaming-mt6397-auxadc-v4-2-23533a0d30e3@gmail.com>
References: <20260928-rbrue-suez-upstreaming-mt6397-auxadc-v4-0-23533a0d30e3@gmail.com>
In-Reply-To: <20260928-rbrue-suez-upstreaming-mt6397-auxadc-v4-0-23533a0d30e3@gmail.com>
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
X-Developer-Signature: v=1; a=ed25519-sha256; t=1790629044; l=16373;
 i=ryanbrue.dev@gmail.com; s=20260906; h=from:subject:message-id;
 bh=PeaPssOcLq6rmmUwXstMV/bMoZzVRdhCCPuKpYzSTG8=;
 b=5uionmJ6VVoOIF7aYTtjebxO4Pku4QTiQXgC8W9nmHxpm5M2CpKt4hzXLsUbhbH42DBHqdUWX
 jc/rIh+VGvzDNxWI9aPISb22t0ZszIR2fOIUI/wO+5TcUBX+Cp/sJGK
X-Developer-Key: i=ryanbrue.dev@gmail.com; a=ed25519;
 pk=KsUvVaP//v/2q+ZBuacc7cLbsyEYn+AD71Sn28oZWKo=

The mt6397 AUXADC is a 10-bit ADC behind the SoC's PMIC wrapper. On boards
built around this PMIC it is the only way to read the battery: the SoC's
AUXADC is wired to board thermistors and the charger ICs these boards use
have no ADC of their own.

Add a driver exposing the battery voltage and battery temperature
channels. Only those two are described, so a channel ID in the device tree
indexes the driver's channel array rather than the PMIC's channel number,
as mt6323-auxadc does. The ready bit lives in a channel's raw result
register, but the value comes from the chip's factory-calibrated copy.

The battery voltage is measured through ISENSE, because a board with a
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

A new driver was created here, instead of modifying an existing driver such
as mt6323-auxadc or mt6359-auxadc, for the following reasons:

 - Both mt6323-auxadc and mt6359-auxadc select channels through a request
   register (1 bit per channel), while mt6397 uses a 4-bit numeric field
   CHSEL in CON1 (10:7), and then pulses a START bit (CON1 bit 0).

 - For mt6323-auxadc, which is the closest I could find to the mt6397
   (CON0..CON27), it has 13 more registers than the mt6397 (CON0..CON14).
   It uses CON22 for its request register, and reads the result value
   from the same register as the ready bit. We don't do that - the mt6397
   has a factory-calibrated value for each channel at 0x16 higher than the
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
---
 MAINTAINERS                     |   1 +
 drivers/iio/adc/Kconfig         |  11 ++
 drivers/iio/adc/Makefile        |   1 +
 drivers/iio/adc/mt6397-auxadc.c | 377 ++++++++++++++++++++++++++++++++++++++++
 4 files changed, 390 insertions(+)

diff --git a/MAINTAINERS b/MAINTAINERS
index c8cef3bcb7de..50647e725eca 100644
--- a/MAINTAINERS
+++ b/MAINTAINERS
@@ -16719,6 +16719,7 @@ MEDIATEK MT6397 PMIC AUXADC DRIVER
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
index 000000000000..8d1702658876
--- /dev/null
+++ b/drivers/iio/adc/mt6397-auxadc.c
@@ -0,0 +1,377 @@
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
+/* Samples accumulated per conversion; the chip's accumulator is left at one. */
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
+	ret = regmap_update_bits(map, MT6397_AUXADC_CON1, MT6397_AUXADC_CON1_CHSEL,
+				 FIELD_PREP(MT6397_AUXADC_CON1_CHSEL, chan->address));
+	if (ret)
+		return ret;
+
+	/*
+	 * START is edge triggered: lower it before raising it again. No delay
+	 * is needed in between -- the ready bit survives the fall and is
+	 * cleared by the rise, before the next transaction on this bus can
+	 * observe it, so a ready bit seen by the poll can only be this
+	 * conversion's.
+	 */
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
+static int mt6397_auxadc_battemp_bias_on(struct mt6397_auxadc *adc)
+{
+	struct regmap *map = adc->regmap;
+	int ret;
+
+	ret = regmap_set_bits(map, MT6397_AUXADC_CON0,
+			      MT6397_AUXADC_CON0_BUF_PWD_ON);
+	if (ret)
+		return ret;
+
+	ret = regmap_set_bits(map, MT6397_AUXADC_CON0,
+			      MT6397_AUXADC_CON0_BUF_PWD_B);
+	if (ret)
+		return ret;
+
+	return regmap_set_bits(map, MT6397_CHR_CON7,
+			       MT6397_CHR_CON7_BATON_TDET_EN);
+}
+
+static void mt6397_auxadc_battemp_bias_off(struct mt6397_auxadc *adc)
+{
+	struct regmap *map = adc->regmap;
+
+	regmap_clear_bits(map, MT6397_CHR_CON7, MT6397_CHR_CON7_BATON_TDET_EN);
+	regmap_clear_bits(map, MT6397_AUXADC_CON0, MT6397_AUXADC_CON0_BUF_PWD_B);
+	regmap_clear_bits(map, MT6397_AUXADC_CON0, MT6397_AUXADC_CON0_BUF_PWD_ON);
+}
+
+static int mt6397_auxadc_isense_enable(struct mt6397_auxadc *adc)
+{
+	struct regmap *map = adc->regmap;
+	int ret;
+
+	/*
+	 * Each ADCIN bit connects one input to the battery channel. BATSNS is
+	 * disconnected before ISENSE is connected, so that the two are never
+	 * connected at the same time.
+	 */
+	ret = regmap_clear_bits(map, MT6397_CHR_CON16, MT6397_CHR_CON16_ADCIN_VBAT_EN);
+	if (ret)
+		return ret;
+
+	ret = regmap_set_bits(map, MT6397_CHR_CON16, MT6397_CHR_CON16_ADCIN_VSEN_EN);
+	if (ret)
+		return ret;
+
+	return regmap_set_bits(map, MT6397_AUXADC_CON14,
+			       MT6397_AUXADC_CON14_CH0_NORM_SEL |
+			       MT6397_AUXADC_CON14_CH0_LBAT_SEL);
+}
+
+static void mt6397_auxadc_isense_disable(struct mt6397_auxadc *adc)
+{
+	struct regmap *map = adc->regmap;
+
+	regmap_clear_bits(map, MT6397_AUXADC_CON14,
+			  MT6397_AUXADC_CON14_CH0_NORM_SEL |
+			  MT6397_AUXADC_CON14_CH0_LBAT_SEL);
+	regmap_clear_bits(map, MT6397_CHR_CON16,
+			  MT6397_CHR_CON16_ADCIN_VSEN_EN |
+			  MT6397_CHR_CON16_ADCIN_VBAT_EN);
+}
+
+/*
+ * One burst on a channel that is already prepared: the caller owns the lock,
+ * the analog setup and the teardown.
+ */
+static int mt6397_auxadc_read_burst(struct mt6397_auxadc *adc,
+				    const struct iio_chan_spec *chan, int *val)
+{
+	unsigned int sum = 0;
+	int sample;
+	int ret;
+
+	for (unsigned int i = 0; i < MT6397_AUXADC_SAMPLES; i++) {
+		ret = mt6397_auxadc_read_once(adc, chan, &sample);
+		if (ret)
+			return ret;
+
+		sum += sample;
+	}
+
+	*val = DIV_ROUND_CLOSEST(sum, MT6397_AUXADC_SAMPLES);
+
+	return 0;
+}
+
+static void mt6397_auxadc_release(struct mt6397_auxadc *adc,
+				  const struct iio_chan_spec *chan)
+{
+	/* Lowering START leaves the converter unarmed between reads. */
+	regmap_clear_bits(adc->regmap, MT6397_AUXADC_CON1, MT6397_AUXADC_CON1_START);
+
+	if (chan->channel == MT6397_AUXADC_ISENSE)
+		mt6397_auxadc_isense_disable(adc);
+	else
+		mt6397_auxadc_battemp_bias_off(adc);
+}
+
+static int mt6397_auxadc_read_channel(struct iio_dev *indio_dev,
+				      const struct iio_chan_spec *chan,
+				      int *val)
+{
+	struct mt6397_auxadc *adc = iio_priv(indio_dev);
+	int ret;
+
+	mutex_lock(&adc->lock);
+
+	if (chan->channel == MT6397_AUXADC_ISENSE) {
+		ret = mt6397_auxadc_isense_enable(adc);
+		if (ret)
+			goto out_release;
+
+		fsleep(MT6397_AUXADC_ISENSE_SETTLE_US);
+	} else {
+		ret = mt6397_auxadc_battemp_bias_on(adc);
+		if (ret)
+			goto out_release;
+
+		fsleep(MT6397_AUXADC_BATTEMP_SETTLE_US);
+	}
+
+	ret = mt6397_auxadc_read_burst(adc, chan, val);
+
+out_release:
+	mt6397_auxadc_release(adc, chan);
+	mutex_unlock(&adc->lock);
+
+	return ret;
+}
+
+static int mt6397_auxadc_read_raw(struct iio_dev *indio_dev,
+				  const struct iio_chan_spec *chan,
+				  int *val, int *val2, long mask)
+{
+	int ret;
+
+	switch (mask) {
+	case IIO_CHAN_INFO_RAW:
+		ret = mt6397_auxadc_read_channel(indio_dev, chan, val);
+		if (ret)
+			return ret;
+
+		return IIO_VAL_INT;
+
+	case IIO_CHAN_INFO_SCALE:
+		/* 1200 mV full range with 10-bit resolution. */
+		if (chan->channel == MT6397_AUXADC_ISENSE)
+			*val = 1200 * MT6397_AUXADC_ISENSE_DIVIDER;
+		else
+			*val = 1200;
+
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

