Received: from esa.microchip.iphmx.com (esa.microchip.iphmx.com [68.232.153.233])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7D9EF3D3301;
	Tue, 23 Jun 2026 11:00:09 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=68.232.153.233
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1782212410; cv=none; b=Qc1qqG2GOJz8RjHlgBMMwtmdLjnORJn2n6nXuo2MCSpKkAkWpSijR7v+0GUsqbSDPjc9kc9ppW6d2se5nqxgYlftKOWIQkBx5h6M1SMQjAdRpnQHdk1SIB6MP4Trmx1fjKkz8mei+Fw9BASMmQ0DojFKYJel0PyX4HeL/aUjHGk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1782212410; c=relaxed/simple;
	bh=ze5tZw3w4M56ltt1q/sTy28a3TwaZwr09+r3Mhm+2F4=;
	h=From:To:CC:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=LXhMP2bCZC89WaNFbx+HfoG4BExhGh5AkPO9wJKXBlTlIYz+jgT6mvsXkCXmi45EpsnCCGVCeysRSUCLRnnTp7RnuLqJPJAnV9fig9xwnn1OxyFbfagnMbyMItAE8+g1h1uT1gGU3hlgu+7QWDbhFhXOrY4LElEO/9/POW8c+50=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=microchip.com; spf=pass smtp.mailfrom=microchip.com; dkim=pass (2048-bit key) header.d=microchip.com header.i=@microchip.com header.b=aPiETp4w; arc=none smtp.client-ip=68.232.153.233
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=microchip.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=microchip.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=microchip.com header.i=@microchip.com header.b="aPiETp4w"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=microchip.com; i=@microchip.com; q=dns/txt; s=mchp;
  t=1782212409; x=1813748409;
  h=from:to:cc:subject:date:message-id:in-reply-to:
   references:mime-version:content-transfer-encoding;
  bh=ze5tZw3w4M56ltt1q/sTy28a3TwaZwr09+r3Mhm+2F4=;
  b=aPiETp4wAMAMZnLUGPr3+hKy+GbHZVprzoXk/0qI9s7NPPx3sFDv+ckY
   Dt/r4F1hDujopRmdwV9MSc+/04cL5VAe0nLq1FN+P856lfQiPoj5GJFE0
   1DLMouxfKFKLh7OA9QW/HoWwM7XyD3RqT/IzABOvPkIgzOylalXWgLY3B
   OKQd0dwBWwpi46ULNbhwp22O4qzgnKZ2KJTYuB3KQdj4icF9Y2eta5jod
   Nv6JZN5eqDh83Gdy+sfzrehO2ZBrPv0K0yQpXFi2w1vVJ4Fll34jTpw8A
   ar9QuSQvNBD9QwLL+lSQ2sUy/YRjbNHMCm+06KBHwdvbX0/bPly1Pridf
   w==;
X-CSE-ConnectionGUID: XNTOYn36RUSid1JgeJkA0g==
X-CSE-MsgGUID: CiLUD8LsRL+AWq/xqvsyWg==
X-IronPort-AV: E=Sophos;i="6.24,220,1774335600"; 
   d="scan'208";a="68690062"
X-Amp-Result: SKIPPED(no attachment in message)
Received: from unknown (HELO email.microchip.com) ([170.129.1.10])
  by esa1.microchip.iphmx.com with ESMTP/TLS/ECDHE-RSA-AES128-GCM-SHA256; 23 Jun 2026 04:00:08 -0700
Received: from chn-vm-ex03.mchp-main.com (10.10.85.151) by
 chn-vm-ex04.mchp-main.com (10.10.85.152) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.58; Tue, 23 Jun 2026 04:00:08 -0700
Received: from che-ll-i67070.microchip.com (10.10.85.11) by
 chn-vm-ex03.mchp-main.com (10.10.85.151) with Microsoft SMTP Server id
 15.1.2507.58 via Frontend Transport; Tue, 23 Jun 2026 04:00:02 -0700
From: Varshini Rajendran <varshini.rajendran@microchip.com>
To: <ehristev@kernel.org>, <jic23@kernel.org>, <dlechner@baylibre.com>,
	<nuno.sa@analog.com>, <andy@kernel.org>, <robh@kernel.org>,
	<krzk+dt@kernel.org>, <conor+dt@kernel.org>, <nicolas.ferre@microchip.com>,
	<alexandre.belloni@bootlin.com>, <claudiu.beznea@tuxon.dev>,
	<srini@kernel.org>, <linux-iio@vger.kernel.org>,
	<devicetree@vger.kernel.org>, <linux-arm-kernel@lists.infradead.org>,
	<linux-kernel@vger.kernel.org>
CC: <varshini.rajendran@microchip.com>
Subject: [PATCH v2 02/12] iio: adc: at91-sama5d2_adc: rework temp calibration layout handling
Date: Tue, 23 Jun 2026 16:29:34 +0530
Message-ID: <20260623105944.128840-3-varshini.rajendran@microchip.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20260623105944.128840-1-varshini.rajendran@microchip.com>
References: <20260623105944.128840-1-varshini.rajendran@microchip.com>
Precedence: bulk
X-Mailing-List: linux-iio@vger.kernel.org
List-Id: <linux-iio.vger.kernel.org>
List-Subscribe: <mailto:linux-iio+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-iio+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain

Extend support to handle different temperature calibration layouts.

Add a temperature calibration data layout structure to describe indexes
of the factors P1, P4, P6, tag, minimum length of the packet and the
scaling factors for P1 (mul, div) which are SoC-specific instead of the
older non scalable id structure. This helps handle the differences in the
same function flow and prepare the calibration data to be applied. Add
additional condition to validate the calibration data read from the
NVMEM cell using the TAG of the packet.

Use cleanup helpers for NVMEM data buffer wherever applicable.

Signed-off-by: Varshini Rajendran <varshini.rajendran@microchip.com>
---
 drivers/iio/adc/at91-sama5d2_adc.c | 85 ++++++++++++++++++++----------
 1 file changed, 58 insertions(+), 27 deletions(-)

diff --git a/drivers/iio/adc/at91-sama5d2_adc.c b/drivers/iio/adc/at91-sama5d2_adc.c
index 255970b2e747..b569d175f4c3 100644
--- a/drivers/iio/adc/at91-sama5d2_adc.c
+++ b/drivers/iio/adc/at91-sama5d2_adc.c
@@ -445,6 +445,28 @@ static const struct at91_adc_reg_layout sama7g5_layout = {
 #define at91_adc_writel(st, reg, val)					\
 	writel_relaxed(val, (st)->base + (st)->soc_info.platform->layout->reg)
 
+#define AT91_TEMP_CALIB_TAG_ACST	0x41435354
+
+/**
+ * struct at91_adc_temp_calib_layout - temperature calibration packet layout
+ * @tag_idx:	index of Packet tag in the NVMEM cell buffer
+ * @p1_idx:	index of FT1_TEMP, equivalent to P1 in the NVMEM cell buffer
+ * @p4_idx:	index of FT1_VPAT, equivalent to P4 in the NVMEM cell buffer
+ * @p6_idx:	index of FT2_VBG, equivalent to P6 in the NVMEM cell buffer
+ * @min_len:	minimum number of u32 words expected in the NVMEM cell buffer
+ * @p1_mul:	multiplier applied to P1 to convert to millicelcius
+ * @p1_div:	divider applied to P1 to convert to millicelcius
+ */
+struct at91_adc_temp_calib_layout {
+	unsigned int tag_idx;
+	unsigned int p1_idx;
+	unsigned int p4_idx;
+	unsigned int p6_idx;
+	unsigned int min_len;
+	unsigned int p1_mul;
+	unsigned int p1_div;
+};
+
 /**
  * struct at91_adc_platform - at91-sama5d2 platform information struct
  * @layout:		pointer to the reg layout struct
@@ -464,6 +486,7 @@ static const struct at91_adc_reg_layout sama7g5_layout = {
  * @chan_realbits:	realbits for registered channels
  * @temp_chan:		temperature channel index
  * @temp_sensor:	temperature sensor supported
+ * @temp_calib_layout:  temperature calibration packet layout
  */
 struct at91_adc_platform {
 	const struct at91_adc_reg_layout	*layout;
@@ -481,6 +504,7 @@ struct at91_adc_platform {
 	unsigned int				chan_realbits;
 	unsigned int				temp_chan;
 	bool					temp_sensor;
+	const struct at91_adc_temp_calib_layout	*temp_calib_layout;
 };
 
 /**
@@ -496,18 +520,14 @@ struct at91_adc_temp_sensor_clb {
 	u32 p6;
 };
 
-/**
- * enum at91_adc_ts_clb_idx - calibration indexes in NVMEM buffer
- * @AT91_ADC_TS_CLB_IDX_P1: index for P1
- * @AT91_ADC_TS_CLB_IDX_P4: index for P4
- * @AT91_ADC_TS_CLB_IDX_P6: index for P6
- * @AT91_ADC_TS_CLB_IDX_MAX: max index for temperature calibration packet in OTP
- */
-enum at91_adc_ts_clb_idx {
-	AT91_ADC_TS_CLB_IDX_P1 = 2,
-	AT91_ADC_TS_CLB_IDX_P4 = 5,
-	AT91_ADC_TS_CLB_IDX_P6 = 7,
-	AT91_ADC_TS_CLB_IDX_MAX = 19,
+static const struct at91_adc_temp_calib_layout sama7g5_temp_calib = {
+	.tag_idx = 1,
+	.p1_idx = 2,
+	.p4_idx = 5,
+	.p6_idx = 7,
+	.min_len = 19,
+	.p1_mul = 1000,
+	.p1_div = 1,
 };
 
 /* Temperature sensor calibration - Vtemp voltage sensitivity to temperature. */
@@ -745,6 +765,7 @@ static const struct at91_adc_platform sama7g5_platform = {
 	.chan_realbits = 16,
 	.temp_sensor = true,
 	.temp_chan = AT91_SAMA7G5_ADC_TEMP_CHANNEL,
+	.temp_calib_layout = &sama7g5_temp_calib,
 };
 
 static int at91_adc_chan_xlate(struct iio_dev *indio_dev, int chan)
@@ -2251,13 +2272,19 @@ static int at91_adc_temp_sensor_init(struct at91_adc_state *st,
 {
 	struct at91_adc_temp_sensor_clb *clb = &st->soc_info.temp_sensor_clb;
 	struct nvmem_cell *temp_calib;
-	u32 *buf;
+	const struct at91_adc_temp_calib_layout *layout;
+	void *cell_data;
+	u32 *buf __free(kfree) = NULL;
 	size_t len;
 	int ret = 0;
 
 	if (!st->soc_info.platform->temp_sensor)
 		return 0;
 
+	layout = st->soc_info.platform->temp_calib_layout;
+	if (!layout || !layout->p1_div)
+		return -EINVAL;
+
 	/* Get the calibration data from NVMEM. */
 	temp_calib = nvmem_cell_get(dev, "temperature_calib");
 	if (IS_ERR(temp_calib)) {
@@ -2267,31 +2294,35 @@ static int at91_adc_temp_sensor_init(struct at91_adc_state *st,
 		return ret;
 	}
 
-	buf = nvmem_cell_read(temp_calib, &len);
+	cell_data = nvmem_cell_read(temp_calib, &len);
 	nvmem_cell_put(temp_calib);
-	if (IS_ERR(buf)) {
+	if (IS_ERR(cell_data)) {
 		dev_err(dev, "Failed to read calibration data!\n");
-		return PTR_ERR(buf);
+		return PTR_ERR(cell_data);
 	}
-	if (len < AT91_ADC_TS_CLB_IDX_MAX * 4) {
+
+	buf = cell_data;
+
+	if (len < layout->min_len * sizeof(*buf) ||
+	    buf[layout->tag_idx] != AT91_TEMP_CALIB_TAG_ACST) {
 		dev_err(dev, "Invalid calibration data!\n");
-		ret = -EINVAL;
-		goto free_buf;
+		return -EINVAL;
 	}
 
 	/* Store calibration data for later use. */
-	clb->p1 = buf[AT91_ADC_TS_CLB_IDX_P1];
-	clb->p4 = buf[AT91_ADC_TS_CLB_IDX_P4];
-	clb->p6 = buf[AT91_ADC_TS_CLB_IDX_P6];
+	clb->p1 = buf[layout->p1_idx];
+	clb->p4 = buf[layout->p4_idx];
+	clb->p6 = buf[layout->p6_idx];
 
 	/*
-	 * We prepare here the conversion to milli to avoid doing it on hotpath.
+	 * Here we prepare the conversion to milli to avoid doing it on hotpath.
+	 * The p1 value is multiplied and divided with a scaling factor as per
+	 * the SoC storage format described by per-platform calibration layout.
 	 */
-	clb->p1 = clb->p1 * 1000;
+	clb->p1 *= layout->p1_mul;
+	clb->p1 /= layout->p1_div;
 
-free_buf:
-	kfree(buf);
-	return ret;
+	return 0;
 }
 
 static int at91_adc_probe(struct platform_device *pdev)
-- 
2.34.1

