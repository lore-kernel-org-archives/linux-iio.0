Received: from esa.microchip.iphmx.com (esa.microchip.iphmx.com [68.232.154.123])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 82E6B345CB2;
	Tue,  4 Aug 2026 11:34:37 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=68.232.154.123
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1785843279; cv=none; b=UUW9Btz5YP2ndH8FuZhhCsJH54gT+gzJUvOwQM6MoQmoHui9ceDCIie3f+bMtb1cLSndyqOvZ8gdcl2Q1YHvIeEGD+h5AuSJKxMj3I1rpKbBmtaB2PP8sAzR/WeI2NQgBIjt4xYXEeKjUGf1ghl6uaYcCbZIlvawl1/V3LEKBj4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1785843279; c=relaxed/simple;
	bh=WMbz2x0oy9U6MHDiryFzAYvYHXh9EzXZWymCLH/WBvQ=;
	h=From:To:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=eQ5WVOx9D9tp1G5PfGE0vZXmYgVfexZh9FEwoiv4vjpbdkqzGse3PaCeC19EkvNUbPYm+qnTjb7hFMM1VNLIhq4jMtMlke8nGs0ysy4/KkiS21lXTtC40qphOlil/eZAqsgQ0pShj3kv/4Rb83u1axZ2htcJisvTe+4Y6UxUydo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=microchip.com; spf=pass smtp.mailfrom=microchip.com; dkim=pass (2048-bit key) header.d=microchip.com header.i=@microchip.com header.b=hhOkE7kB; arc=none smtp.client-ip=68.232.154.123
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=microchip.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=microchip.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=microchip.com header.i=@microchip.com header.b="hhOkE7kB"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=microchip.com; i=@microchip.com; q=dns/txt; s=mchp;
  t=1785843277; x=1817379277;
  h=from:to:subject:date:message-id:in-reply-to:references:
   mime-version:content-transfer-encoding;
  bh=WMbz2x0oy9U6MHDiryFzAYvYHXh9EzXZWymCLH/WBvQ=;
  b=hhOkE7kBTUimyQtesvqYAj5ol9b1qDrvcUr+nRU/fuQyOkrMK1Q4jy1k
   g7PeF2Q4PQQDWmSkuyb/Fs96HRCkqWhursyQscIbYEW8x3vAsbiQoWgR/
   1nLg/HVUQ8Sce3vHYA9+SWPKXIinJCxNKeNT/x1dIqZN4HCedVUZ8aaD6
   Wsd1w2dshQlrvIqWSOCsmLWluhUN8iXXVcLgrvJfl+H7Ym2AOHmqczhwK
   OdSruCdLuM5HyRRp1DjZ4yLt7CXSFdMTIftVOmKDUgWuuvxHR1KLPCvQS
   XX8SQ8Iy3MZc6GpVo8WBXOCGCZkHqY3TYa7T+iLMBomnCD9k9fWwHRWmq
   A==;
X-CSE-ConnectionGUID: KeabGfcFSpCLBhSU10onPA==
X-CSE-MsgGUID: WWabnms5R5qlOqFpu7LBEw==
X-IronPort-AV: E=Sophos;i="6.25,204,1779174000"; 
   d="scan'208";a="228765771"
X-Amp-Result: SKIPPED(no attachment in message)
Received: from unknown (HELO email.microchip.com) ([170.129.1.10])
  by esa6.microchip.iphmx.com with ESMTP/TLS/ECDHE-RSA-AES128-GCM-SHA256; 04 Aug 2026 04:34:36 -0700
Received: from chn-vm-ex01.mchp-main.com (10.10.85.143) by
 chn-vm-ex02.mchp-main.com (10.10.85.144) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.58; Tue, 4 Aug 2026 04:34:36 -0700
Received: from che-ll-i67070.microchip.com (10.10.85.11) by
 chn-vm-ex01.mchp-main.com (10.10.85.143) with Microsoft SMTP Server id
 15.1.2507.58 via Frontend Transport; Tue, 4 Aug 2026 04:34:25 -0700
From: Varshini Rajendran <varshini.rajendran@microchip.com>
To: <ehristev@kernel.org>, <jic23@kernel.org>, <dlechner@baylibre.com>,
	<nuno.sa@analog.com>, <andy@kernel.org>, <robh@kernel.org>,
	<krzk+dt@kernel.org>, <conor+dt@kernel.org>, <nicolas.ferre@microchip.com>,
	<alexandre.belloni@bootlin.com>, <claudiu.beznea@tuxon.dev>,
	<srini@kernel.org>, <marcelo.schmitt@analog.com>, <radu.sabau@analog.com>,
	<joshua.crofts1@gmail.com>, <jorge.marques@analog.com>,
	<Jonathan.Santos@analog.com>, <jishnu.prakash@oss.qualcomm.com>,
	<antoniu.miclaus@analog.com>, <duje@dujemihanovic.xyz>,
	<mazziesaccount@gmail.com>, <varshini.rajendran@microchip.com>,
	<linux-iio@vger.kernel.org>, <devicetree@vger.kernel.org>,
	<linux-arm-kernel@lists.infradead.org>, <linux-kernel@vger.kernel.org>
Subject: [PATCH v5 04/17] iio: adc: at91-sama5d2_adc: rework temp calibration layout handling
Date: Tue, 4 Aug 2026 17:03:25 +0530
Message-ID: <20260804113338.261782-5-varshini.rajendran@microchip.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20260804113338.261782-1-varshini.rajendran@microchip.com>
References: <20260804113338.261782-1-varshini.rajendran@microchip.com>
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

Reviewed-by: Eugen Hristev <ehristev@kernel.org>
Signed-off-by: Varshini Rajendran <varshini.rajendran@microchip.com>
---
 drivers/iio/adc/at91-sama5d2_adc.c | 66 ++++++++++++++++++++++--------
 1 file changed, 48 insertions(+), 18 deletions(-)

diff --git a/drivers/iio/adc/at91-sama5d2_adc.c b/drivers/iio/adc/at91-sama5d2_adc.c
index 09390f082fc4..82db8f2f4db0 100644
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
@@ -444,6 +445,27 @@ static const struct at91_adc_reg_layout sama7g5_layout = {
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
@@ -462,6 +484,7 @@ static const struct at91_adc_reg_layout sama7g5_layout = {
  * @oversampling_avail_no: number of available oversampling values
  * @chan_realbits:	realbits for registered channels
  * @temp_chan:		temperature channel index
+ * @temp_calib_layout:	temperature calibration packet layout
  * @temp_sensor:	temperature sensor supported
  */
 struct at91_adc_platform {
@@ -479,6 +502,7 @@ struct at91_adc_platform {
 	unsigned int				oversampling_avail_no;
 	unsigned int				chan_realbits;
 	unsigned int				temp_chan;
+	const struct at91_adc_temp_calib_layout	*temp_calib_layout;
 	bool					temp_sensor;
 };
 
@@ -495,18 +519,13 @@ struct at91_adc_temp_sensor_clb {
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
@@ -744,6 +763,7 @@ static const struct at91_adc_platform sama7g5_platform = {
 	.chan_realbits = 16,
 	.temp_sensor = true,
 	.temp_chan = AT91_SAMA7G5_ADC_TEMP_CHANNEL,
+	.temp_calib_layout = &sama7g5_temp_calib,
 };
 
 static int at91_adc_chan_xlate(struct iio_dev *indio_dev, int chan)
@@ -2249,12 +2269,19 @@ static int at91_adc_temp_sensor_init(struct at91_adc_state *st,
 				     struct device *dev)
 {
 	struct at91_adc_temp_sensor_clb *clb = &st->soc_info.temp_sensor_clb;
+	const struct at91_adc_temp_calib_layout *layout;
 	size_t len;
 	int ret = 0;
 
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

