Received: from twmbx01.aspeedtech.com (mail.aspeedtech.com [211.20.114.72])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id AD4EB46AA8D;
	Mon,  5 Oct 2026 10:23:04 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=211.20.114.72
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1791195786; cv=none; b=bwhmKFEDedSUcNA9/l8Ihf964gLLKdcUU3V7EeFzrGMNwsBw/VGPb0rlkIjJnaBE2FeKtjeMKyuLfYK3kg49oTbfZUBZAc88jgCvwmG+Ppw6oF7NW6Kx1K0ZbO2zNDtgMG3QpgAP/Oz7mwYf7a4bCZmtP7ih3xGMbeO04dJWzw8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1791195786; c=relaxed/simple;
	bh=CeLk4QqCfcUMyf15HORG2ynxSmeffa9/z/bSNsesTW8=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-ID:References:
	 In-Reply-To:To:CC; b=t4o482RlWSYkyXOyi25H2iRRo5AJSFnLPMF+4zfLWnQ9DJQ4WV3s4BD5JXXNYSke47BaNEQMwNbwAxbRM0PklArzbdPWRQMO/Zn4IV4ZT7x/NZIh6UXd3ekwwT0G5dSpnU0pdXwRDJQRGPTeGpSCMtwV4rbSXYY3HghTfMQffkc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=aspeedtech.com; spf=pass smtp.mailfrom=aspeedtech.com; arc=none smtp.client-ip=211.20.114.72
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=aspeedtech.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=aspeedtech.com
Received: from TWMBX01.aspeed.com (192.168.0.62) by TWMBX01.aspeed.com
 (192.168.0.62) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.1748.10; Mon, 5 Oct
 2026 18:22:54 +0800
Received: from [127.0.1.1] (192.168.10.13) by TWMBX01.aspeed.com
 (192.168.0.62) with Microsoft SMTP Server id 15.2.1748.10 via Frontend
 Transport; Mon, 5 Oct 2026 18:22:54 +0800
From: Billy Tsai <billy_tsai@aspeedtech.com>
Date: Mon, 5 Oct 2026 18:22:53 +0800
Subject: [PATCH v3 1/3] dt-bindings: iio: adc: Add syscon property for
 multi-SCU SoCs
Precedence: bulk
X-Mailing-List: linux-iio@vger.kernel.org
List-Id: <linux-iio.vger.kernel.org>
List-Subscribe: <mailto:linux-iio+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-iio+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-ID: <20261005-ast27xx-adc-upstream-v3-1-ef25552d3a59@aspeedtech.com>
References: <20261005-ast27xx-adc-upstream-v3-0-ef25552d3a59@aspeedtech.com>
In-Reply-To: <20261005-ast27xx-adc-upstream-v3-0-ef25552d3a59@aspeedtech.com>
To: Jonathan Cameron <jic23@kernel.org>, David Lechner
	<dlechner@baylibre.com>, =?utf-8?q?Nuno_S=C3=A1?= <nuno.sa@analog.com>, "Andy
 Shevchenko" <andy@kernel.org>, Rob Herring <robh@kernel.org>, "Krzysztof
 Kozlowski" <krzk+dt@kernel.org>, Conor Dooley <conor+dt@kernel.org>, "Joel
 Stanley" <joel@jms.id.au>, Andrew Jeffery <andrew@codeconstruct.com.au>,
	"Ryan Chen" <ryan_chen@aspeedtech.com>
CC: <linux-iio@vger.kernel.org>, <devicetree@vger.kernel.org>,
	<linux-arm-kernel@lists.infradead.org>, <linux-aspeed@lists.ozlabs.org>,
	<linux-kernel@vger.kernel.org>, Billy Tsai <billy_tsai@aspeedtech.com>,
	Jonathan Cameron <jic23@kernel.org>, Krzysztof Kozlowski
	<krzysztof.kozlowski@oss.qualcomm.com>
X-Mailer: b4 0.14.3
X-Developer-Signature: v=1; a=ed25519-sha256; t=1791195774; l=1812;
 i=billy_tsai@aspeedtech.com; s=20251118; h=from:subject:message-id;
 bh=CeLk4QqCfcUMyf15HORG2ynxSmeffa9/z/bSNsesTW8=;
 b=p8yITQ9TACsK+jl5kkQdqmqJd/sIom+z9wIsD84sc+fJMFvBVo2cJkPUv3fMVUj5y6tiGmrWG
 UlkkWtxfkhDA+kvSdc/B3+ozuLPzKNGBcra0aaxsp5vhv+odpxxcUp0
X-Developer-Key: i=billy_tsai@aspeedtech.com; a=ed25519;
 pk=/A8qvgZ6CPfnwKgT6/+k+nvXOkN477MshEGJvVdzeeQ=

The ADC's reference-voltage trimming data lives in a System Control
Unit (SCU) register. SoCs with a single SCU instance let the driver
locate it without any additional information, but SoCs such as AST2700
that expose more than one SCU node need an explicit phandle to
disambiguate which one holds the trimming data.

Add an "aspeed,trim-syscon" phandle property, and require it for the
AST2700 compatibles since they are the first multi-SCU SoCs supported
by this driver.

Assisted-by: LLM
Reviewed-by: Krzysztof Kozlowski <krzysztof.kozlowski@oss.qualcomm.com>
Signed-off-by: Billy Tsai <billy_tsai@aspeedtech.com>
---
 .../devicetree/bindings/iio/adc/aspeed,ast2600-adc.yaml | 17 +++++++++++++++++
 1 file changed, 17 insertions(+)

diff --git a/Documentation/devicetree/bindings/iio/adc/aspeed,ast2600-adc.yaml b/Documentation/devicetree/bindings/iio/adc/aspeed,ast2600-adc.yaml
index 249101b55cf4e..140d7034e2196 100644
--- a/Documentation/devicetree/bindings/iio/adc/aspeed,ast2600-adc.yaml
+++ b/Documentation/devicetree/bindings/iio/adc/aspeed,ast2600-adc.yaml
@@ -67,6 +67,11 @@ properties:
     description:
       Inform the driver that last channel will be used to sensor battery.
 
+  aspeed,trim-syscon:
+    $ref: /schemas/types.yaml#/definitions/phandle
+    description:
+      Phandle to the SCU holding the ADC's reference-voltage trimming data.
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
+        - aspeed,trim-syscon
+
 additionalProperties: false
 
 examples:

-- 
2.34.1

