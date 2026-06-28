Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 562B53A962E;
	Sun, 28 Jun 2026 14:09:54 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1782655794; cv=none; b=A2Bwp/fRvZDEqYuFaMOlbQdYuu0A25UHXQZpllPK3Oodnx/rxsdWOxBXNW7/UzLf80WVIdpzdSv6gPnob624XIAnxsLAzer9t74YKV4V/0vugd2GSObU8yyMNQxDSHatggCaW3lPVGsj6vpXq7VtN1JAJKZQk/tQ0GPHjtMZ72g=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1782655794; c=relaxed/simple;
	bh=hL7Re/t/yiLNcH5PjRNoJluhv+GCRcTVUyTSOP5c3wU=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=WDSrHRZ1IGRPrbbavMzHpPO5d17rL904WNjdg04ghfE85JUnWYU1KxtSHpQ6LmrFfFNNoURrXMJ57n9tduH1rEXOOOMAg0esE+ik0/5YE0qRVEusBOXqJmAhu2VDQ3DdyyRMF1/0R0dUIVv07H10wkG9mn6Lahk8fooSnwcMV6c=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=WWMu5U4Q; arc=none smtp.client-ip=10.30.226.201
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="WWMu5U4Q"
Received: by smtp.kernel.org (Postfix) with ESMTPS id 12148C4AF0B;
	Sun, 28 Jun 2026 14:09:54 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1782655794;
	bh=hL7Re/t/yiLNcH5PjRNoJluhv+GCRcTVUyTSOP5c3wU=;
	h=From:Date:Subject:References:In-Reply-To:To:Cc:Reply-To:From;
	b=WWMu5U4Q+Zdu5U3dBb8W9VXVB+DvlsRDJaCeVaYTx90zNyW30LGomfO729g9o1a6s
	 u3145LlwyPcLonpI95sdlfsKRPKx42dYkQcFiiYouD9G9IEjKEyDFWeBQi3wv+Dug0
	 A419uIygjixWuN/21dbXvC7jCbbeOYQorMDFbwswpvaLTk57BFRZ+qH4V2WSmzDUqw
	 aU2iA/XRLPUit2+MrxH5q9TAxsoVygTmG65Sau1RFRGFPY4CJ/FgWjwa10kO9g6vpI
	 JehFw/2i5ZMjngleZqIpdlhP0o1/AW855d1OjW+JtlsfHDJWxjtG16p+cCYP0z4a+s
	 3AwVfS8QOJVOw==
Received: from aws-us-west-2-korg-lkml-1.web.codeaurora.org (localhost.localdomain [127.0.0.1])
	by smtp.lore.kernel.org (Postfix) with ESMTP id F1603C43602;
	Sun, 28 Jun 2026 14:09:53 +0000 (UTC)
From: Rodrigo Alencar via B4 Relay <devnull+rodrigo.alencar.analog.com@kernel.org>
Date: Sun, 28 Jun 2026 15:08:10 +0100
Subject: [PATCH v5 03/12] dt-bindings: iio: dac: ad5686: add
 reset/ldac/gain support
Precedence: bulk
X-Mailing-List: linux-iio@vger.kernel.org
List-Id: <linux-iio.vger.kernel.org>
List-Subscribe: <mailto:linux-iio+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-iio+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20260628-ad5686-new-features-v5-3-577caadbf7c0@analog.com>
References: <20260628-ad5686-new-features-v5-0-577caadbf7c0@analog.com>
In-Reply-To: <20260628-ad5686-new-features-v5-0-577caadbf7c0@analog.com>
To: Michael Auchter <michael.auchter@ni.com>, linux@analog.com, 
 linux-iio@vger.kernel.org, devicetree@vger.kernel.org, 
 linux-kernel@vger.kernel.org, linux-hardening@vger.kernel.org
Cc: Michael Hennerich <Michael.Hennerich@analog.com>, 
 Jonathan Cameron <jic23@kernel.org>, David Lechner <dlechner@baylibre.com>, 
 Andy Shevchenko <andy@kernel.org>, Rob Herring <robh@kernel.org>, 
 Krzysztof Kozlowski <krzk+dt@kernel.org>, 
 Conor Dooley <conor+dt@kernel.org>, Philipp Zabel <p.zabel@pengutronix.de>, 
 Kees Cook <kees@kernel.org>, "Gustavo A. R. Silva" <gustavoars@kernel.org>, 
 Rodrigo Alencar <rodrigo.alencar@analog.com>, 
 Conor Dooley <conor.dooley@microchip.com>
X-Mailer: b4 0.14.3
X-Developer-Signature: v=1; a=ed25519-sha256; t=1782655792; l=2649;
 i=rodrigo.alencar@analog.com; s=default; h=from:subject:message-id;
 bh=tqSguVcv0F+ri4HoEKx7VIIb7gTICL++YlTges0Sc4s=;
 b=t+/YdzSVbKFlJBz+2RNnqhm3tFDldlu9UofnMbSe5nlp/wGXEid8LWc5cIQPRCDXvk1cp4myx
 4aJAWuyMoeqBTbUDuU63CAJaLygcO5VOp0b5Dq5P9l21mIQrYtVo8vv
X-Developer-Key: i=rodrigo.alencar@analog.com; a=ed25519;
 pk=ULeHbgU/OYh/PG/4anHDfLgldFItQHAhOktYRVLMFRo=
X-Endpoint-Received: by B4 Relay for rodrigo.alencar@analog.com/default
 with auth_id=561
X-Original-From: Rodrigo Alencar <rodrigo.alencar@analog.com>
Reply-To: rodrigo.alencar@analog.com

From: Rodrigo Alencar <rodrigo.alencar@analog.com>

Add GPIO property for RESET, LDAC and GAIN pin. RESET is active-low, LDAC
is used to load DAC channels with values from input registers and GAIN
can double the voltage in output channels. The gain-gpios property is
not available to all supported parts. The adi,range-double property
indicates that GAIN pin is hardwired to high in case gain-gpios is not
set, otherwise it sets the initial value for the gain setting.

Acked-by: Conor Dooley <conor.dooley@microchip.com>
Signed-off-by: Rodrigo Alencar <rodrigo.alencar@analog.com>
---
 .../devicetree/bindings/iio/dac/adi,ad5686.yaml    | 38 ++++++++++++++++++++++
 1 file changed, 38 insertions(+)

diff --git a/Documentation/devicetree/bindings/iio/dac/adi,ad5686.yaml b/Documentation/devicetree/bindings/iio/dac/adi,ad5686.yaml
index 713f535bb33a..d781baca6a6c 100644
--- a/Documentation/devicetree/bindings/iio/dac/adi,ad5686.yaml
+++ b/Documentation/devicetree/bindings/iio/dac/adi,ad5686.yaml
@@ -35,17 +35,53 @@ properties:
   vcc-supply:
     description: If not supplied the internal reference is used.
 
+  reset-gpios:
+    description: Active-low RESET pin to reset the device.
+    maxItems: 1
+
+  ldac-gpios:
+    description:
+      Active-low LDAC pin used to asynchronously update the DAC channels.
+    maxItems: 1
+
+  gain-gpios:
+    description:
+      GAIN pin that sets a multiplier for the DAC output voltage. When high,
+      the DAC output voltage is multiplied by 2, otherwise it is unchanged.
+    maxItems: 1
+
+  adi,range-double:
+    description:
+      Sets the initial voltage output range from 0 to 2xVREF. On devices that
+      have a GAIN pin and no gain-gpios property is set, this indicates the pin
+      is hardwired high.
+    type: boolean
+
 required:
   - compatible
   - reg
 
 allOf:
   - $ref: /schemas/spi/spi-peripheral-props.yaml#
+  - if:
+      properties:
+        compatible:
+          contains:
+            enum:
+              - adi,ad5310r
+              - adi,ad5681r
+              - adi,ad5682r
+              - adi,ad5683
+              - adi,ad5683r
+    then:
+      properties:
+        gain-gpios: false
 
 unevaluatedProperties: false
 
 examples:
   - |
+    #include <dt-bindings/gpio/gpio.h>
     spi {
         #address-cells = <1>;
         #size-cells = <0>;
@@ -53,6 +89,8 @@ examples:
             reg = <0>;
             compatible = "adi,ad5310r";
             vcc-supply = <&dac_vref0>;
+            reset-gpios = <&gpio0 0 GPIO_ACTIVE_LOW>;
+            ldac-gpios = <&gpio0 1 GPIO_ACTIVE_LOW>;
         };
     };
 ...

-- 
2.43.0


