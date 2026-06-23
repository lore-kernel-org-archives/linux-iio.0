Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 234D33D1709;
	Tue, 23 Jun 2026 10:56:00 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1782212160; cv=none; b=bbW0nNJfwqbGdorPe2iEwR9LlJy8zJbUU13jmoypznm4cOWYEbr9KOhOZOdfKwyRoB4NM07GIJt3nPLcjQIsxCQPJjvhY/NsWDIySjSVq6H1JaYHFDT9xg97DW338KG747j7cZXrqQHlT6fGKltZPppOj0FETbiOQP8USknhTIA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1782212160; c=relaxed/simple;
	bh=nOZGZ62ICmUvfbsrw0b2DeF8zJum/jCmuLlyo00onIo=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=lbp3UOMt5KOu7ASy90eL1j/zw3z9UZlXRfLiLv8T6TX77zVUQ/VdKYB+hwxxCLVe9O0WgtxA7vB0dJpi2zLR+wtW2af8s9bh624q2w0kpEBmF0xVYM/ZMUSmheCjVdEXr4lp1Kai+ic1D6iu7ZudiyPjLkBpEGTwNXXrFKTKMO4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=VvK7TjUA; arc=none smtp.client-ip=10.30.226.201
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="VvK7TjUA"
Received: by smtp.kernel.org (Postfix) with ESMTPS id C3419C2BD00;
	Tue, 23 Jun 2026 10:55:59 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1782212159;
	bh=nOZGZ62ICmUvfbsrw0b2DeF8zJum/jCmuLlyo00onIo=;
	h=From:Date:Subject:References:In-Reply-To:To:Cc:Reply-To:From;
	b=VvK7TjUAdMm2+aAzVZgSOo/2w3Ph/P/0G8gW7Ioibq2YC8iXKtO4s0HB4/VVjF+xT
	 9f2r503+ooUls7HTkuQhnxP543yLvE32HzSVLobNEeQDxuqxcZZFS6drMwqfpKVnKC
	 euMXLSFbfkCcrZMriWqcmKCEzBsJ0jPNB82o0/Nxh8FtcQkARyb7V32BPMnlk/uSVQ
	 +f9nb+rW6vyLI9v03tKSV/O2FwgbGcBWifV01vfLyuKPW21y0VUJbAmocS94GDR0/+
	 Hoa/UA6iMMSiNjNE6x5B+E5edOJG2J5Xv++I7R5NVBmXYPmi8kFw0TkUkczBnawkDv
	 sfcP8Ik5sO9Yw==
Received: from aws-us-west-2-korg-lkml-1.web.codeaurora.org (localhost.localdomain [127.0.0.1])
	by smtp.lore.kernel.org (Postfix) with ESMTP id B7C59CDB47C;
	Tue, 23 Jun 2026 10:55:59 +0000 (UTC)
From: Rodrigo Alencar via B4 Relay <devnull+rodrigo.alencar.analog.com@kernel.org>
Date: Tue, 23 Jun 2026 11:55:44 +0100
Subject: [PATCH v4 04/12] dt-bindings: iio: dac: ad5686: rework on power
 supplies
Precedence: bulk
X-Mailing-List: linux-iio@vger.kernel.org
List-Id: <linux-iio.vger.kernel.org>
List-Subscribe: <mailto:linux-iio+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-iio+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20260623-ad5686-new-features-v4-4-28962a57db0f@analog.com>
References: <20260623-ad5686-new-features-v4-0-28962a57db0f@analog.com>
In-Reply-To: <20260623-ad5686-new-features-v4-0-28962a57db0f@analog.com>
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
X-Developer-Signature: v=1; a=ed25519-sha256; t=1782212158; l=2700;
 i=rodrigo.alencar@analog.com; s=default; h=from:subject:message-id;
 bh=tuQmivHL8J10YKTbXaXhxrSTIqRwhQyNsgU1pD2pB7E=;
 b=YWS42zHIGxntmce5D8yLRdmkSYeks0NH+Q2+86gIJgKaf1gHhHaq95krwh3g+t/rVua+H4wmX
 cOc1CP+FscSDgCSP4CrLE9adVCVQP9g13GyjXhvyOp4jNvlMlAKKFXD
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


