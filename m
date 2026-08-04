Received: from esa.microchip.iphmx.com (esa.microchip.iphmx.com [68.232.154.123])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 50A6A356773;
	Tue,  4 Aug 2026 11:34:04 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=68.232.154.123
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1785843245; cv=none; b=m1y7QMWzUNsksv9HPC2HyrjaC/SgG8QW184jftVysHcDduLd9ffGtxVk2uzbEk/ZQgeRx7X68RNve1IBt9yajogR+BOkn45XJgqnMBLgbcASedXBMvmym9TiuLjak0EpWs7AG0+psleocwUmwYP9UVNfGNWmqhSSIJZZh+8vYn0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1785843245; c=relaxed/simple;
	bh=G59VGDA6rhTXCxCP3iHlNCuRW3WqGdznOrZvREZZi/0=;
	h=From:To:CC:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=Bo46xx3HEFU0KpBIezXQVx/CQY3uEBes/nse6QsXXP/k09zi+06wJ9b+XdhERnM7atM2I5tWePtFsZvzUUkKsakf/gQmnolpFOAqNBt1HpozGcC06uHpcMnTc/aEEHodyS/+J5a+S2aKgldF4NY0wUA97mgMuGdF8D3qlWLNgks=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=microchip.com; spf=pass smtp.mailfrom=microchip.com; dkim=pass (2048-bit key) header.d=microchip.com header.i=@microchip.com header.b=H+sXVw+a; arc=none smtp.client-ip=68.232.154.123
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=microchip.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=microchip.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=microchip.com header.i=@microchip.com header.b="H+sXVw+a"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=microchip.com; i=@microchip.com; q=dns/txt; s=mchp;
  t=1785843244; x=1817379244;
  h=from:to:cc:subject:date:message-id:in-reply-to:
   references:mime-version:content-transfer-encoding;
  bh=G59VGDA6rhTXCxCP3iHlNCuRW3WqGdznOrZvREZZi/0=;
  b=H+sXVw+a+Pg4TJvaKM34JdV+4FL3jenkUmRSk9AHwDQM3w3zI1bTjD5n
   99ZMEYQhfPg0IGloI8Ro0ZY8XcNOhjYj8ARjqlA1AwaTTESqrFV6tcc4k
   3Q4fFxxtXsZYjI2IYiXxaOq3l4WLSr5GTkBhUkjLBa13LNUPMc0rmXLq1
   /mOSyz8qh6VM1sOzBr+JDoLfjkBbOAdW5E0E/cmbZUXOzMM30Ueyn5nVb
   0cw0sqXtDcb09Zu1XcnhQi0gdU2Wfy63Thzgi003V6CWbQ8CLHMsY/v6W
   c0JaIw45yz9G/ktvDyU2QPMVT95tEZtzFnVGsLUztnahVuy8oDuVLPZz/
   A==;
X-CSE-ConnectionGUID: ZAh7y7BsQI2UUJU92+Rbdw==
X-CSE-MsgGUID: 6x+8kSwqS3qVFry6LfnbDg==
X-IronPort-AV: E=Sophos;i="6.25,204,1779174000"; 
   d="scan'208";a="60737105"
X-Amp-Result: SKIPPED(no attachment in message)
Received: from unknown (HELO email.microchip.com) ([170.129.1.10])
  by esa4.microchip.iphmx.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 04 Aug 2026 04:34:03 -0700
Received: from chn-vm-ex01.mchp-main.com (10.10.87.71) by
 chn-vm-ex4.mchp-main.com (10.10.87.33) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.2.2562.45; Tue, 4 Aug 2026 04:34:03 -0700
Received: from che-ll-i67070.microchip.com (10.10.85.11) by
 chn-vm-ex01.mchp-main.com (10.10.85.143) with Microsoft SMTP Server id
 15.1.2507.58 via Frontend Transport; Tue, 4 Aug 2026 04:33:52 -0700
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
CC: Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>
Subject: [PATCH v5 01/17] dt-bindings: iio: adc: at91-sama5d2: document sama7d65
Date: Tue, 4 Aug 2026 17:03:22 +0530
Message-ID: <20260804113338.261782-2-varshini.rajendran@microchip.com>
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

Add dt-binding documentation for sama7d65 ADC.

sama7d65 requires an individual compatible to address the differences
from its predecessor sama7g5. The main difference is the temperature
calibration layout and its handling.

Acked-by: Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>
Signed-off-by: Varshini Rajendran <varshini.rajendran@microchip.com>
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

