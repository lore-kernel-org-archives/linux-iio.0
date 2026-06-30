Received: from esa.microchip.iphmx.com (esa.microchip.iphmx.com [68.232.154.123])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id DA5C940D580;
	Tue, 30 Jun 2026 09:37:11 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=68.232.154.123
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1782812233; cv=none; b=hj6LntFvJdEtSsD3N8AbbUCk9rMNsmOgr3x72lwVUSgoi93qGHWqE/AIy6YlZK0mn+6LKr8SfQ0bZ74RFPPMqDFqIk43Jm+9bxJrpU/y8TZFbkQSIe4/784VOMTqkhZnzCGhs8YDwuqWD1oElzfv9bpEk+XAi/5mDsmKmqGewyE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1782812233; c=relaxed/simple;
	bh=HWjobEVV/DWB+4/iozjTvLRIIlCBYW8DxiEGCxnBV0o=;
	h=From:To:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=T+sEttbJOaxnCGVKOWtwFii0S+S80zIQYOFQ3UHARbp8+I4b1dBBcGAu9xiEeNh7vcFf1iOJxQ3tQuJ13mK19iuKFZSes7BEBGoigKlGl42ZcNLdM70CS9ninHgwvA3SXTG6Cp5gg/HVZV7t75WM9yAxA8qodtZlbP9KxdIfNms=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=microchip.com; spf=pass smtp.mailfrom=microchip.com; dkim=pass (2048-bit key) header.d=microchip.com header.i=@microchip.com header.b=hFBZAE+W; arc=none smtp.client-ip=68.232.154.123
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=microchip.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=microchip.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=microchip.com header.i=@microchip.com header.b="hFBZAE+W"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=microchip.com; i=@microchip.com; q=dns/txt; s=mchp;
  t=1782812231; x=1814348231;
  h=from:to:subject:date:message-id:in-reply-to:references:
   mime-version:content-transfer-encoding;
  bh=HWjobEVV/DWB+4/iozjTvLRIIlCBYW8DxiEGCxnBV0o=;
  b=hFBZAE+WjRvrZJru+6CyXNXjiMZfWmHzk6SlhCpcsiqzyLgBNYRsgtdQ
   KzcKg2WaK0xuu2Ouq9JYOY01/PAmjbC49hTDsVy9wj5QrqAN1BE8h3cVO
   Mg+/Ct+b1/AfmFu2TZcDe+oG5BhNNG8t5I7z+PeQzRFaG9AaB2wP8JzIW
   2hB8XFihy14iVqoXYpf2zpfsrf/2epSAaQ1k3b02We8su9P28HMVbTjMe
   WFpxb8ls9lRXfUeLGfl/KqidtuQUz4qBIu3G9NWyht04t47xe4MvgRRgr
   67rqHspf4/S6nt8+Qs/hZ+vxmQcbhoKKI+8Q4pPiLTqkd71QEW7ClBXvS
   g==;
X-CSE-ConnectionGUID: mOt5XWgTSauewdfaDrJZsg==
X-CSE-MsgGUID: YU5tEAK9RcKIeSfUHSQw1g==
X-IronPort-AV: E=Sophos;i="6.24,233,1774335600"; 
   d="scan'208";a="59032660"
X-Amp-Result: SKIPPED(no attachment in message)
Received: from unknown (HELO email.microchip.com) ([170.129.1.10])
  by esa4.microchip.iphmx.com with ESMTP/TLS/ECDHE-RSA-AES128-GCM-SHA256; 30 Jun 2026 02:37:10 -0700
Received: from chn-vm-ex02.mchp-main.com (10.10.85.144) by
 chn-vm-ex04.mchp-main.com (10.10.85.152) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.58; Tue, 30 Jun 2026 02:37:10 -0700
Received: from che-ll-i67070.microchip.com (10.10.85.11) by
 chn-vm-ex02.mchp-main.com (10.10.85.144) with Microsoft SMTP Server id
 15.1.2507.58 via Frontend Transport; Tue, 30 Jun 2026 02:37:01 -0700
From: Varshini Rajendran <varshini.rajendran@microchip.com>
To: <ehristev@kernel.org>, <jic23@kernel.org>, <dlechner@baylibre.com>,
	<nuno.sa@analog.com>, <andy@kernel.org>, <robh@kernel.org>,
	<krzk+dt@kernel.org>, <conor+dt@kernel.org>, <nicolas.ferre@microchip.com>,
	<alexandre.belloni@bootlin.com>, <claudiu.beznea@tuxon.dev>,
	<srini@kernel.org>, <marcelo.schmitt@analog.com>, <jorge.marques@analog.com>,
	<mazziesaccount@gmail.com>, <Jonathan.Santos@analog.com>,
	<jishnu.prakash@oss.qualcomm.com>, <antoniu.miclaus@analog.com>,
	<duje@dujemihanovic.xyz>, <varshini.rajendran@microchip.com>,
	<linux-iio@vger.kernel.org>, <devicetree@vger.kernel.org>,
	<linux-arm-kernel@lists.infradead.org>, <linux-kernel@vger.kernel.org>
Subject: [PATCH v3 03/13] iio: adc: at91-sama5d2_adc: rework temp calibration layout handling
Date: Tue, 30 Jun 2026 15:05:53 +0530
Message-ID: <20260630093603.38663-4-varshini.rajendran@microchip.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20260630093603.38663-1-varshini.rajendran@microchip.com>
References: <20260630093603.38663-1-varshini.rajendran@microchip.com>
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

Signed-off-by: Varshini Rajendran <varshini.rajendran@microchip.com>
---
 drivers/iio/adc/at91-sama5d2_adc.c | 67 ++++++++++++++++++++++--------
 1 file changed, 49 insertions(+), 18 deletions(-)

diff --git a/drivers/iio/adc/at91-sama5d2_adc.c b/drivers/iio/adc/at91-sama5d2_adc.c
index 5015c234289e..2a25165bc874 100644
--- a/drivers/iio/adc/at91-sama5d2_adc.c
+++ b/drivers/iio/adc/at91-sama5d2_adc.c
@@ -445,6 +445,29 @@ static const struct at91_adc_reg_layout sama7g5_layout = {
 #define at91_adc_writel(st, reg, val)					\
 	writel_relaxed(val, (st)->base + (st)->soc_info.platform->layout->reg)
 
+/* Temperature calibration tag "ACST" in ASCII */
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
@@ -463,6 +486,7 @@ static const struct at91_adc_reg_layout sama7g5_layout = {
  * @oversampling_avail_no: number of available oversampling values
  * @chan_realbits:	realbits for registered channels
  * @temp_chan:		temperature channel index
+ * @temp_calib_layout:  temperature calibration packet layout
  * @temp_sensor:	temperature sensor supported
  */
 struct at91_adc_platform {
@@ -480,6 +504,7 @@ struct at91_adc_platform {
 	unsigned int				oversampling_avail_no;
 	unsigned int				chan_realbits;
 	unsigned int				temp_chan;
+	const struct at91_adc_temp_calib_layout	*temp_calib_layout;
 	bool					temp_sensor;
 };
 
@@ -496,18 +521,14 @@ struct at91_adc_temp_sensor_clb {
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
@@ -745,6 +766,7 @@ static const struct at91_adc_platform sama7g5_platform = {
 	.chan_realbits = 16,
 	.temp_sensor = true,
 	.temp_chan = AT91_SAMA7G5_ADC_TEMP_CHANNEL,
+	.temp_calib_layout = &sama7g5_temp_calib,
 };
 
 static int at91_adc_chan_xlate(struct iio_dev *indio_dev, int chan)
@@ -2250,6 +2272,7 @@ static int at91_adc_temp_sensor_init(struct at91_adc_state *st,
 				     struct device *dev)
 {
 	struct at91_adc_temp_sensor_clb *clb = &st->soc_info.temp_sensor_clb;
+	const struct at91_adc_temp_calib_layout *layout;
 	struct nvmem_cell *temp_calib;
 	u32 *buf __free(kfree) = NULL;
 	void *cell_data;
@@ -2259,6 +2282,10 @@ static int at91_adc_temp_sensor_init(struct at91_adc_state *st,
 	if (!st->soc_info.platform->temp_sensor)
 		return 0;
 
+	layout = st->soc_info.platform->temp_calib_layout;
+	if (!layout || !layout->p1_div)
+		return -EINVAL;
+
 	/* Get the calibration data from NVMEM. */
 	temp_calib = nvmem_cell_get(dev, "temperature_calib");
 	if (IS_ERR(temp_calib)) {
@@ -2277,20 +2304,24 @@ static int at91_adc_temp_sensor_init(struct at91_adc_state *st,
 
 	buf = cell_data;
 
-	if (len < AT91_ADC_TS_CLB_IDX_MAX * 4) {
+	if (len < layout->min_len * sizeof(*buf) ||
+	    buf[layout->tag_idx] != AT91_TEMP_CALIB_TAG_ACST) {
 		dev_err(dev, "Invalid calibration data!\n");
 		return -EINVAL;
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
 
 	return 0;
 }
-- 
2.34.1

