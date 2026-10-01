Received: from twmbx01.aspeedtech.com (mail.aspeedtech.com [211.20.114.72])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 38DF83E008F;
	Thu,  1 Oct 2026 03:29:00 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=211.20.114.72
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1790825353; cv=none; b=aZ35dz+ss82H9hropmhF7voa8VMMaWvphtFw9oAmSTia8NLuj0IEsuCwCNpljzJnUPOHPvUv97UGIvOgO2WXyOtvMci/jLpAhpzmTOY+7vnYCjqzrzF2Y6uOqyyBPzfZK3996jMgkg5498wcsEZ+ORmi629uEO3JFjtBXnPpvC0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1790825353; c=relaxed/simple;
	bh=FsGT1zbL6rxTYT0DVNlN72Kt+1ynoxmzD31cbn5Esb0=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-ID:References:
	 In-Reply-To:To:CC; b=KWCOZRzqqACiCr6Ejyxq12eSjFqzBRFjUL6bnfSFnrrTD/ZOpGi5qA9irTeunGhweJve0qf3vtOxQeQdIK/a+yXbuu3GwqC2xFWjIAXFp2ayD0720l2nJwCmbUDzkoL11voW4r3QdNutuBt5VEp+fBRaorz9tmijNMeVZb8Agn0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=aspeedtech.com; spf=pass smtp.mailfrom=aspeedtech.com; arc=none smtp.client-ip=211.20.114.72
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=aspeedtech.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=aspeedtech.com
Received: from TWMBX01.aspeed.com (192.168.0.62) by TWMBX01.aspeed.com
 (192.168.0.62) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.1748.10; Thu, 1 Oct
 2026 11:28:45 +0800
Received: from [127.0.1.1] (192.168.10.13) by TWMBX01.aspeed.com
 (192.168.0.62) with Microsoft SMTP Server id 15.2.1748.10 via Frontend
 Transport; Thu, 1 Oct 2026 11:28:45 +0800
From: Billy Tsai <billy_tsai@aspeedtech.com>
Date: Thu, 1 Oct 2026 11:28:44 +0800
Subject: [PATCH 1/3] dt-bindings: iio: adc: Add syscon property for
 multi-SCU SoCs
Precedence: bulk
X-Mailing-List: linux-iio@vger.kernel.org
List-Id: <linux-iio.vger.kernel.org>
List-Subscribe: <mailto:linux-iio+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-iio+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-ID: <20261001-ast27xx-adc-upstream-v1-1-5ace57533418@aspeedtech.com>
References: <20261001-ast27xx-adc-upstream-v1-0-5ace57533418@aspeedtech.com>
In-Reply-To: <20261001-ast27xx-adc-upstream-v1-0-5ace57533418@aspeedtech.com>
To: Jonathan Cameron <jic23@kernel.org>, David Lechner
	<dlechner@baylibre.com>, =?utf-8?q?Nuno_S=C3=A1?= <nuno.sa@analog.com>, "Andy
 Shevchenko" <andy@kernel.org>, Rob Herring <robh@kernel.org>, "Krzysztof
 Kozlowski" <krzk+dt@kernel.org>, Conor Dooley <conor+dt@kernel.org>, "Joel
 Stanley" <joel@jms.id.au>, Andrew Jeffery <andrew@codeconstruct.com.au>,
	"Ryan Chen" <ryan_chen@aspeedtech.com>
CC: <linux-iio@vger.kernel.org>, <devicetree@vger.kernel.org>,
	<linux-arm-kernel@lists.infradead.org>, <linux-aspeed@lists.ozlabs.org>,
	<linux-kernel@vger.kernel.org>, Billy Tsai <billy_tsai@aspeedtech.com>,
	Jonathan Cameron <jic23@kernel.org>
X-Mailer: b4 0.14.3
X-Developer-Signature: v=1; a=ed25519-sha256; t=1790825325; l=2250;
 i=billy_tsai@aspeedtech.com; s=20251118; h=from:subject:message-id;
 bh=FsGT1zbL6rxTYT0DVNlN72Kt+1ynoxmzD31cbn5Esb0=;
 b=iiLL+6sgRQAuRmZdFxMpNwDwxz4WK9BDIu+XM8WhKlgLD5WieKxUpiRgWTyiNfTxp6PsnUs2F
 OSn1Dk0UIOECdFmC6HXqdGOQdq4yd9WL9+2W0UOt0jpkHWCII0Lar3m
X-Developer-Key: i=billy_tsai@aspeedtech.com; a=ed25519;
 pk=/A8qvgZ6CPfnwKgT6/+k+nvXOkN477MshEGJvVdzeeQ=

The ADC's reference-voltage trimming data lives in a System Control
Unit (SCU) register. SoCs with a single SCU instance let the driver
locate it without any additional information, but SoCs such as AST2700
that expose more than one SCU node need an explicit phandle to
disambiguate which one holds the trimming data.

Add an optional "syscon" phandle property, and require it for the
AST2700 compatibles since they are the first multi-SCU SoCs supported
by this driver.

Signed-off-by: Billy Tsai <billy_tsai@aspeedtech.com>
Assisted-by: Claude:claude-sonnet-5
---
 .../bindings/iio/adc/aspeed,ast2600-adc.yaml       | 28 ++++++++++++++++++++++
 1 file changed, 28 insertions(+)

diff --git a/Documentation/devicetree/bindings/iio/adc/aspeed,ast2600-adc.yaml b/Documentation/devicetree/bindings/iio/adc/aspeed,ast2600-adc.yaml
index 249101b55cf4e..0d6b10450cfa8 100644
--- a/Documentation/devicetree/bindings/iio/adc/aspeed,ast2600-adc.yaml
+++ b/Documentation/devicetree/bindings/iio/adc/aspeed,ast2600-adc.yaml
@@ -67,6 +67,11 @@ properties:
     description:
       Inform the driver that last channel will be used to sensor battery.
 
+  syscon:
+    $ref: /schemas/types.yaml#/definitions/phandle
+    description:
+      Required on SoCs with more than one SCU instance (e.g. AST2700).
+
 required:
   - compatible
   - reg
@@ -74,6 +79,18 @@ required:
   - resets
   - "#io-channel-cells"
 
+allOf:
+  - if:
+      properties:
+        compatible:
+          contains:
+            enum:
+              - aspeed,ast2700-adc0
+              - aspeed,ast2700-adc1
+    then:
+      required:
+        - syscon
+
 additionalProperties: false
 
 examples:
@@ -95,4 +112,15 @@ examples:
         #io-channel-cells = <1>;
         aspeed,int-vref-microvolt = <2500000>;
     };
+  - |
+    #include <dt-bindings/clock/aspeed,ast2700-scu.h>
+    #include <dt-bindings/reset/aspeed,ast2700-scu.h>
+    adc0: adc@14c00000 {
+        compatible = "aspeed,ast2700-adc0";
+        reg = <0x14c00000 0x100>;
+        clocks = <&syscon1 SCU1_CLK_AHB>;
+        resets = <&syscon1 SCU1_RESET_ADC>;
+        syscon = <&syscon1>;
+        #io-channel-cells = <1>;
+    };
 ...

-- 
2.34.1

