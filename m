Received: from esa.microchip.iphmx.com (esa.microchip.iphmx.com [68.232.153.233])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 17DFA40096C;
	Mon, 27 Jul 2026 12:28:21 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=68.232.153.233
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1785155302; cv=none; b=Y3mKowPrKFRljpcsSQyZlkDBCyWm7yVyyL+XtFCstQYGU3bR1FCZpPy32xvRTAwlOyA3bPPjPP/NDMkYnaynrkrtk6mEido7E/dXXWE2jmYuvmvoRTaRwWcEwfYPNsHTcaDdLDFqd+qrM7jvyO8axH6E8OP/Q0ALsZbRHP0Hxp0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1785155302; c=relaxed/simple;
	bh=u15qrM0OxZ0RvZIq7htTa72mSwEegJY4xHMEJ2Ga+Kw=;
	h=From:To:CC:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=Qy+UDfQu9GJ43iK3uqjyGSWXNzvVb9W6AgrC405gqltrLiVvlOjOvbX5DcaH2TaDSJ8kP/f8NbRJKdwwXsU2sr/DICEu4STAHDxgHLfmAgXOMFddIcbdVnUpt4kBAJHXGEwWcYxiVWh1KxSMRS42NnXfnNlsV6Oxq/Djd2b7zQE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=microchip.com; spf=pass smtp.mailfrom=microchip.com; dkim=pass (2048-bit key) header.d=microchip.com header.i=@microchip.com header.b=kMgOgkm1; arc=none smtp.client-ip=68.232.153.233
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=microchip.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=microchip.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=microchip.com header.i=@microchip.com header.b="kMgOgkm1"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=microchip.com; i=@microchip.com; q=dns/txt; s=mchp;
  t=1785155300; x=1816691300;
  h=from:to:cc:subject:date:message-id:in-reply-to:
   references:mime-version:content-transfer-encoding;
  bh=u15qrM0OxZ0RvZIq7htTa72mSwEegJY4xHMEJ2Ga+Kw=;
  b=kMgOgkm1q0jtUoGNOzTXZOQdNWp0psTVOS9vSBSfmwe1RUYrpoue3S2M
   nX7pjem9PuWbVEAAQawtO/ikBLykrfVfv1cCBFOkdyvgwRbKUnrbnwcp3
   TyS41ParFf2Dyo/C02zX/Zz1rgJ+FlfKAQVSO5YuAZaIV+pDzq+KAHH+A
   sFoYIFJWtk5HP48y+CooYoROv+8HH2OBkaLiQm69h1CP/Om3ZDCwsmZ+N
   ariGlYamzt3zOwnuNTPUMCen2PUMM7vVjuVDq++PT7Y69iyFULNjohzSs
   ql9U4MeZG6156X3RmXLv6qhgO2sHIIzGTd0W4DeiHiUXhnkPpERLk0NS/
   Q==;
X-CSE-ConnectionGUID: opGnupBsQuiohLycbo45AQ==
X-CSE-MsgGUID: yQdRrD+DRR+iH4IQXKiaQA==
X-IronPort-AV: E=Sophos;i="6.25,188,1779174000"; 
   d="scan'208";a="70709542"
X-Amp-Result: SKIPPED(no attachment in message)
Received: from unknown (HELO email.microchip.com) ([170.129.1.10])
  by esa1.microchip.iphmx.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 27 Jul 2026 05:27:09 -0700
Received: from chn-vm-ex01.mchp-main.com (10.10.87.71) by
 chn-vm-ex4.mchp-main.com (10.10.87.33) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.2.2562.43; Mon, 27 Jul 2026 05:27:08 -0700
Received: from che-ll-i67070.microchip.com (10.10.85.11) by
 chn-vm-ex01.mchp-main.com (10.10.85.143) with Microsoft SMTP Server id
 15.1.2507.58 via Frontend Transport; Mon, 27 Jul 2026 05:26:58 -0700
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
CC: Andy Shevchenko <andriy.shevchenko@intel.com>
Subject: [PATCH v4 02/16] iio: adc: at91-sama5d2_adc: use cleanup.h for NVMEM buffer
Date: Mon, 27 Jul 2026 17:56:19 +0530
Message-ID: <20260727122633.117435-3-varshini.rajendran@microchip.com>
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

Use __free(kfree) and __free(nvmem_cell_put) cleanup helpers in
at91_adc_temp_sensor_init() to simplify error handling paths.

Reviewed-by: Andy Shevchenko <andriy.shevchenko@intel.com>
Signed-off-by: Varshini Rajendran <varshini.rajendran@microchip.com>
---
 drivers/iio/adc/at91-sama5d2_adc.c | 33 +++++++++++++-----------------
 1 file changed, 14 insertions(+), 19 deletions(-)

diff --git a/drivers/iio/adc/at91-sama5d2_adc.c b/drivers/iio/adc/at91-sama5d2_adc.c
index e8a5285bb6d4..4a4a25f3c715 100644
--- a/drivers/iio/adc/at91-sama5d2_adc.c
+++ b/drivers/iio/adc/at91-sama5d2_adc.c
@@ -35,6 +35,8 @@
 
 #include <dt-bindings/iio/adc/at91-sama5d2_adc.h>
 
+DEFINE_FREE(nvmem_cell_put, struct nvmem_cell *, if (_T) nvmem_cell_put(_T))
+
 struct at91_adc_reg_layout {
 /* Control Register */
 	u16				CR;
@@ -2249,33 +2251,28 @@ static int at91_adc_temp_sensor_init(struct at91_adc_state *st,
 				     struct device *dev)
 {
 	struct at91_adc_temp_sensor_clb *clb = &st->soc_info.temp_sensor_clb;
-	struct nvmem_cell *temp_calib;
-	u32 *buf;
 	size_t len;
-	int ret = 0;
 
 	if (!st->soc_info.platform->temp_sensor)
 		return 0;
 
 	/* Get the calibration data from NVMEM. */
-	temp_calib = nvmem_cell_get(dev, "temperature_calib");
+	struct nvmem_cell *temp_calib __free(nvmem_cell_put) =
+		nvmem_cell_get(dev, "temperature_calib");
 	if (IS_ERR(temp_calib)) {
-		ret = PTR_ERR(temp_calib);
-		if (ret != -ENOENT)
+		if (PTR_ERR(temp_calib) != -ENOENT)
 			dev_err(dev, "Failed to get temperature_calib cell!\n");
-		return ret;
+		return PTR_ERR(temp_calib);
 	}
 
-	buf = nvmem_cell_read(temp_calib, &len);
-	nvmem_cell_put(temp_calib);
-	if (IS_ERR(buf)) {
-		dev_err(dev, "Failed to read calibration data!\n");
-		return PTR_ERR(buf);
-	}
-	if (len < AT91_ADC_TS_CLB_IDX_MAX * 4) {
+	u32 *buf __free(kfree) = nvmem_cell_read(temp_calib, &len);
+	if (IS_ERR(buf))
+		return dev_err_probe(dev, PTR_ERR(buf),
+				     "Failed to read calibration data!\n");
+
+	if (len < AT91_ADC_TS_CLB_IDX_MAX * sizeof(*buf)) {
 		dev_err(dev, "Invalid calibration data!\n");
-		ret = -EINVAL;
-		goto free_buf;
+		return -EINVAL;
 	}
 
 	/* Store calibration data for later use. */
@@ -2288,9 +2285,7 @@ static int at91_adc_temp_sensor_init(struct at91_adc_state *st,
 	 */
 	clb->p1 = clb->p1 * 1000;
 
-free_buf:
-	kfree(buf);
-	return ret;
+	return 0;
 }
 
 static int at91_adc_probe(struct platform_device *pdev)
-- 
2.34.1

