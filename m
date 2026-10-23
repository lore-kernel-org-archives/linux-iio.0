Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=209.85.221.51
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1792778380;
	b=WMf0Prr7BFAvUkppLwx1EBptlUhuAtdlLqUSM7RBugrjt258yEnPsWui6rDms8i0cHMI
	 3GsC1cfUu9xqmj8qbmjfJK3bHsPxjnO6Kw62zoxk2mndkiW7TL1BpGTjNkhZ/suYILVi1
	 goLmDjtwEVuBxGvOSVGUyyoJNgk9mXUj1uODUBk2gPrfYIJdhOMKXhk3F24AW16f8QPLF
	 MKWcVjBqIA1xarAGATYGBdi2P3eTgcTZxsIYNff/4z70dd16SbjhkeQu8spUXxzj1Ym7P
	 stB1s1z/BeNqrGb3rqv3mWACagleYJpVGkA0x85hrHOsN7O2VQOeTguGfatc/Cn8KZQ==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1792778380;
	h=DMARC-Filter:Received:DKIM-Signature:X-Google-DKIM-Signature:
	 X-Gm-Message-State:X-Gm-Gg:X-Received:Received:From:
	 X-Google-Original-From:To:Cc:Subject:Date:Message-ID:X-Mailer:
	 In-Reply-To:References:MIME-Version:Content-Transfer-Encoding;
	bh=HsASSsYkcsYXD5c9vRssQgLjjk2C9ftFBDoea0YZIyk=;
	b=zyNp2lg91BEB/0ncBKnqfdTh1RwOLkltxw5BM87VbJXYTlcfd7CMo/C0BLP/4t9XR+hT
	 dVxY3qybOibEZEkhla63545ujLxI5qY4/28LpRNAb5aUeXvuc/yNzfZxCgfmQFXtE28XL
	 NCTnHPo5fmMDBw/e2BQ/qMcVbrKLnS51ndZZtIrVXoBZKyPCe/GFdrDloPoXS7Gjgc7tZ
	 VIVoR7Uip3Yse2ry6qaa3sWZSL6xK8B/icbvPD7iMmU4henWZOP7CPLnPHNHi7J7YSNFE
	 LCnnsVnl74naGtp5tEsQfA7+uyJniR+j3FOVycR3QrLNll2WMDiB/EUCJRTSjVrkW6w==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=gmail.com;
	spf=pass smtp.mailfrom=gmail.com;
	dkim=pass header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20251104 header.b=OMxHs6oU;
	arc=none smtp.remote-ip=209.85.221.51
Received: from mail-wr1-f51.google.com (mail-wr1-f51.google.com [209.85.221.51])
	(using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 645AA60A380D
	for <linux-iio@vger.kernel.org>; Fri, 23 Oct 2026 17:59:34 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org 645AA60A380D
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20251104 header.b=OMxHs6oU
Received: by mail-wr1-f51.google.com with SMTP id ffacd0b85a97d-48e00eee27dso764987f8f.0
        for <linux-iio@vger.kernel.org>; Fri, 23 Oct 2026 10:59:34 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1792778373; x=1793383173; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=HsASSsYkcsYXD5c9vRssQgLjjk2C9ftFBDoea0YZIyk=;
        b=OMxHs6oUhvubJij7+kLnqMhKaWj1uTQLPLOlOZ6ercnKo2dZNpu6oxW2tv38LGay0t
         VVBQJEtWYpjDpruzg21QobnDYzJJNuLmZCHeWonkvTz/hXF43f0JFC4AtaEuWiUogFAU
         kolqriz7VCemQn7sqwxmTY74s3rpO/mcO7T8VSxCnBqhRFU7g+Ds3bMNbp010W2006eY
         2xiVFlSQLT8OspyGFyZKxX1ZYMGm0DcVZQX9NWMGjxtMT6wVKzS8BruSgOA7nASADetj
         YXPg9z7MSRVHSi8VCL/31y8Jpr1iul5WGLj6tGQd+yrrze0Va3wBVdujr/3G109b4JKE
         tSTQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1792778373; x=1793383173;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to:content-type;
        bh=HsASSsYkcsYXD5c9vRssQgLjjk2C9ftFBDoea0YZIyk=;
        b=Yagg6f24+77El+/jIhkXv0p2ec621vSTIlj04m4Z599Bb8aZhylTQ+OcQiFRIujqcb
         ASFeTxjsyeB6gJwYTPWC7SwX0Zmm0oLp5ykL/uR22eT3P2HhkMmptJZ41/Va2at0U++l
         FtCn6n4nhBUzyAFaytgeQYvcx2PRxexLDrxEMGuj3vCfKuFb+BMKMrANy1Upny7txbqW
         V9qr5NDIU5y43ZytRq/aGCXFO7vZ0CQccRDpXUQX8VBqiXZ5/d33/X1NiBkywqoXw6Iz
         Wflbj0Xg2C+olZo2+N9Y7YOTO6Lq9gn4ZU+xMBRyG2byYDm7xiSPRvup9im5zgDq4zeE
         ZwBA==
X-Gm-Message-State: AFq9FYL80sb/9FLXNtECysTyMPuVwc6kHK3wNLlZwSNgrswbogsrZPHx
	MmNk58/u4q+6lx3y+06J9PlGZU8+KSta1UP5Oap7x9fnvFykkAuiP+fj
X-Gm-Gg: AYBFou3raKfjUfv1fm5UgQ7HOzmq+YfLY62ZVb7IsY66+zeR5TtzRGLy7DkEAYpjoKW
	k+jgRrU6LcntRosHecBR223f88sEwR+/Dk/W17e+Dapy6VyIbYZXE8B4J1HDgfNFl7EWJzVKAeU
	q1oXrH0c4+Gcid6Cs56NNxHj6tR4Ey4AsHGYPlsVghqQH1dS6oZH0PZP0afCJVWNjSsEDhp8ejo
	CJma/SwzcIibY0uqLTuvsTQ6/B/acFm9Z9PtiPEInMnFFR7dD/m+bm24z7SRAFV96MnWC3Y68r0
	aZJGcHZTQBkxp8lbZ07RfiQiO7TRGgO2zORxy8iAs09XQjUAVJOAdHHvYrLS+niZR6IKoX2b81b
	Skb698dYMSiZ34o6JGTOuRfTbM+/A3xAXlLjkhVxcd8FvDB9BtyhZRZuGPobHlqe+Uhfxu+ybz1
	HGsO+vRxeCsGwbJBzPIVZC9AYE0YUx1ZXVnYYjZEbnvUcSOd8xAsCgZ81Z2svCVEUMblgb7iNwT
	+9rAA3mdnBwWkQv+XkTzNdR0k7Kw+MAdEWOUHkgzn7uG3NuxsUd5lajBD51iZLu+r7lPEy7l40C
	pAC+u444K/mez8XlIB9v6CoGiK1n1ZHrqPfaNTTLEyRT2RtiUXlRIiMRHZlQuw6qiQXoZkVqXbW
	NtxnmkF7fZs8INHqXrPEan6FVc5/EXwujZJEoDp0OkXcPP0TPsUvdpUrUNoZc/O/IXw==
X-Received: by 2002:a05:6000:2008:b0:48a:fb3e:d93c with SMTP id ffacd0b85a97d-48e3854e23bmr4739914f8f.5.1792778372641;
        Fri, 23 Oct 2026 10:59:32 -0700 (PDT)
Received: from iku.example.org (host86-133-9-17.range86-133.btcentralplus.com. [86.133.9.17])
        by smtp.gmail.com with ESMTPSA id ffacd0b85a97d-48e3d37ca2asm1342800f8f.8.2026.10.23.10.59.31
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 23 Oct 2026 10:59:32 -0700 (PDT)
From: Prabhakar <prabhakar.csengg@gmail.com>
X-Google-Original-From: Prabhakar <prabhakar.mahadev-lad.rj@bp.renesas.com>
To: Cosmin Tanislav <cosmin-gabriel.tanislav.xa@renesas.com>,
	Jonathan Cameron <jic23@kernel.org>,
	Andy Shevchenko <andy@kernel.org>,
	David Lechner <dlechner@baylibre.com>,
	=?UTF-8?q?Nuno=20S=C3=A1?= <nuno.sa@analog.com>,
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
Subject: [PATCH v3 8/8] iio: adc: rzt2h: Add support for RZ/V2H(P) SoC
Date: Fri, 23 Oct 2026 18:59:19 +0100
Message-ID: <20261023175919.160103-9-prabhakar.mahadev-lad.rj@bp.renesas.com>
X-Mailer: git-send-email 2.55.0
In-Reply-To: <20261023175919.160103-1-prabhakar.mahadev-lad.rj@bp.renesas.com>
References: <20261023175919.160103-1-prabhakar.mahadev-lad.rj@bp.renesas.com>
X-Mailing-List: linux-iio@vger.kernel.org
List-Id: <linux-iio.vger.kernel.org>
List-Post: <mailto:linux-iio@vger.kernel.org>
List-Help: <mailto:linux-iio+help@vger.kernel.org>
List-Subscribe: <mailto:linux-iio+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-iio+unsubscribe@vger.kernel.org>
List-Owner: <mailto:linux-iio+owner@vger.kernel.org>
Precedence: list
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
v2->v3:
- In rzt2h_adc_write_scale() used multiplication() operation
  for comparison by dropping the div_u64_rem.

v1->v2:
- Updated Kconfig description
- Included array_size.h
- Dropped unnecessary extra line in rzt2h_adc_write_scale
---
 drivers/iio/adc/Kconfig     |  10 +-
 drivers/iio/adc/rzt2h_adc.c | 199 +++++++++++++++++++++++++++++++++++-
 2 files changed, 203 insertions(+), 6 deletions(-)

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
index debd5873ed2a..c2b30a533a15 100644
--- a/drivers/iio/adc/rzt2h_adc.c
+++ b/drivers/iio/adc/rzt2h_adc.c
@@ -1,5 +1,6 @@
 // SPDX-License-Identifier: GPL-2.0
 
+#include <linux/array_size.h>
 #include <linux/bitfield.h>
 #include <linux/cleanup.h>
 #include <linux/clk.h>
@@ -16,11 +17,14 @@
 #include <linux/iopoll.h>
 #include <linux/kthread.h>
 #include <linux/math.h>
+#include <linux/math64.h>
 #include <linux/module.h>
 #include <linux/platform_device.h>
 #include <linux/pm_runtime.h>
 #include <linux/property.h>
+#include <linux/pwrseq/consumer.h>
 #include <linux/reset.h>
+#include <linux/units.h>
 #include <linux/time64.h>
 
 #define RZT2H_ADCSR_REG			0x00
@@ -33,6 +37,11 @@
 #define RZT2H_ADANSA0_REG		0x04
 #define RZT2H_ADANSA0_CH_MASK(x)	BIT(x)
 
+#define RZT2H_ADCER_REG			0x0e
+#define RZT2H_ADCER_ADPRC_MASK		GENMASK(2, 1)
+#define RZT2H_ADCER_ADPRC_12BIT		0b00
+#define RZT2H_ADCER_ADPRC_8BIT		0b10
+
 #define RZT2H_ADDR_REG(x)		(0x20 + 0x2 * (x))
 
 #define RZT2H_ADSSTRn(n)		(0xe0 + 0x1 * (n))
@@ -60,13 +69,29 @@
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
@@ -100,6 +125,7 @@ struct rzt2h_adc {
 	struct device *dev;
 	const struct rzt2h_adc_chip_info *chip_info;
 	struct reset_control *rstc;
+	struct pwrseq_desc *pwrseq;
 
 	phys_addr_t phys_base;
 	struct rzt2h_adc_dma dma;
@@ -108,6 +134,7 @@ struct rzt2h_adc {
 	struct mutex lock;
 
 	const struct iio_chan_spec *channels;
+	enum rzt2h_adc_resolution resolution;
 	unsigned int num_channels;
 	u16 buf[RZT2H_ADC_MAX_CHANNELS];
 
@@ -118,6 +145,11 @@ struct rzt2h_adc {
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
@@ -162,6 +194,23 @@ static void rzt2h_adc_set_sst(struct rzt2h_adc *adc, unsigned int ch, u8 sst)
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
@@ -178,12 +227,14 @@ static int rzt2h_adc_read_single(struct rzt2h_adc *adc, unsigned int ch, int *va
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
@@ -471,6 +522,8 @@ static int rzt2h_adc_buffer_postenable(struct iio_dev *indio_dev)
 
 	writew(val, adc->base + RZT2H_ADANSA0_REG);
 
+	rzt2h_adc_set_resolution(adc);
+
 	adc->dma.period_index = 0;
 	atomic_set(&adc->dma.pending_periods, 0);
 
@@ -508,6 +561,11 @@ static int rzt2h_adc_sst_to_freq(struct rzt2h_adc *adc, u8 sst)
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
@@ -520,6 +578,45 @@ static u8 rzt2h_adc_freq_to_sst(struct rzt2h_adc *adc, int freq)
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
+	u64 req_scale, scale;
+	unsigned int i;
+
+	if (!(adc->chip_info->features & RZT2H_ADC_FEATURE_RES_SELECT))
+		return -EINVAL;
+
+	req_scale = mul_u32_u32(val, NANO) + val2;
+	for (i = 0; i < chan->num_ext_scan_type; i++) {
+		scale = mul_u32_u32(RZT2H_ADC_VREF_mV, NANO) >>
+			chan->ext_scan_type[i].realbits;
+		if (scale == req_scale)
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
@@ -575,11 +672,25 @@ static int rzt2h_adc_write_raw(struct iio_dev *indio_dev,
 
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
@@ -593,6 +704,11 @@ static int rzt2h_adc_read_avail(struct iio_dev *indio_dev,
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
@@ -609,6 +725,14 @@ static const struct iio_info rzt2h_adc_iio_info = {
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
@@ -633,6 +757,33 @@ static const struct iio_chan_spec rzt2h_adc_chan_template = {
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
@@ -701,6 +852,21 @@ static int rzt2h_adc_setup_dma(struct iio_dev *indio_dev)
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
@@ -735,6 +901,10 @@ static int rzt2h_adc_probe(struct platform_device *pdev)
 	if (IS_ERR(adc->rstc))
 		return PTR_ERR(adc->rstc);
 
+	ret = rzt2h_adc_get_pwrseq(adc);
+	if (ret)
+		return ret;
+
 	ret = rzt2h_adc_parse_properties(adc);
 	if (ret)
 		return ret;
@@ -786,6 +956,14 @@ static int rzt2h_adc_probe(struct platform_device *pdev)
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
@@ -795,6 +973,7 @@ static const struct rzt2h_adc_chip_info rzt2h_adc_info = {
 };
 
 static const struct of_device_id rzt2h_adc_match[] = {
+	{ .compatible = "renesas,r9a09g057-adc", .data = &rzv2h_adc_info },
 	{ .compatible = "renesas,r9a09g077-adc", .data = &rzt2h_adc_info },
 	{ }
 };
@@ -805,9 +984,15 @@ static int rzt2h_adc_pm_runtime_suspend(struct device *dev)
 	struct rzt2h_adc *adc = dev_get_drvdata(dev);
 	int ret;
 
+	ret = pwrseq_disable(adc->pwrseq);
+	if (ret)
+		return ret;
+
 	ret = reset_control_assert(adc->rstc);
-	if (ret)
+	if (ret) {
+		pwrseq_enable(adc->pwrseq);
 		return ret;
+	}
 
 	return 0;
 }
@@ -822,6 +1007,12 @@ static int rzt2h_adc_pm_runtime_resume(struct device *dev)
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
 
@@ -833,8 +1024,10 @@ static int rzt2h_adc_pm_runtime_resume(struct device *dev)
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

