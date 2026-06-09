Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A2D433F58C7;
	Tue,  9 Jun 2026 10:13:11 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1780999991; cv=none; b=THaWiDHvX35v5YWQZvEt90Ofzk9uYlAWoPkzkL63xkEFPwHbrqdHL1adiSCtkNJq3nIlD/ozMpmdx02N23HzBIXwKsdWCWRG4m4OeQaUw0AQ7bGOfCsjq7e85HNl02ZMur6s/gCJl48DMCVWYLUL9NWEagAiOJOLpTr11RzRmtA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1780999991; c=relaxed/simple;
	bh=6gOQEDA0IWSAHnE8IOZo2vs8WRv6rjM3bRfGiPxIwzY=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=uNvj6dSgmf6XTOiAj6wAcJAJkGDsgDh7VSw0zMdWHV+x6R5IF02xdY9QZC+AdneTHlJkXe0gETWiv/LjZ5lIi7N9y3tblZppiNoXLgJCBa6WvtKIyatEGL8zqJY6/t84z2FykEJ79PB2t2lvLWdbmU/QvJLfln1NbJUQ0fXfFqA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=Niemw5iF; arc=none smtp.client-ip=10.30.226.201
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="Niemw5iF"
Received: by smtp.kernel.org (Postfix) with ESMTPS id 7F01CC2BCC7;
	Tue,  9 Jun 2026 10:13:11 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1780999991;
	bh=6gOQEDA0IWSAHnE8IOZo2vs8WRv6rjM3bRfGiPxIwzY=;
	h=From:Date:Subject:References:In-Reply-To:To:Cc:Reply-To:From;
	b=Niemw5iFEQpaeRyREp+H1SZ90UypxAEJMJMr2HiH6hadwqP7qYN8gZ3Z53RjIR7Fq
	 9Mr3lkCUEACTbwcofrrkExn8VrKz4/AIz5PR3roWbDKV0Nq8UiU9w1gB6wmnuoKfiP
	 LVDc7xOseVL4YvdDc2oNVTyudoNPJj2QDWkGdleL97hZ2DngX96S65CrHmV05WR923
	 qoChPAEDSGY3K4jdNT4Jdqq/CMdoJLp+yLSi5fE7pYBZBp5HBEq9Azpqh1cQLyW2nZ
	 YLRswHJN3JRYmVOa8d6BV+mG6gOR8EFk2wUHzRCv1//FDSd30lMDLqWwAbOm7BOsIK
	 +e6GMN2605r0w==
Received: from aws-us-west-2-korg-lkml-1.web.codeaurora.org (localhost.localdomain [127.0.0.1])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 6F4C4CD8CAA;
	Tue,  9 Jun 2026 10:13:11 +0000 (UTC)
From: Rodrigo Alencar via B4 Relay <devnull+rodrigo.alencar.analog.com@kernel.org>
Date: Tue, 09 Jun 2026 11:12:59 +0100
Subject: [PATCH v2 04/12] dt-bindings: iio: dac: ad5686: rework on power
 supplies
Precedence: bulk
X-Mailing-List: linux-iio@vger.kernel.org
List-Id: <linux-iio.vger.kernel.org>
List-Subscribe: <mailto:linux-iio+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-iio+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20260609-ad5686-new-features-v2-4-70b423f5c76d@analog.com>
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
X-Developer-Signature: v=1; a=ed25519-sha256; t=1780999989; l=2535;
 i=rodrigo.alencar@analog.com; s=default; h=from:subject:message-id;
 bh=xThjS0NZwRPW7H/fihcV2ZV9hd9PWkwh/nkEf+3mqL8=;
 b=Ptqnd+VdCMZ8brMiTZknWgmDMMVdovqCv3UXd2nIXTagpbVyOClNlAsVmW/KahXcT7NgZJhgh
 UxEw6JemaIXBTX5tkYjoc9qqXeAjHGjG1rW880oi7EQuJ4ZTjUFIuWm
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


