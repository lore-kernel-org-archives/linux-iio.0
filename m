Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id CBD0A36F439;
	Tue,  2 Jun 2026 16:33:52 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1780418032; cv=none; b=VX9TAVIN8/21SYFxG9OsQXuyKNHpqmpPRDwX1khNe4Pc8CIN2JGPgprKiwNCt6yhFZNwpR1lQFxkXCgmOQcfBZWZYaZQjF1z28sDmNzT+HWeVZ9Zkk6tqcQiNjWjsS15HDp0ObDaEzbr8kumd7ZcchjuxoTzCbsKgCHkkGxv54Y=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1780418032; c=relaxed/simple;
	bh=MjM22zJK0gok/1JHSadsu38lb17Xjio+GrUTcGYaAHA=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=XE+jwexVIm8Q6oomqcGRbsb0O0+dSUz7aYpm7foPE13bf5Qsp3ZOVzZCwEHQzaVswnFatzEh5/eQ2OLE0NfKquaScI3LHtpdha+XPXPU2UIQvTt2HyXntSabdkTmimw/8uceKgbGT3l6GQ2/VL3zHzE5b7Vp1VOQ8ant/i/ifXo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=m9BZLtdf; arc=none smtp.client-ip=10.30.226.201
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="m9BZLtdf"
Received: by smtp.kernel.org (Postfix) with ESMTPS id A6414C2BCC9;
	Tue,  2 Jun 2026 16:33:52 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1780418032;
	bh=MjM22zJK0gok/1JHSadsu38lb17Xjio+GrUTcGYaAHA=;
	h=From:Date:Subject:References:In-Reply-To:To:Cc:Reply-To:From;
	b=m9BZLtdf/SZh0uxsXW4Cm7j5FoPflF63oiP07vETJVw5riAeyNN1qKvtzcQZ3Xyif
	 WaQGCHNiuesHrQ4JwkkkKakJtsU81w6BeANk2r16wFTsfK9JXQxsKyE6OG8cDO8oi5
	 GkkSHHnu2RSgXI8gurL6rSLalGkiU9Yat/YGDXj5D/jHasjh7P8uHBqZBiga2rxTZH
	 n7MsV93Rq8nvJx8A8CBS6DXctO23QWiPuhE6OlsltoNihojUFp5ZywHyTdDXJRAv/9
	 nhwiKYvdaiHkHDuB2tOi1GZnmAAMV/ER/6l/SXZO8RnTG2w9+AbgnIkfiRQajNaiYr
	 Mzo9afqKv+3Tg==
Received: from aws-us-west-2-korg-lkml-1.web.codeaurora.org (localhost.localdomain [127.0.0.1])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 9BD7CCD6E57;
	Tue,  2 Jun 2026 16:33:52 +0000 (UTC)
From: Rodrigo Alencar via B4 Relay <devnull+rodrigo.alencar.analog.com@kernel.org>
Date: Tue, 02 Jun 2026 17:33:51 +0100
Subject: [PATCH 04/12] dt-bindings: iio: dac: ad5686: rework on power
 supplies
Precedence: bulk
X-Mailing-List: linux-iio@vger.kernel.org
List-Id: <linux-iio.vger.kernel.org>
List-Subscribe: <mailto:linux-iio+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-iio+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20260602-ad5686-new-features-v1-4-691e01883d27@analog.com>
References: <20260602-ad5686-new-features-v1-0-691e01883d27@analog.com>
In-Reply-To: <20260602-ad5686-new-features-v1-0-691e01883d27@analog.com>
To: Michael Auchter <michael.auchter@ni.com>, linux@analog.com, 
 linux-iio@vger.kernel.org, devicetree@vger.kernel.org, 
 linux-kernel@vger.kernel.org, linux-hardening@vger.kernel.org
Cc: Michael Hennerich <Michael.Hennerich@analog.com>, 
 Jonathan Cameron <jic23@kernel.org>, David Lechner <dlechner@baylibre.com>, 
 Andy Shevchenko <andy@kernel.org>, Rob Herring <robh@kernel.org>, 
 Krzysztof Kozlowski <krzk+dt@kernel.org>, 
 Conor Dooley <conor+dt@kernel.org>, Philipp Zabel <p.zabel@pengutronix.de>, 
 Kees Cook <kees@kernel.org>, "Gustavo A. R. Silva" <gustavoars@kernel.org>, 
 Rodrigo Alencar <rodrigo.alencar@analog.com>
X-Mailer: b4 0.14.3
X-Developer-Signature: v=1; a=ed25519-sha256; t=1780418030; l=2482;
 i=rodrigo.alencar@analog.com; s=default; h=from:subject:message-id;
 bh=SZ+4+Wyz9VHuj/4IF6ruPdi67TJbJTwam23OqhjqJG4=;
 b=Pd05U39JY446ke6lGgbOgMTMy07LDnyKYr0NO97Syn2+SXjbWvi709evDDHpV5NCnDNLlK01I
 yFftrufzlC2CF+RHkBzkwXdAHUTWK39iQtPr3bbilgZ4aBUazyyDeQX
X-Developer-Key: i=rodrigo.alencar@analog.com; a=ed25519;
 pk=ULeHbgU/OYh/PG/4anHDfLgldFItQHAhOktYRVLMFRo=
X-Endpoint-Received: by B4 Relay for rodrigo.alencar@analog.com/default
 with auth_id=561
X-Original-From: Rodrigo Alencar <rodrigo.alencar@analog.com>
Reply-To: rodrigo.alencar@analog.com

From: Rodrigo Alencar <rodrigo.alencar@analog.com>

Add supplies for VDD, VLOGIC and VREF input voltage pins. The vcc-supply
property is deprecated, once it does not really exist as none of the
devices describe any power input with that name. VCC is also misleading as
it sounds like the input power supply, but it is being used as an external
voltage reference, which should be called VREF. Certain devices require
vref-supply to be available once an internal reference voltage is absent.
For correct operation vdd and vlogic supplies are required.

Signed-off-by: Rodrigo Alencar <rodrigo.alencar@analog.com>
---
 .../devicetree/bindings/iio/dac/adi,ad5686.yaml    | 31 ++++++++++++++++++++--
 1 file changed, 29 insertions(+), 2 deletions(-)

diff --git a/Documentation/devicetree/bindings/iio/dac/adi,ad5686.yaml b/Documentation/devicetree/bindings/iio/dac/adi,ad5686.yaml
index 4680d4753dd4..2abdbf325392 100644
--- a/Documentation/devicetree/bindings/iio/dac/adi,ad5686.yaml
+++ b/Documentation/devicetree/bindings/iio/dac/adi,ad5686.yaml
@@ -32,8 +32,19 @@ properties:
   reg:
     maxItems: 1
 
+  vdd-supply:
+    description: Input power supply.
+
+  vlogic-supply:
+    description: Digital power supply.
+
+  vref-supply:
+    description:
+      Reference voltage supply. If not supplied the internal reference is used.
+
   vcc-supply:
-    description: If not supplied the internal reference is used.
+    deprecated: true
+    description: Use vref-supply instead.
 
   reset-gpios:
     description: Active-low RESET pin to reset the device.
@@ -53,9 +64,23 @@ properties:
 required:
   - compatible
   - reg
+  - vdd-supply
+  - vlogic-supply
 
 allOf:
   - $ref: /schemas/spi/spi-peripheral-props.yaml#
+  - if:
+      properties:
+        compatible:
+          contains:
+            anyOf:
+              - const: adi,ad5676
+              - const: adi,ad5683
+              - const: adi,ad5684
+              - const: adi,ad5686
+    then:
+      required:
+        - vref-supply
   - if:
       properties:
         compatible:
@@ -81,7 +106,9 @@ examples:
         dac@0 {
             reg = <0>;
             compatible = "adi,ad5310r";
-            vcc-supply = <&dac_vref0>;
+            vdd-supply = <&dac_vdd>;
+            vlogic-supply = <&dac_vlogic>;
+            vref-supply = <&dac_vref>;
             reset-gpios = <&gpio0 0 GPIO_ACTIVE_LOW>;
             ldac-gpios = <&gpio0 1 GPIO_ACTIVE_LOW>;
         };

-- 
2.43.0


