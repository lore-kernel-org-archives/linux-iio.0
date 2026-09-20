Received: from mail-oa2-f10.google.com (mail-oa2-f10.google.com [74.125.231.74])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id BFC983D522C
	for <linux-iio@vger.kernel.org>; Sun, 20 Sep 2026 05:32:05 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=74.125.231.74
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1789882328; cv=none; b=pbKxAlRZe9O6zuxT6PTJktS0/QWQqAyn85iUl1TWjb2hx+aDuj90HAm/3oUOSYjP4MsmsW6RyK4jzYFxq0pUFpVpusvXuaBnaSFl77CL6xqHq9piinGAArSV2qh7tvyygylM6HRsVac4M3tHD5ySZtaBl35yqQmlhplg6ey7SjQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1789882328; c=relaxed/simple;
	bh=2/09mwmCWHAmQRczFfkj/6sO+pEFVwrBXzlkK6Y4DMY=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=mBvivqrG4uI3iPUqh6AwRJKhWXMFMNRVQXtynt0pN1WuBv+BIfHJTVYyhaHx4aZ4bpbPwdwpGLCk24Ly709vuolQWzXsb3Wo3GtzfWACl5D0nCKm/A8y9DjUg50t09RZqoNxc/7aEISkWM6i6aA11C7uHF6quVnT/ot+anuHRFE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=U25VE7dd; arc=none smtp.client-ip=74.125.231.74
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="U25VE7dd"
Received: by mail-oa2-f10.google.com with SMTP id 586e51a60fabf-47bbb846425so1021842fac.0
        for <linux-iio@vger.kernel.org>; Sat, 19 Sep 2026 22:32:05 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1789882324; x=1790487124; darn=vger.kernel.org;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :content-type:mime-version:subject:date:from:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=N1Hvg2JMi4nrnD6ulr7LYBIUqOQmteayVujpA8jQF9Y=;
        b=U25VE7ddcgnSCpbG1qolMZIri7E8KU+fyYVQBM7lS/o6CihHhi16y0TO+3cYdjvHBt
         P8XDddZK50eC2rTgGldDWuqA7Rc2dEFRTjlQ7SEGxTbxBbvt4CoMpp/BIkQk1lCLC1Fc
         RJK8dJ12YH2mInTigO+/0QFaoDF31HVQsZGAPZbJq0Sg7HAVp5CYO1+WHrZCbPCEYkbE
         5fUsgg/P8E2rVyrYPpS+R9E3cE048CmlqgQexZ8RIcM0UtVkCfmOQz0CLRRec/djGJQN
         kPF81CJc8QqrV9+0SSNkulSKpOoRbrr0sYGsZKmM7FjqmF6u59UlOwZG96QVJYwmmTy8
         /6JA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1789882324; x=1790487124;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :content-type:mime-version:subject:date:from:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=N1Hvg2JMi4nrnD6ulr7LYBIUqOQmteayVujpA8jQF9Y=;
        b=1MHekxo7Ew57trY5rKC+Qgfy/bkQcoXHyKR5sigUqVP6kxgz/RfrPNfhnuwmOJ/Pj8
         L8crguznwEEjqTw12mN3pSPBxiPK8W10Vy2K3qLCzzknXLiRK7guN0o698OdJv63f3gK
         K3buRq5wDR/BEMaWQe6pOWFyHXwrpGvVePnpyDEsHI6Cr+PQX6XzT/Rh1e7nEkePKcAf
         5asL2QFOvxyg0NForMVwHgmqdT+Wv4iTWNQAXpMv0SaIfF7Gxav+oQF36BY0GrWBeeYx
         w5zvMD0zvvOZ9N/xZXf1EEccqsQ8WN2RHagO0kslPFKC06GqQKpFccjbq/f3jj0fxWGx
         g+3g==
X-Gm-Message-State: AFuF++nl0h3DwvXlMzn+scLBo4lSJkwIF7u3VBSP4LiDEjay+x1bg42A
	R8C7KO8an9zAsKqhb3MCDwjQE93GNuiKMKlqWaG8Kn5dITYbRZlwZyJ/
X-Gm-Gg: AYBFou3kiUOlRB+TfuQGsMR6PhkkjQ1J4LZx2HeYGeTwD7Mqu4Ry+1AJqicb/gkL1W+
	G0AewzD0Cev/2D2tdJKw3IjhuWCm2CeB4KuhPbt2hSf6cAHFm0e24rXC4dtEMV0g4Ou7Q+rBnBB
	EPUphORspMJf1zulfeZsNWjjmzv9MR298SwoOzWJUVTe4eokUKpD6WrQn+4qClhLI9d23KUXa2x
	MjYz18tnn+HAnDGde0yR96vVD1MiaeauWGkdR4ih2sNqJfnno8bIbQUuQ3xzUfRvbTL9dTqQbRP
	qu+OvnZeRvZwHZ+R9UHJip9N5CTkLW2hvFwWKv+mZ/RKakPKpI/0NAgPMJlRPCEmZl1f1WYoS4k
	ONPgQHHFWx4C6iDQSE/WhxJkLfMJSckn22OhFOZo/1l8nMfDmszyf6rkfl9jFcF7yKTkidb/QPc
	S27V6mEFoFOYln9SFFPHBsUsvL4udw+xbPAoFKfCpRLLXXr30RzJf225GfXZPw/tyaFA==
X-Received: by 2002:a05:6820:a515:10b0:6cd:3ffc:ad0a with SMTP id 006d021491bc7-6cd3ffcb664mr2483465eaf.90.1789882324562;
        Sat, 19 Sep 2026 22:32:04 -0700 (PDT)
Received: from [192.168.18.164] ([2600:8804:5716:d800::2620])
        by smtp.gmail.com with ESMTPSA id 006d021491bc7-6cd3541f07fsm5007319eaf.10.2026.09.19.22.32.01
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sat, 19 Sep 2026 22:32:03 -0700 (PDT)
From: Ryan Brue <ryanbrue.dev@gmail.com>
Date: Sun, 20 Sep 2026 00:31:52 -0500
Subject: [PATCH v3 2/3] iio: adc: mt6397-auxadc: add mt6397 PMIC AUXADC
 driver
Precedence: bulk
X-Mailing-List: linux-iio@vger.kernel.org
List-Id: <linux-iio.vger.kernel.org>
List-Subscribe: <mailto:linux-iio+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-iio+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20260920-rbrue-suez-upstreaming-mt6397-auxadc-v3-2-c00edacbee64@gmail.com>
References: <20260920-rbrue-suez-upstreaming-mt6397-auxadc-v3-0-c00edacbee64@gmail.com>
In-Reply-To: <20260920-rbrue-suez-upstreaming-mt6397-auxadc-v3-0-c00edacbee64@gmail.com>
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
X-Developer-Signature: v=1; a=ed25519-sha256; t=1789882316; l=16778;
 i=ryanbrue.dev@gmail.com; s=20260906; h=from:subject:message-id;
 bh=2/09mwmCWHAmQRczFfkj/6sO+pEFVwrBXzlkK6Y4DMY=;
 b=nD3z2Iubwzgrgho2o2g8EpigyswjyQjo9Ur/pCVbdBWfjgQ24X5gGVbYk6XRVy+2tJLILTuAu
 xzedVNGAhkMCp2V7sHZXSqPjxZkxO4thqr6c+7GcWLUZPedj1uxZ7fS
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
 drivers/iio/adc/mt6397-auxadc.c | 391 ++++++++++++++++++++++++++++++++++++++++
 4 files changed, 404 insertions(+)

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
index 000000000000..d860cd3a8922
--- /dev/null
+++ b/drivers/iio/adc/mt6397-auxadc.c
@@ -0,0 +1,391 @@
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
+static int mt6397_auxadc_battemp_bias_off(struct mt6397_auxadc *adc)
+{
+	struct regmap *map = adc->regmap;
+	int ret;
+
+	ret = regmap_clear_bits(map, MT6397_CHR_CON7, MT6397_CHR_CON7_BATON_TDET_EN);
+	if (ret)
+		return ret;
+
+	ret = regmap_clear_bits(map, MT6397_AUXADC_CON0, MT6397_AUXADC_CON0_BUF_PWD_B);
+	if (ret)
+		return ret;
+
+	return regmap_clear_bits(map, MT6397_AUXADC_CON0,
+				 MT6397_AUXADC_CON0_BUF_PWD_ON);
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
+static int mt6397_auxadc_isense_disable(struct mt6397_auxadc *adc)
+{
+	struct regmap *map = adc->regmap;
+	int ret;
+
+	ret = regmap_clear_bits(map, MT6397_AUXADC_CON14,
+				MT6397_AUXADC_CON14_CH0_NORM_SEL |
+				MT6397_AUXADC_CON14_CH0_LBAT_SEL);
+	if (ret)
+		return ret;
+
+	return regmap_clear_bits(map, MT6397_CHR_CON16,
+				 MT6397_CHR_CON16_ADCIN_VSEN_EN |
+				 MT6397_CHR_CON16_ADCIN_VBAT_EN);
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
+static int mt6397_auxadc_read_channel(struct iio_dev *indio_dev,
+				      const struct iio_chan_spec *chan,
+				      int *val)
+{
+	struct mt6397_auxadc *adc = iio_priv(indio_dev);
+	bool isense = chan->channel == MT6397_AUXADC_ISENSE;
+	int ret, stop_err, release_err;
+
+	guard(mutex)(&adc->lock);
+
+	if (isense) {
+		ret = mt6397_auxadc_isense_enable(adc);
+		if (!ret)
+			fsleep(MT6397_AUXADC_ISENSE_SETTLE_US);
+	} else {
+		ret = mt6397_auxadc_battemp_bias_on(adc);
+		if (!ret)
+			fsleep(MT6397_AUXADC_BATTEMP_SETTLE_US);
+	}
+
+	if (!ret)
+		ret = mt6397_auxadc_read_burst(adc, chan, val);
+
+	/*
+	 * The teardown is unconditional: once any part of the setup has been
+	 * written it has to run, even if the setup itself failed part-way.
+	 * Lowering START also leaves the converter unarmed between reads.
+	 * A caller has nothing to do with a teardown error, so it is logged
+	 * rather than returned.
+	 */
+	stop_err = regmap_clear_bits(adc->regmap, MT6397_AUXADC_CON1,
+				     MT6397_AUXADC_CON1_START);
+
+	if (isense)
+		release_err = mt6397_auxadc_isense_disable(adc);
+	else
+		release_err = mt6397_auxadc_battemp_bias_off(adc);
+
+	if (stop_err || release_err)
+		dev_err(&indio_dev->dev, "failed to release channel %d\n",
+			chan->channel);
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

