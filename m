Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7C4FF3F4DEA;
	Tue,  9 Jun 2026 10:13:11 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1780999991; cv=none; b=ClA76pPjg2JuUNg+pjs/1eYerTYhNuOovFBhLY8UOnL5mMJ58WXxJCBJx6C85lFy8r8eCYg/vlEwJb+3XmVm3xTq8dQ9redwItv7t6eWCr/t7uk5/zpX4h4y7NVUy40F97Y+hNVumoTGFj8XLAUXm1sV/zQL4MQoVAd/BBjOnsE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1780999991; c=relaxed/simple;
	bh=PfzvH81Ajnwxo8skiVPyd2mjdF+LjWFrsS2NC+DT7Uc=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=lK3u98mbyBHIouOU5jEtOovwkZLd7KbtFQNSbHRq9Uzlg2lncLj+4b6sbxXXSm9Nsy+q9Qvl0BUI7r5astmJjjIEvVkfLNX0sw5ngdQjkYNy4gXgYFSVNo2OBcwpNUYC3V0UXZBQ/HIOq2SVswvxYT6xxsZZAASKtCaLQqALsUU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=lfpN0D01; arc=none smtp.client-ip=10.30.226.201
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="lfpN0D01"
Received: by smtp.kernel.org (Postfix) with ESMTPS id 5AEB6C4AF0D;
	Tue,  9 Jun 2026 10:13:11 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1780999991;
	bh=PfzvH81Ajnwxo8skiVPyd2mjdF+LjWFrsS2NC+DT7Uc=;
	h=From:Date:Subject:References:In-Reply-To:To:Cc:Reply-To:From;
	b=lfpN0D01Vwu9mxKULLsKoZePguibhkmCrHNvHdop6Pu0eS3v/aEGhw5pACapQVYq5
	 lyeVp0KOmPX9SySmpUJqXgj+QOh3SVXTx6vUsDHdskY8b01L1uPtSqWlk7aiXsf07S
	 5nEBRv6c+ClVNJA1rm3FKJN1nszHoGFrtld7Ecae7KL1yVz1oOf5MJkx26tF1dUgdW
	 g+ImsH+kbJEMdf5Bpv9tUNE94wRcj1fnhDpU7sfKW6S6xSc6zcMBCQdEeXMVvxcjw1
	 L8d3EUxZKASPPYlLbOokJWJ2HQ6MbDgNfHEFXQp1fT3AFXHJUVu/3IMWHoWyhn+Sr4
	 djXuVxxe7gaag==
Received: from aws-us-west-2-korg-lkml-1.web.codeaurora.org (localhost.localdomain [127.0.0.1])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 3E669CD8CA4;
	Tue,  9 Jun 2026 10:13:11 +0000 (UTC)
From: Rodrigo Alencar via B4 Relay <devnull+rodrigo.alencar.analog.com@kernel.org>
Date: Tue, 09 Jun 2026 11:12:58 +0100
Subject: [PATCH v2 03/12] dt-bindings: iio: dac: ad5686: add
 reset/ldac/gain gpio support
Precedence: bulk
X-Mailing-List: linux-iio@vger.kernel.org
List-Id: <linux-iio.vger.kernel.org>
List-Subscribe: <mailto:linux-iio+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-iio+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20260609-ad5686-new-features-v2-3-70b423f5c76d@analog.com>
References: <20260609-ad5686-new-features-v2-0-70b423f5c76d@analog.com>
In-Reply-To: <20260609-ad5686-new-features-v2-0-70b423f5c76d@analog.com>
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
X-Developer-Signature: v=1; a=ed25519-sha256; t=1780999989; l=2266;
 i=rodrigo.alencar@analog.com; s=default; h=from:subject:message-id;
 bh=Rs2rqZGq7IiMu22sP4N1aq9P+WM2P1YWJFniol3eG0I=;
 b=6R73OAW/BhEU4k4srCmXzFmmRWr1FzTTXS756o49auX3RJFmBJt3zuUFwDL2MGCPtxxm4lHmD
 uIhCUB3VS9YDRLVtYtpy/AtMJy9RjfHGVZYOKE9vMObJgivOQxVSIJI
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
not available to all supported parts.

Acked-by: Conor Dooley <conor.dooley@microchip.com>
Signed-off-by: Rodrigo Alencar <rodrigo.alencar@analog.com>
---
 .../devicetree/bindings/iio/dac/adi,ad5686.yaml    | 31 ++++++++++++++++++++++
 1 file changed, 31 insertions(+)

diff --git a/Documentation/devicetree/bindings/iio/dac/adi,ad5686.yaml b/Documentation/devicetree/bindings/iio/dac/adi,ad5686.yaml
index 713f535bb33a..4680d4753dd4 100644
--- a/Documentation/devicetree/bindings/iio/dac/adi,ad5686.yaml
+++ b/Documentation/devicetree/bindings/iio/dac/adi,ad5686.yaml
@@ -35,17 +35,46 @@ properties:
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
 required:
   - compatible
   - reg
 
 allOf:
   - $ref: /schemas/spi/spi-peripheral-props.yaml#
+  - if:
+      properties:
+        compatible:
+          contains:
+            anyOf:
+              - const: adi,ad5310r
+              - const: adi,ad5681r
+              - const: adi,ad5682r
+              - const: adi,ad5683
+              - const: adi,ad5683r
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
@@ -53,6 +82,8 @@ examples:
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


