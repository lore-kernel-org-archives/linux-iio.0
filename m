Received: from esa.microchip.iphmx.com (esa.microchip.iphmx.com [68.232.153.233])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A19803FDBF5;
	Mon, 27 Jul 2026 12:27:38 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=68.232.153.233
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1785155260; cv=none; b=qfGiGWRdYXXLGRgxdgyNL6SNM+iCRNgq/8LxHJIRrdAbgpdas1/GAQwVs4iWWYIbEVbvslSWD/t2CdDyrH9ejvSSmQVV1wSUfjH5F104aiDLTCYAvXaciZ3b+Z4BX7NYbKe1+s5Ke/lSYXy9Co+8oEtEfthf1pqgz01e23piaoc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1785155260; c=relaxed/simple;
	bh=pVFOZevFakd5Gm/92xP58/1LjCv/xOINaboGFg4D4bA=;
	h=From:To:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=AcFeqUI70dT3dBZ13aao8mgNNYHXFMUTu/oGOXJad2cjfo6g5h3hOaWtPc0W4W6LYkusBWFUeysq5UYW2tfKcunXx3Pvi0/RH4lTaS6SHtQv1hRvYkqsf/RLq146Nt0CG/Zuqw9Ve1yawSsweQOEdxo+uwSP1581JFmd1hIIhfw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=microchip.com; spf=pass smtp.mailfrom=microchip.com; dkim=pass (2048-bit key) header.d=microchip.com header.i=@microchip.com header.b=Pl12gwwN; arc=none smtp.client-ip=68.232.153.233
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=microchip.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=microchip.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=microchip.com header.i=@microchip.com header.b="Pl12gwwN"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=microchip.com; i=@microchip.com; q=dns/txt; s=mchp;
  t=1785155259; x=1816691259;
  h=from:to:subject:date:message-id:in-reply-to:references:
   mime-version:content-transfer-encoding;
  bh=pVFOZevFakd5Gm/92xP58/1LjCv/xOINaboGFg4D4bA=;
  b=Pl12gwwN+aDkqx2wXMVawwIkKzdT1FYX1ZEp6vTOAmda8tQubjzFAYlk
   qZnmgy4SZH6UjAqg4/z56QAnOh7Yrbrbd3UCEhSHIxPYSUttx3rimCnfc
   sqSILuPb3XvY+hXuWcw8vGNQq2wqedzOYiNyhvOTgr2zVOmJI0bBmegbM
   WeEzTwByKRvS+EPaasnAfq7TkaH6VcHFrH+LWd6hnuZ1pB7BQ5+2cYo6H
   onBO10iAZLa+F7yLVws+/3G1sxbt8u0fN0XSoAsmqd0iVqeThjzHCUL9k
   YzFw0sPMo0xSA84/RcfFq0T7qOCcxhdWqw/b8KO9NDDG8XWyDAKxi3QgQ
   Q==;
X-CSE-ConnectionGUID: Ezh773ZLSHaPRd+fUiBaaQ==
X-CSE-MsgGUID: J+cO06IDTlaeVHEF/uittw==
X-IronPort-AV: E=Sophos;i="6.25,188,1779174000"; 
   d="scan'208";a="292591670"
X-Amp-Result: SKIPPED(no attachment in message)
Received: from unknown (HELO email.microchip.com) ([170.129.1.10])
  by esa5.microchip.iphmx.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 27 Jul 2026 05:27:20 -0700
Received: from chn-vm-ex01.mchp-main.com (10.10.87.71) by
 chn-vm-ex4.mchp-main.com (10.10.87.33) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.2.2562.43; Mon, 27 Jul 2026 05:27:19 -0700
Received: from che-ll-i67070.microchip.com (10.10.85.11) by
 chn-vm-ex01.mchp-main.com (10.10.85.143) with Microsoft SMTP Server id
 15.1.2507.58 via Frontend Transport; Mon, 27 Jul 2026 05:27:08 -0700
From: Varshini Rajendran <varshini.rajendran@microchip.com>
To: <ehristev@kernel.org>, <jic23@kernel.org>, <dlechner@baylibre.com>,
	<nuno.sa@analog.com>, <andy@kernel.org>, <robh@kernel.org>,
	<krzk+dt@kernel.org>, <conor+dt@kernel.org>, <nicolas.ferre@microchip.com>,
	<alexandre.belloni@bootlin.com>, <claudiu.beznea@tuxon.dev>,
	<srini@kernel.org>, <marcelo.schmitt@analog.com>, <radu.sabau@analog.com>,
	<Jonathan.Santos@analog.com>, <jorge.marques@analog.com>,
	<joshua.crofts1@gmail.com>, <jishnu.prakash@oss.qualcomm.com>,
	<antoniu.miclaus@analog.com>, <varshini.rajendran@microchip.com>,
	<mazziesaccount@gmail.com>, <linux-iio@vger.kernel.org>,
	<devicetree@vger.kernel.org>, <linux-arm-kernel@lists.infradead.org>,
	<linux-kernel@vger.kernel.org>
Subject: [PATCH v4 03/16] iio: adc: at91-sama5d2_adc: rework temp calibration layout handling
Date: Mon, 27 Jul 2026 17:56:20 +0530
Message-ID: <20260727122633.117435-4-varshini.rajendran@microchip.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20260727122633.117435-1-varshini.rajendran@microchip.com>
References: <20260727122633.117435-1-varshini.rajendran@microchip.com>
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
scaling factors for P1 (p1_scale) which are SoC-specific instead of the
older non scalable id structure. This helps handle the differences in the
same function flow and prepare the calibration data to be applied.

Signed-off-by: Varshini Rajendran <varshini.rajendran@microchip.com>
---
 drivers/iio/adc/at91-sama5d2_adc.c | 66 ++++++++++++++++++++++--------
 1 file changed, 48 insertions(+), 18 deletions(-)

diff --git a/drivers/iio/adc/at91-sama5d2_adc.c b/drivers/iio/adc/at91-sama5d2_adc.c
index 4a4a25f3c715..798e4d60bf69 100644
--- a/drivers/iio/adc/at91-sama5d2_adc.c
+++ b/drivers/iio/adc/at91-sama5d2_adc.c
@@ -16,6 +16,7 @@
 #include <linux/dmaengine.h>
 #include <linux/interrupt.h>
 #include <linux/io.h>
+#include <linux/math.h>
 #include <linux/module.h>
 #include <linux/platform_device.h>
 #include <linux/property.h>
@@ -446,6 +447,27 @@ static const struct at91_adc_reg_layout sama7g5_layout = {
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
+ * @p1_scale:	scaling factor applied to P1 to convert to millicelcius
+ */
+struct at91_adc_temp_calib_layout {
+	unsigned int tag_idx;
+	unsigned int p1_idx;
+	unsigned int p4_idx;
+	unsigned int p6_idx;
+	unsigned int min_len;
+	struct u32_fract p1_scale;
+};
+
 /**
  * struct at91_adc_platform - at91-sama5d2 platform information struct
  * @layout:		pointer to the reg layout struct
@@ -464,6 +486,7 @@ static const struct at91_adc_reg_layout sama7g5_layout = {
  * @oversampling_avail_no: number of available oversampling values
  * @chan_realbits:	realbits for registered channels
  * @temp_chan:		temperature channel index
+ * @temp_calib_layout:	temperature calibration packet layout
  * @temp_sensor:	temperature sensor supported
  */
 struct at91_adc_platform {
@@ -481,6 +504,7 @@ struct at91_adc_platform {
 	unsigned int				oversampling_avail_no;
 	unsigned int				chan_realbits;
 	unsigned int				temp_chan;
+	const struct at91_adc_temp_calib_layout	*temp_calib_layout;
 	bool					temp_sensor;
 };
 
@@ -497,18 +521,13 @@ struct at91_adc_temp_sensor_clb {
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
+	.p1_scale = { .numerator = 1000, .denominator = 1 },
 };
 
 /* Temperature sensor calibration - Vtemp voltage sensitivity to temperature. */
@@ -746,6 +765,7 @@ static const struct at91_adc_platform sama7g5_platform = {
 	.chan_realbits = 16,
 	.temp_sensor = true,
 	.temp_chan = AT91_SAMA7G5_ADC_TEMP_CHANNEL,
+	.temp_calib_layout = &sama7g5_temp_calib,
 };
 
 static int at91_adc_chan_xlate(struct iio_dev *indio_dev, int chan)
@@ -2251,11 +2271,18 @@ static int at91_adc_temp_sensor_init(struct at91_adc_state *st,
 				     struct device *dev)
 {
 	struct at91_adc_temp_sensor_clb *clb = &st->soc_info.temp_sensor_clb;
+	const struct at91_adc_temp_calib_layout *layout;
 	size_t len;
 
 	if (!st->soc_info.platform->temp_sensor)
 		return 0;
 
+	layout = st->soc_info.platform->temp_calib_layout;
+	if (!layout)
+		return -ENODEV;
+	if (!layout->p1_scale.denominator)
+		return -EINVAL;
+
 	/* Get the calibration data from NVMEM. */
 	struct nvmem_cell *temp_calib __free(nvmem_cell_put) =
 		nvmem_cell_get(dev, "temperature_calib");
@@ -2270,20 +2297,23 @@ static int at91_adc_temp_sensor_init(struct at91_adc_state *st,
 		return dev_err_probe(dev, PTR_ERR(buf),
 				     "Failed to read calibration data!\n");
 
-	if (len < AT91_ADC_TS_CLB_IDX_MAX * sizeof(*buf)) {
+	if (len < layout->min_len * sizeof(*buf)) {
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
+	clb->p1 *= layout->p1_scale.numerator;
+	clb->p1 /= layout->p1_scale.denominator;
 
 	return 0;
 }
-- 
2.34.1

