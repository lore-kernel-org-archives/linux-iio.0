Received: from mail-wr2-f12.google.com (mail-wr2-f12.google.com [74.125.225.76])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id EC958527581
	for <linux-iio@vger.kernel.org>; Tue, 29 Sep 2026 12:43:01 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=74.125.225.76
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1790685786; cv=none; b=Bau9TXiFy7zV3yWbN8sFvgB+ZlqbniYayDW1/Qr9+mqApfxSxeexVR29d5F0YfZarZ+mXMyVnV9s+QFWAh2Q+HUpmG8PZptw7zhUec1WCu65ni5w02jPpkJgUlcrjsQ3kf16Hr/QN6b35sytP9VIbR3SiM0wlks272CEPCpx5UM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1790685786; c=relaxed/simple;
	bh=eLsV3zrxG4YUPyLn8GMoJZufZKs9XDOvvk5A5Za6Gh0=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=SKYY/VsOTdUu0LZ+OEPjNYT6YgclZDqYr3i0m9u+QiKNBSzJJ6AZnY75xZc7z39YzlHAQpNKqHBUFkoZbkkObjVmR5y6fob75EAIb1+5Uy9wUa8lUtgWmOVjAMe1z92Pivfe/Atd9c3Fz03JxPIhF5IZ8IKiRjkWxMrb/vHrVfI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=H5fk8oLF; arc=none smtp.client-ip=74.125.225.76
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="H5fk8oLF"
Received: by mail-wr2-f12.google.com with SMTP id ffacd0b85a97d-486e1a044c5so3480981f8f.3
        for <linux-iio@vger.kernel.org>; Tue, 29 Sep 2026 05:43:01 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1790685779; x=1791290579; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=4JqKfUEQbpvir6EgjG03iqITrdNwkP+vOymOjHkR4yc=;
        b=H5fk8oLFpkcRbQj5MghkAliVx4OgRWcL/kUoF+okheqkvngQr94ZF5Ie4fXgYVYJmo
         3EQ525bL4e1P4PupT8zFDRw3piVmHwm37Layh9fUqixve5IeenfBXDPHM+aALqDKvIYa
         ngX+4yu+71jibpKscQynAKQJXIo6ZIlulWJRdVsf0t8RJvwrFczmRT7KR+2ldIgpN3eG
         j619fMS4s5/hMjuvCnUfirpvPF7goKosSdoIJZ61YAN0+jbtw1TXRBxBjkIrDH/oOmpN
         G1uzCYMtOJbYrqDbEgecAzx77Ezt1s8oJBC5XkECu1N4/heORdQwBjvjnXldzT5tG8Fy
         7zoQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1790685779; x=1791290579;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to:content-type;
        bh=4JqKfUEQbpvir6EgjG03iqITrdNwkP+vOymOjHkR4yc=;
        b=VecFmj13Ds2ummj3P807m5Im6HGzu9WsOfsDaUUWXrwcIWe9RXvAP8t7dzTNoc3Rc3
         Cfy7FrmAYCfwBpOTXl/lArliac6El6MEQbJ0cYSY9czdoOuw3XnUjGivvyr95ZZBE8UY
         9i7aN/Ujraf2KeJOtcvUo36/iJOEz3QGR/0Nvylqyp1f7TP/aho7TYSmQHqYwXO6Rgjq
         USQruImGgP42cgE+WbuPJCs3jRx1b8rcpd5qwxjsgAd2v5rx0CSmP1upY1i0eE0gI11w
         7fyEuO4NKNWlg7xIZXtyxuQbZiyL/Y/eZxmevdm8ng/4XPYqJwxTX5eWDxutGnGyq3vI
         k78w==
X-Forwarded-Encrypted: i=1; AKwUvBxJBwPjteHCNOg2JO/2qCzrZm6UC9zzpQWUF4ZXof9uioG4ijwxY8yMpCM7hJRG35KpTqtbAd5kzWY=@vger.kernel.org
X-Gm-Message-State: AFq9FYK8rkQNPzscjmDGHcXThOP33iDF1wnnCP0lbyFQDJLNOAJpqroY
	Rx8wwEBKg3COqAQQOaKJFICE4P+pDnj2C9xvoeVN7nipSrINkPXrG6DC
X-Gm-Gg: AYBFou22M+mFGmvWT/e2+Xl7V5Lu1HxfIFqF05pbYLEjR6B7h7tcl4axumhy6XWkwZe
	5pFbRTarE6zuqxGW9nu9tPveYjRaHUVM6z0PBI06rzGcSKKvZyRbiy1BrYPYWePEFqALZG4tWTf
	qC23DIzczwE1gDr4Zso56BPk4HUVjwMlvmR4aCykw5VYHHPHoq1UyAWXXgVkjgyd2oebkT7N4LO
	d/1x0oq9io8mJ2DTksFS0rzKnGoUoHweP5Krp3huW8WtwtNvksb+nD2RBrEeUv8Lay2Mj+Jlw0y
	NxQYr0TgEhGrEpGdCUe/jEeIa92pXORU3PQx8QI0Rhv53sHyeOUcq1kBzn5LGMVTZzh3YcfGT0h
	X7L/CnzF3J6cOvelQYQgosOYSV5+Y8eFDrFQmV370pzVzyyGmRvNciaMlCn05lCuylw6563QdSj
	9NlWujpabmDbGR4rNm+U86I4sSkY/xVDIq83UjrqEPQondBjDtqqvQaa6Sd5NAgbArSi4c0Dpyn
	Wp2dBPr2YY5iiGhHe4H7fl1HofVf8pQ7AsMuHFu1EPz1hqjzLPcxOdilXFGS+wzInh9wMU+Nu3d
	IpHJMlsNdBxq+JAQGkPsYPKPpHi5
X-Received: by 2002:a05:6000:420d:b0:487:14b6:b1be with SMTP id ffacd0b85a97d-4887172e3ffmr32814278f8f.25.1790685778866;
        Tue, 29 Sep 2026 05:42:58 -0700 (PDT)
Received: from iku.example.org ([2a06:5906:61b:2d00:be4b:8730:c872:1736])
        by smtp.gmail.com with ESMTPSA id ffacd0b85a97d-48af502da06sm4436630f8f.11.2026.09.29.05.42.58
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 29 Sep 2026 05:42:58 -0700 (PDT)
From: Prabhakar <prabhakar.csengg@gmail.com>
X-Google-Original-From: Prabhakar <prabhakar.mahadev-lad.rj@bp.renesas.com>
To: Cosmin Tanislav <cosmin-gabriel.tanislav.xa@renesas.com>,
	Jonathan Cameron <jic23@kernel.org>,
	David Lechner <dlechner@baylibre.com>,
	=?UTF-8?q?Nuno=20S=C3=A1?= <nuno.sa@analog.com>,
	Andy Shevchenko <andy@kernel.org>,
	Rob Herring <robh@kernel.org>,
	Krzysztof Kozlowski <krzk+dt@kernel.org>,
	Conor Dooley <conor+dt@kernel.org>,
	Philipp Zabel <p.zabel@pengutronix.de>,
	Geert Uytterhoeven <geert+renesas@glider.be>,
	Magnus Damm <magnus.damm@gmail.com>,
	linux-iio@vger.kernel.org
Cc: linux-renesas-soc@vger.kernel.org,
	devicetree@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	Prabhakar <prabhakar.csengg+renesas@gmail.com>,
	Biju Das <biju.das.jz@bp.renesas.com>,
	Fabrizio Castro <fabrizio.castro.jz@renesas.com>,
	Lad Prabhakar <prabhakar.mahadev-lad.rj@bp.renesas.com>
Subject: [PATCH 8/8] iio: adc: rzt2h: Add support for RZ/V2H(P) SoC
Date: Tue, 29 Sep 2026 13:42:48 +0100
Message-ID: <20260929124248.237032-9-prabhakar.mahadev-lad.rj@bp.renesas.com>
X-Mailer: git-send-email 2.55.0
In-Reply-To: <20260929124248.237032-1-prabhakar.mahadev-lad.rj@bp.renesas.com>
References: <20260929124248.237032-1-prabhakar.mahadev-lad.rj@bp.renesas.com>
Precedence: bulk
X-Mailing-List: linux-iio@vger.kernel.org
List-Id: <linux-iio.vger.kernel.org>
List-Subscribe: <mailto:linux-iio+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-iio+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

From: Lad Prabhakar <prabhakar.mahadev-lad.rj@bp.renesas.com>

Add support for the ADC found on the Renesas RZ/V2H(P) SoC, which shares
the RZ/T2H ADC IP but differs in channel count, sampling, calibration and
resolution support.

The RZ/V2H(P) ADC provides 8 channels, has a fixed conversion time of
20 ADCLK cycles, does not support calibration, and supports selectable
12-bit and 8-bit conversion resolution.

Expose the fixed sampling frequency as a read-only attribute and allow
the conversion resolution to be changed through the scale attribute.
Use extended scan types so the reported scan type follows the selected
resolution, and prevent resolution changes while buffered capture is
active.

Signed-off-by: Lad Prabhakar <prabhakar.mahadev-lad.rj@bp.renesas.com>
---
 drivers/iio/adc/Kconfig     |   3 +-
 drivers/iio/adc/rzt2h_adc.c | 201 +++++++++++++++++++++++++++++++++++-
 2 files changed, 200 insertions(+), 4 deletions(-)

diff --git a/drivers/iio/adc/Kconfig b/drivers/iio/adc/Kconfig
index a802d8ee4dd9..052bc018e97d 100644
--- a/drivers/iio/adc/Kconfig
+++ b/drivers/iio/adc/Kconfig
@@ -1592,9 +1592,10 @@ config RZT2H_ADC
 	select IIO_ADC_HELPER
 	select IIO_BUFFER
 	select IIO_KFIFO_BUF
+	select POWER_SEQUENCING
 	help
 	  Say yes here to build support for the ADC found in Renesas
-	  RZ/T2H / RZ/N2H SoCs.
+	  RZ/T2H / RZ/N2H (and similar SoCs).
 
 	  To compile this driver as a module, choose M here: the
 	  module will be called rzt2h_adc.
diff --git a/drivers/iio/adc/rzt2h_adc.c b/drivers/iio/adc/rzt2h_adc.c
index 953736b5475a..0db936097740 100644
--- a/drivers/iio/adc/rzt2h_adc.c
+++ b/drivers/iio/adc/rzt2h_adc.c
@@ -20,7 +20,9 @@
 #include <linux/platform_device.h>
 #include <linux/pm_runtime.h>
 #include <linux/property.h>
+#include <linux/pwrseq/consumer.h>
 #include <linux/reset.h>
+#include <linux/units.h>
 
 #define RZT2H_ADCSR_REG			0x00
 #define RZT2H_ADCSR_ADIE_MASK		BIT(12)
@@ -32,6 +34,11 @@
 #define RZT2H_ADANSA0_REG		0x04
 #define RZT2H_ADANSA0_CH_MASK(x)	BIT(x)
 
+#define RZT2H_ADCER_REG			0x0e
+#define RZT2H_ADCER_ADPRC_MASK		GENMASK(2, 1)
+#define RZT2H_ADCER_ADPRC_12BIT		0b00
+#define RZT2H_ADCER_ADPRC_8BIT		0b10
+
 #define RZT2H_ADDR_REG(x)		(0x20 + 0x2 * (x))
 
 #define RZT2H_ADSSTRn(n)		(0xe0 + 0x1 * (n))
@@ -59,13 +66,29 @@
 					 RZT2H_ADC_DMA_PERIOD_SAMPLES)
 #define RZT2H_ADC_STOP_CYCLES		2
 
+/*
+ * RZ/V2H has no sample state register, each A/D channel conversion takes a
+ * fixed 20 ADCLK cycles (sampling + comparison), giving a conversion rate of
+ * ADCLK / 20.
+ */
+#define RZV2H_ADC_CONV_CYCLES		20
+
 #define RZT2H_ADC_VREF_MV		1800
 
 #define RZT2H_ADC_FEATURE_CALIBRATION	BIT(0)
 #define RZT2H_ADC_FEATURE_SAMPLE_STATE	BIT(1)
+/* Selectable 12-bit / 8-bit conversion (ADCER.ADPRC) */
+#define RZT2H_ADC_FEATURE_RES_SELECT	BIT(2)
+/* Power-down mode controlled by the SYS power sequencer (SY_MSTP_ADA) */
+#define RZT2H_ADC_FEATURE_POWER_DOWN	BIT(3)
 
 struct rzt2h_adc;
 
+enum rzt2h_adc_resolution {
+	RZT2H_ADC_RES_12BIT,
+	RZT2H_ADC_RES_8BIT,
+};
+
 struct rzt2h_adc_chip_info {
 	const struct iio_chan_spec *chan_template;
 	int (*sst_to_freq)(struct rzt2h_adc *adc, u8 sst);
@@ -99,6 +122,7 @@ struct rzt2h_adc {
 	struct device *dev;
 	const struct rzt2h_adc_chip_info *chip_info;
 	struct reset_control *rstc;
+	struct pwrseq_desc *pwrseq;
 
 	phys_addr_t phys_base;
 	struct rzt2h_adc_dma dma;
@@ -107,6 +131,7 @@ struct rzt2h_adc {
 	struct mutex lock;
 
 	const struct iio_chan_spec *channels;
+	enum rzt2h_adc_resolution resolution;
 	unsigned int num_channels;
 	u16 buf[RZT2H_ADC_MAX_CHANNELS];
 
@@ -117,6 +142,11 @@ struct rzt2h_adc {
 	int irq;
 };
 
+static const int rzv2h_adc_scale_avail[] = {
+	RZT2H_ADC_VREF_MV, 12,
+	RZT2H_ADC_VREF_MV, 8,
+};
+
 static void rzt2h_adc_start(struct rzt2h_adc *adc, unsigned int conversion_type)
 {
 	u16 reg;
@@ -159,6 +189,23 @@ static void rzt2h_adc_set_sst(struct rzt2h_adc *adc, unsigned int ch, u8 sst)
 	writeb(sst, adc->base + RZT2H_ADSSTRn(ch));
 }
 
+static void rzt2h_adc_set_resolution(struct rzt2h_adc *adc)
+{
+	u16 reg;
+
+	if (!(adc->chip_info->features & RZT2H_ADC_FEATURE_RES_SELECT))
+		return;
+
+	reg = readw(adc->base + RZT2H_ADCER_REG);
+
+	if (adc->resolution == RZT2H_ADC_RES_8BIT)
+		FIELD_MODIFY(RZT2H_ADCER_ADPRC_MASK, &reg, RZT2H_ADCER_ADPRC_8BIT);
+	else
+		FIELD_MODIFY(RZT2H_ADCER_ADPRC_MASK, &reg, RZT2H_ADCER_ADPRC_12BIT);
+
+	writew(reg, adc->base + RZT2H_ADCER_REG);
+}
+
 static int rzt2h_adc_read_single(struct rzt2h_adc *adc, unsigned int ch, int *val)
 {
 	int ret;
@@ -175,12 +222,14 @@ static int rzt2h_adc_read_single(struct rzt2h_adc *adc, unsigned int ch, int *va
 	writew(RZT2H_ADANSA0_CH_MASK(ch), adc->base + RZT2H_ADANSA0_REG);
 
 	rzt2h_adc_set_sst(adc, ch, adc->sst[ch]);
+	rzt2h_adc_set_resolution(adc);
 
 	rzt2h_adc_start(adc, RZT2H_ADCSR_ADCS_SINGLE);
 
 	/*
 	 * Conversion can take up to ~4.3us at the maximum configurable ADSSTRn
-	 * (ADSSTRn + 13 cycles at 62.5 MHz), which rounds up to 1 jiffy. A bare
+	 * (ADSSTRn + 13 cycles at 62.5 MHz) on RZ/T2H, and up to 4.0us (20
+	 * cycles at 5 MHz) on RZ/V2H, which rounds up to 1 jiffy. A bare
 	 * 1-jiffy timeout can expire almost immediately if it's armed right
 	 * before a tick, so add one more jiffy to guarantee the conversion time
 	 * actually elapses.
@@ -468,6 +517,8 @@ static int rzt2h_adc_buffer_postenable(struct iio_dev *indio_dev)
 
 	writew(val, adc->base + RZT2H_ADANSA0_REG);
 
+	rzt2h_adc_set_resolution(adc);
+
 	adc->dma.period_index = 0;
 	atomic_set(&adc->dma.pending_periods, 0);
 
@@ -505,6 +556,11 @@ static int rzt2h_adc_sst_to_freq(struct rzt2h_adc *adc, u8 sst)
 	return adc->adclk_rate / (RZT2H_ADC_CONV_CYCLES_BASE + sst);
 }
 
+static int rzv2h_adc_sst_to_freq(struct rzt2h_adc *adc, u8 sst)
+{
+	return DIV_ROUND_CLOSEST(adc->adclk_rate, RZV2H_ADC_CONV_CYCLES);
+}
+
 static u8 rzt2h_adc_freq_to_sst(struct rzt2h_adc *adc, int freq)
 {
 	unsigned int cycles;
@@ -517,6 +573,46 @@ static u8 rzt2h_adc_freq_to_sst(struct rzt2h_adc *adc, int freq)
 	return cycles - RZT2H_ADC_CONV_CYCLES_BASE;
 }
 
+static int rzt2h_adc_get_current_scan_type(const struct iio_dev *indio_dev,
+					   const struct iio_chan_spec *chan)
+{
+	struct rzt2h_adc *adc = iio_priv(indio_dev);
+
+	return adc->resolution;
+}
+
+static int rzt2h_adc_write_scale(struct iio_dev *indio_dev,
+				 struct iio_chan_spec const *chan,
+				 int val, int val2)
+{
+	struct rzt2h_adc *adc = iio_priv(indio_dev);
+	unsigned int i;
+	u64 scale;
+	u32 rem;
+
+	if (!(adc->chip_info->features & RZT2H_ADC_FEATURE_RES_SELECT))
+		return -EINVAL;
+
+	for (i = 0; i < chan->num_ext_scan_type; i++) {
+		scale = (u64)RZT2H_ADC_VREF_MV * NANO >>
+			chan->ext_scan_type[i].realbits;
+		if (div_u64_rem(scale, NANO, &rem) == val && rem == val2)
+			break;
+	}
+
+	if (i == chan->num_ext_scan_type)
+		return -EINVAL;
+
+	/* The scan type changes with the resolution. */
+	IIO_DEV_ACQUIRE_DIRECT_MODE(indio_dev, claim);
+	if (IIO_DEV_ACQUIRE_FAILED(claim))
+		return -EBUSY;
+
+	adc->resolution = i;
+
+	return 0;
+}
+
 static int rzt2h_adc_read_raw(struct iio_dev *indio_dev,
 			      struct iio_chan_spec const *chan,
 			      int *val, int *val2, long mask)
@@ -572,11 +668,25 @@ static int rzt2h_adc_write_raw(struct iio_dev *indio_dev,
 
 		return 0;
 	}
+	case IIO_CHAN_INFO_SCALE:
+		return rzt2h_adc_write_scale(indio_dev, chan, val, val2);
 	default:
 		return -EINVAL;
 	}
 }
 
+static int rzt2h_adc_write_raw_get_fmt(struct iio_dev *indio_dev,
+				       struct iio_chan_spec const *chan,
+				       long mask)
+{
+	switch (mask) {
+	case IIO_CHAN_INFO_SCALE:
+		return IIO_VAL_INT_PLUS_NANO;
+	default:
+		return IIO_VAL_INT_PLUS_MICRO;
+	}
+}
+
 static int rzt2h_adc_read_avail(struct iio_dev *indio_dev,
 				struct iio_chan_spec const *chan,
 				const int **vals, int *type, int *length,
@@ -590,6 +700,11 @@ static int rzt2h_adc_read_avail(struct iio_dev *indio_dev,
 		*type = IIO_VAL_INT;
 		*length = ARRAY_SIZE(adc->samp_freq_avail);
 		return IIO_AVAIL_RANGE;
+	case IIO_CHAN_INFO_SCALE:
+		*vals = rzv2h_adc_scale_avail;
+		*type = IIO_VAL_FRACTIONAL_LOG2;
+		*length = ARRAY_SIZE(rzv2h_adc_scale_avail);
+		return IIO_AVAIL_LIST;
 	default:
 		return -EINVAL;
 	}
@@ -606,6 +721,14 @@ static const struct iio_info rzt2h_adc_iio_info = {
 	.read_avail = rzt2h_adc_read_avail,
 };
 
+static const struct iio_info rzv2h_adc_iio_info = {
+	.read_raw = rzt2h_adc_read_raw,
+	.write_raw = rzt2h_adc_write_raw,
+	.write_raw_get_fmt = rzt2h_adc_write_raw_get_fmt,
+	.read_avail = rzt2h_adc_read_avail,
+	.get_current_scan_type = rzt2h_adc_get_current_scan_type,
+};
+
 static irqreturn_t rzt2h_adc_isr(int irq, void *private)
 {
 	struct rzt2h_adc *adc = private;
@@ -630,6 +753,33 @@ static const struct iio_chan_spec rzt2h_adc_chan_template = {
 	},
 };
 
+static const struct iio_scan_type rzv2h_adc_scan_types[] = {
+	[RZT2H_ADC_RES_12BIT] = {
+		.sign = 'u',
+		.realbits = 12,
+		.storagebits = 16,
+		.endianness = IIO_CPU,
+	},
+	[RZT2H_ADC_RES_8BIT] = {
+		.sign = 'u',
+		.realbits = 8,
+		.storagebits = 16,
+		.endianness = IIO_CPU,
+	},
+};
+
+static const struct iio_chan_spec rzv2h_adc_chan_template = {
+	.indexed = 1,
+	.info_mask_separate = BIT(IIO_CHAN_INFO_RAW),
+	.info_mask_shared_by_type = BIT(IIO_CHAN_INFO_SCALE),
+	.info_mask_shared_by_type_available = BIT(IIO_CHAN_INFO_SCALE),
+	.info_mask_shared_by_all = BIT(IIO_CHAN_INFO_SAMP_FREQ),
+	.type = IIO_VOLTAGE,
+	.has_ext_scan_type = 1,
+	.ext_scan_type = rzv2h_adc_scan_types,
+	.num_ext_scan_type = ARRAY_SIZE(rzv2h_adc_scan_types),
+};
+
 static int rzt2h_adc_parse_properties(struct rzt2h_adc *adc)
 {
 	struct iio_chan_spec *chan_array;
@@ -698,6 +848,21 @@ static int rzt2h_adc_setup_dma(struct iio_dev *indio_dev)
 					       &rzt2h_adc_buffer_setup_ops, NULL);
 }
 
+static int rzt2h_adc_get_pwrseq(struct rzt2h_adc *adc)
+{
+	struct device *dev = adc->dev;
+
+	if (!(adc->chip_info->features & RZT2H_ADC_FEATURE_POWER_DOWN))
+		return 0;
+
+	adc->pwrseq = devm_pwrseq_get(dev, "adc-power");
+	if (IS_ERR(adc->pwrseq))
+		return dev_err_probe(dev, PTR_ERR(adc->pwrseq),
+				     "failed to get power sequencer\n");
+
+	return 0;
+}
+
 static int rzt2h_adc_probe(struct platform_device *pdev)
 {
 	const struct rzt2h_adc_chip_info *chip_info;
@@ -732,6 +897,10 @@ static int rzt2h_adc_probe(struct platform_device *pdev)
 	if (IS_ERR(adc->rstc))
 		return PTR_ERR(adc->rstc);
 
+	ret = rzt2h_adc_get_pwrseq(adc);
+	if (ret)
+		return ret;
+
 	ret = rzt2h_adc_parse_properties(adc);
 	if (ret)
 		return ret;
@@ -783,6 +952,14 @@ static int rzt2h_adc_probe(struct platform_device *pdev)
 	return devm_iio_device_register(dev, indio_dev);
 }
 
+static const struct rzt2h_adc_chip_info rzv2h_adc_info = {
+	.chan_template = &rzv2h_adc_chan_template,
+	.sst_to_freq = rzv2h_adc_sst_to_freq,
+	.info = &rzv2h_adc_iio_info,
+	.num_channels = 8,
+	.features = RZT2H_ADC_FEATURE_RES_SELECT | RZT2H_ADC_FEATURE_POWER_DOWN,
+};
+
 static const struct rzt2h_adc_chip_info rzt2h_adc_info = {
 	.chan_template = &rzt2h_adc_chan_template,
 	.sst_to_freq = rzt2h_adc_sst_to_freq,
@@ -792,6 +969,7 @@ static const struct rzt2h_adc_chip_info rzt2h_adc_info = {
 };
 
 static const struct of_device_id rzt2h_adc_match[] = {
+	{ .compatible = "renesas,r9a09g057-adc", .data = &rzv2h_adc_info },
 	{ .compatible = "renesas,r9a09g077-adc", .data = &rzt2h_adc_info },
 	{ }
 };
@@ -800,8 +978,17 @@ MODULE_DEVICE_TABLE(of, rzt2h_adc_match);
 static int rzt2h_adc_pm_runtime_suspend(struct device *dev)
 {
 	struct rzt2h_adc *adc = dev_get_drvdata(dev);
+	int ret;
+
+	ret = pwrseq_disable(adc->pwrseq);
+	if (ret)
+		return ret;
+
+	ret = reset_control_assert(adc->rstc);
+	if (ret)
+		pwrseq_enable(adc->pwrseq);
 
-	return reset_control_assert(adc->rstc);
+	return ret;
 }
 
 static int rzt2h_adc_pm_runtime_resume(struct device *dev)
@@ -814,6 +1001,12 @@ static int rzt2h_adc_pm_runtime_resume(struct device *dev)
 	if (ret)
 		return ret;
 
+	ret = pwrseq_enable(adc->pwrseq);
+	if (ret) {
+		reset_control_assert(adc->rstc);
+		return ret;
+	}
+
 	if (!(chip_info->features & RZT2H_ADC_FEATURE_CALIBRATION))
 		return 0;
 
@@ -825,8 +1018,10 @@ static int rzt2h_adc_pm_runtime_resume(struct device *dev)
 	fsleep(1);
 
 	ret = rzt2h_adc_calibrate(adc);
-	if (ret)
+	if (ret) {
+		pwrseq_disable(adc->pwrseq);
 		reset_control_assert(adc->rstc);
+	}
 
 	return ret;
 }
-- 
2.55.0

