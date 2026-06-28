Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5FBEE3AB26A;
	Sun, 28 Jun 2026 14:09:54 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1782655794; cv=none; b=LwkuFG1zacZ3mO40SDaRXmuMmPUytkf5zGSK+xcycmfW7HhaXtsjKrFX1EslpASViS9gdsp1eZeUMvWBg7jocMobxaiy7QeXLMc5MURiUPRhyoSnnd+59nYWQABfFxD8CuJ+0V8obRjPxrObHKsujFGJaMHb536YoCQC5EliGVo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1782655794; c=relaxed/simple;
	bh=nOZGZ62ICmUvfbsrw0b2DeF8zJum/jCmuLlyo00onIo=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=iExqjMEQo3/1S1btbUrkEM6TMDZhYqBLIIG9C4IHfs0Gw2Eb9eoFRD08OTXZITsro6KDzG0kZoHs/mA7X8hayQS1P9nXvSqYjY08P8+FSMbslpGeEfoiP1cuS/4SHppxHlh/gD72xLt2F0OkcpKcbxgvltFlfgu6qm5h5rIH2oM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=g8zEYnim; arc=none smtp.client-ip=10.30.226.201
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="g8zEYnim"
Received: by smtp.kernel.org (Postfix) with ESMTPS id 17BCDC2BD00;
	Sun, 28 Jun 2026 14:09:54 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1782655794;
	bh=nOZGZ62ICmUvfbsrw0b2DeF8zJum/jCmuLlyo00onIo=;
	h=From:Date:Subject:References:In-Reply-To:To:Cc:Reply-To:From;
	b=g8zEYnimC1Zf3Y85UXyYj09KEQtw+sf399v/YJVmmSrfwQR8mR1chgNS+NQ/a75cg
	 lNzX9UAYzMOyExIyvHXN9krGB4S1MlpxvDss4Dl0xLW8y4JJpW2G8J2XVtEQUZb3Lm
	 V9cGk7JyQUt7uF107mqBUxIVbZXq7hly6qn1rr/rLOkCXaRiITaMsW8IxN1E/Oi5T4
	 QhHiOASogRQ/Qm3EQ/OZsKn2QsWNFm6MYxOeEehWTf9ejIRc7eMlGsH3ygGHm31ITK
	 AHf3JPBKtkCJGgrEziQMcxqdRUH64VbHaA8n4KtxHvkXNEF88c2Z1NzS/Ynp8VhxYW
	 xokKfwRxVBSAg==
Received: from aws-us-west-2-korg-lkml-1.web.codeaurora.org (localhost.localdomain [127.0.0.1])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 0C8E2C43638;
	Sun, 28 Jun 2026 14:09:54 +0000 (UTC)
From: Rodrigo Alencar via B4 Relay <devnull+rodrigo.alencar.analog.com@kernel.org>
Date: Sun, 28 Jun 2026 15:08:11 +0100
Subject: [PATCH v5 04/12] dt-bindings: iio: dac: ad5686: rework on power
 supplies
Precedence: bulk
X-Mailing-List: linux-iio@vger.kernel.org
List-Id: <linux-iio.vger.kernel.org>
List-Subscribe: <mailto:linux-iio+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-iio+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20260628-ad5686-new-features-v5-4-577caadbf7c0@analog.com>
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
X-Developer-Signature: v=1; a=ed25519-sha256; t=1782655792; l=2700;
 i=rodrigo.alencar@analog.com; s=default; h=from:subject:message-id;
 bh=tuQmivHL8J10YKTbXaXhxrSTIqRwhQyNsgU1pD2pB7E=;
 b=p69fOARa4T5Zu5LaqRNHqy6UijRGWjyT2Soxkr4tIDdR6fruTEP5bhXKL+CYUtv/p9Mkuczak
 2IKkCWhyZEPCLnVTm9wvW6C5135W+oXBAlDyTdQ7JPRtJGprtjT4f6J
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

Acked-by: Conor Dooley <conor.dooley@microchip.com>
Signed-off-by: Rodrigo Alencar <rodrigo.alencar@analog.com>
---
 .../devicetree/bindings/iio/dac/adi,ad5686.yaml    | 34 ++++++++++++++++++++--
 1 file changed, 32 insertions(+), 2 deletions(-)

diff --git a/Documentation/devicetree/bindings/iio/dac/adi,ad5686.yaml b/Documentation/devicetree/bindings/iio/dac/adi,ad5686.yaml
index d781baca6a6c..02e8c78e36d3 100644
--- a/Documentation/devicetree/bindings/iio/dac/adi,ad5686.yaml
+++ b/Documentation/devicetree/bindings/iio/dac/adi,ad5686.yaml
@@ -32,8 +32,22 @@ properties:
   reg:
     maxItems: 1
 
+  vdd-supply:
+    description: Input power supply.
+
+  vlogic-supply:
+    description:
+      Digital power supply. On some tiny package variants for single-channel
+      devices, this supply is internally connected to vdd; in that case, specify
+      this property with the same regulator as vdd.
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
@@ -60,9 +74,23 @@ properties:
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
+            enum:
+              - adi,ad5676
+              - adi,ad5683
+              - adi,ad5684
+              - adi,ad5686
+    then:
+      required:
+        - vref-supply
   - if:
       properties:
         compatible:
@@ -88,7 +116,9 @@ examples:
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


