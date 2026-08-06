Received: from esa.microchip.iphmx.com (esa.microchip.iphmx.com [68.232.154.123])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1162D30E84F;
	Thu,  6 Aug 2026 08:47:55 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=68.232.154.123
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1786006077; cv=none; b=f9TtJS7XG2f6oxiq86PMzAU2apw1UQI9r1Trp4lZPWq+IB6Qfio6hAneTCShe6YiWqjkp9iR+3qwQbLYcATEQ8f/CH4Tk6ojb6GKceyUUbfHa/yACjD4z7DOI7PzvyrhtW5iEBDmwtxAsX6MTAczfdR/+PyZE7pEIdeUM9YnRAc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1786006077; c=relaxed/simple;
	bh=9TV+tsofy6TCtX8zVKSBqg0wGh2pcJEEZrqQnPraG7U=;
	h=From:To:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=k1URwJY2ZzKlMxLxCFWJnfd0HvgHlQJ7MQ0tVh3UHghe26QRXDX2KQNiMsqCERFOOgPumDER0BCG9ZDO6vCNAcgfbtp57ZjwwxNJjWSTb2ZCSDvlxIpkZdIQh59RX1mbTpfV+cv7N/IMvbJbQQyIKVgUH/EeKJgK4JpLx4mCNY4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=microchip.com; spf=pass smtp.mailfrom=microchip.com; dkim=pass (2048-bit key) header.d=microchip.com header.i=@microchip.com header.b=wyeVV8Tn; arc=none smtp.client-ip=68.232.154.123
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=microchip.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=microchip.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=microchip.com header.i=@microchip.com header.b="wyeVV8Tn"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=microchip.com; i=@microchip.com; q=dns/txt; s=mchp;
  t=1786006076; x=1817542076;
  h=from:to:subject:date:message-id:in-reply-to:references:
   mime-version:content-transfer-encoding;
  bh=9TV+tsofy6TCtX8zVKSBqg0wGh2pcJEEZrqQnPraG7U=;
  b=wyeVV8TnUjaobRPsgxLygP9zF3gxfe2qXZyYEj5l+h9Ev8ZrgtPfdrkO
   CFOoEP5Kh0S3F9s5Ug2ZRbHW8IWcd4d8HhD6ojBZr4PUZ/VQkfsQQk8LT
   YCgvC9/aoXb4bhDi+VdNF7Ndc3L3OHSDbvctjmm7e30rahMPD06AMv9oz
   FyFkcxFipWPnMmgUvgK+0aBQAfNU9YmF21WmY+goH/0lfW5h/q1G/EgSi
   l6yGuUuZFGeusLTQ4VWxmYmQF51D+VUeqQ+jYx2gwRFfbpIryCI700LvI
   wy4Q5ST+jPmK2pLaqVoc61rAvhUDfCfcbNohZFKKGJodpzmdMjv/JCHIw
   w==;
X-CSE-ConnectionGUID: dLx6FcJJTU68ufzJ4BcPDg==
X-CSE-MsgGUID: 3Sl4veB/RH+ZX1I+jniI1g==
X-IronPort-AV: E=Sophos;i="6.25,208,1779174000"; 
   d="scan'208";a="60854103"
X-Amp-Result: SKIPPED(no attachment in message)
Received: from unknown (HELO email.microchip.com) ([170.129.1.10])
  by esa4.microchip.iphmx.com with ESMTP/TLS/ECDHE-RSA-AES128-GCM-SHA256; 06 Aug 2026 01:47:54 -0700
Received: from chn-vm-ex03.mchp-main.com (10.10.85.151) by
 chn-vm-ex02.mchp-main.com (10.10.85.144) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.58; Thu, 6 Aug 2026 01:47:54 -0700
Received: from che-ll-i67070.microchip.com (10.10.85.11) by
 chn-vm-ex03.mchp-main.com (10.10.85.151) with Microsoft SMTP Server id
 15.1.2507.58 via Frontend Transport; Thu, 6 Aug 2026 01:47:45 -0700
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
Subject: [PATCH v6 07/17] iio: adc: at91-sama5d2_adc: adapt the driver for sama7d65
Date: Thu, 6 Aug 2026 13:10:14 +0530
Message-ID: <20260806074024.531259-8-varshini.rajendran@microchip.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20260806074024.531259-1-varshini.rajendran@microchip.com>
References: <20260806074024.531259-1-varshini.rajendran@microchip.com>
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
 drivers/iio/adc/at91-sama5d2_adc.c | 30 ++++++++++++++++++++++++++++++
 2 files changed, 31 insertions(+), 1 deletion(-)

diff --git a/drivers/iio/adc/Kconfig b/drivers/iio/adc/Kconfig
index 3755a81c1efd..85b443853a08 100644
--- a/drivers/iio/adc/Kconfig
+++ b/drivers/iio/adc/Kconfig
@@ -647,7 +647,7 @@ config AT91_SAMA5D2_ADC
 	select IIO_TRIGGERED_BUFFER
 	help
 	  Say yes here to build support for Atmel SAMA5D2 ADC which is
-	  available on SAMA5D2 SoC family.
+	  available on SAMA5D2 and SAMA7 SoC families.
 
 	  To compile this driver as a module, choose M here: the module will be
 	  called at91-sama5d2_adc.
diff --git a/drivers/iio/adc/at91-sama5d2_adc.c b/drivers/iio/adc/at91-sama5d2_adc.c
index 3e9feb824a66..c1e5139a058c 100644
--- a/drivers/iio/adc/at91-sama5d2_adc.c
+++ b/drivers/iio/adc/at91-sama5d2_adc.c
@@ -528,6 +528,15 @@ static const struct at91_adc_temp_calib_layout sama7g5_temp_calib = {
 	.p1_scale = { .numerator = 1000, .denominator = 1 },
 };
 
+static const struct at91_adc_temp_calib_layout sama7d65_temp_calib = {
+	.tag_idx = 1,
+	.p1_idx = 3,
+	.p4_idx = 2,
+	.p6_idx = 5,
+	.min_len = 11,
+	.p1_scale = { .numerator = 1, .denominator = 1000 },
+};
+
 /* Temperature sensor calibration - Vtemp voltage sensitivity to temperature. */
 #define AT91_ADC_TS_VTEMP_DT		(2080U)
 
@@ -766,6 +775,24 @@ static const struct at91_adc_platform sama7g5_platform = {
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
+	.oversampling_avail = { 1, 4, 16, 64, 256 },
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
@@ -2632,6 +2659,9 @@ static const struct of_device_id at91_adc_dt_match[] = {
 	}, {
 		.compatible = "microchip,sama7g5-adc",
 		.data = &sama7g5_platform,
+	}, {
+		.compatible = "microchip,sama7d65-adc",
+		.data = &sama7d65_platform,
 	}, {
 		/* sentinel */
 	}
-- 
2.34.1

