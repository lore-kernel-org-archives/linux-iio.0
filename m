Received: from esa.microchip.iphmx.com (esa.microchip.iphmx.com [68.232.153.233])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A5088382290;
	Tue, 30 Jun 2026 09:37:20 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=68.232.153.233
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1782812241; cv=none; b=tp76SkWpPRVyJt4fBdwY6oGVgwShIbY/zdPBprKoz94WKIN5sKbCMEeOwev9sbOQy6zaA0GAYWrBs7xMsQ79Tb4RZUgWdUVfMNvfqqssXH+t4WMzwVPYMplByfrReymMNOi/SMYJ+4aeQd30NbOtPj0p0BZPIshrJLmUmW9Eqvk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1782812241; c=relaxed/simple;
	bh=14iKVjIbPt4BXpZNPCTRWlVVhuV9b7Zz5uk1BB4yLSM=;
	h=From:To:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=QwWUfrPDbIQMJoNursV9tZdyjx9mRd7+YopkWICZTkVWud/fliSp3tPh+Xv5L9krk12wsRVQggUNXPt2b44OSPophBsns22MWcpA/j6mJSbDVX+SLFgS1YDsxzUuZxmKmeHnsuLVyNI+TkRBtvVys9+qeY90HrKTk4gkEo9hLBA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=microchip.com; spf=pass smtp.mailfrom=microchip.com; dkim=pass (2048-bit key) header.d=microchip.com header.i=@microchip.com header.b=LeYg0r6o; arc=none smtp.client-ip=68.232.153.233
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=microchip.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=microchip.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=microchip.com header.i=@microchip.com header.b="LeYg0r6o"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=microchip.com; i=@microchip.com; q=dns/txt; s=mchp;
  t=1782812240; x=1814348240;
  h=from:to:subject:date:message-id:in-reply-to:references:
   mime-version:content-transfer-encoding;
  bh=14iKVjIbPt4BXpZNPCTRWlVVhuV9b7Zz5uk1BB4yLSM=;
  b=LeYg0r6o6J7pnoBntb07v5w6jovKmwhk3WbeuSe/WOGKitRzPrUxyG4K
   ZFrDudHFz9ImX8uxLF1DwFUBeZqT2pGZZMXBetPWATNqCpfNaZdLkpvsv
   kdnRLZPE9oCqotcPkUgWqR9JKNTqFxLj9AKg+lohdSmkQez08t1PEpue/
   TQcbXqGDcgT0GU/uogf15tm3b45a8aUcMIDmFeuYMnpQCFjj3+tCMl060
   fNbljJVDBOlySNu+zmIFZvVwMx/mR9q14GkCbI6gzmE0ro2ZfX+liQh5I
   gaGhebZ/t9aAw2uaVvltAdTJQKxRYhmlfZYCBI9aKW5k0gRZXolCuj2gu
   g==;
X-CSE-ConnectionGUID: RYdOZI3+SAqAgq9+5DMc4A==
X-CSE-MsgGUID: vt6FXm27SiOmsmupIS4Fkg==
X-IronPort-AV: E=Sophos;i="6.24,233,1774335600"; 
   d="scan'208";a="69114899"
X-Amp-Result: SKIPPED(no attachment in message)
Received: from unknown (HELO email.microchip.com) ([170.129.1.10])
  by esa1.microchip.iphmx.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 30 Jun 2026 02:37:19 -0700
Received: from chn-vm-ex02.mchp-main.com (10.10.87.72) by
 chn-vm-ex3.mchp-main.com (10.10.87.32) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.2.2562.43; Tue, 30 Jun 2026 02:37:19 -0700
Received: from che-ll-i67070.microchip.com (10.10.85.11) by
 chn-vm-ex02.mchp-main.com (10.10.85.144) with Microsoft SMTP Server id
 15.1.2507.58 via Frontend Transport; Tue, 30 Jun 2026 02:37:10 -0700
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
Subject: [PATCH v3 04/13] iio: adc: at91-sama5d2_adc: adapt the driver for sama7d65
Date: Tue, 30 Jun 2026 15:05:54 +0530
Message-ID: <20260630093603.38663-5-varshini.rajendran@microchip.com>
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

Add support for sama7d65 ADC. The differences are highlighted with the
compatible. The calibration data layout is the main difference.

Update Kconfig help text to mention SAMA7 SoC family support.

Signed-off-by: Varshini Rajendran <varshini.rajendran@microchip.com>
---
 drivers/iio/adc/Kconfig            |  2 +-
 drivers/iio/adc/at91-sama5d2_adc.c | 31 ++++++++++++++++++++++++++++++
 2 files changed, 32 insertions(+), 1 deletion(-)

diff --git a/drivers/iio/adc/Kconfig b/drivers/iio/adc/Kconfig
index a9dedbb8eb46..cf28755a6109 100644
--- a/drivers/iio/adc/Kconfig
+++ b/drivers/iio/adc/Kconfig
@@ -626,7 +626,7 @@ config AT91_SAMA5D2_ADC
 	select IIO_TRIGGERED_BUFFER
 	help
 	  Say yes here to build support for Atmel SAMA5D2 ADC which is
-	  available on SAMA5D2 SoC family.
+	  available on SAMA5D2 and SAMA7 SoC families.
 
 	  To compile this driver as a module, choose M here: the module will be
 	  called at91-sama5d2_adc.
diff --git a/drivers/iio/adc/at91-sama5d2_adc.c b/drivers/iio/adc/at91-sama5d2_adc.c
index 2a25165bc874..7e3e347bb6a5 100644
--- a/drivers/iio/adc/at91-sama5d2_adc.c
+++ b/drivers/iio/adc/at91-sama5d2_adc.c
@@ -531,6 +531,16 @@ static const struct at91_adc_temp_calib_layout sama7g5_temp_calib = {
 	.p1_div = 1,
 };
 
+static const struct at91_adc_temp_calib_layout sama7d65_temp_calib = {
+	.tag_idx = 1,
+	.p1_idx = 3,
+	.p4_idx = 2,
+	.p6_idx = 5,
+	.min_len = 11,
+	.p1_mul = 1,
+	.p1_div = 1000,
+};
+
 /* Temperature sensor calibration - Vtemp voltage sensitivity to temperature. */
 #define AT91_ADC_TS_VTEMP_DT		(2080U)
 
@@ -769,6 +779,24 @@ static const struct at91_adc_platform sama7g5_platform = {
 	.temp_calib_layout = &sama7g5_temp_calib,
 };
 
+static const struct at91_adc_platform sama7d65_platform = {
+	.layout = &sama7g5_layout,
+	.adc_channels = &at91_sama7g5_adc_channels,
+	.nr_channels = AT91_SAMA7G5_SINGLE_CHAN_CNT +
+		       AT91_SAMA7G5_DIFF_CHAN_CNT +
+		       AT91_SAMA7G5_TEMP_CHAN_CNT,
+	.max_channels = ARRAY_SIZE(at91_sama7g5_adc_channels),
+	.max_index = AT91_SAMA7G5_MAX_CHAN_IDX,
+	.hw_trig_cnt = AT91_SAMA7G5_HW_TRIG_CNT,
+	.osr_mask = GENMASK(18, 16),
+	.oversampling_avail = { 1, 4, 16, 64, 256, },
+	.oversampling_avail_no = 5,
+	.chan_realbits = 16,
+	.temp_sensor = true,
+	.temp_chan = AT91_SAMA7G5_ADC_TEMP_CHANNEL,
+	.temp_calib_layout = &sama7d65_temp_calib,
+};
+
 static int at91_adc_chan_xlate(struct iio_dev *indio_dev, int chan)
 {
 	int i;
@@ -2639,6 +2667,9 @@ static const struct of_device_id at91_adc_dt_match[] = {
 	}, {
 		.compatible = "microchip,sama7g5-adc",
 		.data = (const void *)&sama7g5_platform,
+	}, {
+		.compatible = "microchip,sama7d65-adc",
+		.data = (const void *)&sama7d65_platform,
 	}, {
 		/* sentinel */
 	}
-- 
2.34.1

