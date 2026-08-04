Received: from esa.microchip.iphmx.com (esa.microchip.iphmx.com [68.232.154.123])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8783235201F;
	Tue,  4 Aug 2026 11:34:48 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=68.232.154.123
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1785843289; cv=none; b=I61vsNgIEsaIvEg1eFGoG2Qba3kLDd2u4q/3dRhN3agh9GEvPi9lNP1ZlPHth2+2R7ZbNV22d4kvJ9o3iEyjUqPht3N7dSjZBZECkXJLcyDAhJunfNVKC3+r8wjV8S6J0bzeaIuxXqCAy5NWUxDENcReg+3Qmq/oVIIseTiAfho=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1785843289; c=relaxed/simple;
	bh=HAGc0aQvGQ6xckPzuGtbesPxW4BhT95FbIaJJrF46dg=;
	h=From:To:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=JRTg7MJN0lxZZixRwbvRyUFgA0UE45F+gsUt3M1ymg4cAMl6TaVy46t8QN8vw8fk9lHOiLtA627ueAbzce1huxjGszkkUFTtNTxjgYQmeshhmclgi6DcQJX5fCJV2OjqodNqnob7RDr3Wtk2iv9e4fAMPKUO5awM5QdtCF4VC8c=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=microchip.com; spf=pass smtp.mailfrom=microchip.com; dkim=pass (2048-bit key) header.d=microchip.com header.i=@microchip.com header.b=HrO/n72Y; arc=none smtp.client-ip=68.232.154.123
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=microchip.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=microchip.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=microchip.com header.i=@microchip.com header.b="HrO/n72Y"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=microchip.com; i=@microchip.com; q=dns/txt; s=mchp;
  t=1785843288; x=1817379288;
  h=from:to:subject:date:message-id:in-reply-to:references:
   mime-version:content-transfer-encoding;
  bh=HAGc0aQvGQ6xckPzuGtbesPxW4BhT95FbIaJJrF46dg=;
  b=HrO/n72YOgoj6IKC5vRMCBvoaRV3WEFAutdeL4b2xRh6BTOIn/EmytLk
   RNQH/zbWcq8kGuDIHbvasxoQcLKXfbe5WEKDN89Nod25+IXpKQORz1iLd
   ZCraQGWoLOCNFHVeBliXcRuheAG0KzPkfszylXMecT97xVcfxjpWYiR0V
   8J6YtKNKzs6yEW2ymROHE6EG3+NC1Zm14rRcn2dbzOKqkT2qQvCtzfgKa
   g34JNNr23FDXpYRKEDP43EgIft0iewTeHlU5yNsfsLRWxKI/itbMOvMVo
   2gOWLFTU0iRua1QU6MrTa/M78NjXN1UvFhnVkyleAtaDkhOc5CMHkf921
   w==;
X-CSE-ConnectionGUID: hQ0YnYp7SQGjHFa3FSHSsg==
X-CSE-MsgGUID: nSraFaAjTEum1TRTSW9ddw==
X-IronPort-AV: E=Sophos;i="6.25,204,1779174000"; 
   d="scan'208";a="61934860"
X-Amp-Result: SKIPPED(no attachment in message)
Received: from unknown (HELO email.microchip.com) ([170.129.1.10])
  by esa2.microchip.iphmx.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 04 Aug 2026 04:34:47 -0700
Received: from chn-vm-ex01.mchp-main.com (10.10.87.71) by
 chn-vm-ex1.mchp-main.com (10.10.87.30) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.2.2562.45; Tue, 4 Aug 2026 04:34:47 -0700
Received: from che-ll-i67070.microchip.com (10.10.85.11) by
 chn-vm-ex01.mchp-main.com (10.10.85.143) with Microsoft SMTP Server id
 15.1.2507.58 via Frontend Transport; Tue, 4 Aug 2026 04:34:36 -0700
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
Subject: [PATCH v5 05/17] iio: adc: at91-sama5d2_adc: add condition to validate calibration data
Date: Tue, 4 Aug 2026 17:03:26 +0530
Message-ID: <20260804113338.261782-6-varshini.rajendran@microchip.com>
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

Add additional condition to validate the calibration data read from the
NVMEM cell using the TAG of the packet.

Signed-off-by: Varshini Rajendran <varshini.rajendran@microchip.com>
---
 drivers/iio/adc/at91-sama5d2_adc.c | 3 ++-
 1 file changed, 2 insertions(+), 1 deletion(-)

diff --git a/drivers/iio/adc/at91-sama5d2_adc.c b/drivers/iio/adc/at91-sama5d2_adc.c
index 82db8f2f4db0..5b21367cf6b4 100644
--- a/drivers/iio/adc/at91-sama5d2_adc.c
+++ b/drivers/iio/adc/at91-sama5d2_adc.c
@@ -2297,7 +2297,8 @@ static int at91_adc_temp_sensor_init(struct at91_adc_state *st,
 		return dev_err_probe(dev, PTR_ERR(buf),
 				     "Failed to read calibration data!\n");
 
-	if (len < layout->min_len * sizeof(*buf)) {
+	if (len < layout->min_len * sizeof(*buf) ||
+	    buf[layout->tag_idx] != AT91_TEMP_CALIB_TAG_ACST) {
 		dev_err(dev, "Invalid calibration data!\n");
 		return -EINVAL;
 	}
-- 
2.34.1

