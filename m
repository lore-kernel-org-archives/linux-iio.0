Received: from esa.microchip.iphmx.com (esa.microchip.iphmx.com [68.232.154.123])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7E0683DC850;
	Thu,  6 Aug 2026 08:46:55 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=68.232.154.123
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1786006017; cv=none; b=u2ckfwRFVSGhLxXhP0AnqfM50KTMFACHllX0D4k/jPZeXEcpCgmq9XPs5VSIPKUi70NrKOH3eDeCNe2NOwmi5gaPDCVGrc6suK60OXvk157M/ZjnZIva1V+/u1UDGai5RB/7jravw3e++d/eowJtgJ3qATV/GLf9ZlTgLl2LK3g=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1786006017; c=relaxed/simple;
	bh=G59VGDA6rhTXCxCP3iHlNCuRW3WqGdznOrZvREZZi/0=;
	h=From:To:CC:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=n0Ip45bPUua7+0ir9dTJtj/qAX71v7QhM0c7I/QzXUCkXeki0KNb3thHSDEZTsgggdp/NlS4TkGPf4mg5qzlAXwYgxp2fsr5npzjkx8YPlgLmV1qlpp7aJAQsk8bfiqn1bAN+0vVUxW7Lu5fsPc1Xn7l+0TiaeLnA27gkJhYmmk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=microchip.com; spf=pass smtp.mailfrom=microchip.com; dkim=pass (2048-bit key) header.d=microchip.com header.i=@microchip.com header.b=ge7ahfSA; arc=none smtp.client-ip=68.232.154.123
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=microchip.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=microchip.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=microchip.com header.i=@microchip.com header.b="ge7ahfSA"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=microchip.com; i=@microchip.com; q=dns/txt; s=mchp;
  t=1786006015; x=1817542015;
  h=from:to:cc:subject:date:message-id:in-reply-to:
   references:mime-version:content-transfer-encoding;
  bh=G59VGDA6rhTXCxCP3iHlNCuRW3WqGdznOrZvREZZi/0=;
  b=ge7ahfSAq+O9FsNezs9QaEzahnq8G0M2a+8NIuWSaG3kg7hn9x+DCNne
   RxXNk0eCFm5IX4JM6ouhf1jj9Xgqr64eo/dE8oblTvv1Uuc+RqWW/YuRw
   v6rJXqzvWlaqGdbZskYUUyF6ju/3fgke1aATeUnfr2ogI40naTgGrGn9U
   rcW8meah44t08xoz040oWLvKwbAbH9JI5YW3/vkyKF3QP3LJdCNvS/A2B
   Jjuauud1ivyzEQdrzonx9rQtNRvQLxZvZo3aHI7vL1+xo9uuzg8riRx5N
   WPwiQSMxxTxPipNGNmapcE5/O4kcWds97q9M9mMpGx/WoFNpq3+SJ3jBz
   g==;
X-CSE-ConnectionGUID: ixmKcRJUSUqx/8+EoaHqZw==
X-CSE-MsgGUID: xiUz6Ng2QMOWtNXMvUTKtQ==
X-IronPort-AV: E=Sophos;i="6.25,208,1779174000"; 
   d="scan'208";a="62050862"
X-Amp-Result: SKIPPED(no attachment in message)
Received: from unknown (HELO email.microchip.com) ([170.129.1.10])
  by esa2.microchip.iphmx.com with ESMTP/TLS/ECDHE-RSA-AES128-GCM-SHA256; 06 Aug 2026 01:46:54 -0700
Received: from chn-vm-ex03.mchp-main.com (10.10.85.151) by
 chn-vm-ex02.mchp-main.com (10.10.85.144) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.58; Thu, 6 Aug 2026 01:46:53 -0700
Received: from che-ll-i67070.microchip.com (10.10.85.11) by
 chn-vm-ex03.mchp-main.com (10.10.85.151) with Microsoft SMTP Server id
 15.1.2507.58 via Frontend Transport; Thu, 6 Aug 2026 01:46:44 -0700
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
Subject: [PATCH v6 01/17] dt-bindings: iio: adc: at91-sama5d2: document sama7d65
Date: Thu, 6 Aug 2026 13:10:08 +0530
Message-ID: <20260806074024.531259-2-varshini.rajendran@microchip.com>
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

