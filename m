Received: from esa.microchip.iphmx.com (esa.microchip.iphmx.com [68.232.153.233])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 96A9241CB39;
	Thu,  6 Aug 2026 08:48:05 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=68.232.153.233
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1786006087; cv=none; b=Jz810PqYAKxdAfof+HW8/YbckZXUYAYjEaSL0Ai67VyTJ5FQB+6RMc647STXe65bG2QiQeg/l1UUJhgNJI4BzMF+OemfsfTvhWPQ4R8C7rOsjVVApMlGh9/YCueBF+LiFwPFfUJLivqjLz9fYbSabqYOvdWcOLMf44t3k4BMc/Y=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1786006087; c=relaxed/simple;
	bh=bCA8BUnUCacAeM9L4GkNBcOulMHRN3ZMV7gjy96hcXs=;
	h=From:To:CC:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=siyChZALwSrzEipGrzY5kRvB8poIgz6wKNWUuM9HtVxTm6LbFG7XVVRXfL7CvIopqumCIVDg10M1pGOzKMkj8gbMpLVbx48c0UVRyizwUbtpYvlfNVRnSsxykLPbo/6onPFSTRyTTFE2eogB44r0QVXTblZkRfSCxCr0JDfbwHo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=microchip.com; spf=pass smtp.mailfrom=microchip.com; dkim=pass (2048-bit key) header.d=microchip.com header.i=@microchip.com header.b=iVkqdiNi; arc=none smtp.client-ip=68.232.153.233
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=microchip.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=microchip.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=microchip.com header.i=@microchip.com header.b="iVkqdiNi"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=microchip.com; i=@microchip.com; q=dns/txt; s=mchp;
  t=1786006086; x=1817542086;
  h=from:to:cc:subject:date:message-id:in-reply-to:
   references:mime-version:content-transfer-encoding;
  bh=bCA8BUnUCacAeM9L4GkNBcOulMHRN3ZMV7gjy96hcXs=;
  b=iVkqdiNicSKM0AgwOVNRsXZ83bPtbvQBRb1aFSRXuiRfxcrRjXKCPk7d
   GuDeGbvYCdaT6L3UjqB3Nd8XE/fswbipcW5Y9gsJqYEfFLrTZ82Nyt1Dy
   BWK1yDFpeAOF8yK+2+OwFvU6upHf2C139hn/vrZVMfPuIjaDjdYh+bXAW
   3Wtl89R003n39GndcLKKirQqtfzJGBqLefr4m74dCSJ2FkS9iaHjHLMAc
   pfxKd9/K/rCchlWGUgU0IbXTXGWEM34atYp3eWrNNF2X8aG6JPR0xXXJE
   0a1kFahzAkGdEyQ9nD+nkPXDIM8Un3NVeeBYXiGdPcfKjPNqfN7iKhsv9
   A==;
X-CSE-ConnectionGUID: SP0wRg71Tc+6ntZ+lvX79w==
X-CSE-MsgGUID: h/SNKm7qSmqEOdQiGk+FIw==
X-IronPort-AV: E=Sophos;i="6.25,208,1779174000"; 
   d="scan'208";a="61741619"
X-Amp-Result: SKIPPED(no attachment in message)
Received: from unknown (HELO email.microchip.com) ([170.129.1.10])
  by esa3.microchip.iphmx.com with ESMTP/TLS/ECDHE-RSA-AES128-GCM-SHA256; 06 Aug 2026 01:48:05 -0700
Received: from chn-vm-ex03.mchp-main.com (10.10.85.151) by
 chn-vm-ex03.mchp-main.com (10.10.85.151) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.58; Thu, 6 Aug 2026 01:48:04 -0700
Received: from che-ll-i67070.microchip.com (10.10.85.11) by
 chn-vm-ex03.mchp-main.com (10.10.85.151) with Microsoft SMTP Server id
 15.1.2507.58 via Frontend Transport; Thu, 6 Aug 2026 01:47:55 -0700
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
CC: Conor Dooley <conor.dooley@microchip.com>
Subject: [PATCH v6 08/17] dt-bindings: nvmem: microchip,sama7g5-otpc: add sama7d65 and dt node example
Date: Thu, 6 Aug 2026 13:10:15 +0530
Message-ID: <20260806074024.531259-9-varshini.rajendran@microchip.com>
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

Add support for sama7d65 and a dt node example that shows tag can be used
to reference a packet stored in the OTP memory.

Signed-off-by: Varshini Rajendran <varshini.rajendran@microchip.com>
Acked-by: Conor Dooley <conor.dooley@microchip.com>
---
 .../nvmem/microchip,sama7g5-otpc.yaml         | 28 +++++++++++++++++--
 1 file changed, 25 insertions(+), 3 deletions(-)

diff --git a/Documentation/devicetree/bindings/nvmem/microchip,sama7g5-otpc.yaml b/Documentation/devicetree/bindings/nvmem/microchip,sama7g5-otpc.yaml
index cc25f2927682..04b44660554e 100644
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
+    efuse@e8c00000 {
+        compatible = "microchip,sama7d65-otpc", "microchip,sama7g5-otpc", "syscon";
+        reg = <0xe8c00000 0x100>;
+
+        nvmem-layout {
+            compatible = "fixed-layout";
+            #address-cells = <1>;
+            #size-cells = <1>;
+
+            calib@41435354 {
+                reg = <0x41435354 0x2c>;    /* Temp calib data packet TAG */
+            };
+        };
+    };
+
 ...
-- 
2.34.1

