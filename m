Received: from mail-wr1-f44.google.com (mail-wr1-f44.google.com [209.85.221.44])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id BE9CB4FDA6F
	for <linux-iio@vger.kernel.org>; Fri,  9 Oct 2026 18:41:37 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.221.44
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1791571309; cv=none; b=hmUV4+K2EcN0fzhEELAibz+WGVmVB475HxR4J6B6xFQaBCHJoc5DaDvzlCEO7GkxIFWQFx0Eq//3TY1ywqOi6VJfImAKqqjwGGSFcEeCU6dj4tCENTxpe7+e5+e/orav74rxkWFNn14rW3SDY+5IrogvKXchFAtO3b09VnndIuw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1791571309; c=relaxed/simple;
	bh=M3THxPaiupoHDBfoF8EhLpuzItTibPd3Gkmj4uesrdI=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=iuIO9j21oeBqTTaku5WMEd0IKprZlixeDJNaRpL5/tQvOLnWb49auyUnf3Xx7mtSGkfMtvT1oqS+XPYt2BcpneQ7Ium6LCXAywaR8Q1Grw+AUxRgR/5jzdsYPYPpw1Xy2niRENmigIj0S4gW72i4B0JjiVK+9DedK1SYlIIVjdY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=lTicYtiY; arc=none smtp.client-ip=209.85.221.44
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="lTicYtiY"
Received: by mail-wr1-f44.google.com with SMTP id ffacd0b85a97d-48c4649b3aaso61869f8f.2
        for <linux-iio@vger.kernel.org>; Fri, 09 Oct 2026 11:41:37 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1791571296; x=1792176096; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=tEl0hA+WrG1ePKN2or71FBFdKVEXmpLINRNvObllAQk=;
        b=lTicYtiYhyMB/fqX4MFCUNzhn7mG8DrERtJmz8/AstbSLrs8D8+7KvdUIRaYwy2540
         33EaDIfLOLmSFLUFL+3nQAcvHSSUBGS36rZe+3IFi5irqMqxjTj23wBtsTJ7BngT/Eew
         rUG/aled1TCtZeZXV38By4XE0YuQw5vxKtzhh1JBJZuRNBadSdlwJF7iv7Q7U7znvwls
         Uv1LB7e2WomKGKYtWUEhMrigfIDbGW2csX3DrI4Mw04XfE6OUCcpxJQ4dw62z0lWTU7H
         9OyThiKPpMU/7gjKIXZH38XQ4AaD8+zhhvnaqzjMIe9RPPBLlosg5LkYHSvW6B4fjK9J
         Fizg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1791571296; x=1792176096;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to:content-type;
        bh=tEl0hA+WrG1ePKN2or71FBFdKVEXmpLINRNvObllAQk=;
        b=mHhJYgRHn2eYsSdGsrErG48Qw3ddAuhFz4WmlkHjNWGp76i5TctxW7g3cbPFIOI+uP
         mchiOR4DGdi3XPp+pR5UkMSCiHt8BlDDKZEj5OggFAyi+bWrbZWJYUZTLP0vlfanAoce
         bVmveiOgouKVMY4lThBQSQLztui+8cM2TzGe7v7oGjmaH5O/njuTaPF13OJj8+jUs48f
         7AHdqiRObo3WsPu7lxYwpqH6dixtZ6+xaRqguo0jMb1v2kvnguVhshYVjPsBKHDocREn
         df7uTJcqfHkoEPeNXztk4cjIYG9mmNuD+GhfuoGvOweHn6KxMCh1HLp/soTOrN1wgruu
         3eSg==
X-Gm-Message-State: AFuF++nP3JRH1KjAF/UbWi935hAStQtWCvnfr/rEC/ua8C5YQBDITckr
	xmT6YqSlGqZMJLtJYvidmQVD9tRRdFCqIYbDPg4ygBS3wlMQEbN7umqb
X-Gm-Gg: AYBFou0hVhoxChXJCWVX6PEyjatZ85IzlMXq9V4VH08rF5rPX/37ROA82ju4r2wrOvI
	hFsrNkRoutPL1mHHUoVnMQVIDQRdHRxonNIOQhtTa53JR0D/uLFM0mkpxEeA1lH7lkf5d5umvZM
	dDitszJYgfMDwkxa45YIVGG7NunYn+ygd7VVDboNC/KT2/+waeYgBqkYMw6czQF8HSLm9/0lHje
	s5dd/PXke6dmGY4k+KiqGfb0HT/tx/oFY3tHxZLatNpovARs0uwA9yvinlAvKsMeetMWYfsdski
	BEriqwZgoYgxVXCrwgABwXplKSRU5CE4+DHuS4rI4mORFzI5iIBGcWJYo6DqSj/F66wjMG01Tuk
	SI7HP1cQFFLwIsZ0aelgTJ4hpCBYUcx4+PYFUrD3dGsopPzOu85aZ6ljGNhIWIbveEMYyXolof8
	MLtRSwUrtFSjuTaBCKvCStW9Q+g2yrPC4WCcqqUM1LI0pFFbAb3CCQicivFy/x/25S1mAds4PYU
	dPCmHQBN3IEzdXQwbY939GmNlV+Igca1d6gGYP7FHQsDohS+gb/IHG9SjcO3JDGrpsyQKFQc55o
	2nvuf8OjSo+wV8flWg==
X-Received: by 2002:a05:600c:4688:b0:49f:f963:7093 with SMTP id 5b1f17b1804b1-4a18e4ce84cmr58943675e9.23.1791571295695;
        Fri, 09 Oct 2026 11:41:35 -0700 (PDT)
Received: from iku.example.org ([2a06:5906:61b:2d00:e93d:161b:5ff8:cb57])
        by smtp.gmail.com with ESMTPSA id 5b1f17b1804b1-4a18e4225f4sm91761705e9.0.2026.10.09.11.41.34
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 09 Oct 2026 11:41:35 -0700 (PDT)
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
	Magnus Damm <magnus.damm@gmail.com>
Cc: linux-iio@vger.kernel.org,
	linux-renesas-soc@vger.kernel.org,
	devicetree@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	Prabhakar <prabhakar.csengg+renesas@gmail.com>,
	Biju Das <biju.das.jz@bp.renesas.com>,
	Fabrizio Castro <fabrizio.castro.jz@renesas.com>,
	Lad Prabhakar <prabhakar.mahadev-lad.rj@bp.renesas.com>
Subject: [PATCH v2 8/8] iio: adc: rzt2h: Add support for RZ/V2H(P) SoC
Date: Fri,  9 Oct 2026 19:41:22 +0100
Message-ID: <20261009184122.1378797-9-prabhakar.mahadev-lad.rj@bp.renesas.com>
X-Mailer: git-send-email 2.55.0
In-Reply-To: <20261009184122.1378797-1-prabhakar.mahadev-lad.rj@bp.renesas.com>
References: <20261009184122.1378797-1-prabhakar.mahadev-lad.rj@bp.renesas.com>
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
v1->v2:
- Updated Kconfig description
- Included array_size.h
- Dropped unnecessary extra line in rzt2h_adc_write_scale
---
 drivers/iio/adc/Kconfig     |  10 +-
 drivers/iio/adc/rzt2h_adc.c | 201 +++++++++++++++++++++++++++++++++++-
 2 files changed, 205 insertions(+), 6 deletions(-)

diff --git a/drivers/iio/adc/Kconfig b/drivers/iio/adc/Kconfig
index a802d8ee4dd9..9a58f8b5868b 100644
--- a/drivers/iio/adc/Kconfig
+++ b/drivers/iio/adc/Kconfig
@@ -1587,14 +1587,18 @@ config RZN1_ADC
 	  module will be called rzn1-adc.
 
 config RZT2H_ADC
-	tristate "Renesas RZ/T2H / RZ/N2H ADC driver"
+	tristate "Renesas RZ/T2H / RZ/N2H (and similar SoCs) ADC driver"
 	depends on ARCH_RENESAS || COMPILE_TEST
 	select IIO_ADC_HELPER
 	select IIO_BUFFER
 	select IIO_KFIFO_BUF
+	select POWER_SEQUENCING
 	help
-	  Say yes here to build support for the ADC found in Renesas
-	  RZ/T2H / RZ/N2H SoCs.
+	  Say yes here to build support for the ADC found in Renesas SoCs:
+	  - RZ/N2H
+	  - RZ/T2H
+	  - RZ/V2H(P)
+	  - RZ/V2N
 
 	  To compile this driver as a module, choose M here: the
 	  module will be called rzt2h_adc.
diff --git a/drivers/iio/adc/rzt2h_adc.c b/drivers/iio/adc/rzt2h_adc.c
index 0703c2025e3f..be8273f3b61d 100644
--- a/drivers/iio/adc/rzt2h_adc.c
+++ b/drivers/iio/adc/rzt2h_adc.c
@@ -1,5 +1,6 @@
 // SPDX-License-Identifier: GPL-2.0
 
+#include <linux/array_size.h>
 #include <linux/bitfield.h>
 #include <linux/cleanup.h>
 #include <linux/clk.h>
@@ -20,7 +21,9 @@
 #include <linux/platform_device.h>
 #include <linux/pm_runtime.h>
 #include <linux/property.h>
+#include <linux/pwrseq/consumer.h>
 #include <linux/reset.h>
+#include <linux/units.h>
 #include <linux/time64.h>
 
 #define RZT2H_ADCSR_REG			0x00
@@ -33,6 +36,11 @@
 #define RZT2H_ADANSA0_REG		0x04
 #define RZT2H_ADANSA0_CH_MASK(x)	BIT(x)
 
+#define RZT2H_ADCER_REG			0x0e
+#define RZT2H_ADCER_ADPRC_MASK		GENMASK(2, 1)
+#define RZT2H_ADCER_ADPRC_12BIT		0b00
+#define RZT2H_ADCER_ADPRC_8BIT		0b10
+
 #define RZT2H_ADDR_REG(x)		(0x20 + 0x2 * (x))
 
 #define RZT2H_ADSSTRn(n)		(0xe0 + 0x1 * (n))
@@ -60,13 +68,29 @@
 					 RZT2H_ADC_DMA_PERIOD_SAMPLES)
 #define RZT2H_ADC_STOP_CYCLES		2
 
+/*
+ * RZ/V2H has no sample state register, each A/D channel conversion takes a
+ * fixed 20 ADCLK cycles (sampling + comparison), giving a conversion rate of
+ * ADCLK / 20.
+ */
+#define RZV2H_ADC_CONV_CYCLES		20
+
 #define RZT2H_ADC_VREF_mV		1800
 
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
@@ -100,6 +124,7 @@ struct rzt2h_adc {
 	struct device *dev;
 	const struct rzt2h_adc_chip_info *chip_info;
 	struct reset_control *rstc;
+	struct pwrseq_desc *pwrseq;
 
 	phys_addr_t phys_base;
 	struct rzt2h_adc_dma dma;
@@ -108,6 +133,7 @@ struct rzt2h_adc {
 	struct mutex lock;
 
 	const struct iio_chan_spec *channels;
+	enum rzt2h_adc_resolution resolution;
 	unsigned int num_channels;
 	u16 buf[RZT2H_ADC_MAX_CHANNELS];
 
@@ -118,6 +144,11 @@ struct rzt2h_adc {
 	int irq;
 };
 
+static const int rzv2h_adc_scale_avail[] = {
+	RZT2H_ADC_VREF_mV, 12,
+	RZT2H_ADC_VREF_mV, 8,
+};
+
 static void rzt2h_adc_start(struct rzt2h_adc *adc, unsigned int conversion_type)
 {
 	u16 reg;
@@ -163,6 +194,23 @@ static void rzt2h_adc_set_sst(struct rzt2h_adc *adc, unsigned int ch, u8 sst)
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
@@ -179,12 +227,14 @@ static int rzt2h_adc_read_single(struct rzt2h_adc *adc, unsigned int ch, int *va
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
@@ -472,6 +522,8 @@ static int rzt2h_adc_buffer_postenable(struct iio_dev *indio_dev)
 
 	writew(val, adc->base + RZT2H_ADANSA0_REG);
 
+	rzt2h_adc_set_resolution(adc);
+
 	adc->dma.period_index = 0;
 	atomic_set(&adc->dma.pending_periods, 0);
 
@@ -509,6 +561,11 @@ static int rzt2h_adc_sst_to_freq(struct rzt2h_adc *adc, u8 sst)
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
@@ -521,6 +578,45 @@ static u8 rzt2h_adc_freq_to_sst(struct rzt2h_adc *adc, int freq)
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
+		scale = (u64)RZT2H_ADC_VREF_mV * NANO >>
+			chan->ext_scan_type[i].realbits;
+		if (div_u64_rem(scale, NANO, &rem) == val && rem == val2)
+			break;
+	}
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
@@ -576,11 +672,25 @@ static int rzt2h_adc_write_raw(struct iio_dev *indio_dev,
 
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
@@ -594,6 +704,11 @@ static int rzt2h_adc_read_avail(struct iio_dev *indio_dev,
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
@@ -610,6 +725,14 @@ static const struct iio_info rzt2h_adc_iio_info = {
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
@@ -634,6 +757,33 @@ static const struct iio_chan_spec rzt2h_adc_chan_template = {
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
@@ -702,6 +852,21 @@ static int rzt2h_adc_setup_dma(struct iio_dev *indio_dev)
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
@@ -736,6 +901,10 @@ static int rzt2h_adc_probe(struct platform_device *pdev)
 	if (IS_ERR(adc->rstc))
 		return PTR_ERR(adc->rstc);
 
+	ret = rzt2h_adc_get_pwrseq(adc);
+	if (ret)
+		return ret;
+
 	ret = rzt2h_adc_parse_properties(adc);
 	if (ret)
 		return ret;
@@ -787,6 +956,14 @@ static int rzt2h_adc_probe(struct platform_device *pdev)
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
@@ -796,6 +973,7 @@ static const struct rzt2h_adc_chip_info rzt2h_adc_info = {
 };
 
 static const struct of_device_id rzt2h_adc_match[] = {
+	{ .compatible = "renesas,r9a09g057-adc", .data = &rzv2h_adc_info },
 	{ .compatible = "renesas,r9a09g077-adc", .data = &rzt2h_adc_info },
 	{ }
 };
@@ -804,8 +982,17 @@ MODULE_DEVICE_TABLE(of, rzt2h_adc_match);
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
@@ -818,6 +1005,12 @@ static int rzt2h_adc_pm_runtime_resume(struct device *dev)
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
 
@@ -829,8 +1022,10 @@ static int rzt2h_adc_pm_runtime_resume(struct device *dev)
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

