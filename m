Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3B4AE3A48F1;
	Sun, 28 Jun 2026 14:09:54 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1782655794; cv=none; b=WInJN1eHQrWBw7itsud9GFdkDpUonivhZ6J5sFZeBQ8OUvg4VCqfKEu4mlwVW96aQ1B5ekagmF6ZMmHVGvOY7cr8PIV7GqGEdzi0Fc4BTThaLGSG/yri0HqYWcIR/ao2pk7JLEnz1SECGueRm0CfuDopJSXB36w59S5HOocxFM0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1782655794; c=relaxed/simple;
	bh=/hOn4fySUo5oVZeU7urQX1VDtPgooi3SzYzle9I35Oc=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=JSGqEDjFgWT3Rmr3rX4VEHN87ua5QVZZifOSHDr6zyZWs2Q0J+G/jluO1vuRzIHfq47Kly7RpElTXlG0dB4LwPREsKq1Q3j/TRvtNJ8PLfrJlFFGHGATcTxYhCgBIOgZa9AY04a8j7sWX5ID7Iztjd24IbPSTofZ/m/2Yy2ptW8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=Za+RBEfe; arc=none smtp.client-ip=10.30.226.201
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="Za+RBEfe"
Received: by smtp.kernel.org (Postfix) with ESMTPS id D9958C2BCC9;
	Sun, 28 Jun 2026 14:09:53 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1782655794;
	bh=/hOn4fySUo5oVZeU7urQX1VDtPgooi3SzYzle9I35Oc=;
	h=From:Date:Subject:References:In-Reply-To:To:Cc:Reply-To:From;
	b=Za+RBEfee6glWWzsgUK/zbArQ8a78kmUQPuIYaukILtT1YXM1dUeg7RF7RFUyGv7B
	 BSR7dcL4qPhoxSK3YPOj3q4mOM+e1Y2JjVCrmXUEEXvjRhIqewEM98Vkal6J1TUPkj
	 N2dXGvlgIOi6Ih1v7gMfKZsVDAicslMmASV8KWlG12Gnyx304X4qqn2CwhFASZA8lW
	 cl9bUpAVaBuKnDqdxzKH2hl0cVmR+VY7YL56Idm6b55P2jAk1rkQfEBSVGui4V75tx
	 UVHzNzmz5sQp+UCxkbN6ORxbjd+ZIDa/3IW0sOqji47SobysiYjTHSU+8SCN5M6jjo
	 x1GCSrdfY1kfQ==
Received: from aws-us-west-2-korg-lkml-1.web.codeaurora.org (localhost.localdomain [127.0.0.1])
	by smtp.lore.kernel.org (Postfix) with ESMTP id C2602C43327;
	Sun, 28 Jun 2026 14:09:53 +0000 (UTC)
From: Rodrigo Alencar via B4 Relay <devnull+rodrigo.alencar.analog.com@kernel.org>
Date: Sun, 28 Jun 2026 15:08:08 +0100
Subject: [PATCH v5 01/12] dt-bindings: iio: dac: ad5696: add
 reset/ldac/gain support
Precedence: bulk
X-Mailing-List: linux-iio@vger.kernel.org
List-Id: <linux-iio.vger.kernel.org>
List-Subscribe: <mailto:linux-iio+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-iio+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20260628-ad5686-new-features-v5-1-577caadbf7c0@analog.com>
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
X-Developer-Signature: v=1; a=ed25519-sha256; t=1782655792; l=2510;
 i=rodrigo.alencar@analog.com; s=default; h=from:subject:message-id;
 bh=u5R3874jHfOu97aR2wSSkYPIPtcGkPorklx5wMrHEeo=;
 b=G+qsiJ8GUPVh7rCOQxyfgW6E4j+f6omNXzpWVD+ufG/dg0FiBBK/G944TsOA+kWzgHgps/68K
 HQJxKP3GqIaBu3hOnxnFck6fvsLGM1eEicrkM2h6+TlvHuO13nm0+v3
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
 .../devicetree/bindings/iio/dac/adi,ad5696.yaml    | 39 ++++++++++++++++++++++
 1 file changed, 39 insertions(+)

diff --git a/Documentation/devicetree/bindings/iio/dac/adi,ad5696.yaml b/Documentation/devicetree/bindings/iio/dac/adi,ad5696.yaml
index b5a88b03dc2f..cc343cdf6085 100644
--- a/Documentation/devicetree/bindings/iio/dac/adi,ad5696.yaml
+++ b/Documentation/devicetree/bindings/iio/dac/adi,ad5696.yaml
@@ -37,14 +37,52 @@ properties:
     description: |
       The regulator supply for DAC reference voltage.
 
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
 
+allOf:
+  - if:
+      properties:
+        compatible:
+          contains:
+            enum:
+              - adi,ad5311r
+              - adi,ad5691r
+              - adi,ad5692r
+              - adi,ad5693
+              - adi,ad5693r
+    then:
+      properties:
+        gain-gpios: false
+
 additionalProperties: false
 
 examples:
   - |
+    #include <dt-bindings/gpio/gpio.h>
     i2c {
       #address-cells = <1>;
       #size-cells = <0>;
@@ -53,6 +91,7 @@ examples:
         compatible = "adi,ad5696";
         reg = <0>;
         vcc-supply = <&dac_vref>;
+        ldac-gpios = <&gpio0 1 GPIO_ACTIVE_LOW>;
       };
     };
 ...

-- 
2.43.0


