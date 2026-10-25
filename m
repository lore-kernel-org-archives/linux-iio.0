Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=74.125.224.139
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1792905499;
	b=aIlU8EV1wRq8Nq07+840v58xVfInj7sYTGCJBW9W3C2PAJaJuk+5aOBW5SR/MsII/4YX
	 R7URl82EZadi9g4bD+BnPcziGxu3UBU69xcR60QcNDg0JxdICDhvOlNE4zeLwzDR8tZ/q
	 TogupVkIndhLA8csGCqT5PQK6osKhcJEV43SOL7GLznH0oUHBFppDf3C1rmmO5XDJuTpx
	 DDGj0P6e1yHP7tckmQ7q66XuCpK8pvn1nebkAPN4Sy7SP+DiO19UdJyH2AUHUWyYMWXe6
	 aLg4hxjbCxuGVsEQxkD0Gc0Q/xnS3j38arpcTMcjTbLtqB6uJ8wLcDZ2gncVSbQEO4g==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1792905499;
	h=DMARC-Filter:Received:DKIM-Signature:X-Google-DKIM-Signature:
	 X-Forwarded-Encrypted:X-Gm-Message-State:X-Gm-Gg:X-Received:Received:
	 From:Date:Subject:MIME-Version:Content-Type:Content-Transfer-Encoding:
	 Message-Id:References:In-Reply-To:To:Cc:X-Mailer:
	 X-Developer-Signature:X-Developer-Key;
	bh=EwHVDnWszJQ91WriRUxs2YdOfWEpY4IVRbcfMVvMvn8=;
	b=TgPLnQ9xZ0rQt4fSNYQsY6m61tCougz8it93mdzMv9tpLotYJXZZf7Nh9TuAKGuf4YpC
	 JUUp088a7azLGrg5JatV9t7hEOJ+YHSXj02CCNxV+tZBKhWbTrdIKTn0db2tJp1nxmSEv
	 W1vbwaMI+RV6ZgIAe+vyxtuMwojc/GfkjAiDz1cxnDn+F2FD6YKFzKnVkibIJy8ifWhMw
	 FP17RbIZ3F1CL+cZMVhzY6Evm1n6NSJ3C1rjZ/i/+tGy/u9Brros//NQv3WZ+/uDmddmt
	 gSBQumXX/W2nvRfTyTdQMr7bLu3hPRvuBeC5CGf5136H6BMGsOu+xE9zzi+3JfjQ3wQ==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=gmail.com;
	spf=pass smtp.mailfrom=gmail.com;
	dkim=pass header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20251104 header.b=gMRRCknV;
	arc=none smtp.remote-ip=74.125.224.139
Received: from mail-yx2-f11.google.com (mail-yx2-f11.google.com [74.125.224.139])
	(using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C5DA760A260B
	for <linux-iio@vger.kernel.org>; Sun, 25 Oct 2026 05:18:18 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org C5DA760A260B
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20251104 header.b=gMRRCknV
Received: by mail-yx2-f11.google.com with SMTP id 956f58d0204a3-67a3f22cee8so828301d50.0
        for <linux-iio@vger.kernel.org>; Sat, 24 Oct 2026 22:18:18 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1792905498; x=1793510298; darn=vger.kernel.org;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :content-type:mime-version:subject:date:from:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=EwHVDnWszJQ91WriRUxs2YdOfWEpY4IVRbcfMVvMvn8=;
        b=gMRRCknVg5/jPOCzhLZ4001ak6rvS5AoC6ypBowulMTZFIcH4LWdLqdE658vIZ1rf8
         5bCtQf6dhQi27JU3KcCF/bq4TuL/s4wg6FbFWvZ7BIVMjugrWeKnASl8D2PSye61yPfb
         /4F5RhuuT6BcNetQrlkUAzmOLsTdMWHXrHVb12mC/3Rj5XIg7aiJYfHz3EVNGa9icV6x
         38aYvmT5WwR9B18/8fCtYPxnBPHXAAiCY6gfCNLr1AAc5AQVmT44j/eaY9G4dvyg2J17
         fgSwvX7umEoThGA0AN+eUifFQyvOkwQmO8zs4SaH13k2PLBGoOmGb8XxGKfNySNoqkzT
         POIQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1792905498; x=1793510298;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :content-type:mime-version:subject:date:from:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=EwHVDnWszJQ91WriRUxs2YdOfWEpY4IVRbcfMVvMvn8=;
        b=LboCGIn3hYEk9LVJGYu14RuIceXlF7KJfTtgOhUtn6b6hrxnQlBQH4sSmpO1NwTOGm
         XPVKvGAxCvgmEaAcTpDMNN15XSeoyRaRT7FV8d23JGiPbmO+AcvXI6fLQLMwYHI59VxG
         QvqyMcLJ/YUqtm06Qgd/bKWT+23ly3ljHETCZ61vhGOjph4ZUubQtbQsbyEMW4ns89G3
         qIfZnSAfxvDUfdfUQN6vzFdHp5uNlgGYC36rDzWD0V8pHX7116tu4X2jsf6kU+4GNZ6f
         KqNh5U6KguuS/GdyWlBbzpX4jL1I/7bGCARHAxieVG7763R3EpJpQ9Xh879CY3PmA7+o
         tsRQ==
X-Forwarded-Encrypted: i=1; AKwUvBwWraIbUHC2YeH5twtLCeca83pJxHFM66MVaYnLJgS4cshZwvUbNFU1NSGcz0HciqcHfxXincdAfDs=@vger.kernel.org
X-Gm-Message-State: AFq9FYIyvtx/N8d39R2ekEUfmnWzTC2u2m/8DBXAQbvVT60XN4x9eitK
	O8wIeEMLSrmdSG4NK1RHetl9mc0qoDNzyM1YSSMwYV+u08bOah4z2wfo
X-Gm-Gg: AYBFou0ARwir0Oey7jG9TM6VslfcckejzyJupaUzJ8OV+tHF5/uzFKzGqf38eZ8FVha
	ANuT21iTjOpOv85NRAFxnOwSJLVIQp4GmsB/xXV0x/ddFrJKzQ9u2w/Eh2MXgYzjlP4Nu27CfKl
	u3lcUjY1lz5VbEym01J+IRytl0yQPp+R0HIgDS4VJyYzGBLIP286CLcWpZI5Fsr9pE6OAdTNmMD
	jZcuGyEBrnHPJV7LyBZMvDHafiEkeX7jroyZbSnHb/932GciQIh6J4ulCjBfn2kFG4Z8FO0fXV4
	qkGq25EoEsD6qGB3pCwo2qyQtxVsxNEod0evWdpAhKM5RU7JLNPxWwZdSLkIHX/nweC1prQU+hs
	afjEFFBj/BP5/v/PFr05g0EbMSqDz6fnNoVo6vDTvwPO3joiCp+73VoKFncMhR9yxp9c9qWhusm
	usU7eWpq5oWWTrsPjJx3oibMzoQ+uMX63ynXnYATbz8JCiG6FAFyNsMgA+CI/P3wGrUFZmjOSyG
	sJLx7EASjFNqaF/bRHyw0H61Ec97q8q6htZxfzYgFIqow==
X-Received: by 2002:a05:690c:5c19:b0:8ab:4989:bcc3 with SMTP id 00721157ae682-8b166be0e0amr18546617b3.42.1792905497844;
        Sat, 24 Oct 2026 22:18:17 -0700 (PDT)
Received: from [192.168.1.91] ([2600:1702:894b:4a00::12])
        by smtp.gmail.com with ESMTPSA id 00721157ae682-8b166c5d605sm16477797b3.5.2026.10.24.22.18.15
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sat, 24 Oct 2026 22:18:16 -0700 (PDT)
From: Ryan Brue <ryanbrue.dev@gmail.com>
Date: Sun, 25 Oct 2026 00:18:09 -0500
Subject: [PATCH v5 2/2] iio: adc: mt6397-auxadc: add mt6397 PMIC AUXADC
 driver
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
Message-Id: <20261025-rbrue-suez-upstreaming-mt6397-auxadc-v5-2-5c3c7a5a1851@gmail.com>
References: <20261025-rbrue-suez-upstreaming-mt6397-auxadc-v5-0-5c3c7a5a1851@gmail.com>
In-Reply-To: <20261025-rbrue-suez-upstreaming-mt6397-auxadc-v5-0-5c3c7a5a1851@gmail.com>
To: Jonathan Cameron <jic23@kernel.org>, 
 David Lechner <dlechner@baylibre.com>, 
 =?utf-8?q?Nuno_S=C3=A1?= <nuno.sa@analog.com>, 
 Andy Shevchenko <andy@kernel.org>, Rob Herring <robh@kernel.org>, 
 Krzysztof Kozlowski <krzk+dt@kernel.org>, 
 Conor Dooley <conor+dt@kernel.org>, 
 Matthias Brugger <matthias.bgg@gmail.com>, 
 AngeloGioacchino Del Regno <angelogioacchino.delregno@collabora.com>
Cc: Roman Vivchar <rva333@protonmail.com>, 
 Luca Leonardo Scorcia <l.scorcia@gmail.com>, linux-iio@vger.kernel.org, 
 devicetree@vger.kernel.org, linux-kernel@vger.kernel.org, 
 linux-arm-kernel@lists.infradead.org, linux-mediatek@lists.infradead.org, 
 Ryan Brue <ryanbrue.dev@gmail.com>, 
 Andy Shevchenko <andriy.shevchenko@intel.com>
X-Mailer: b4 0.14.3
X-Developer-Signature: v=1; a=ed25519-sha256; t=1792905489; l=16790;
 i=ryanbrue.dev@gmail.com; s=20260906; h=from:subject:message-id;
 bh=gOmx21VTlI75af2dFfmMResTJsUgn6W0Lsryo8w3kEc=;
 b=XqRd9Q9DkobmeDN28QEqOtBXFXN3aTtR+mhFVDlu6i7QVIiIdjCFoa+aBiR0QbC80GUDBVRd4
 XuyP8zay/L6D9Y/SnpM4PTzrX8tRWj7h78QP9OmY2ckAih4RwqaTUTF
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

Reviewed-by: Andy Shevchenko <andriy.shevchenko@intel.com>
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
 drivers/iio/adc/mt6397-auxadc.c | 394 ++++++++++++++++++++++++++++++++++++++++
 4 files changed, 407 insertions(+)

diff --git a/MAINTAINERS b/MAINTAINERS
index b5417c02eb01..761db34f84a1 100644
--- a/MAINTAINERS
+++ b/MAINTAINERS
@@ -16784,6 +16784,7 @@ MEDIATEK MT6397 PMIC AUXADC DRIVER
 M:	Ryan Brue <ryanbrue.dev@gmail.com>
 L:	linux-iio@vger.kernel.org
 S:	Maintained
+F:	drivers/iio/adc/mt6397-auxadc.c
 F:	include/dt-bindings/iio/adc/mediatek,mt6397-auxadc.h
 
 MEDIATEK MT6735 CLOCK & RESET DRIVERS
diff --git a/drivers/iio/adc/Kconfig b/drivers/iio/adc/Kconfig
index f32f678f73fb..7686314bc91b 100644
--- a/drivers/iio/adc/Kconfig
+++ b/drivers/iio/adc/Kconfig
@@ -1273,6 +1273,17 @@ config MEDIATEK_MT6370_ADC
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
index fee580bdd3b2..d7bb4815df61 100644
--- a/drivers/iio/adc/Makefile
+++ b/drivers/iio/adc/Makefile
@@ -108,6 +108,7 @@ obj-$(CONFIG_MEDIATEK_MT6323_AUXADC) += mt6323-auxadc.o
 obj-$(CONFIG_MEDIATEK_MT6359_AUXADC) += mt6359-auxadc.o
 obj-$(CONFIG_MEDIATEK_MT6360_ADC) += mt6360-adc.o
 obj-$(CONFIG_MEDIATEK_MT6370_ADC) += mt6370-adc.o
+obj-$(CONFIG_MEDIATEK_MT6397_AUXADC) += mt6397-auxadc.o
 obj-$(CONFIG_MEDIATEK_MT6577_AUXADC) += mt6577_auxadc.o
 obj-$(CONFIG_MEN_Z188_ADC) += men_z188_adc.o
 obj-$(CONFIG_MESON_SARADC) += meson_saradc.o
diff --git a/drivers/iio/adc/mt6397-auxadc.c b/drivers/iio/adc/mt6397-auxadc.c
new file mode 100644
index 000000000000..234022f15eba
--- /dev/null
+++ b/drivers/iio/adc/mt6397-auxadc.c
@@ -0,0 +1,394 @@
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
+static void mt6397_auxadc_stop(struct mt6397_auxadc *adc)
+{
+	/* Lowering START leaves the converter unarmed between reads. */
+	regmap_clear_bits(adc->regmap, MT6397_AUXADC_CON1, MT6397_AUXADC_CON1_START);
+}
+
+static int mt6397_auxadc_isense_read(struct mt6397_auxadc *adc,
+				     const struct iio_chan_spec *chan, int *val)
+{
+	int ret;
+
+	ret = mt6397_auxadc_isense_enable(adc);
+	if (ret)
+		goto out_disable;
+
+	fsleep(MT6397_AUXADC_ISENSE_SETTLE_US);
+
+	ret = mt6397_auxadc_read_burst(adc, chan, val);
+
+out_disable:
+	mt6397_auxadc_stop(adc);
+	mt6397_auxadc_isense_disable(adc);
+
+	return ret;
+}
+
+static int mt6397_auxadc_battemp_read(struct mt6397_auxadc *adc,
+				      const struct iio_chan_spec *chan, int *val)
+{
+	int ret;
+
+	ret = mt6397_auxadc_battemp_bias_on(adc);
+	if (ret)
+		goto out_bias_off;
+
+	fsleep(MT6397_AUXADC_BATTEMP_SETTLE_US);
+
+	ret = mt6397_auxadc_read_burst(adc, chan, val);
+
+out_bias_off:
+	mt6397_auxadc_stop(adc);
+	mt6397_auxadc_battemp_bias_off(adc);
+
+	return ret;
+}
+
+static int mt6397_auxadc_read_channel(struct iio_dev *indio_dev,
+				      const struct iio_chan_spec *chan,
+				      int *val)
+{
+	struct mt6397_auxadc *adc = iio_priv(indio_dev);
+
+	guard(mutex)(&adc->lock);
+
+	if (chan->channel == MT6397_AUXADC_ISENSE)
+		return mt6397_auxadc_isense_read(adc, chan, val);
+
+	return mt6397_auxadc_battemp_read(adc, chan, val);
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

