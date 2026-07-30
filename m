Received: from layka.disroot.org (layka.disroot.org [178.21.23.139])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E121E372B26;
	Thu, 30 Jul 2026 20:07:20 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=178.21.23.139
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1785442042; cv=none; b=plJ08LilNpBJIwtdtpF0vk4sU7+4cPl2ZfJgmA1yAkYwhT6IgyBmdl+WPkah5pdln/HLO31Y9Rxtt7ZqG2SZLLp2GLHNU6pSkuaRaS6JU7wF9EmwD1Uq1Ddbd11iJsNc7pxrShaHTTmBUpp4LW/EieWSPfZ5U418vpQZNS+CpJo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1785442042; c=relaxed/simple;
	bh=hsDrP8++gHKqbMjx+74h0AYnoikBSvo37osklk8gToQ=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=OuHPKfSGVNk7kefO0n2N0u0PZosMKjulTIdmG4UpCZQWgDdvRmfSa/4sZUTfk82fjutR88aBLBwgX62iWQbZHq/NZ6xfgRM71zaOZhS6IZGIGz0K7WhoVuZsB3FzZdT/7UxQ9I/9kLP7ed3FzVVRiOiYOerb/VRJ86UJWjl8Lng=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=disroot.org; spf=pass smtp.mailfrom=disroot.org; dkim=pass (2048-bit key) header.d=disroot.org header.i=@disroot.org header.b=Q9HL3wLc; arc=none smtp.client-ip=178.21.23.139
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=disroot.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=disroot.org
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=disroot.org header.i=@disroot.org header.b="Q9HL3wLc"
Received: from mail01.layka.lan (localhost [127.0.0.1])
	by disroot.org (Postfix) with ESMTP id 55E9D847ED;
	Thu, 30 Jul 2026 22:07:19 +0200 (CEST)
X-Virus-Scanned: SPAM Filter at disroot.org
Received: from layka.disroot.org ([127.0.0.1])
 by localhost (disroot.org [127.0.0.1]) (amavis, port 10024) with ESMTP
 id VenSGTaRhAZp; Thu, 30 Jul 2026 22:07:18 +0200 (CEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=disroot.org; s=mail;
	t=1785442038; bh=hsDrP8++gHKqbMjx+74h0AYnoikBSvo37osklk8gToQ=;
	h=From:Date:Subject:References:In-Reply-To:To:Cc;
	b=Q9HL3wLcsOqiU7SLb9F1HlcwQh2OwSEanz3lM934qhmuBVlfZF+8y04Pz91UvFljT
	 FchxTk1koKt25W8/yIx/kr16P9JpoIoNksUCw5kqWyldwxJdYemWyixFfNKToSAhKr
	 WYLpp8/CPfU+i84Xt+8nTFTvvXQ6DIGk2BnMFqk7BfKBfwEQLzZVOYFN4rX+vlt7xx
	 wI1tc+VPe7D2FO8Df3aSt84hEqWyg7RatkxsxK9Sp6oyr3Zvdvs7Y4sGIce+piXWlc
	 Q7JcrUPS1KQKpH7LSpEtfcG73lZnwwLTIFE4j0DyhhBqetq8wfjhKAsQx0/sMu1vP3
	 1/LsTjjRuX5lQ==
From: Kaustabh Chakraborty <kauschluss@disroot.org>
Date: Fri, 31 Jul 2026 01:37:00 +0530
Subject: [PATCH v3 1/3] dt-bindings: iio: proximity: add Sharp GP2AP070S
 proximity sensor
Precedence: bulk
X-Mailing-List: linux-iio@vger.kernel.org
List-Id: <linux-iio.vger.kernel.org>
List-Subscribe: <mailto:linux-iio+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-iio+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20260731-gp2ap070s-v3-1-d1f5cecf9fe7@disroot.org>
References: <20260731-gp2ap070s-v3-0-d1f5cecf9fe7@disroot.org>
In-Reply-To: <20260731-gp2ap070s-v3-0-d1f5cecf9fe7@disroot.org>
To: Jonathan Cameron <jic23@kernel.org>, 
 David Lechner <dlechner@baylibre.com>, 
 =?utf-8?q?Nuno_S=C3=A1?= <nuno.sa@analog.com>, 
 Andy Shevchenko <andy@kernel.org>, Rob Herring <robh@kernel.org>, 
 Krzysztof Kozlowski <krzk+dt@kernel.org>, 
 Conor Dooley <conor+dt@kernel.org>, 
 Kaustabh Chakraborty <kauschluss@disroot.org>, 
 Peter Griffin <peter.griffin@linaro.org>, 
 Alim Akhtar <alim.akhtar@samsung.com>
Cc: linux-iio@vger.kernel.org, devicetree@vger.kernel.org, 
 linux-kernel@vger.kernel.org, linux-arm-kernel@lists.infradead.org, 
 linux-samsung-soc@vger.kernel.org

The GP2AP070S is a proximity sensor designed and manufactured by Sharp
Corporation. Unlike the other GP2AP* schemas, this is strictly a
proximity sensor and NOT an ambient light sensor.

For power supplies, it expects two voltage supplies, one for core and
other for driving the infrared LED which is used to measure proximity
distance.

This chip has been used in production mobile devices such as the Samsung
Galaxy J6.

Signed-off-by: Kaustabh Chakraborty <kauschluss@disroot.org>
---
 .../bindings/iio/proximity/sharp,gp2ap070s.yaml    | 60 ++++++++++++++++++++++
 1 file changed, 60 insertions(+)

diff --git a/Documentation/devicetree/bindings/iio/proximity/sharp,gp2ap070s.yaml b/Documentation/devicetree/bindings/iio/proximity/sharp,gp2ap070s.yaml
new file mode 100644
index 000000000000..73f0abc1f09c
--- /dev/null
+++ b/Documentation/devicetree/bindings/iio/proximity/sharp,gp2ap070s.yaml
@@ -0,0 +1,60 @@
+# SPDX-License-Identifier: (GPL-2.0-only OR BSD-2-Clause)
+%YAML 1.2
+---
+$id: http://devicetree.org/schemas/iio/proximity/sharp,gp2ap070s.yaml#
+$schema: http://devicetree.org/meta-schemas/core.yaml#
+
+title: Sharp GP2AP070S Proximity sensor
+
+maintainers:
+  - Kaustabh Chakraborty <kauschluss@disroot.org>
+
+allOf:
+  - $ref: ../common.yaml#
+
+properties:
+  compatible:
+    const: sharp,gp2ap070s
+
+  reg:
+    maxItems: 1
+
+  interrupts:
+    maxItems: 1
+
+  vdd-supply:
+    description: Voltage supply for the internal circuitry
+
+  vled-supply:
+    description: Voltage supply for the IR LED
+
+  proximity-near-level: true
+
+required:
+  - compatible
+  - reg
+  - interrupts
+  - vdd-supply
+
+additionalProperties: false
+
+examples:
+  - |
+    #include <dt-bindings/interrupt-controller/irq.h>
+
+    i2c {
+      #address-cells = <1>;
+      #size-cells = <0>;
+
+      proximity@39 {
+        compatible = "sharp,gp2ap070s";
+        reg = <0x39>;
+        interrupt-parent = <&gpio>;
+        interrupts = <1 IRQ_TYPE_EDGE_BOTH>;
+        vdd-supply = <&vdd_supply>;
+        vled-supply = <&vled_supply>;
+        proximity-near-level = <500>;
+      };
+    };
+
+...

-- 
2.54.0

