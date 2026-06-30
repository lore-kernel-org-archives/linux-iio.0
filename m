Received: from esa.microchip.iphmx.com (esa.microchip.iphmx.com [68.232.153.233])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9EB8734F48A;
	Tue, 30 Jun 2026 09:37:02 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=68.232.153.233
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1782812223; cv=none; b=W9kMg9uEJLbmOMBiGhjca09lRiqtrwbIGx4SbASAWcmIeIyh6TWB0awJR3zXTg5LFXxeQHhI2xtNAOhKXWcgWfBZ5hjX3G+BXfQsh8n7zusKqf3G+hxNPWsNylorBNNVC/zw3ArEOEP52J4y4TDxZHOR0rSTgQYpTNcbp9Gg1nA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1782812223; c=relaxed/simple;
	bh=b2HE2/l9IrpGvkPLNtqbKq6IrgROI2wKPVDiGDKGxTU=;
	h=From:To:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=fPDdzfLQNrmJpGStpoO2ouqqradVrDVeq8QmJ0viQU7N6JiUeLNpUIPA8N5jbj1oULtgOKgOy8rtp5wwQEKWnL6jNApcMsK6x/SpinlJBYk8qlS7LZpYg8n5Ti6ikyIYUa8OeKe4bi7ULz7IRoIwGAGJga69SjT+aBD6bmlvhho=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=microchip.com; spf=pass smtp.mailfrom=microchip.com; dkim=pass (2048-bit key) header.d=microchip.com header.i=@microchip.com header.b=07X5LiZS; arc=none smtp.client-ip=68.232.153.233
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=microchip.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=microchip.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=microchip.com header.i=@microchip.com header.b="07X5LiZS"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=microchip.com; i=@microchip.com; q=dns/txt; s=mchp;
  t=1782812223; x=1814348223;
  h=from:to:subject:date:message-id:in-reply-to:references:
   mime-version:content-transfer-encoding;
  bh=b2HE2/l9IrpGvkPLNtqbKq6IrgROI2wKPVDiGDKGxTU=;
  b=07X5LiZSEDl4U/t0ZxepwYLyXpj1FV2ORiEm0Mq1cBM43RbkYvWb3feV
   IW6uDKZhObwBlW7xoAxE79EG3rw+pkn0JxDhsmkvNp1NHQ83x2WporDNn
   qFZXm/9qdoVXV8rYS+5WTgWvgk4wkVKUNnBm1a4hRsq9RnPDhaMKZ5UQD
   gfm6+qUEKAnQ208sgcaS7k4wB5I5Xe/Qm1n+dnhK5/Ts++JOBaHy1cE2v
   qK+gpls379rtUsGUJWWVe6tU/a9WQ5uNzCaznRaC0/IQ+V9QfgB5YQh5A
   2ybez0TV3Gg/9teyL5csPLnN9iSJMdzrlTzMFC+j+GN4pWnqf9qo6Ndpv
   Q==;
X-CSE-ConnectionGUID: ke3uW/xuQkuIIzeAFFBFjw==
X-CSE-MsgGUID: qDgVRIxdS7WTrMiyOUgiuQ==
X-IronPort-AV: E=Sophos;i="6.24,233,1774335600"; 
   d="scan'208";a="291266929"
X-Amp-Result: SKIPPED(no attachment in message)
Received: from unknown (HELO email.microchip.com) ([170.129.1.10])
  by esa5.microchip.iphmx.com with ESMTP/TLS/ECDHE-RSA-AES128-GCM-SHA256; 30 Jun 2026 02:37:02 -0700
Received: from chn-vm-ex02.mchp-main.com (10.10.85.144) by
 chn-vm-ex04.mchp-main.com (10.10.85.152) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.58; Tue, 30 Jun 2026 02:37:01 -0700
Received: from che-ll-i67070.microchip.com (10.10.85.11) by
 chn-vm-ex02.mchp-main.com (10.10.85.144) with Microsoft SMTP Server id
 15.1.2507.58 via Frontend Transport; Tue, 30 Jun 2026 02:36:52 -0700
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
Subject: [PATCH v3 02/13] iio: adc: at91-sama5d2_adc: use cleanup.h for NVMEM buffer
Date: Tue, 30 Jun 2026 15:05:52 +0530
Message-ID: <20260630093603.38663-3-varshini.rajendran@microchip.com>
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

Use __free(kfree) cleanup helper for the NVMEM data buffer in
at91_adc_temp_sensor_init() to simplify error handling paths.

Since __free(kfree) requires a valid kfree-able pointer (not an
ERR_PTR), store nvmem_cell_read() result in a temporary void pointer
first, check for errors, then assign to the managed buffer.

Signed-off-by: Varshini Rajendran <varshini.rajendran@microchip.com>
---
 drivers/iio/adc/at91-sama5d2_adc.c | 21 +++++++++++----------
 1 file changed, 11 insertions(+), 10 deletions(-)

diff --git a/drivers/iio/adc/at91-sama5d2_adc.c b/drivers/iio/adc/at91-sama5d2_adc.c
index 255970b2e747..5015c234289e 100644
--- a/drivers/iio/adc/at91-sama5d2_adc.c
+++ b/drivers/iio/adc/at91-sama5d2_adc.c
@@ -2251,9 +2251,10 @@ static int at91_adc_temp_sensor_init(struct at91_adc_state *st,
 {
 	struct at91_adc_temp_sensor_clb *clb = &st->soc_info.temp_sensor_clb;
 	struct nvmem_cell *temp_calib;
-	u32 *buf;
+	u32 *buf __free(kfree) = NULL;
+	void *cell_data;
 	size_t len;
-	int ret = 0;
+	int ret;
 
 	if (!st->soc_info.platform->temp_sensor)
 		return 0;
@@ -2267,16 +2268,18 @@ static int at91_adc_temp_sensor_init(struct at91_adc_state *st,
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
+
+	buf = cell_data;
+
 	if (len < AT91_ADC_TS_CLB_IDX_MAX * 4) {
 		dev_err(dev, "Invalid calibration data!\n");
-		ret = -EINVAL;
-		goto free_buf;
+		return -EINVAL;
 	}
 
 	/* Store calibration data for later use. */
@@ -2289,9 +2292,7 @@ static int at91_adc_temp_sensor_init(struct at91_adc_state *st,
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

