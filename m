Received: from esa.microchip.iphmx.com (esa.microchip.iphmx.com [68.232.154.123])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C5CB33546C1;
	Tue, 23 Jun 2026 11:00:36 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=68.232.154.123
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1782212438; cv=none; b=XuMNSaI+axaCNBjBq+1kkBndoZH2wgPb5u2iFM9XoJndi/I1D9FsHuoRmLYqncD03jShFhg+rBQSUY0RPCZUx/deWEw1Sj4bb32CCNSSeEltRg8eXul4IENVyliT81oZpL/fF3lOQkpydH/zG38y6ie1dfgtZn6Q4Qj7offGLdM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1782212438; c=relaxed/simple;
	bh=8SqdaiIS6Qy1xziTpkitvj8Bg/i5SzTlOVrsER7CPzY=;
	h=From:To:CC:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=tmfkg1ZfuPDF8fNTkE0BHZXHD5dpMwV0mG73D0wMzPyllwMYAo2Urhr7+vw8DLAmOw7x9khMgWxw3YGKmH/n1KPnTD5NJQomjEVZi2n9EcasqRpomVDE900n/pDIbTMzenp6M7Ow9yNvjk2siSuAmbTful/CaGFLIFqC2usNJYA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=microchip.com; spf=pass smtp.mailfrom=microchip.com; dkim=pass (2048-bit key) header.d=microchip.com header.i=@microchip.com header.b=mQH34x+D; arc=none smtp.client-ip=68.232.154.123
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=microchip.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=microchip.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=microchip.com header.i=@microchip.com header.b="mQH34x+D"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=microchip.com; i=@microchip.com; q=dns/txt; s=mchp;
  t=1782212436; x=1813748436;
  h=from:to:cc:subject:date:message-id:in-reply-to:
   references:mime-version:content-transfer-encoding;
  bh=8SqdaiIS6Qy1xziTpkitvj8Bg/i5SzTlOVrsER7CPzY=;
  b=mQH34x+DFD1NoY/J9jgT8BJXE9wmXq5q+k2xGb49BG966p96GF+neI8N
   2cJkh2voncH60zEJVCDW2kd9Dkhfpsk1FTqYIDq4mMBFyuKHcxzF2l1Ot
   ktG1oZh2g7lnykmQsXW+ySKzcZvGDYms56BqriE8XSMdb6OGXQohbhkO+
   i9row/uvjo55g1fvAw3XMAgqmya6rwrpLmRPT3qtJ2QhNvj4gELxp6/yd
   5JDI+6WbJ6oXAzPLjHPoj9uMRfKg6J8+46SoDCsaj3pJ0F3oWpHlr1DlX
   DNImBZlXAeIIFp+V2zH+BYyMkasXQ00GKT0ml+5n3EHG9CitGo+qOg21X
   g==;
X-CSE-ConnectionGUID: xeDfIW6TTOGl8izz4/LUdg==
X-CSE-MsgGUID: pamKiZP5QM+kImGPVYYSBQ==
X-IronPort-AV: E=Sophos;i="6.24,220,1774335600"; 
   d="scan'208";a="226724836"
X-Amp-Result: SKIPPED(no attachment in message)
Received: from unknown (HELO email.microchip.com) ([170.129.1.10])
  by esa6.microchip.iphmx.com with ESMTP/TLS/ECDHE-RSA-AES128-GCM-SHA256; 23 Jun 2026 04:00:35 -0700
Received: from chn-vm-ex03.mchp-main.com (10.10.85.151) by
 chn-vm-ex02.mchp-main.com (10.10.85.144) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.58; Tue, 23 Jun 2026 04:00:35 -0700
Received: from che-ll-i67070.microchip.com (10.10.85.11) by
 chn-vm-ex03.mchp-main.com (10.10.85.151) with Microsoft SMTP Server id
 15.1.2507.58 via Frontend Transport; Tue, 23 Jun 2026 04:00:26 -0700
From: Varshini Rajendran <varshini.rajendran@microchip.com>
To: <ehristev@kernel.org>, <jic23@kernel.org>, <dlechner@baylibre.com>,
	<nuno.sa@analog.com>, <andy@kernel.org>, <robh@kernel.org>,
	<krzk+dt@kernel.org>, <conor+dt@kernel.org>, <nicolas.ferre@microchip.com>,
	<alexandre.belloni@bootlin.com>, <claudiu.beznea@tuxon.dev>,
	<srini@kernel.org>, <linux-iio@vger.kernel.org>,
	<devicetree@vger.kernel.org>, <linux-arm-kernel@lists.infradead.org>,
	<linux-kernel@vger.kernel.org>
CC: <varshini.rajendran@microchip.com>
Subject: [PATCH v2 04/12] dt-bindings: nvmem: microchip,sama7g5-otpc: add sama7d65 and dt node example
Date: Tue, 23 Jun 2026 16:29:36 +0530
Message-ID: <20260623105944.128840-5-varshini.rajendran@microchip.com>
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

Add support for sama7d65 and a dt node example that shows tag can be used
to reference a packet stored in the OTP memory.

Signed-off-by: Varshini Rajendran <varshini.rajendran@microchip.com>
---
 .../nvmem/microchip,sama7g5-otpc.yaml         | 28 +++++++++++++++++--
 1 file changed, 25 insertions(+), 3 deletions(-)

diff --git a/Documentation/devicetree/bindings/nvmem/microchip,sama7g5-otpc.yaml b/Documentation/devicetree/bindings/nvmem/microchip,sama7g5-otpc.yaml
index cc25f2927682..3cc16b0044a6 100644
--- a/Documentation/devicetree/bindings/nvmem/microchip,sama7g5-otpc.yaml
+++ b/Documentation/devicetree/bindings/nvmem/microchip,sama7g5-otpc.yaml
@@ -20,9 +20,15 @@ allOf:
 
 properties:
   compatible:
-    items:
-      - const: microchip,sama7g5-otpc
-      - const: syscon
+    oneOf:
+      - items:
+          - const: microchip,sama7g5-otpc
+          - const: syscon
+      - items:
+          - enum:
+              - microchip,sama7d65-otpc
+          - const: microchip,sama7g5-otpc
+          - const: syscon
 
   reg:
     maxItems: 1
@@ -48,4 +54,20 @@ examples:
         };
     };
 
+  - |
+    otp_controller: efuse@e8c00000 {
+        compatible = "microchip,sama7d65-otpc", "microchip,sama7g5-otpc", "syscon";
+        reg = <0xe8c00000 0x100>;
+
+        nvmem-layout {
+            compatible = "fixed-layout";
+            #address-cells = <1>;
+            #size-cells = <1>;
+
+            temp_calib: calib@41435354 {
+                reg = <0x41435354 0x2c>;    /* Temp calib data packet TAG */
+            };
+        };
+    };
+
 ...
-- 
2.34.1

