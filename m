Received: from esa.microchip.iphmx.com (esa.microchip.iphmx.com [68.232.154.123])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8749A3D091C;
	Tue, 23 Jun 2026 11:00:08 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=68.232.154.123
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1782212409; cv=none; b=G7mvnLtUfLPVv4cui7jPX5Dr7a/PzzegcqfeemHthnJEldLOzg2CKC7zm7gYoV+34HNhFa+eD/aIV8dgLJespc88ftySrM6XDdIBmj6RPyZuAe8B3TiUiyEQHN9ugFfloeQ6Zb5sCCtcTMUBYVU7H52QyVAz6168QtFZnJiOQr0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1782212409; c=relaxed/simple;
	bh=mXQLuZ4tPiAdaSPF967IEdaCWZnXeOO89gBf2T38Jn0=;
	h=From:To:CC:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=vD/Uz9znUQRDVqStQu7CgKBZx9V8okmNGLoEKg8cSdeT7N+bdXUtylzyWVQZb9/VONPZN8YtRnEXKPPSZEpdFmHYHTiNgoChh6CFdqsO/dnnZ7uDZcz6VuVUFlNzUrhCwN/AzboXYLyocBPHw+Cy6zmW4zolxFWf5UbZYirk1VE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=microchip.com; spf=pass smtp.mailfrom=microchip.com; dkim=pass (2048-bit key) header.d=microchip.com header.i=@microchip.com header.b=pm9ozIgS; arc=none smtp.client-ip=68.232.154.123
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=microchip.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=microchip.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=microchip.com header.i=@microchip.com header.b="pm9ozIgS"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=microchip.com; i=@microchip.com; q=dns/txt; s=mchp;
  t=1782212408; x=1813748408;
  h=from:to:cc:subject:date:message-id:in-reply-to:
   references:mime-version:content-transfer-encoding;
  bh=mXQLuZ4tPiAdaSPF967IEdaCWZnXeOO89gBf2T38Jn0=;
  b=pm9ozIgSiU6peJQ27MJft0DYoGkKvNvgR9VQEfih4ZnJah8Gc5He0ONm
   MDNkTN3LAkwkUzCQXXOD9XR1xAQBX8/lILiovxQCTVxCJp3s/7sk8e0X/
   KMsc8x3x8kLW7p9fkWKgtpDpBEiLDcyNMyLSNR5FoaCjaUSe10Mpw6k7q
   ydK+oRDSiK2rsmJwmRFVTHf5CfUoLpIpmZY8G/1eeWJzHyEBNc9xJAe2r
   XOI+occlVRyt7Ne4P6oBQeHKf44nyCtZp8VZjLx7Urkq+JQ8M7G7ewcZ8
   i4r6nLLZ1QMoWfb1wQ8ptw9uFf9hdPdnMWapvRiUQ7dJ+KeRHfWpAxx3U
   w==;
X-CSE-ConnectionGUID: OokZqtn9SqelXvKa91uuDw==
X-CSE-MsgGUID: fHXf2Y4qRvOEtkKZqM/HRA==
X-IronPort-AV: E=Sophos;i="6.24,220,1774335600"; 
   d="scan'208";a="226724794"
X-Amp-Result: SKIPPED(no attachment in message)
Received: from unknown (HELO email.microchip.com) ([170.129.1.10])
  by esa6.microchip.iphmx.com with ESMTP/TLS/ECDHE-RSA-AES128-GCM-SHA256; 23 Jun 2026 04:00:02 -0700
Received: from chn-vm-ex03.mchp-main.com (10.10.85.151) by
 chn-vm-ex01.mchp-main.com (10.10.85.143) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.58; Tue, 23 Jun 2026 04:00:02 -0700
Received: from che-ll-i67070.microchip.com (10.10.85.11) by
 chn-vm-ex03.mchp-main.com (10.10.85.151) with Microsoft SMTP Server id
 15.1.2507.58 via Frontend Transport; Tue, 23 Jun 2026 03:59:55 -0700
From: Varshini Rajendran <varshini.rajendran@microchip.com>
To: <ehristev@kernel.org>, <jic23@kernel.org>, <dlechner@baylibre.com>,
	<nuno.sa@analog.com>, <andy@kernel.org>, <robh@kernel.org>,
	<krzk+dt@kernel.org>, <conor+dt@kernel.org>, <nicolas.ferre@microchip.com>,
	<alexandre.belloni@bootlin.com>, <claudiu.beznea@tuxon.dev>,
	<srini@kernel.org>, <linux-iio@vger.kernel.org>,
	<devicetree@vger.kernel.org>, <linux-arm-kernel@lists.infradead.org>,
	<linux-kernel@vger.kernel.org>
CC: <varshini.rajendran@microchip.com>, Krzysztof Kozlowski
	<krzysztof.kozlowski@linaro.org>
Subject: [PATCH v2 01/12] dt-bindings: iio: adc: at91-sama5d2: document sama7d65
Date: Tue, 23 Jun 2026 16:29:33 +0530
Message-ID: <20260623105944.128840-2-varshini.rajendran@microchip.com>
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

Add dt-binding documentation for sama7d65 ADC.

Signed-off-by: Varshini Rajendran <varshini.rajendran@microchip.com>
Acked-by: Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>
---
 Documentation/devicetree/bindings/iio/adc/atmel,sama5d2-adc.yaml | 1 +
 1 file changed, 1 insertion(+)

diff --git a/Documentation/devicetree/bindings/iio/adc/atmel,sama5d2-adc.yaml b/Documentation/devicetree/bindings/iio/adc/atmel,sama5d2-adc.yaml
index 4817b840977a..e8a65fdcd018 100644
--- a/Documentation/devicetree/bindings/iio/adc/atmel,sama5d2-adc.yaml
+++ b/Documentation/devicetree/bindings/iio/adc/atmel,sama5d2-adc.yaml
@@ -15,6 +15,7 @@ properties:
       - atmel,sama5d2-adc
       - microchip,sam9x60-adc
       - microchip,sama7g5-adc
+      - microchip,sama7d65-adc
 
   reg:
     maxItems: 1
-- 
2.34.1

